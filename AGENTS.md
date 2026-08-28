# AGENTS.md

This file is the entry point for AI coding agents working in this repository. Keep it small: detailed guidance lives under
`.agents/`, and discoverable repo skills live under `.agents/skills/*/SKILL.md`.

## Start Here

Read these files before making changes:

- [.agents/project.md](.agents/project.md): project overview, versions, and build dependencies.
- [.agents/commands.md](.agents/commands.md): build, development, code generation, and test commands.
- [.agents/rules.md](.agents/rules.md): lint, testing, generated-code, and workflow rules.

Read these only when the task touches their area:

- [.agents/architecture.md](.agents/architecture.md): core integration, providers, database, managers, build system, and
  local plugins.
- [.agents/agent-config.md](.agents/agent-config.md): how to choose between `AGENTS.md`, `.agents`, skills, Codex config,
  command rules, and hooks.
- [.agents/skills.md](.agents/skills.md): index of repo-scoped skills in `.agents/skills/`.

## Highest Priority Rules

- When the user explicitly requests a scoped, low-risk change, inspect the relevant context and implement it directly.
  Do not require brainstorming, design documents, implementation plans, multiple-option proposals, or repeated confirmation.
  Ask only when material ambiguity, destructive impact, additional authority, or scope expansion could change the result.
- Do not add code or configuration comments unless the user explicitly asks for comments. This includes explanatory,
  narrative, TODO, and documentation comments. Never annotate line by line; comments belong only at the few key points
  that cannot be understood without one, and there you must propose the exact text and wait for approval. Delete
  commented-out code and stale notes whenever you touch the surrounding code. Put assertable behavior in a test,
  repository-wide invariants in `.agents/`, and keep a comment only for a fact that is local to one call site.
  See [.agents/rules.md](.agents/rules.md) for the full policy.
- Use `flutter test`, not `dart test`, because models pull in Flutter types.
- Run code generation after modifying models, providers, or database schema.
- Do not manually edit generated files.
- Preserve lifecycle ownership: desktop Core process convergence belongs to `lib/core/desktop/`; Android service intent
  arbitration belongs to `ServiceState`. UI/provider code may request a transition but must not become a second source of
  truth.
- Keep start/stop/restart paths latest-intent-safe. Flutter-to-Android service commands are deliberately optimistic, while
  native state serializes the actual work; desktop lifecycle results distinguish applied, coalesced, and superseded
  requests.
- Follow `analysis_options.yaml`, especially single quotes, trailing commas, `child:` last, no `print()`, const/final
  preferences, and declared return types.
- For CI parity, verify with `flutter pub get`, `flutter analyze --no-fatal-infos`, and
  `flutter test --reporter expanded` when practical.

## Repo Skills

Use repo skills from `.agents/skills/` when a task matches their descriptions. Current skills cover localization,
provider tests, UI work, and core/platform changes.

## Cursor Cloud specific instructions

The Cloud VM is preconfigured for **Linux desktop** development (Flutter 3.44.4 stable, Dart 3.12.2, Go 1.22.2,
Rust/cargo, plus the GTK/appindicator/keybinder/ninja/libstdc++ toolchain). The startup update script only refreshes
dependencies (`git submodule update --init --recursive` then `flutter pub get`); everything else already lives in the
snapshot. `flutter`, `dart`, and `go` are on `PATH`.

- Standard build/dev/test commands are in [.agents/commands.md](.agents/commands.md). Lint = `flutter analyze
  --no-fatal-infos`; tests = `flutter test`; run = `flutter run -d linux` (needs `DISPLAY=:1`, a VNC X server is
  already running).
- The `core/Clash.Meta` submodule is required for the Go core build. Its `.gitmodules` URL is SSH
  (`git@github.com:...`); the global git config rewrites GitHub SSH to token HTTPS so `git submodule update` works
  non-interactively. Do not "fix" the SSH URL in `.gitmodules`.
- `flutter run -d linux` / `flutter build linux` auto-compiles the Go core via the buildkit CMake hook and bundles it
  as `FlClashCore` next to the `FlClash` binary. Go 1.22.2 builds the core fine; you do not need the CI Go version.
- If a Linux build fails at the install step with `cannot copy file ... to /usr/local/FlClash: Permission denied`, it
  is a stale CMake cache from an earlier failed configure: `rm -rf build/linux` and rebuild.
- The GTK file-chooser portal is unavailable (no `xdg-desktop-portal-gtk`), so "import profile from file" dialogs do
  not open. Import profiles via the URL option instead (e.g. serve a local config with `python3 -m http.server` and
  import `http://localhost:<port>/config.yaml`).
- Expected harmless runtime noise on this headless VM: `libayatana-appindicator` tray assertions, a
  `NetworkManager`/DBus `ServiceUnknown` exception from `connectivity_plus`, and minor `RenderFlex overflowed`
  warnings. These do not indicate a broken build.
- The app launches and is fully interactive without any proxy subscription; the core still starts and the Dashboard
  resolves the external IP.
