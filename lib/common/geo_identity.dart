/// Helpers for the Tools → Geo identity checklist.
///
/// FlClash only controls the network exit. Browser / OS signals (timezone,
/// language, fonts, geolocation) live outside the proxy and must be aligned
/// separately when users want a consistent geo profile with a US exit IP.
class GeoIdentitySnapshot {
  const GeoIdentitySnapshot({
    required this.timeZoneName,
    required this.timeZoneOffset,
    required this.systemLocale,
  });

  final String timeZoneName;
  final Duration timeZoneOffset;
  final String systemLocale;

  factory GeoIdentitySnapshot.fromClock({
    required DateTime now,
    required String systemLocale,
  }) {
    return GeoIdentitySnapshot(
      timeZoneName: now.timeZoneName,
      timeZoneOffset: now.timeZoneOffset,
      systemLocale: systemLocale,
    );
  }

  bool get isUtcPlus8 => timeZoneOffset == const Duration(hours: 8);

  bool get looksChineseLocale {
    final locale = systemLocale.toLowerCase().replaceAll('_', '-');
    return locale.startsWith('zh');
  }

  bool get looksChinaTimezoneName {
    final name = timeZoneName.toLowerCase();
    const markers = <String>[
      'asia/shanghai',
      'asia/urumqi',
      'asia/chongqing',
      'asia/harbin',
      'asia/kashgar',
      'shanghai',
      'urumqi',
      'china standard',
      'china time',
    ];
    for (final marker in markers) {
      if (name.contains(marker)) {
        return true;
      }
    }
    return false;
  }

  /// High when both timezone and locale look China-local; medium for either.
  GeoIdentityRiskLevel get riskLevel {
    final timezoneHit = looksChinaTimezoneName || isUtcPlus8;
    if (timezoneHit && looksChineseLocale) {
      return GeoIdentityRiskLevel.high;
    }
    if (timezoneHit || looksChineseLocale) {
      return GeoIdentityRiskLevel.medium;
    }
    return GeoIdentityRiskLevel.low;
  }

  String get offsetLabel {
    final totalMinutes = timeZoneOffset.inMinutes;
    final sign = totalMinutes >= 0 ? '+' : '-';
    final abs = totalMinutes.abs();
    final hours = (abs ~/ 60).toString().padLeft(2, '0');
    final minutes = (abs % 60).toString().padLeft(2, '0');
    return 'UTC$sign$hours:$minutes';
  }
}

enum GeoIdentityRiskLevel { low, medium, high }

/// External tools recommended by the geo-identity guide.
abstract final class GeoIdentityLinks {
  static const fuckClaude = 'https://fuck-claude.vercel.app/';
  static const geoMirror = 'https://github.com/Azurboy/geomirror';
  static const geoMirrorReleases =
      'https://github.com/Azurboy/geomirror/releases';
}
