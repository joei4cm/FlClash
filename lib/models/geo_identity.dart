import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/geo_identity.freezed.dart';
part 'generated/geo_identity.g.dart';

const defaultGeoIdentityProps = GeoIdentityProps();

/// Opt-in geo-identity protection for US AI exit consistency.
///
/// FlClash can verify and steer the **network exit**. Browser/OS fingerprints
/// (fonts, HTML5 geolocation, real OS timezone for Claude Code) still need
/// separate alignment (GeoMirror / system settings).
@freezed
abstract class GeoIdentityProps with _$GeoIdentityProps {
  const factory GeoIdentityProps({
    /// When true, FlClash treats geo identity as an active concern: prefer a US
    /// Accept-Language on network probes and surface capture-mode guidance.
    @Default(false) bool enable,

    /// Send `Accept-Language: en-US,en;q=0.9` on FuckClaude network probes so
    /// the server-side estimate is not polluted by a Chinese Accept-Language.
    @Default(true) bool useUsAcceptLanguage,
  }) = _GeoIdentityProps;

  factory GeoIdentityProps.fromJson(Map<String, Object?> json) =>
      _$GeoIdentityPropsFromJson(json);

  factory GeoIdentityProps.safeFromJson(Map<String, Object?>? json) {
    if (json == null) {
      return defaultGeoIdentityProps;
    }
    try {
      return GeoIdentityProps.fromJson(json);
    } catch (_) {
      return defaultGeoIdentityProps;
    }
  }
}

/// Accept-Language used when [GeoIdentityProps.useUsAcceptLanguage] is on.
const geoIdentityUsAcceptLanguage = 'en-US,en;q=0.9';

/// FuckClaude network check endpoint (IP geo + request headers).
const geoIdentityCheckApiUrl =
    'https://fuck-claude.vercel.app/api/check?format=json';

/// Helpers for the Tools → Geo identity checklist and network probe.
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

/// Parsed FuckClaude `/api/check?format=json` response.
class GeoIdentityNetworkReport {
  const GeoIdentityNetworkReport({
    required this.score,
    required this.band,
    required this.verdict,
    required this.message,
    required this.country,
    required this.timezone,
    required this.language,
    required this.estimate,
  });

  final int score;
  final String band;
  final String verdict;
  final String message;
  final String? country;
  final String? timezone;
  final String? language;
  final bool estimate;

  factory GeoIdentityNetworkReport.fromJson(Map<String, dynamic> json) {
    final geo = json['geo'];
    final signals = json['signals'];
    String? language;
    if (signals is List) {
      for (final item in signals) {
        if (item is Map && item['id'] == 'language') {
          final value = item['value'];
          language = value?.toString();
          break;
        }
      }
    }
    return GeoIdentityNetworkReport(
      score: (json['score'] as num?)?.toInt() ?? 0,
      band: (json['band'] ?? '').toString(),
      verdict: (json['verdict'] ?? '').toString(),
      message: (json['message'] ?? '').toString(),
      country: geo is Map ? geo['country']?.toString() : null,
      timezone: geo is Map ? geo['timezone']?.toString() : null,
      language: language,
      estimate: json['estimate'] == true,
    );
  }

  bool get isLowRisk => band.toLowerCase() == 'low';

  bool get looksUsExit {
    final value = country?.toUpperCase();
    return value == 'US' || value == 'USA' || value == 'UNITED STATES';
  }

  /// Network env is considered protected when exit geo looks US and band is low.
  bool get isProtected => looksUsExit && isLowRisk;
}

/// How FlClash is capturing traffic for geo-identity protection.
enum GeoIdentityCaptureMode {
  /// Core is not started — traffic is not forced through FlClash.
  inactive,

  /// Core started but neither system proxy nor TUN/VPN is on.
  /// FlClash's own probes still use mixed-port; most apps do not.
  mixedPortOnly,

  /// Desktop/Android system proxy only (some apps may bypass).
  systemProxy,

  /// Desktop TUN / Android VPN — broad capture.
  virtualNic,

  /// Both system proxy and TUN/VPN are on.
  both,
}

/// External tools recommended by the geo-identity guide.
abstract final class GeoIdentityLinks {
  static const fuckClaude = 'https://fuck-claude.vercel.app/';
  static const geoMirror = 'https://github.com/Azurboy/geomirror';
  static const geoMirrorReleases =
      'https://github.com/Azurboy/geomirror/releases';
  static const checkApi = geoIdentityCheckApiUrl;
}
