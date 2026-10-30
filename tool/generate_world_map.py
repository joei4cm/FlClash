#!/usr/bin/env python3
"""Pack Natural Earth 1:50m admin-0 countries into assets/data/world_countries.wmap.

The vectors are public domain: https://www.naturalearthdata.com/
Pass the ne_50m_admin_0_countries.geojson path as the only argument.
"""

import json
import struct
import sys
from pathlib import Path

_SCALE = 100
_OUT = Path('assets/data/world_countries.wmap')


def _iso(props: dict) -> str:
    for key in ('ISO_A2', 'ISO_A2_EH'):
        value = str(props.get(key) or '')
        if len(value) == 2 and value.isalpha():
            return value.upper()
    return ''


def _rings(geometry: dict) -> list[list[list[float]]]:
    kind = geometry.get('type')
    coordinates = geometry.get('coordinates') or []
    if kind == 'Polygon':
        polygons = [coordinates]
    elif kind == 'MultiPolygon':
        polygons = coordinates
    else:
        return []
    rings: list[list[list[float]]] = []
    for polygon in polygons:
        for ring in polygon:
            if len(ring) >= 3:
                rings.append(ring)
    return rings


def _pack_country(iso: str, rings: list[list[list[float]]]) -> bytes:
    body = struct.pack('<B', len(iso)) + iso.encode('ascii')
    body += struct.pack('<H', len(rings))
    for ring in rings:
        body += struct.pack('<H', len(ring))
        for lon, lat, *_rest in ring:
            body += struct.pack(
                '<hh',
                max(-32768, min(32767, round(lon * _SCALE))),
                max(-32768, min(32767, round(lat * _SCALE))),
            )
    return body


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit(f'usage: {sys.argv[0]} ne_50m_admin_0_countries.geojson')
    features = json.loads(Path(sys.argv[1]).read_text())['features']
    countries = bytearray()
    count = 0
    for feature in features:
        geometry = feature.get('geometry') or {}
        rings = _rings(geometry)
        if not rings:
            continue
        countries += _pack_country(_iso(feature.get('properties') or {}), rings)
        count += 1
    payload = struct.pack('<4sHH', b'WMAP', 1, count) + countries
    _OUT.write_bytes(payload)
    print(f'wrote {_OUT} ({len(payload)} bytes, {count} countries)')


if __name__ == '__main__':
    main()
