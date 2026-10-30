import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' show Size;

import 'package:fl_clash/common/world_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late WorldMapData map;

  setUpAll(() {
    map = WorldMapData.decode(File(WorldMapData.assetPath).readAsBytesSync());
  });

  test('decodes the packed Natural Earth countries', () {
    expect(map.countries.length, greaterThan(200));
    expect(
      map.countries.map((country) => country.iso).toSet(),
      containsAll(['US', 'CN', 'GB', 'JP', 'FR', 'AU', 'HK', 'TW']),
    );
  });

  test('rejects a truncated or unknown payload', () {
    expect(
      () => WorldMapData.decode(
        File(WorldMapData.assetPath).readAsBytesSync().sublist(0, 12),
      ),
      throwsFormatException,
    );
    expect(() => WorldMapData.decode(Uint8List(8)), throwsFormatException);
  });

  test('contains cities inside their countries and not the ocean', () {
    expect(map.contains('US', 37.39, -122.08), isTrue);
    expect(map.contains('US', 39.83, -98.58), isTrue);
    expect(map.contains('US', 0, -30), isFalse);
    expect(map.contains('GB', 51.5, -0.12), isTrue);
    expect(map.contains('CN', 39.9, 116.4), isTrue);
    expect(map.contains('JP', 35.69, 139.69), isTrue);
    expect(map.contains('FR', 48.86, 2.35), isTrue);
    expect(map.contains('AU', -33.87, 151.2), isTrue);
    expect(map.contains('TW', 25.03, 121.5), isTrue);
  });

  test('projects a country outline onto the map', () {
    final unitedStates = map.countries.firstWhere(
      (country) => country.iso == 'US',
    );
    final bounds = unitedStates.path(const Size(360, 180)).getBounds();
    expect(bounds.width, greaterThan(20));
    expect(bounds.height, greaterThan(10));
  });
}
