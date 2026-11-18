import 'package:fl_clash/common/tailscale_setup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('tailscaleUsageModeSettings', () {
    test('embedded keeps FlClash VPN and disables bypass', () {
      final android = tailscaleUsageModeSettings(
        TailscaleUsageMode.embedded,
        isAndroid: true,
      );
      expect(android.vpnEnable, isTrue);
      expect(android.tailscaleEnable, isTrue);
      expect(android.bypassTraffic, isFalse);

      final desktop = tailscaleUsageModeSettings(
        TailscaleUsageMode.embedded,
        isAndroid: false,
      );
      expect(desktop.vpnEnable, isTrue);
      expect(desktop.tailscaleEnable, isTrue);
      expect(desktop.bypassTraffic, isFalse);
    });

    test('systemApp yields Android VPN and enables desktop bypass', () {
      final android = tailscaleUsageModeSettings(
        TailscaleUsageMode.systemApp,
        isAndroid: true,
      );
      expect(android.vpnEnable, isFalse);
      expect(android.tailscaleEnable, isFalse);
      expect(android.bypassTraffic, isFalse);

      final desktop = tailscaleUsageModeSettings(
        TailscaleUsageMode.systemApp,
        isAndroid: false,
      );
      expect(desktop.vpnEnable, isFalse);
      expect(desktop.tailscaleEnable, isTrue);
      expect(desktop.bypassTraffic, isTrue);
    });
  });

  group('resolveTailscaleUsageMode', () {
    test('Android follows VPN ownership', () {
      expect(
        resolveTailscaleUsageMode(
          isAndroid: true,
          vpnEnable: true,
          tailscaleEnable: true,
          bypassTraffic: false,
        ),
        TailscaleUsageMode.embedded,
      );
      expect(
        resolveTailscaleUsageMode(
          isAndroid: true,
          vpnEnable: false,
          tailscaleEnable: false,
          bypassTraffic: false,
        ),
        TailscaleUsageMode.systemApp,
      );
    });

    test('desktop treats bypass as system-app companion mode', () {
      expect(
        resolveTailscaleUsageMode(
          isAndroid: false,
          vpnEnable: true,
          tailscaleEnable: true,
          bypassTraffic: true,
        ),
        TailscaleUsageMode.systemApp,
      );
      expect(
        resolveTailscaleUsageMode(
          isAndroid: false,
          vpnEnable: true,
          tailscaleEnable: true,
          bypassTraffic: false,
        ),
        TailscaleUsageMode.embedded,
      );
    });
  });
}
