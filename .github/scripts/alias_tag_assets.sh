#!/usr/bin/env bash
# Copy FlClash-X.Y.Z-* artifacts to FlClash-X.Y.Z_abcdef-* when the release
# tag carries a 6-hex commit suffix. Old in-app updaters look up the long name;
# fixed clients and the release page keep the bare X.Y.Z name.
set -euo pipefail

TAG="${1:-${TAG:-}}"
DIR="${2:-.}"

if [[ -z "$TAG" ]]; then
  echo 'usage: alias_tag_assets.sh <tag> [dir]' >&2
  exit 2
fi

tag_version=$(printf '%s' "$TAG" | sed -E 's/^v//')
bare_version=$(printf '%s' "$tag_version" | sed -E 's/_[0-9a-fA-F]{6}$//')

if [[ "$tag_version" == "$bare_version" ]]; then
  echo "tag $TAG has no commit suffix; skipping aliases"
  exit 0
fi

cd "$DIR"
shopt -s nullglob
for f in FlClash-"$bare_version"-*; do
  [[ -f "$f" ]] || continue
  [[ "$f" == SHA256SUMS ]] && continue
  alias="FlClash-${tag_version}-${f#FlClash-${bare_version}-}"
  if [[ "$alias" == "$f" ]]; then
    continue
  fi
  cp -f -- "$f" "$alias"
  echo "aliased $f -> $alias"
done
