import 'package:fl_clash/common/proxy_geo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('inferProxyGeoRegion detects common tags', () {
    expect(inferProxyGeoRegion('US-AWS-01'), 'US');
    expect(inferProxyGeoRegion('香港 IPLC'), 'HK');
    expect(inferProxyGeoRegion('Tokyo Premium'), 'JP');
    expect(inferProxyGeoRegion('Random Node'), isNull);
  });

  test('resolveAutoSelectStickyGeo prefers geo identity US', () {
    expect(
      resolveAutoSelectStickyGeo(
        configuredGeo: null,
        geoIdentityEnabled: true,
        proxyName: 'HK-01',
      ),
      'US',
    );
  });
}
