#!/usr/bin/env bash
# Refresh the bundled MMDB / ASN / GEOIP / GEOSITE databases from MetaCubeX
# meta-rules-dat "latest" release assets. Keep URLs in sync with
# defaultGeoXUrl in lib/models/clash_config.dart and on-disk names with
# MMDB / ASN / GEOIP / GEOSITE in lib/common/constant.dart.
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root="$(cd "$script_dir/.." && pwd)"
out_dir="${GEO_ASSETS_DIR:-"$root/assets/data"}"
base_url="${GEO_ASSETS_BASE_URL:-https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest}"

die() {
  echo "error: $*" >&2
  exit 1
}

command -v curl >/dev/null || die "curl is required"
command -v sha256sum >/dev/null || die "sha256sum is required"
mkdir -p "$out_dir"

# dest_name|remote_name
assets=(
  "GEOIP.metadb|geoip.metadb"
  "ASN.mmdb|GeoLite2-ASN.mmdb"
  "GEOIP.dat|geoip.dat"
  "GEOSITE.dat|geosite.dat"
)

download_one() {
  local dest_name="$1"
  local remote_name="$2"
  local url="$base_url/$remote_name"
  local dest="$out_dir/$dest_name"
  local tmp
  tmp="$(mktemp "$out_dir/.$dest_name.XXXXXX")"
  # shellcheck disable=SC2064
  trap "rm -f '$tmp'" RETURN

  echo "Fetching $remote_name -> $dest_name"
  local attempt
  for attempt in 1 2 3 4 5; do
    if curl -fsSL --retry 3 --retry-delay 2 --connect-timeout 30 \
      -o "$tmp" "$url"; then
      break
    fi
    if ((attempt == 5)); then
      die "failed to download $url"
    fi
    echo "download failed (attempt $attempt); retrying..." >&2
    sleep $((attempt * 5))
  done

  local size
  size="$(wc -c <"$tmp" | tr -d ' ')"
  ((size > 1024)) || die "$dest_name is only ${size}B; refusing to replace"

  local before after
  before="$(sha256sum "$dest" 2>/dev/null | awk '{print $1}' || true)"
  after="$(sha256sum "$tmp" | awk '{print $1}')"
  mv -f "$tmp" "$dest"
  if [[ "$before" == "$after" ]]; then
    echo "  unchanged ($after, ${size} bytes)"
  else
    echo "  updated ${before:-missing} -> $after (${size} bytes)"
  fi
}

changed=0
for entry in "${assets[@]}"; do
  IFS='|' read -r dest_name remote_name <<<"$entry"
  before="$(sha256sum "$out_dir/$dest_name" 2>/dev/null | awk '{print $1}' || true)"
  download_one "$dest_name" "$remote_name"
  after="$(sha256sum "$out_dir/$dest_name" | awk '{print $1}')"
  if [[ "$before" != "$after" ]]; then
    changed=1
  fi
done

if ((changed)); then
  echo "Geo assets under $out_dir were refreshed."
else
  echo "Geo assets under $out_dir already matched latest."
fi
