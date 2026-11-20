# FlClash Neo (experimental)

Headless desktop host + CLI for Linux, Windows, and macOS.

This lives on `cursor/neo-*` branches only. It must not merge into `production`
until the ownership model is deliberate and tested.

## Goal

A standalone CLI that can:

1. Start `FlClashCore` as a child (direct launch first; Helper/TUN later)
2. Own the FlClash IPC socket (the role the GUI plays today)
3. Apply a Clash config YAML via `config.setup`
4. Optionally publish `tui-controller.json` so `flclash-tui` can attach
5. Later: detach/daemonize, Helper/TUN, shared state with the GUI

## Non-goals (for now)

- Android (Service/VPN model is different)
- Replacing the GUI on `production`
- Sharing the GUI single-instance lock or Flutter DB

## Run from source

```bash
# Core must be on PATH or next to the neo binary, or pass --core
export FLCLASH_CORE=/workspace/libclash/linux/FlClashCore

dart run tool/neo.dart run --config /path/to/config.yaml
```

One-shot:

```bash
dart run tool/neo.dart status   # against a running neo host (control file)
dart run tool/neo.dart stop
```

## Layout

| File | Role |
|------|------|
| `tool/neo.dart` | Entry |
| `tool/neo/host.dart` | Bind IPC, spawn Core, init/setup |
| `tool/neo/ipc.dart` | Length-prefixed Unix IPC |
| `tool/neo/rpc.dart` | `core.*` / `config.*` method calls |
| `tool/neo/paths.dart` | Home dir, socket, state file |
| `tool/neo/cli.dart` | Argument parsing |

## Platform notes

- **Linux / macOS:** Unix domain socket IPC (matches Core `dial_socket.go`).
- **Windows:** Named-pipe host is phase 2; `run` currently refuses on Windows
  until a pipe listener lands (Core uses `dial_pipe.go`).
- **TUN / system proxy:** not in the first slice; use a mixed-port config.
