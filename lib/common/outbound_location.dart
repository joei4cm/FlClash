import 'dart:ui' show Offset, Size;

import 'package:fl_clash/models/models.dart';

/// Rough country centroids for when a probe only returns an ISO code.
const countryCentroids = <String, (double, double)>{
  'US': (39.8283, -98.5795),
  'CA': (56.1304, -106.3468),
  'MX': (23.6345, -102.5528),
  'BR': (-14.2350, -51.9253),
  'AR': (-38.4161, -63.6167),
  'GB': (55.3781, -3.4360),
  'IE': (53.1424, -7.6921),
  'FR': (46.2276, 2.2137),
  'DE': (51.1657, 10.4515),
  'NL': (52.1326, 5.2913),
  'BE': (50.5039, 4.4699),
  'ES': (40.4637, -3.7492),
  'PT': (39.3999, -8.2245),
  'IT': (41.8719, 12.5674),
  'CH': (46.8182, 8.2275),
  'SE': (60.1282, 18.6435),
  'NO': (60.4720, 8.4689),
  'FI': (61.9241, 25.7482),
  'DK': (56.2639, 9.5018),
  'PL': (51.9194, 19.1451),
  'CZ': (49.8175, 15.4730),
  'AT': (47.5162, 14.5501),
  'RU': (61.5240, 105.3188),
  'UA': (48.3794, 31.1656),
  'TR': (38.9637, 35.2433),
  'IL': (31.0461, 34.8516),
  'AE': (23.4241, 53.8478),
  'SA': (23.8859, 45.0792),
  'IN': (20.5937, 78.9629),
  'SG': (1.3521, 103.8198),
  'MY': (4.2105, 101.9758),
  'ID': (-0.7893, 113.9213),
  'TH': (15.8700, 100.9925),
  'VN': (14.0583, 108.2772),
  'PH': (12.8797, 121.7740),
  'JP': (36.2048, 138.2529),
  'KR': (35.9078, 127.7669),
  'CN': (35.8617, 104.1954),
  'HK': (22.3193, 114.1694),
  'TW': (23.6978, 120.9605),
  'MO': (22.1987, 113.5439),
  'AU': (-25.2744, 133.7751),
  'NZ': (-40.9006, 174.8860),
  'ZA': (-30.5595, 22.9375),
  'EG': (26.8206, 30.8025),
  'NG': (9.0820, 8.6753),
};

/// Exact probe coordinates when present; otherwise a country centroid.
(double, double)? resolveOutboundMapPoint(IpInfo info) {
  if (info.hasCoordinates) {
    return (info.latitude!, info.longitude!);
  }
  return countryCentroids[info.countryCode.trim().toUpperCase()];
}

bool isApproximateOutboundLocation(IpInfo info) => !info.hasCoordinates;

/// Equirectangular projection used by the outbound location map.
Offset outboundLatLonToOffset(double latitude, double longitude, Size size) {
  final x = (longitude + 180) / 360 * size.width;
  final y = (90 - latitude) / 180 * size.height;
  return Offset(x, y);
}

(double, Offset) frameOutboundMap({
  required Size viewport,
  required double latitude,
  required double longitude,
  double scale = 3.2,
}) {
  final framed = scale.clamp(1.0, 8.0);
  final mapPoint = outboundLatLonToOffset(latitude, longitude, viewport);
  final centered = viewport.center(Offset.zero) - mapPoint * framed;
  final minX = viewport.width * (1 - framed);
  final minY = viewport.height * (1 - framed);
  return (
    framed,
    Offset(
      centered.dx.clamp(minX, 0).toDouble(),
      centered.dy.clamp(minY, 0).toDouble(),
    ),
  );
}
