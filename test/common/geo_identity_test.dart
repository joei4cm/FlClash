import 'package:fl_clash/common/geo_identity.dart';
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

  test('GeoIdentityLinks point at known tools', () {
    expect(GeoIdentityLinks.fuckClaude, contains('fuck-claude'));
    expect(GeoIdentityLinks.geoMirror, contains('geomirror'));
    expect(GeoIdentityLinks.geoMirrorReleases, contains('releases'));
  });
}
