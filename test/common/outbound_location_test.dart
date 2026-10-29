import 'dart:ui' show Offset, Size;

import 'package:fl_clash/common/outbound_location.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveOutboundMapPoint', () {
    test('prefers exact coordinates from the probe', () {
      const info = IpInfo(
        ip: '8.8.8.8',
        countryCode: 'US',
        city: 'Mountain View',
        region: 'California',
        latitude: 37.386,
        longitude: -122.0838,
      );
      expect(resolveOutboundMapPoint(info), (37.386, -122.0838));
      expect(isApproximateOutboundLocation(info), isFalse);
    });

    test('falls back to a country centroid', () {
      const info = IpInfo(ip: '1.1.1.1', countryCode: 'US');
      expect(resolveOutboundMapPoint(info), countryCentroids['US']);
      expect(isApproximateOutboundLocation(info), isTrue);
    });
  });

  test('projects lat/lon onto an equirectangular map', () {
    final size = const Size(360, 180);
    expect(outboundLatLonToOffset(0, 0, size), const Offset(180, 90));
    expect(outboundLatLonToOffset(90, -180, size), const Offset(0, 0));
    expect(outboundLatLonToOffset(-90, 180, size), const Offset(360, 180));
  });
}
