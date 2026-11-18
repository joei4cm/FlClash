/// How the user wants FlClash to relate to Tailscale on this device.
enum TailscaleUsageMode {
  /// FlClash runs embedded Tailscale nodes (and keeps VPN on Android).
  embedded,

  /// Prefer the real Tailscale app/service: yield Android VPN, or keep
  /// Tailscale traffic direct on desktop.
  systemApp,
}

({bool vpnEnable, bool tailscaleEnable, bool bypassTraffic})
tailscaleUsageModeSettings(TailscaleUsageMode mode, {required bool isAndroid}) {
  return switch (mode) {
    TailscaleUsageMode.embedded => (
      vpnEnable: true,
      tailscaleEnable: true,
      bypassTraffic: false,
    ),
    TailscaleUsageMode.systemApp => (
      vpnEnable: false,
      // Desktop may still keep optional embedded nodes; Android yields fully.
      tailscaleEnable: isAndroid ? false : true,
      bypassTraffic: isAndroid ? false : true,
    ),
  };
}

TailscaleUsageMode resolveTailscaleUsageMode({
  required bool isAndroid,
  required bool vpnEnable,
  required bool tailscaleEnable,
  required bool bypassTraffic,
}) {
  if (isAndroid) {
    return vpnEnable
        ? TailscaleUsageMode.embedded
        : TailscaleUsageMode.systemApp;
  }
  if (bypassTraffic) {
    return TailscaleUsageMode.systemApp;
  }
  return TailscaleUsageMode.embedded;
}

/// Default route destinations that cover the Tailscale CGNAT range and MagicDNS.
const defaultTailscaleRouteSuggestions = <String>['100.64.0.0/10', 'ts.net'];
