# Performance improvement tasks

Investigation snapshot against fork `main` (`0.8.101`, based on upstream `7c83185`).
Goal: cut steady-state CPU/IPC while started, and reduce jank on Proxies / Connections / macOS tray.

## How to use

- Prefer **P0 → P1 → P2** order.
- Each task should land as its own PR with before/after notes (DevTools CPU / Timeline, or a short manual checklist).
- Do not regress: start/stop, delay test, profile apply, TUN/VPN.

## Already in good shape (do not redo)

- Delay → `updateGroups` debounced (~5s); profile apply / changeProxy debounced.
- Heavy profile/group work uses `compute()` isolates (`lib/common/task.dart`).
- Dashboard cards `keep: false`; requests/logs UI throttled (`FunctionTag.requests`).
- Charts wrapped in `RepaintBoundary`.
- macOS tray title split from full menu (`trayTitleStateProvider` vs `trayStateProvider`).
- Transparent/blur macOS sidebar left disabled.

Upstream history of note: `de9c5ba` dashboard, `c9cd80b` Android VPN, `7e7f1f8` macOS (mixed commit; tray/title isolation is the lasting pattern).

---

## P0 — High impact, clear evidence

### PERF-01 — Coalesce traffic IPC (1 Hz → less work)

**Problem:** While started, `SetupAction._handleStart` runs a 1s timer that calls both `getTraffic` and `getTotalTraffic` (`lib/providers/action.dart`). That is 2× JSON IPC/FFI per second and feeds dashboard + tray title.

**Plan:**
1. Add a single core API that returns both counters (or push traffic events from core).
2. Or call one endpoint and derive UI needs on the Dart side.
3. Optionally skip tray/chart updates when values are unchanged.

**Touches:** `lib/providers/action.dart`, `lib/core/*`, `core/hub.go`  
**Effort:** medium · **Verify:** started idle CPU, tray title still updates

### PERF-02 — Connections page: lazy build + lighter poll

**Problem:** `ConnectionsView` polls full snapshots every 1s (`_updateConnectionsTask`) and maps **all** rows into widgets before `SuperListView.builder` (`lib/views/connection/connections.dart`).

**Plan:**
1. Build `TrackerInfoItem` only inside `itemBuilder` (no eager `.map().toList()`).
2. Diff/replace list by connection id; avoid full notifier replace when empty diff.
3. Decode JSON off the UI isolate (mirror proxies/`compute` pattern).
4. Consider 1.5–2s poll or pause when page not visible / app backgrounded.

**Touches:** `lib/views/connection/connections.dart`, `lib/core/controller.dart`  
**Effort:** small–medium · **Verify:** open Connections under heavy traffic; scroll jank

### PERF-03 — Proxies list: stop eager card materialization

**Problem:** `ProxiesListView.build` calls `_buildItems` and materializes every header/card, then `ListView.builder` only indexes that list (`lib/views/proxies/list.dart`). Any `proxiesListState` change rebuilds the whole tree.

**Plan:**
1. Store lightweight row descriptors (group / proxy indices) instead of widgets.
2. Construct `ProxyCard` / headers in `itemBuilder` (+ keep `itemExtentBuilder`).
3. Narrow watches so delay-only updates do not rebuild non-visible cards.

**Touches:** `lib/views/proxies/list.dart`, related proxy widgets  
**Effort:** medium · **Verify:** large subscription (500+ nodes), expand/collapse, delay test

### PERF-04 — Slim per-proxy delay watches

**Problem:** `delayProvider` → `realSelectedProxyStateProvider` watches full `groupsProvider` (`lib/providers/state.dart`), so group refreshes ripple through every `ProxyCard`.

**Plan:**
1. Select only the needed group/proxy fields (or maintain a `Map` of selected names / test URLs).
2. Ensure delay map updates (`delayDataSourceProvider.select`) stay the only hot path for card delay text.

**Touches:** `lib/providers/state.dart`, `lib/views/proxies/card.dart`  
**Effort:** medium · **Verify:** delay test batch does not freeze UI

### PERF-05 — Default `findProcessMode` to off (or platform-safe)

**Problem:** Default is `FindProcessMode.always` (`lib/models/clash_config.dart`). Product copy already warns of performance loss; mihomo notes process lookup cost/memory.

**Plan:**
1. Change default to `off` for new installs (keep persisted user choice).
2. Optionally default `always` only when Access / Connections UI needs process names.
3. Document migration: existing configs unchanged.

**Touches:** `lib/models/clash_config.dart`, settings UI if needed, tests  
**Effort:** small · **Verify:** Connections still works; Android VPN CPU under load

---

## P1 — Medium impact

### PERF-06 — macOS tray: avoid rebuilding all proxy submenus

**Problem:** On macOS, tray rebuild walks every group/proxy into `MenuItem.checkbox` (`lib/common/tray.dart`) whenever `trayState` changes (including groups refresh).

**Plan:**
1. Rebuild proxy submenus only when groups/selection change (not on traffic).
2. Cap submenu size or load on demand / “Open Proxies…” only.
3. Keep title updates on the lightweight `trayTitleState` path.

**Effort:** medium · **Verify:** macOS menu open latency with large lists

### PERF-07 — FixedList / event ingest copies

**Problem:** Logs, requests, traffics use `FixedList.copyWith()` on every add (`lib/providers/app.dart`), copying up to 500 entries under high event rate from `CoreManager`.

**Plan:**
1. Ring-buffer / in-place mutate with identity-safe notify.
2. Optional global coalesce for request/log bursts (UI already throttles some views).

**Effort:** small–medium · **Verify:** Logs/Requests pages under proxy flood

### PERF-08 — Preferences: dirty-section saves

**Problem:** `AppStateManager` listens to aggregated `configProvider` and debounced-saves the **entire** `Config` JSON (`lib/manager/app_manager.dart` + preferences).

**Plan:**
1. Save only changed leaves (theme / VPN / patch config / …).
2. Or deepen debounce / skip encode when deep-equal.

**Effort:** medium · **Verify:** toggle settings rapidly; no lost persistence

### PERF-09 — Delay-test batch pressure

**Problem:** Delay tests batch 100 concurrent IPC calls (`lib/views/proxies/common.dart`), each updating delay maps and eventually `updateGroups`.

**Plan:**
1. Lower concurrency or adaptive batch by platform.
2. Update visible delays immediately; defer full group re-sort until batch ends (debounce already helps).

**Effort:** medium · **Verify:** “Check delay” on large list

### PERF-10 — Access control package list

**Problem:** `AccessView` watches full `packagesProvider` and filters/sorts on rebuild (`lib/views/access.dart`); can be thousands of Android packages + icons.

**Plan:**
1. Debounced search; memoize filtered list.
2. Lazy icon load; virtualize aggressively.

**Effort:** medium · **Verify:** Android Access page open/search

---

## P2 — Lower priority / larger design

### PERF-11 — Push model for traffic / connections from core

Replace Dart polling with core-originated events (socket/FFI callbacks). Larger design; supersedes parts of PERF-01/02.

### PERF-12 — Narrow `configProvider` aggregation

Leaf settings already exist; consumers that only need one leaf should not watch the aggregate (`lib/providers/config.dart`). Audit high-churn listeners.

### PERF-13 — `EmojiText` cost on proxy names

Regex-split every build (`lib/widgets/text.dart`) on every card. Cache spans per string or skip emoji parsing when name has no emoji.

### PERF-14 — Theme / layout storm

`ThemeManager` `LayoutBuilder` → `updateViewSize` can cascade viewMode/columns (`lib/manager/theme_manager.dart`). Debounce or equality-guard size updates.

### PERF-15 — Desktop IPC protocol

Line-delimited JSON for every action (`lib/core/service.dart`) is an architecture ceiling. Binary framing for hot counters is a long-term option.

---

## Suggested first sprint (fork)

| Order | ID | Why first |
|------|----|-----------|
| 1 | PERF-05 | One-line default; large real-world win |
| 2 | PERF-02 | Localized UI fix; easy to measure |
| 3 | PERF-03 + PERF-04 | Proxies is the primary large-list surface |
| 4 | PERF-01 | Steady-state CPU while started |
| 5 | PERF-06 | macOS-specific follow-up to upstream tray work |

## Out of scope for this list

- Geo identity / Tailscale feature work (unless they add new timers/IPC).
- Upstream mihomo internals beyond FlClash hub wrappers (track upstream separately).
- Rewriting the entire desktop IPC stack in one PR (see PERF-15).
