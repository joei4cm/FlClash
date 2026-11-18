import 'package:fl_clash/models/models.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;

import 'tailscale_setup.dart';

/// Official Tailscale Android package id.
const tailscaleAndroidPackageName = 'com.tailscale.ipn';

/// How FlClash should share the phone with Tailscale. Android allows only one
/// active [VpnService], so the two apps cannot both own the tunnel.
enum AndroidTailscaleMode {
  /// FlClash keeps VpnService; use embedded Tailscale outbounds for the
  /// tailnet. Turn the Tailscale app's VPN off.
  flclashVpn,

  /// Tailscale app owns VpnService; FlClash VPN is turned off (proxy-only).
  tailscaleAppVpn,
}

AndroidTailscaleMode resolveAndroidTailscaleMode({
  required bool vpnEnable,
  required bool tailscaleEnable,
}) {
  final mode = resolveTailscaleUsageMode(
    isAndroid: true,
    vpnEnable: vpnEnable,
    tailscaleEnable: tailscaleEnable,
    bypassTraffic: false,
  );
  return switch (mode) {
    TailscaleUsageMode.embedded => AndroidTailscaleMode.flclashVpn,
    TailscaleUsageMode.systemApp => AndroidTailscaleMode.tailscaleAppVpn,
  };
}

/// Settings applied when the user picks a coexistence mode.
({bool vpnEnable, bool tailscaleEnable, bool bypassTraffic})
androidTailscaleModeSettings(AndroidTailscaleMode mode) {
  return tailscaleUsageModeSettings(switch (mode) {
    AndroidTailscaleMode.flclashVpn => TailscaleUsageMode.embedded,
    AndroidTailscaleMode.tailscaleAppVpn => TailscaleUsageMode.systemApp,
  }, isAndroid: true);
}

bool packagesIncludeTailscaleApp(Iterable<Package> packages) {
  for (final package in packages) {
    if (package.packageName == tailscaleAndroidPackageName) {
      return true;
    }
  }
  return false;
}

@visibleForTesting
bool packagesIncludeTailscaleAppNames(Iterable<String> packageNames) {
  return packageNames.contains(tailscaleAndroidPackageName);
}
