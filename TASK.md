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

### PERF-01 — Coalesce traffic IPC (1 Hz → less work) — DONE

**Problem:** While started, `SetupAction._handleStart` ran a 1s timer that called both `getTraffic` and `getTotalTraffic`.

**Done:**
- Added `getTrafficSnapshot` core action (`core/hub.go`, `ActionMethod.getTrafficSnapshot`).
- `CommonAction.updateTraffic` uses one IPC call and skips Riverpod writes when values are unchanged.

**Touches:** `lib/providers/action.dart`, `lib/core/*`, `core/hub.go` / `action.go` / `constant.go`

### PERF-02 — Connections page: lazy build + lighter poll — DONE

**Problem:** Eager widget map + 1s full snapshot poll.

**Done:**
- Build `TrackerInfoItem` only in `itemBuilder` (fixed separator `itemCount`).
- Poll every 2s; skip notifier updates on identical snapshots; pause when route inactive / app not resumed.
- Decode connection JSON via `compute()`.

**Touches:** `lib/views/connection/connections.dart`, `lib/core/controller.dart`

### PERF-03 — Proxies list: stop eager card materialization — DONE

**Problem:** `_buildItems` materialized every card before `ListView.builder`.

**Done:**
- Row descriptors (`_ProxyListEntry`); widgets built in `itemBuilder` only.
- Height extents still precomputed from descriptors.

**Touches:** `lib/views/proxies/list.dart`

### PERF-04 — Slim per-proxy delay watches — DONE

**Problem:** Each `delayProvider` → `realSelectedProxyState` watched full `groupsProvider`.

**Done:**
- `realSelectedProxyStateMapProvider` resolves once; per-proxy provider selects by name (equality-stable).

**Touches:** `lib/providers/state.dart`

### PERF-05 — Default `findProcessMode` to off — DONE

**Problem:** Default was `FindProcessMode.always`.

**Done:**
- Default and unknown-enum fallback set to `off` for new / unspecified configs.
- Persisted `"always"` values still restore as always.

**Touches:** `lib/models/clash_config.dart` (+ generated)

---

## P1 — Medium impact

### PERF-06 — macOS tray: avoid rebuilding all proxy submenus — PARTIAL

**Done:** Cap each group submenu at 30 proxies (keep selected if outside head) + “Proxies…” to focus the window.

**Still open:** Skip full menu rebuilds when only traffic/title changes (title path already separate); optional lazy/open-on-demand menus.

**Touches:** `lib/common/tray.dart`

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

## Suggested next sprint

| Order | ID | Why |
|------|----|-----------|
| 1 | PERF-07 | Event flood CPU |
| 2 | PERF-09 | Delay-test UX on large lists |
| 3 | PERF-08 | Preference write amplification |
| 4 | PERF-06 follow-up | Tray rebuild gating |
| 5 | PERF-10 | Android Access jank |

## Out of scope for this list

- Geo identity / Tailscale feature work (unless they add new timers/IPC).
- Upstream mihomo internals beyond FlClash hub wrappers (track upstream separately).
- Rewriting the entire desktop IPC stack in one PR (see PERF-15).
