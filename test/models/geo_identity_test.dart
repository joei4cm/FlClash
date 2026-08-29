import 'package:fl_clash/common/geo_identity_host.dart';
import 'package:fl_clash/models/geo_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeoIdentityNetworkReport', () {
    test('parses FuckClaude JSON and marks US low as protected', () {
      final report = GeoIdentityNetworkReport.fromJson({
        'score': 3,
        'band': 'low',
        'verdict': 'Low risk',
        'message': 'ok',
        'estimate': true,
        'geo': {'country': 'US', 'timezone': 'America/Los_Angeles'},
        'signals': [
          {'id': 'language', 'value': 'en-US, en'},
        ],
      });
      expect(report.looksUsExit, isTrue);
      expect(report.isLowRisk, isTrue);
      expect(report.isProtected, isTrue);
      expect(report.language, 'en-US, en');
      expect(report.timezone, 'America/Los_Angeles');
    });

    test(
      'marks zh Accept-Language on US IP as not protected when band rises',
      () {
        final report = GeoIdentityNetworkReport.fromJson({
          'score': 32,
          'band': 'medium',
          'verdict': 'medium',
          'message': 'maybe',
          'estimate': true,
          'geo': {'country': 'US', 'timezone': 'America/Los_Angeles'},
          'signals': [
            {'id': 'language', 'value': 'zh'},
          ],
        });
        expect(report.looksUsExit, isTrue);
        expect(report.isProtected, isFalse);
        expect(report.language, 'zh');
      },
    );
  });

  group('GeoIdentityHost', () {
    test('builds shell proxy exports for Claude Code terminals', () {
      final exports = GeoIdentityHost.buildTerminalProxyExports(
        mixedPort: 7890,
      );
      expect(exports, contains('https_proxy=http://127.0.0.1:7890'));
      expect(exports, contains('HTTPS_PROXY=http://127.0.0.1:7890'));
      expect(exports, contains('ALL_PROXY=http://127.0.0.1:7890'));
      expect(exports, contains('NO_PROXY=localhost,127.0.0.1,::1'));
    });

    test('builds PowerShell proxy exports', () {
      final exports = GeoIdentityHost.buildTerminalProxyExportsPowerShell(
        mixedPort: 7890,
      );
      expect(exports, contains(r'$env:HTTPS_PROXY="http://127.0.0.1:7890"'));
    });

    test('flags Claude Code China timezones', () {
      expect(
        GeoIdentityHost.isClaudeCodeChinaTimezone('Asia/Shanghai'),
        isTrue,
      );
      expect(GeoIdentityHost.isClaudeCodeChinaTimezone('Asia/Urumqi'), isTrue);
      expect(
        GeoIdentityHost.isClaudeCodeChinaTimezone('America/Los_Angeles'),
        isFalse,
      );
    });

    test('maps common US IANA zones to Windows tzutil names', () {
      expect(
        GeoIdentityHost.windowsTimezoneNames['America/Los_Angeles'],
        'Pacific Standard Time',
      );
      expect(
        GeoIdentityHost.windowsTimezoneNames['America/New_York'],
        'Eastern Standard Time',
      );
    });
  });

  test('GeoIdentityLinks and probe constants stay wired', () {
    expect(GeoIdentityLinks.fuckClaude, contains('fuck-claude'));
    expect(GeoIdentityLinks.geoMirror, contains('geomirror'));
    expect(GeoIdentityLinks.checkApi, contains('format=json'));
    expect(geoIdentityUsAcceptLanguage, startsWith('en-US'));
  });

  test('GeoIdentityProps defaults are opt-in', () {
    const props = GeoIdentityProps();
    expect(props.enable, isFalse);
    expect(props.useUsAcceptLanguage, isTrue);
    expect(props.captureMode, GeoIdentityCaptureMode.auto);
    expect(props.previousOsTimezone, isNull);
    expect(props.appliedOsTimezone, isNull);
  });

  group('resolveGeoIdentityCaptureActions', () {
    test('auto leaves existing desktop capture alone', () {
      final actions = resolveGeoIdentityCaptureActions(
        mode: GeoIdentityCaptureMode.auto,
        isDesktop: true,
        currentSystemProxy: true,
        currentTunEnable: false,
        currentVpnEnable: false,
      );
      expect(actions.setSystemProxy, isNull);
      expect(actions.setTunEnable, isNull);
      expect(actions.setVpnEnable, isNull);
    });

    test('auto enables TUN only when desktop has no capture', () {
      final actions = resolveGeoIdentityCaptureActions(
        mode: GeoIdentityCaptureMode.auto,
        isDesktop: true,
        currentSystemProxy: false,
        currentTunEnable: false,
        currentVpnEnable: false,
      );
      expect(actions.setSystemProxy, isNull);
      expect(actions.setTunEnable, isTrue);
    });

    test('tun mode does not force system proxy', () {
      final actions = resolveGeoIdentityCaptureActions(
        mode: GeoIdentityCaptureMode.tun,
        isDesktop: true,
        currentSystemProxy: false,
        currentTunEnable: false,
        currentVpnEnable: false,
      );
      expect(actions.setSystemProxy, isNull);
      expect(actions.setTunEnable, isTrue);
    });

    test('systemProxy mode does not force TUN', () {
      final actions = resolveGeoIdentityCaptureActions(
        mode: GeoIdentityCaptureMode.systemProxy,
        isDesktop: true,
        currentSystemProxy: false,
        currentTunEnable: false,
        currentVpnEnable: false,
      );
      expect(actions.setSystemProxy, isTrue);
      expect(actions.setTunEnable, isNull);
    });

    test('both enables missing desktop capture toggles', () {
      final actions = resolveGeoIdentityCaptureActions(
        mode: GeoIdentityCaptureMode.both,
        isDesktop: true,
        currentSystemProxy: false,
        currentTunEnable: true,
        currentVpnEnable: false,
      );
      expect(actions.setSystemProxy, isTrue);
      expect(actions.setTunEnable, isNull);
    });
  });
}
