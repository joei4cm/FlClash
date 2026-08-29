import 'package:fl_clash/common/proxy_geo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('inferProxyGeoRegion detects common tags', () {
    expect(inferProxyGeoRegion('US-AWS-01'), 'US');
    expect(inferProxyGeoRegion('香港 IPLC'), 'HK');
    expect(inferProxyGeoRegion('Tokyo Premium'), 'JP');
    expect(inferProxyGeoRegion('Random Node'), isNull);
  });

  test('resolvePreferredStickyGeo uses configured then geo-identity US', () {
    expect(
      resolvePreferredStickyGeo(
        configuredGeo: 'JP',
        geoIdentityEnabled: true,
      ),
      'JP',
    );
    expect(
      resolvePreferredStickyGeo(
        configuredGeo: null,
        geoIdentityEnabled: true,
      ),
      'US',
    );
    expect(
      resolvePreferredStickyGeo(
        configuredGeo: null,
        geoIdentityEnabled: false,
      ),
      isNull,
    );
  });

  test('resolveAutoSelectStickyGeo prefers geo identity US for display', () {
    expect(
      resolveAutoSelectStickyGeo(
        configuredGeo: null,
        geoIdentityEnabled: true,
        proxyName: 'HK-01',
      ),
      'US',
    );
  });

  test('pickBestHealthyProxyInGeo ignores untested and out-of-geo nodes', () {
    final best = pickBestHealthyProxyInGeo(
      proxyNames: const ['HK-01', 'US-Slow', 'US-Fast', 'US-Dead'],
      preferredGeo: 'US',
      testUrl: 'https://www.gstatic.com/generate_204',
      delayMap: {
        'https://www.gstatic.com/generate_204': {
          'HK-01': 20,
          'US-Slow': 200,
          'US-Fast': 50,
          'US-Dead': -1,
        },
      },
    );
    expect(best, 'US-Fast');
  });

  group('decideAutoSelectSwitch', () {
    final now = DateTime.utc(2026, 8, 29, 6);

    test('does not switch healthy current node even outside preferred geo', () {
      expect(
        decideAutoSelectSwitch(
          currentName: 'HK-01',
          userOverride: null,
          preferredGeo: 'US',
          currentHealthy: true,
          bestHealthyInPreferredGeo: 'US-01',
          now: now,
        ),
        isNull,
      );
    });

    test('respects user override', () {
      expect(
        decideAutoSelectSwitch(
          currentName: 'HK-01',
          userOverride: 'HK-01',
          preferredGeo: 'US',
          currentHealthy: false,
          bestHealthyInPreferredGeo: 'US-01',
          now: now,
        ),
        isNull,
      );
    });

    test('switches unhealthy current to healthy preferred-geo node', () {
      final decision = decideAutoSelectSwitch(
        currentName: 'HK-01',
        userOverride: null,
        preferredGeo: 'US',
        currentHealthy: false,
        bestHealthyInPreferredGeo: 'US-01',
        now: now,
      );
      expect(decision?.proxyName, 'US-01');
    });

    test('honors cooldown after a recent switch', () {
      expect(
        decideAutoSelectSwitch(
          currentName: 'HK-01',
          userOverride: null,
          preferredGeo: 'US',
          currentHealthy: false,
          bestHealthyInPreferredGeo: 'US-01',
          now: now,
          lastSwitchAt: now.subtract(const Duration(seconds: 10)),
        ),
        isNull,
      );
    });

    test('does not fall back when preferred geo has no healthy node', () {
      expect(
        decideAutoSelectSwitch(
          currentName: 'HK-01',
          userOverride: null,
          preferredGeo: 'US',
          currentHealthy: false,
          bestHealthyInPreferredGeo: null,
          now: now,
        ),
        isNull,
      );
    });
  });
}
