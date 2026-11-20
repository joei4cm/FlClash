# Neo (experimental headless CLI)

Branch family: `cursor/neo-*` (currently `cursor/neo-headless-cli-78f9`).

Neo is a **separate product slice**: a desktop headless host that owns
`FlClashCore` IPC the way the GUI does today, plus a CLI entry
(`tool/neo.dart`). It must **not** merge into `production` until ownership,
TUN/Helper, and GUI coexistence are settled.

See `tool/neo/README.md` for run instructions and platform limits.
