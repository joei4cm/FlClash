import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/geo_identity.freezed.dart';
part 'generated/geo_identity.g.dart';

const defaultGeoIdentityProps = GeoIdentityProps();

enum GeoIdentityCaptureMode { auto, tun, systemProxy, both }

/// A null action leaves that capture toggle unchanged.
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
    return GeoIdentityCaptureActions(setVpnEnable: needsVpn ? true : null);
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

/// Protect steers the network exit. Browser fingerprints and the OS timezone stay outside FlClash.
@freezed
abstract class GeoIdentityProps with _$GeoIdentityProps {
  const factory GeoIdentityProps({
    @Default(false) bool enable,
    @Default(true) bool useUsAcceptLanguage,
    @Default(GeoIdentityCaptureMode.auto) GeoIdentityCaptureMode captureMode,
    String? previousOsTimezone,
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

const geoIdentityUsAcceptLanguage = 'en-US,en;q=0.9';

const geoIdentityCheckApiUrl =
    'https://fuck-claude.vercel.app/api/check?format=json';

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

  bool get isProtected => looksUsExit && isLowRisk;
}

abstract final class GeoIdentityLinks {
  static const fuckClaude = 'https://fuck-claude.vercel.app/';
  static const geoMirror = 'https://github.com/Azurboy/geomirror';
  static const geoMirrorReleases =
      'https://github.com/Azurboy/geomirror/releases';
  static const checkApi = geoIdentityCheckApiUrl;
}
