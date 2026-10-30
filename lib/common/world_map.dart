import 'dart:typed_data';
import 'dart:ui' show Offset, Path, PathFillType, Size;

import 'package:fl_clash/common/outbound_location.dart';
import 'package:flutter/services.dart';

/// Natural Earth 1:50m admin-0 countries, public domain, packed by
/// `tool/generate_world_map.py`. Coordinates are hundredths of a degree.
class WorldMapData {
  const WorldMapData(this.countries);

  static const assetPath = 'assets/data/world_countries.wmap';

  final List<WorldCountry> countries;

  static Future<WorldMapData>? _loading;

  static Future<WorldMapData> load() => _loading ??= _read();

  static Future<WorldMapData> _read() async {
    final data = await rootBundle.load(assetPath);
    return decode(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    );
  }

  static WorldMapData decode(Uint8List bytes) {
    final data = ByteData.sublistView(bytes);
    if (bytes.length < 8 ||
        String.fromCharCodes(bytes.sublist(0, 4)) != 'WMAP' ||
        data.getUint16(4, Endian.little) != 1) {
      throw const FormatException('unrecognized world map');
    }
    final count = data.getUint16(6, Endian.little);
    final countries = <WorldCountry>[];
    var offset = 8;
    for (var index = 0; index < count; index++) {
      final parsed = _readCountry(data, offset);
      countries.add(parsed.$1);
      offset = parsed.$2;
    }
    if (offset != bytes.length) {
      throw const FormatException('world map has trailing bytes');
    }
    return WorldMapData(countries);
  }

  bool contains(String iso, double latitude, double longitude) {
    for (final country in countries) {
      if (country.iso == iso && country.contains(latitude, longitude)) {
        return true;
      }
    }
    return false;
  }
}

class WorldCountry {
  const WorldCountry({
    required this.iso,
    required this.longitudeE2,
    required this.latitudeE2,
  });

  final String iso;
  final List<Int16List> longitudeE2;
  final List<Int16List> latitudeE2;

  bool contains(double latitude, double longitude) {
    var inside = false;
    for (var ring = 0; ring < longitudeE2.length; ring++) {
      if (_ringContains(
        longitudeE2[ring],
        latitudeE2[ring],
        longitude,
        latitude,
      )) {
        inside = !inside;
      }
    }
    return inside;
  }

  Path path(Size size) {
    final outline = Path()..fillType = PathFillType.evenOdd;
    for (var ring = 0; ring < longitudeE2.length; ring++) {
      final longitudes = longitudeE2[ring];
      final latitudes = latitudeE2[ring];
      if (longitudes.isEmpty) {
        continue;
      }
      var point = _point(latitudes[0], longitudes[0], size);
      outline.moveTo(point.dx, point.dy);
      for (var index = 1; index < longitudes.length; index++) {
        point = _point(latitudes[index], longitudes[index], size);
        outline.lineTo(point.dx, point.dy);
      }
      outline.close();
    }
    return outline;
  }
}

Offset _point(int latitudeE2, int longitudeE2, Size size) =>
    outboundLatLonToOffset(latitudeE2 / 100, longitudeE2 / 100, size);

bool _ringContains(
  Int16List longitudeE2,
  Int16List latitudeE2,
  double longitude,
  double latitude,
) {
  var inside = false;
  for (
    var index = 0, previous = longitudeE2.length - 1;
    index < longitudeE2.length;
    previous = index++
  ) {
    final y1 = latitudeE2[index] / 100;
    final y2 = latitudeE2[previous] / 100;
    if ((y1 > latitude) == (y2 > latitude)) {
      continue;
    }
    final x1 = longitudeE2[index] / 100;
    final x2 = longitudeE2[previous] / 100;
    final cross = (x2 - x1) * (latitude - y1) / (y2 - y1) + x1;
    if (longitude < cross) {
      inside = !inside;
    }
  }
  return inside;
}

(WorldCountry, int) _readCountry(ByteData data, int offset) {
  final isoLength = _byte(data, offset);
  offset += 1;
  if (isoLength > 2) {
    throw const FormatException('world map country code is too long');
  }
  final isoBytes = Uint8List(isoLength);
  for (var index = 0; index < isoLength; index++) {
    isoBytes[index] = _byte(data, offset + index);
  }
  offset += isoLength;
  final ringCount = _uint16(data, offset);
  offset += 2;
  final longitudes = <Int16List>[];
  final latitudes = <Int16List>[];
  for (var ring = 0; ring < ringCount; ring++) {
    final pointCount = _uint16(data, offset);
    offset += 2;
    final longitude = Int16List(pointCount);
    final latitude = Int16List(pointCount);
    for (var point = 0; point < pointCount; point++) {
      longitude[point] = _int16(data, offset);
      latitude[point] = _int16(data, offset + 2);
      offset += 4;
    }
    longitudes.add(longitude);
    latitudes.add(latitude);
  }
  return (
    WorldCountry(
      iso: String.fromCharCodes(isoBytes),
      longitudeE2: longitudes,
      latitudeE2: latitudes,
    ),
    offset,
  );
}

int _byte(ByteData data, int offset) {
  _require(data, offset, 1);
  return data.getUint8(offset);
}

int _uint16(ByteData data, int offset) {
  _require(data, offset, 2);
  return data.getUint16(offset, Endian.little);
}

int _int16(ByteData data, int offset) {
  _require(data, offset, 2);
  return data.getInt16(offset, Endian.little);
}

void _require(ByteData data, int offset, int length) {
  if (offset < 0 || offset + length > data.lengthInBytes) {
    throw const FormatException('world map truncated');
  }
}
