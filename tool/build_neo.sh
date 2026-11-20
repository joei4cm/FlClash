#!/usr/bin/env bash
# Compile FlClash Neo (and host Core if missing) into libclash/<platform>/.
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root="$(cd "$script_dir/.." && pwd)"
cd "$root"

die() {
  echo "error: $*" >&2
  exit 1
}

host_os="$(uname -s)"
case "$host_os" in
  Linux)
    platform=linux
    goos=linux
    ;;
  Darwin)
    platform=macos
    goos=darwin
    ;;
  MINGW* | MSYS* | CYGWIN*)
    platform=windows
    goos=windows
    ;;
  *) die "unsupported host: $host_os" ;;
esac

host_arch="$(uname -m)"
case "$host_arch" in
  x86_64 | amd64) goarch=amd64 ;;
  aarch64 | arm64) goarch=arm64 ;;
  *) die "unsupported arch: $host_arch" ;;
esac

ext=""
[[ "$platform" == "windows" ]] && ext=".exe"

out_dir="${1:-$root/libclash/$platform}"
mkdir -p "$out_dir"

core_out="$out_dir/FlClashCore$ext"
neo_out="$out_dir/flclash-neo$ext"

tags="$(sed -n 's/^tags: *//p' build_config.yaml)"
ldflags="$(sed -n 's/^go_ldflags: *"\(.*\)"/\1/p' build_config.yaml)"
core_version="$(sed -n 's/^core_version: *//p' build_config.yaml)"
[[ -n "$tags" ]] || die "could not read tags from build_config.yaml"

if [[ ! -f "$core_out" ]]; then
  echo "building FlClashCore ($goos/$goarch) -> $core_out"
  (
    cd core
    GOOS="$goos" GOARCH="$goarch" CGO_ENABLED=0 go build \
      -ldflags="$ldflags -X github.com/metacubex/mihomo/constant.Version=$core_version" \
      -tags="$tags" \
      -o "$core_out" \
      ./cmd/core
  )
else
  echo "reusing existing Core: $core_out"
fi

echo "compiling tool/neo.dart -> $neo_out"
dart compile exe tool/neo.dart -o "$neo_out"
chmod +x "$neo_out" 2>/dev/null || true
chmod +x "$core_out" 2>/dev/null || true

echo "ok:"
ls -lh "$core_out" "$neo_out"
