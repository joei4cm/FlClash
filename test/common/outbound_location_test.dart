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

  test('frames the exit in the card and keeps the map covering it', () {
    const viewport = Size(360, 180);
    const latitude = 37.39;
    const longitude = -122.08;
    final (scale, translation) = frameOutboundMap(
      viewport: viewport,
      latitude: latitude,
      longitude: longitude,
    );
    final marker =
        outboundLatLonToOffset(latitude, longitude, viewport) * scale +
        translation;
    expect(scale, 3.2);
    expect(marker.dx, closeTo(180, 0.01));
    expect(marker.dy, closeTo(90, 0.01));
    expect(translation.dx, inInclusiveRange(viewport.width * (1 - scale), 0));
    expect(translation.dy, inInclusiveRange(viewport.height * (1 - scale), 0));

    final (edgeScale, edge) = frameOutboundMap(
      viewport: viewport,
      latitude: 71,
      longitude: 170,
      scale: 8,
    );
    expect(edgeScale, 8);
    expect(edge.dx, viewport.width * (1 - edgeScale));
    expect(edge.dy, inInclusiveRange(viewport.height * (1 - edgeScale), 0));
  });

  test('projects lat/lon onto an equirectangular map', () {
    const size = Size(360, 180);
    expect(outboundLatLonToOffset(0, 0, size), const Offset(180, 90));
    expect(outboundLatLonToOffset(90, -180, size), const Offset(0, 0));
    expect(outboundLatLonToOffset(-90, 180, size), const Offset(360, 180));
  });
}
