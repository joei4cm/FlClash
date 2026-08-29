import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/geo_identity.freezed.dart';
part 'generated/geo_identity.g.dart';

const defaultGeoIdentityProps = GeoIdentityProps();

/// How Geo Identity should take over traffic when protect is turned on.
///
/// - [auto]: leave the user's current system-proxy / TUN / VPN settings alone;
///   if nothing is capturing yet, enable TUN (desktop) or VPN (Android) only.
/// - [tun]: ensure TUN (desktop) / VPN (Android) is on; do not force system proxy.
/// - [systemProxy]: ensure system proxy is on (desktop); do not force TUN.
/// - [both]: ensure both system proxy and TUN/VPN are on (legacy behavior).
enum GeoIdentityCaptureMode { auto, tun, systemProxy, both }

/// Desired capture toggles when enabling geo-identity protect.
///
/// `null` means leave the current user setting unchanged.
class GeoIdentityCaptureActions {
  const GeoIdentityCaptureActions({
    this.setSystemProxy,
    this.setTunEnable,
    this.setVpnEnable,
  });

  final bool? setSystemProxy;
  final bool? setTunEnable;
  final bool? setVpnEnable;
}

/// Resolve which capture toggles to flip for [mode] given current settings.
GeoIdentityCaptureActions resolveGeoIdentityCaptureActions({
  required GeoIdentityCaptureMode mode,
  required bool isDesktop,
  required bool currentSystemProxy,
  required bool currentTunEnable,
  required bool currentVpnEnable,
}) {
  if (!isDesktop) {
    final needsVpn = switch (mode) {
      GeoIdentityCaptureMode.auto => !currentVpnEnable,
      GeoIdentityCaptureMode.tun ||
      GeoIdentityCaptureMode.systemProxy ||
      GeoIdentityCaptureMode.both => !currentVpnEnable,
    };
    return GeoIdentityCaptureActions(
      setVpnEnable: needsVpn ? true : null,
    );
  }

  return switch (mode) {
    GeoIdentityCaptureMode.auto =>
      (!currentSystemProxy && !currentTunEnable)
          ? const GeoIdentityCaptureActions(setTunEnable: true)
          : const GeoIdentityCaptureActions(),
    GeoIdentityCaptureMode.tun => GeoIdentityCaptureActions(
      setTunEnable: currentTunEnable ? null : true,
    ),
    GeoIdentityCaptureMode.systemProxy => GeoIdentityCaptureActions(
      setSystemProxy: currentSystemProxy ? null : true,
    ),
    GeoIdentityCaptureMode.both => GeoIdentityCaptureActions(
      setSystemProxy: currentSystemProxy ? null : true,
      setTunEnable: currentTunEnable ? null : true,
    ),
  };
}

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

    /// How protect should enable traffic capture when turned on.
    @Default(GeoIdentityCaptureMode.auto) GeoIdentityCaptureMode captureMode,

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
