## v0.8.107

- sync: replace main with upstream/dev + Tailscale/Geo/perf (v0.8.107)

- Single commit on current main so merge / squash / rebase all land cleanly.

- Includes upstream/dev post-0.8.95 (connections ActivePolling, Windows delay

- RPC fix, commented-policy cleanup) and fork features ported onto the new

- architecture.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

## v0.8.105

- chore: bump version to 0.8.105 for delay/event robustness release

- Includes hardened proxy delay batching and CoreEventManager dispatch

- isolation merged from the upstream/dev port.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- fix: harden delay tests and core event dispatch

- Port robustness from the upstream/dev performance branch: catch

- individual delay IPC failures so batch tests keep going, and isolate

- listener errors in CoreEventManager so traffic/connections pushes

- cannot abort the event loop.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- chore: bump version to 0.8.103 for connections push and UX polish

- Ship connections core push, Geo/Tailscale recovery polish, and the

- TASK.md conflict cleanup since 0.8.102.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- fix: connections push, Geo/Tailscale polish, fix TASK.md

- Resolve leftover merge conflict markers in TASK.md. Push live

- connection snapshots from core every 2s (PERF-11 follow-up) and drop

- Connections page polling. Polish Geo identity recovery/start copy and

- Tailscale bypass/auth-key/guide UX.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- chore: bump version to 0.8.102 for perf and UX release

- Ship traffic push IPC, config leaf watches, Geo/Tailscale UX polish,

- and remaining P2 performance work since 0.8.101.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- perf: finish leftover P2 tasks and geo model cleanup

- Push traffic counters from core while listening (PERF-11), narrow

- config/leaf Riverpod watches (PERF-12), add EmojiText/viewSize

- micro-wins (PERF-13/14), defer binary IPC (PERF-15), and remove

- unused geo checklist/capture/snapshot types.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- docs: mark PERF-13/14 done in TASK.md

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(ux): Tailscale advanced collapse, Features section, ARB prune

- Collapse uncommon Tailscale node fields behind Show advanced, surface

- Tailscale/Geo under Tools → Features, prune unused geo/tailscale ARB

- keys, and ship EmojiText/viewSize perf micro-wins.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- fix(ux): honest Geo status and Tailscale setup edges

- Clarify Geo identity banner/failure paths, wait for capture before

- verify, surface timezone/clipboard outcomes, and restore thin recovery

- actions. Fix Tailscale rename duplicates, require auth keys, warn on

- empty routes, await profile apply before ping, and nudge desktop bypass.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- perf: FixedList notify, delay batches, prefs skip, tray/access

- Second TASK.md sprint: in-place FixedList notifyClone for event

- ingest, adaptive delay-test concurrency, preference save skip +

- longer debounce, tray menu rebuild gating, and Access list/icon

- caching with debounced search.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- perf: cut traffic IPC, list rebuilds, and find-process default

- Implement first TASK.md sprint: coalesce traffic via getTrafficSnapshot,

- lazy Connections/Proxies builds, slim delay watches, default

- findProcessMode to off, and cap macOS tray proxy submenus.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- docs: add TASK.md performance improvement plan

- Track investigated Flutter/Go hotspots (traffic IPC, Connections/Proxies

- rebuilds, find-process default, macOS tray) as prioritized PERF tasks.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

## v0.8.101

- chore: bump version to 0.8.101 for simplified Geo identity release

- Ship the purpose + one-switch + FuckClaude validation Geo identity UI.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- refactor(geo-identity): reduce UI to purpose, on/off, and API status

- Show a short purpose blurb, a single protect switch that runs the setup

- checklist, and a FuckClaude-backed status banner (good to go / not ready)

- with an optional Recheck action.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- refactor(geo-identity): simplify UI to status card and quick actions

- Collapse the long multi-section menu into a Ready/Needs-setup status

- card with compact chips, one-click setup, a short Quick actions list,

- and an Advanced toggle for the remaining switches and links.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

## v0.8.100

- fix(test): update config overrides count for geo identity

- buildConfigOverrides now includes geoIdentitySettingProvider, so the

- provider test expectation must be 14 and cover the new defaults.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- chore: bump version to 0.8.100 for Geo identity release

- Ship Tools → Geo identity: one-click undercover checklist, FuckClaude

- network verify, Claude Code OS timezone align, and terminal proxy exports.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(geo-identity): Tailscale-style one-click checklist for newbies

- Add a live 5-step checklist and One-click setup that enables protect,

- turns on system proxy + TUN (or Android VPN), starts FlClash, verifies

- the FuckClaude network exit, and tries to align the OS timezone.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(geo-identity): help Claude Code via OS timezone and terminal proxy

- Add a Claude Code terminal section: align/restore desktop OS timezone to

- the exit geo (the CLI signal GeoMirror cannot change), copy HTTP(S)_PROXY

- exports for system-proxy-only terminals, and document TUN preference plus

- ANTHROPIC_BASE_URL hostname hygiene.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(geo-identity): verify network undercover via FuckClaude API

- Add an opt-in protect mode that works with system proxy and TUN/VPN:

- show capture-mode status, probe /api/check through the mixed-port stack

- with optional US Accept-Language, and surface protected vs exposed

- results from exit geo + band.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(tools): add Geo identity guide for US AI exit consistency

- Add a Tools menu that explains exit-IP vs OS/browser fingerprint

- alignment, surfaces local timezone/locale risk heuristics, and links

- FuckClaude self-check plus GeoMirror for browser-side geo mirroring.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

## v0.8.99

- chore: bump version to 0.8.99 for Tailscale friendly UX release

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(tailscale): friendlier setup guide and one-tap connection test

- Make the Tailscale screen easier to use on Android and desktop:

- - Platform-specific scenario card and step-by-step guide (Android client vs desktop host)

- - Context-aware bypass hint (recommended on desktop; usually off on Android)

- - Live status banner (disabled / no nodes / start VPN / ready)

- - Per-node ping button reusing the existing delay test, with latency or Timeout

- - Clear prompts if Enable is off or FlClash VPN is not started

- Localized in en/zh_CN/ja/ru.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

## v0.8.98

- chore: bump version to 0.8.98 for Tailscale fake-IP bypass release

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(tailscale): sync Fake IP Filter with bypass toggle

- Turning 'Keep Tailscale traffic direct' on now adds +.tailscale.com / +.tailscale.io / +.ts.net to Config → DNS → Fake IP Filter; turning it off removes only those entries and leaves unrelated filters alone. Also re-applies the running profile so the change takes effect without a manual VPN restart.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- fix(tailscale): exclude control plane from fake-IP DNS on bypass

- The curl diagnostic showing controlplane.tailscale.com -> 198.18.0.12 is Clash fake-IP DNS poisoning. DOMAIN-SUFFIX DIRECT alone does not stop that; the TLS handshake then hangs mid-certificate and tailscale up never completes.

- When 'Keep Tailscale traffic direct' is on:

- - Expand DIRECT domains to tailscale.com / tailscale.io / ts.net

- - Inject fake-ip-filter entries (+.tailscale.com, +.tailscale.io, +.ts.net) into the running DNS config so those names resolve to real public IPs

- Also updates the in-app copy to call out the 198.18.x.x symptom.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

## v0.8.97

- chore: bump version to 0.8.97 for Tailscale UX release

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(tailscale): one-click bypass + per-node route destinations

- Adds provider-agnostic Tailscale routing controls so users don't hand-edit rules per VPN profile:

- - 'Keep Tailscale traffic direct' toggle: auto-injects DIRECT rules for the tailnet CGNAT ranges, control/DERP domains and the tailscaled process, so a host that also runs the Tailscale service isn't hijacked by FlClash's VPN.

- - Per-node 'Route destinations': domains/IPs routed through that embedded Tailscale node, so a phone can reach a home host through FlClash's built-in tailnet node without running the Tailscale app (avoids the Android single-VPN conflict).

- Rules are injected at the top of the running config (highest priority) via MakeRealProfileState, independent of the imported profile. Localized in en/zh_CN/ja/ru; adds model/provider tests.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(tailscale): add in-app guide and a prominent add-node button

- The only way to add a node was a small + icon in the app bar, which was easy to miss on the full-page view. Add a clear FilledButton in the empty state and an inline 'How Tailscale works' guide (auth key -> add node -> enable -> select on proxies page). Also add helper text to the node dialog fields explaining each option. Localized in en/zh_CN/ja/ru.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

## v0.8.96

- chore: bump version to 0.8.96 for Tailscale + Android CI release

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- ci: build Android in release workflow without requiring signing secrets

- The build-android job was gated behind the ENABLE_ANDROID repo variable, so it was skipped and no Android artifacts appeared in releases.

- - Remove the ENABLE_ANDROID gate so Android builds by default.

- - Make signing optional: use KEYSTORE/SERVICE_JSON/etc. only when present, otherwise build a debug-signed '.dev' APK covered by the bundled placeholder google-services.json.

- - Disable the Crashlytics mapping upload on the unsigned '.dev' fallback so the minified release build cannot fail trying to reach the dummy Firebase project.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

## v0.0.0-ci-test

- ci: add fork-friendly release workflow

- Adds .github/workflows/release.yaml that builds desktop (and optionally

- Android) and publishes a GitHub Release on the current repo using the

- built-in GITHUB_TOKEN, without upstream-only Telegram/Homebrew/F-Droid steps.

- Guards build.yaml jobs so the upstream pipeline no longer runs on forks.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(tailscale): gate outbound injection behind an opt-in enable switch

- Tailscale is now off by default. A master switch controls whether authored

- nodes are merged into the running config; when off, Tailscale handles no

- traffic and normal global/VPN traffic is unaffected.

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- test(tailscale): cover Tailscale model, merge, and provider

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(tailscale): add Tailscale node management UI and localization

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

- feat(tailscale): add Tailscale outbound model and merge into generated config

- Co-authored-by: MichaelZ <joei4cm@users.noreply.github.com>

## v0.8.94

- Fix macos performance issue

- Support custom global-ua

- Update core

- Optimize some details

- Fix linux silent launching not working

## v0.8.93

- Support custom overwrite

- Support run on demand

- Optimize windows ipc

- Optimize windows arm64

- Optimize build

- Optimize some details

- Update core

## v0.8.92

- Add sqlite store

- Optimize android quick action

- Optimize backup and restore

- Optimize more details

## v0.8.91

- Fix windows some issues

- Optimize overwrite handle

- Optimize access control page

- Optimize some details

## v0.8.90

- Fix android tile service

- Support append system DNS

- Fix some issues

## v0.8.89

- Fix some issues

- Optimize Windows service mode

- Update core

## v0.8.88

- Add android separates the core process

- Support core status check and force restart

- Optimize proxies page and access page

- Update flutter and pub dependencies

- Update go version

- Optimize more details

## v0.8.87

- Optimize desktop view

- Optimize logs, requests, connection pages

- Optimize windows tray auto hide

- Optimize some details

- Update core

## v0.8.86

- Fix windows tun issues

- Optimize android get system dns

- Optimize more details

## v0.8.85

- Support override script

- Support proxies search

- Support svg display

- Optimize config persistence

- Add some scenes auto close connections

- Update core

- Optimize more details

## v0.8.84

- Fix issues that TUN repeat failed to open.

- Fix windows service verify issues

## v0.8.83

- Add windows server mode start process verify

- Add linux deb dependencies

- Add backup recovery strategy select

- Support custom text scaling

- Optimize the display of different text scale

- Optimize windows setup experience

- Optimize startTun performance

- Optimize android tv experience

- Optimize default option

- Optimize computed text size

- Optimize hyperOS freeform window

- Add developer mode

- Update core

- Optimize more details

- Add issues template

## v0.8.82

- Optimize android vpn performance

- Add custom primary color and color scheme

- Add linux nad windows arm release

- Optimize requests and logs page

- Fix map input page delete issues

## v0.8.81

- Add rule override

- Update core

- Optimize more details

## v0.8.80

- Optimize dashboard performance

- Fix some issues

- Fix unselected proxy group delay issues

- Fix asn url issues

## v0.8.79

- Fix tab delay view issues

- Fix tray action issues

- Fix get profile redirect client ua issues

- Fix proxy card delay view issues

- Add Russian, Japanese adaptation

- Fix some issues

## v0.8.78

- Fix list form input view issues

- Fix traffic view issues

## v0.8.77

- Optimize performance

- Update core

- Optimize core stability

- Fix linux tun authority check error

- Fix some issues

- Fix scroll physics error

## v0.8.75

- Add windows storage corruption detection

- Fix core crash caused by windows resource manager restart

- Optimize logs, requests, access to pages

- Fix macos bypass domain issues

## v0.8.74

- Fix some issues

## v0.8.73

- Update popup menu

- Add file editor

- Fix android service issues

- Optimize desktop background performance

- Optimize android main process performance

- Optimize delay test

- Optimize vpn protect

## v0.8.72

- Update core

- Fix some issues

## v0.8.71

- Remake dashboard

- Optimize theme

- Optimize more details

- Update flutter version

## v0.8.70

- Support better window position memory

- Add windows arm64 and linux arm64 build script

- Optimize some details

## v0.8.69

- Remake desktop

- Optimize change proxy

- Optimize network check

- Fix fallback issues

- Optimize lots of details

- Update change.yaml

- Fix android tile issues

- Fix windows tray issues

- Support setting bypassDomain

- Update flutter version

- Fix android service issues

- Fix macos dock exit button issues

- Add route address setting

- Optimize provider view

- Update CHANGELOG.md

- Add android shortcuts

- Fix init params issues

- Fix dynamic color issues

- Optimize navigator animate

- Optimize window init

- Optimize fab

- Optimize save

- Fix the collapse issues

- Add fontFamily options

- Update core version

- Update flutter version

- Optimize ip check

- Optimize url-test

- Update release message

- Init auto gen changelog

- Fix windows tray issues

- Fix urltest issues

- Add auto changelog

- Fix windows admin auto launch issues

- Add android vpn options

- Support proxies icon configuration

- Optimize android immersion display

- Fix some issues

- Optimize ip detection

- Support android vpn ipv6 inbound switch

- Support log export

- Optimize more details

- Fix android system dns issues

- Optimize dns default option

- Fix some issues

- Update readme

- Fix build error2

- Fix build error

- Support desktop hotkey

- Support android ipv6 inbound

- Support android system dns

- fix some bugs

- Fix delete profile error

- Fix submit error 2

- Fix submit error

- Optimize DNS strategy

- Fix the problem that the tray is not displayed in some cases

- Optimize tray

- Update core

- Fix some error

- Fix tun update issues

- Add DNS override

- Fixed some bugs

- Optimize more detail

- Add Hosts override

- fix android tip error

- fix windows auto launch error

- Fix windows tray issues

- Optimize windows logic

- Optimize app logic

- Support windows administrator auto launch

- Support android close vpn

- Change flutter version

- Support profiles sort

- Support windows country flags display

- Optimize proxies page and profiles page columns

- Update flutter version

- Update version

- Update timeout time

- Update access control page

- Fix bug

- Optimize provider page

- Optimize delay test

- Support local backup and recovery

- Fix android tile service issues

- Fix linux core build error

- Add proxy-only traffic statistics

- Update core

- Optimize more details

- Add fdroid-repo

## v0.8.48

- Optimize proxies page

- Fix ua issues

- Optimize more details

## v0.8.47

- Fix windows build error

## v0.8.46

- Update app icon

- Fix desktop backup error

- Optimize request ua

- Change android icon

- Optimize dashboard

## v0.8.44

- Remove request validate certificate

- Sync core

## v0.8.43

- Fix windows error

## v0.8.42

- Fix setup.dart error

- Fix android system proxy not effective

- Add macos arm64

## v0.8.41

- Optimize proxies page

- Support mouse drag scroll

- Adjust desktop ui

- Revert "Fix android vpn issues"

- This reverts commit 891977408e6938e2acd74e9b9adb959c48c79988.

## v0.8.40

- Fix android vpn issues

- Fix android vpn issues

- Rollback partial modification

## v0.8.39

- Fix the problem that ui can't be synchronized when android vpn is occupied by an external

- Override default socksPort,port

## v0.8.38

- Fix fab issues

## v0.8.37

- Update version

- Fix the problem that vpn cannot be started in some cases

- Fix the problem that geodata url does not take effect

## v0.8.36

- Update ua

- Fix change outbound mode without check ip issues

- Separate android ui and vpn

- Fix url validate issues 2

- Add android hidden from the recent task

- Add geoip file

- Support modify geoData URL

## v0.8.35

- Fix url validate issues

- Fix check ip performance problem

- Optimize resources page

## v0.8.34

- Add ua selector

- Support modify test url

- Optimize android proxy

- Fix the error that async proxy provider could not selected the proxy

## v0.8.33

- Fix android proxy error

- Fix submit error

- Add windows tun

- Optimize android proxy

- Optimize change profile

- Update application ua

- Optimize delay test

## v0.8.32

- Fix android repeated request notification issues

## v0.8.31

- Fix memory overflow issues

## v0.8.30

- Optimize proxies expansion panel 2

- Fix android scan qrcode error

## v0.8.29

- Optimize proxies expansion panel

- Fix text error

## v0.8.28

- Optimize proxy

- Optimize delayed sorting performance

- Add expansion panel proxies page

- Support to adjust the proxy card size

- Support to adjust proxies columns number

- Fix autoRun show issues

- Fix Android 10 issues

- Optimize ip show

## v0.8.26

- Add intranet IP display

- Add connections page

- Add search in connections, requests

- Add keyword search in connections, requests, logs

- Add basic viewing editing capabilities

- Optimize update profile

## v0.8.25

- Update version

- Fix the problem of excessive memory usage in traffic usage.

- Add lightBlue theme color

- Fix start unable to update profile issues

- Fix flashback caused by process

## v0.8.23

- Add build version

- Optimize quick start

- Update system default option

## v0.8.22

- Update build.yml

- Fix android vpn close issues

- Add requests page

- Fix checkUpdate dark mode style error

- Fix quickStart error open app

- Add memory proxies tab index

- Support hidden group

- Optimize logs

- Fix externalController hot load error

## v0.8.21

- Add tcp concurrent switch

- Add system proxy switch

- Add geodata loader switch

- Add external controller switch

- Add auto gc on trim memory

- Fix android notification error

## v0.8.20

- Fix ipv6 error

- Fix android udp direct error

- Add ipv6 switch

- Add access all selected button

- Remove android low version splash

## v0.8.19

- Update version

- Add allowBypass

- Fix Android only pick .text file issues

## v0.8.18

- Fix search issues

## v0.8.17

- Fix LoadBalance, Relay load error

- Fix build.yml4

- Fix build.yml3

- Fix build.yml2

- Fix build.yml

- Add search function at access control

- Fix the issues with the profile add button to cover the edit button

- Adapt LoadBalance and Relay

- Add arm

- Fix android notification icon error

## v0.8.16

- Add one-click update all profiles

- Add expire show

## v0.8.15

- Temp remove tun mode

- Remove macos in workflow

- Change go version

## v0.8.14

- Update Version

- Fix tun unable to open

## v0.8.13

- Optimize delay test2

- Optimize delay test

- Add check ip

- add check ip request

## v0.8.12

- Fix the problem that the download of remote resources failed after GeodataMode was turned on, which caused the application to flash back.

- Fix edit profile error

- Fix quickStart change proxy error

- Fix core version

## v0.8.10

- Fix core version

## v0.8.9

- Update file_picker

- Add resources page

- Optimize more detail

- Add access selected sorted

- Fix notification duplicate creation issue

- Fix AccessControl click issue

## v0.8.7

- Fix Workflow

- Fix Linux unable to open

- Update README.md 3

- Create LICENSE

- Update README.md 2

- Update README.md

- Optimize workFlow

## v0.8.6

- optimize checkUpdate

## v0.8.5

- Fix submit error

## v0.8.4

- add WebDAV

- add Auto check updates

- Optimize more details

- optimize delayTest

## v0.8.2

- upgrade flutter version

## v0.8.1

- Update kernel

- Add import profile via QR code image

## v0.8.0

- Add compatibility mode and adapt clash scheme.

## v0.7.14

- update Version

- Reconstruction application proxy logic

## v0.7.13

- Fix Tab destroy error

## v0.7.12

- Optimize repeat healthcheck

## v0.7.11

- Optimize Direct mode ui

## v0.7.10

- Optimize Healthcheck

- Remove proxies position animation, improve performance

- Add Telegram Link

- Update healthcheck policy

- New Check URLTest

- Fix the problem of invalid auto-selection

## v0.7.8

- New Async UpdateConfig

- add changeProfileDebounce

- Update Workflow

- Fix ChangeProfile block

- Fix Release Message Error

## v0.7.7

- Update Selector 2

## v0.7.6

- Update Version

- Fix Proxies Select Error

## v0.7.5

- Fix the problem that the proxy group is empty in global mode.

- Fix the problem that the proxy group is empty in global mode.

## v0.7.4

- Add ProxyProvider2

## v0.7.3

- Add ProxyProvider

- Update Version

- Update ProxyGroup Sort

- Fix Android quickStart VpnService some problems

## v0.7.1

- Update version

- Set Android notification low importance

- Fix the issue that VpnService can't be closed correctly in special cases

- Fix the problem that TileService is not destroyed correctly in some cases

- Adjust tab animation defaults

- Add Telegram in README_zh_CN.md

- Add Telegram

## v0.7.0

- update mobile_scanner

- Initial commit

## v0.8.108

- Fix VPN uptime display for multi-day sessions (no more `999:59:59` ceiling; show `Nd HH:MM:SS`).
- Add dashboard service-reachability tile (search / social / AI / streaming probes through the current node).
- Show url-test / fallback current node with restore-auto, plus enable-auto-select flow.
- Fix Linux taskbar icon grouping on Ubuntu/Debian via `StartupWMClass`.
- Add auto-select geo sticky policy so url-test/fallback can stay in a chosen region.

## v0.8.107

- Integrate upstream/dev: package icon loading + connections ActivePolling, Windows group delay/RPC fix, commented-policy cleanup.
- Rebase fork onto upstream/main with performance push path, Tailscale outbounds/bypass, and Geo identity.

## v0.8.106

- Port fork main features onto upstream/dev: performance push path, Tailscale outbounds/bypass, and Geo identity.
- Add fork-friendly release.yaml workflow.
- Include delay-test and CoreEventManager dispatch robustness.

## v0.8.96

- Optimize commented policy

- Fix whole group delay test failing on Windows

- Optimize package icon loading and connections polling

## v0.8.95

- Optimize Android TV launcher icon

- Optimize back navigation

- Optimize more details

- Fix some issues

- Optimize app layout

- Optimize focus control

- Adjust android process

## v0.8.94

- Fix macos performance issue

- Support custom global-ua

- Update core

- Optimize some details

- Fix linux silent launching not working

## v0.8.93

- Support custom overwrite

- Support run on demand

- Optimize windows ipc

- Optimize windows arm64

- Optimize build

- Optimize some details

- Update core

## v0.8.92

- Add sqlite store

- Optimize android quick action

- Optimize backup and restore

- Optimize more details

## v0.8.91

- Fix windows some issues

- Optimize overwrite handle

- Optimize access control page

- Optimize some details

## v0.8.90

- Fix android tile service

- Support append system DNS

- Fix some issues

- Update changelog

## v0.8.89

- Fix some issues

- Optimize Windows service mode

- Update core

- Update changelog

## v0.8.88

- Add android separates the core process

- Support core status check and force restart

- Optimize proxies page and access page

- Update flutter and pub dependencies

- Update go version

- Optimize more details

- Update changelog

## v0.8.87

- Optimize desktop view

- Optimize logs, requests, connection pages

- Optimize windows tray auto hide

- Optimize some details

- Update core

- Update changelog

## v0.8.86

- Fix windows tun issues

- Optimize android get system dns

- Optimize more details

- Update changelog

## v0.8.85

- Support override script

- Support proxies search

- Support svg display

- Optimize config persistence

- Add some scenes auto close connections

- Update core

- Optimize more details

## v0.8.84

- Fix windows service verify issues

- Update changelog

## v0.8.83

- Add windows server mode start process verify

- Add linux deb dependencies

- Add backup recovery strategy select

- Support custom text scaling

- Optimize the display of different text scale

- Optimize windows setup experience

- Optimize startTun performance

- Optimize android tv experience

- Optimize default option

- Optimize computed text size

- Optimize hyperOS freeform window

- Add developer mode

- Update core

- Optimize more details

- Add issues template

- Update changelog

## v0.8.82

- Optimize android vpn performance

- Add custom primary color and color scheme

- Add linux nad windows arm release

- Optimize requests and logs page

- Fix map input page delete issues

- Update changelog

## v0.8.81

- Add rule override

- Update core

- Optimize more details

- Update changelog

## v0.8.80

- Optimize dashboard performance

- Fix some issues

- Fix unselected proxy group delay issues

- Fix asn url issues

- Update changelog

## v0.8.79

- Fix tab delay view issues

- Fix tray action issues

- Fix get profile redirect client ua issues

- Fix proxy card delay view issues

- Add Russian, Japanese adaptation

- Fix some issues

- Update changelog

## v0.8.78

- Fix list form input view issues

- Fix traffic view issues

- Update changelog

## v0.8.77

- Optimize performance

- Update core

- Optimize core stability

- Fix linux tun authority check error

- Fix some issues

- Fix scroll physics error

- Update changelog

## v0.8.75

- Add windows storage corruption detection

- Fix core crash caused by windows resource manager restart

- Optimize logs, requests, access to pages

- Fix macos bypass domain issues

- Update changelog

## v0.8.74

- Fix some issues

- Update changelog

## v0.8.73

- Update popup menu

- Add file editor

- Fix android service issues

- Optimize desktop background performance

- Optimize android main process performance

- Optimize delay test

- Optimize vpn protect

- Update changelog

## v0.8.72

- Update core

- Fix some issues

- Update changelog

## v0.8.71

- Remake dashboard

- Optimize theme

- Optimize more details

- Update flutter version

- Update changelog

## v0.8.70

- Support better window position memory

- Add windows arm64 and linux arm64 build script

- Optimize some details

## v0.8.69

- Remake desktop

- Optimize change proxy

- Optimize network check

- Fix fallback issues

- Optimize lots of details

- Update change.yaml

- Fix android tile issues

- Fix windows tray issues

- Support setting bypassDomain

- Update flutter version

- Fix android service issues

- Fix macos dock exit button issues

- Add route address setting

- Optimize provider view

- Update changelog

- Update CHANGELOG.md

## v0.8.67

- Add android shortcuts

- Fix init params issues

- Fix dynamic color issues

- Optimize navigator animate

- Optimize window init

- Optimize fab

- Optimize save

## v0.8.66

- Fix the collapse issues

- Add fontFamily options

## v0.8.65

- Update core version

- Update flutter version

- Optimize ip check

- Optimize url-test

## v0.8.64

- Update release message

- Init auto gen changelog

- Fix windows tray issues

- Fix urltest issues

- Add auto changelog

- Fix windows admin auto launch issues

- Add android vpn options

- Support proxies icon configuration

- Optimize android immersion display

- Fix some issues

- Optimize ip detection

- Support android vpn ipv6 inbound switch

- Support log export

- Optimize more details

- Fix android system dns issues

- Optimize dns default option

- Fix some issues

- Update readme

## v0.8.60

- Fix build error2

- Fix build error

- Support desktop hotkey

- Support android ipv6 inbound

- Support android system dns

- fix some bugs

## v0.8.59

- Fix delete profile error

## v0.8.58

- Fix submit error 2

- Fix submit error

- Optimize DNS strategy

- Fix the problem that the tray is not displayed in some cases

- Optimize tray

- Update core

- Fix some error

## v0.8.57

- Fix tun update issues

- Add DNS override
- Fixed some bugs
- Optimize more detail

- Add Hosts override

## v0.8.56

- fix android tip error
- fix windows auto launch error

## v0.8.55

- Fix windows tray issues

- Optimize windows logic

- Optimize app logic

- Support windows administrator auto launch

- Support android close vpn

## v0.8.53

- Change flutter version

- Support profiles sort

- Support windows country flags display

- Optimize proxies page and profiles page columns

## v0.8.52

- Update flutter version

- Update version

- Update timeout time

- Update access control page

- Fix bug

## v0.8.51

- Optimize provider page

- Optimize delay test

- Support local backup and recovery

- Fix android tile service issues

## v0.8.49

- Fix linux core build error

- Add proxy-only traffic statistics

- Update core

- Optimize more details

- Merge pull request #140 from txyyh/main

- 添加自建 F-Droid 仓库相关 workflow
- Rename readme fingerprint

- Rename workflow deploy repo name

- Add download guide to README

- Add push release files to fdroid-repo

## v0.8.48

- Optimize proxies page

- Fix ua issues

- Optimize more details

## v0.8.47

- Fix windows build error

## v0.8.46

- Update app icon

- Fix desktop backup error

- Optimize request ua

- Change android icon

- Optimize dashboard

## v0.8.44

- Remove request validate certificate

- Sync core

## v0.8.43

- Fix windows error

## v0.8.42

- Fix setup.dart error

- Fix android system proxy not effective

- Add macos arm64

## v0.8.41

- Optimize proxies page

- Support mouse drag scroll

- Adjust desktop ui

- Revert "Fix android vpn issues"

- This reverts commit 891977408e6938e2acd74e9b9adb959c48c79988.

## v0.8.40

- Fix android vpn issues

- Fix android vpn issues

- Rollback partial modification

## v0.8.39

- Fix the problem that ui can't be synchronized when android vpn is occupied by an external

- Override default socksPort,port

## v0.8.38

- Fix fab issues

## v0.8.37

- Update version

- Fix the problem that vpn cannot be started in some cases

- Fix the problem that geodata url does not take effect

## v0.8.36

- Update ua

- Fix change outbound mode without check ip issues

- Separate android ui and vpn

- Fix url validate issues 2

- Add android hidden from the recent task

- Add geoip file

- Support modify geoData URL

## v0.8.35

- Fix url validate issues

- Fix check ip performance problem

- Optimize resources page

## v0.8.34

- Add ua selector

- Support modify test url

- Optimize android proxy

- Fix the error that async proxy provider could not selected the proxy

## v0.8.33

- Fix android proxy error

- Fix submit error

- Add windows tun

- Optimize android proxy

- Optimize change profile

- Update application ua

- Optimize delay test

## v0.8.32

- Fix android repeated request notification issues

## v0.8.31

- Fix memory overflow issues

## v0.8.30

- Optimize proxies expansion panel 2

- Fix android scan qrcode error

## v0.8.29

- Optimize proxies expansion panel

- Fix text error

## v0.8.28

- Optimize proxy

- Optimize delayed sorting performance

- Add expansion panel proxies page

- Support to adjust the proxy card size

- Support to adjust proxies columns number

- Fix autoRun show issues

- Fix Android 10 issues

- Optimize ip show

## v0.8.26

- Add intranet IP display

- Add connections page

- Add search in connections, requests

- Add keyword search in connections, requests, logs

- Add basic viewing editing capabilities

- Optimize update profile

## v0.8.25

- Update version

- Fix the problem of excessive memory usage in traffic usage.

- Add lightBlue theme color

- Fix start unable to update profile issues

- Fix flashback caused by process

## v0.8.23

- Add build version

- Optimize quick start

- Update system default option

## v0.8.22

- Update build.yml

- Fix android vpn close issues

- Add requests page

- Fix checkUpdate dark mode style error

- Fix quickStart error open app

- Add memory proxies tab index

- Support hidden group

- Optimize logs

- Fix externalController hot load error

## v0.8.21

- Add tcp concurrent switch

- Add system proxy switch

- Add geodata loader switch

- Add external controller switch

- Add auto gc on trim memory

- Fix android notification error

## v0.8.20

- Fix ipv6 error

- Fix android udp direct error

- Add ipv6 switch

- Add access all selected button

- Remove android low version splash

## v0.8.19

- Update version

- Add allowBypass

- Fix Android only pick .text file issues

## v0.8.18

- Fix search issues

## v0.8.17

- Fix LoadBalance, Relay load error

- Fix build.yml4

- Fix build.yml3

- Fix build.yml2

- Fix build.yml

- Add search function at access control

- Fix the issues with the profile add button to cover the edit button

- Adapt LoadBalance and Relay

- Add arm

- Fix android notification icon error

## v0.8.16

- Add one-click update all profiles
- Add expire show

## v0.8.15

- Temp remove tun mode

- Remove macos in workflow

- Change go version

## v0.8.14

- Update Version

- Fix tun unable to open

## v0.8.13

- Optimize delay test2

- Optimize delay test

- Add check ip

- add check ip request

## v0.8.12

- Fix the problem that the download of remote resources failed after GeodataMode was turned on, which caused the
  application to flash back.

- Fix edit profile error

- Fix quickStart change proxy error

- Fix core version

## v0.8.10

- Fix core version

## v0.8.9

- Update file_picker

- Add resources page

- Optimize more detail

- Add access selected sorted

- Fix notification duplicate creation issue

- Fix AccessControl click issue

## v0.8.7

- Fix Workflow

- Fix Linux unable to open

- Update README.md 3

- Create LICENSE
- Update README.md 2

- Update README.md

- Optimize workFlow

## v0.8.6

- optimize checkUpdate

## v0.8.5

- Fix submit error

## v0.8.4

- add WebDAV

- add Auto check updates

- Optimize more details

- optimize delayTest

## v0.8.2

- upgrade flutter version

## v0.8.1

- Update kernel
- Add import profile via QR code image

## v0.8.0

- Add compatibility mode and adapt clash scheme.

## v0.7.14

- update Version

- Reconstruction application proxy logic

## v0.7.13

- Fix Tab destroy error

## v0.7.12

- Optimize repeat healthcheck

## v0.7.11

- Optimize Direct mode ui

## v0.7.10

- Optimize Healthcheck

- Remove proxies position animation, improve performance
- Add Telegram Link

- Update healthcheck policy

- New Check URLTest

- Fix the problem of invalid auto-selection

## v0.7.8

- New Async UpdateConfig

- add changeProfileDebounce

- Update Workflow

- Fix ChangeProfile block

- Fix Release Message Error

## v0.7.7

- Update Selector 2

## v0.7.6

- Update Version

- Fix Proxies Select Error

## v0.7.5

- Fix the problem that the proxy group is empty in global mode.

- Fix the problem that the proxy group is empty in global mode.

## v0.7.4

- Add ProxyProvider2

## v0.7.3

- Add ProxyProvider

- Update Version

- Update ProxyGroup Sort

- Fix Android quickStart VpnService some problems

## v0.7.1

- Update version

- Set Android notification low importance

- Fix the issue that VpnService can't be closed correctly in special cases

- Fix the problem that TileService is not destroyed correctly in some cases

- Adjust tab animation defaults

- Add Telegram in README_zh_CN.md

- Add Telegram

## v0.7.0

- update mobile_scanner

- Initial commit