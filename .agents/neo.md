# Neo (experimental headless CLI)

Branch family: `cursor/neo-*` (currently `cursor/neo-headless-cli-78f9`).

Neo is a **separate product slice**: a desktop headless host that owns
`FlClashCore` IPC the way the GUI does today, plus an AOT CLI binary
(`flclash-neo`, built by `tool/build_neo.sh` / setup hook).

Release tags on neo branches use the channel suffix **`_neo`**
(`vX.Y.Z_neo_<sha6>`). Do **not** merge into `production` until ownership,
TUN/Helper, and GUI coexistence are settled.

See `tool/neo/README.md` for build, run, and release instructions.
