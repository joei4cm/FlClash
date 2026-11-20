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

## Build (AOT binary)

```bash
bash tool/build_neo.sh
# -> libclash/<linux|macos|windows>/flclash-neo
#    (+ FlClashCore if it was missing)
```

The desktop setup hook also compiles `flclash-neo` next to Core on every
`flutter build` / hook run (same pattern as `flclash-tui`).

## Run

```bash
./libclash/linux/flclash-neo run --config /path/to/config.yaml
./libclash/linux/flclash-neo status
./libclash/linux/flclash-neo stop
```

Override Core path with `FLCLASH_CORE` or `--core` when it is not beside the
binary.

## Release (neo channel)

On a `cursor/neo-*` branch:

```bash
tool/release.sh stable --yes --push
# tags vX.Y.Z_neo_<sha6>  (skips production CHANGELOG / geo refresh)
```

CI workflow `neo-release` builds platform archives
`FlClashNeo-X.Y.Z_neo-<os>-<arch>.tar.gz` (zip on Windows) and publishes a
**prerelease**. Full GUI matrix tags must not contain `_neo`.

## Layout

| File | Role |
|------|------|
| `tool/neo.dart` | Entry |
| `tool/build_neo.sh` | AOT compile (+ Core if needed) |
| `tool/neo/host.dart` | Bind IPC, spawn Core, init/setup |
| `tool/neo/ipc.dart` | Length-prefixed Unix IPC |
| `tool/neo/rpc.dart` | `core.*` / `config.*` method calls |
| `tool/neo/paths.dart` | Home dir, socket, state file |
| `tool/neo/cli.dart` | Argument parsing |

## Platform notes

- **Linux / macOS:** Unix domain socket IPC (matches Core `dial_socket.go`).
- **Windows:** Named-pipe host is phase 2; `run` currently refuses on Windows
  until a pipe listener lands (Core uses `dial_pipe.go`). Archives still ship
  the AOT binary for later.
- **TUN / system proxy:** not in the first slice; use a mixed-port config.
