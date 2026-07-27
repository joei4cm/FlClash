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

    /// Previous OS timezone id saved before an align action (for Restore).
    String? previousOsTimezone,

    /// Last OS timezone FlClash successfully applied.
    String? appliedOsTimezone,
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

/// External tools recommended by the geo-identity guide.
abstract final class GeoIdentityLinks {
  static const fuckClaude = 'https://fuck-claude.vercel.app/';
  static const geoMirror = 'https://github.com/Azurboy/geomirror';
  static const geoMirrorReleases =
      'https://github.com/Azurboy/geomirror/releases';
  static const checkApi = geoIdentityCheckApiUrl;
}
