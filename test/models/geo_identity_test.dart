import 'package:fl_clash/models/geo_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeoIdentitySnapshot', () {
    test('marks high risk when China timezone and zh locale align', () {
      const snapshot = GeoIdentitySnapshot(
        timeZoneName: 'Asia/Shanghai',
        timeZoneOffset: Duration(hours: 8),
        systemLocale: 'zh_CN',
      );
      expect(snapshot.looksChinaTimezoneName, isTrue);
      expect(snapshot.looksChineseLocale, isTrue);
      expect(snapshot.riskLevel, GeoIdentityRiskLevel.high);
      expect(snapshot.offsetLabel, 'UTC+08:00');
    });

    test('marks medium risk for UTC+8 with English locale', () {
      const snapshot = GeoIdentitySnapshot(
        timeZoneName: 'CST',
        timeZoneOffset: Duration(hours: 8),
        systemLocale: 'en_US',
      );
      expect(snapshot.isUtcPlus8, isTrue);
      expect(snapshot.looksChineseLocale, isFalse);
      expect(snapshot.riskLevel, GeoIdentityRiskLevel.medium);
    });

    test('marks low risk for US-looking signals', () {
      const snapshot = GeoIdentitySnapshot(
        timeZoneName: 'Pacific Standard Time',
        timeZoneOffset: Duration(hours: -8),
        systemLocale: 'en_US',
      );
      expect(snapshot.riskLevel, GeoIdentityRiskLevel.low);
      expect(snapshot.offsetLabel, 'UTC-08:00');
    });

    test('normalizes zh-Hans locale tags', () {
      const snapshot = GeoIdentitySnapshot(
        timeZoneName: 'America/Los_Angeles',
        timeZoneOffset: Duration(hours: -7),
        systemLocale: 'zh-Hans-CN',
      );
      expect(snapshot.looksChineseLocale, isTrue);
      expect(snapshot.riskLevel, GeoIdentityRiskLevel.medium);
    });
  });

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

    test('marks zh Accept-Language on US IP as not protected when band rises', () {
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
  });
}
