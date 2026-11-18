import 'package:fl_clash/common/tailscale_android.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveAndroidTailscaleMode', () {
    test('prefers FlClash VPN when vpn is enabled', () {
      expect(
        resolveAndroidTailscaleMode(vpnEnable: true, tailscaleEnable: true),
        AndroidTailscaleMode.flclashVpn,
      );
      expect(
        resolveAndroidTailscaleMode(vpnEnable: true, tailscaleEnable: false),
        AndroidTailscaleMode.flclashVpn,
      );
    });

    test('uses Tailscale app mode when FlClash VPN is off', () {
      expect(
        resolveAndroidTailscaleMode(vpnEnable: false, tailscaleEnable: false),
        AndroidTailscaleMode.tailscaleAppVpn,
      );
      expect(
        resolveAndroidTailscaleMode(vpnEnable: false, tailscaleEnable: true),
        AndroidTailscaleMode.tailscaleAppVpn,
      );
    });
  });

  group('androidTailscaleModeSettings', () {
    test('FlClash VPN mode enables VPN and embedded Tailscale', () {
      final settings = androidTailscaleModeSettings(
        AndroidTailscaleMode.flclashVpn,
      );
      expect(settings.vpnEnable, isTrue);
      expect(settings.tailscaleEnable, isTrue);
      expect(settings.bypassTraffic, isFalse);
    });

    test('Tailscale app mode disables FlClash VPN and embedded Tailscale', () {
      final settings = androidTailscaleModeSettings(
        AndroidTailscaleMode.tailscaleAppVpn,
      );
      expect(settings.vpnEnable, isFalse);
      expect(settings.tailscaleEnable, isFalse);
      expect(settings.bypassTraffic, isFalse);
    });
  });

  group('packagesIncludeTailscaleApp', () {
    test('detects the official Tailscale package id', () {
      expect(
        packagesIncludeTailscaleApp([
          const Package(
            packageName: 'com.example.other',
            label: 'Other',
            system: false,
            internet: true,
            lastUpdateTime: 0,
          ),
          const Package(
            packageName: tailscaleAndroidPackageName,
            label: 'Tailscale',
            system: false,
            internet: true,
            lastUpdateTime: 1,
          ),
        ]),
        isTrue,
      );
    });

    test('returns false when Tailscale is not installed', () {
      expect(
        packagesIncludeTailscaleApp([
          const Package(
            packageName: 'com.example.other',
            label: 'Other',
            system: false,
            internet: true,
            lastUpdateTime: 0,
          ),
        ]),
        isFalse,
      );
      expect(packagesIncludeTailscaleAppNames(const []), isFalse);
      expect(
        packagesIncludeTailscaleAppNames(const [tailscaleAndroidPackageName]),
        isTrue,
      );
    });
  });
}
