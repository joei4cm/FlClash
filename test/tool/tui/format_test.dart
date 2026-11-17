import 'package:flutter_test/flutter_test.dart';

import '../../../tool/tui/format.dart';

void main() {
  test('formatRate scales units', () {
    expect(formatRate(512), '512 B/s');
    expect(formatRate(2048), '2.0 KB/s');
    expect(formatRate(2 * 1024 * 1024), '2.00 MB/s');
  });

  test('formatBytes scales units', () {
    expect(formatBytes(100), '100 B');
    expect(formatBytes(2048), '2.0 KB');
    expect(formatBytes(3 * 1024 * 1024), '3.00 MB');
  });

  test('formatDelay and history', () {
    expect(formatDelay(null), '—');
    expect(formatDelay(0), 'timeout');
    expect(formatDelay(42), '42ms');
    expect(
      latestHistoryDelay([
        {'delay': 10},
        {'delay': 55},
      ]),
      55,
    );
  });

  test('filterNames is case-insensitive', () {
    expect(filterNames(['Hong Kong', 'US01', 'Tokyo'], 'us'), ['US01']);
    expect(filterNames(['a', 'b'], ''), ['a', 'b']);
  });

  test('isProxyGroupType', () {
    expect(isProxyGroupType('Selector'), isTrue);
    expect(isProxyGroupType('URLTest'), isTrue);
    expect(isProxyGroupType('Shadowsocks'), isFalse);
  });

  test('connectionLabel prefers host and process', () {
    expect(
      connectionLabel({
        'metadata': {
          'host': 'example.com',
          'destinationPort': 443,
          'process': 'Chrome',
        },
        'chains': ['HK01', 'Proxy'],
      }),
      'Chrome · example.com:443 → HK01',
    );
    expect(connectionHost({'host': '', 'destinationIP': '1.2.3.4'}), '1.2.3.4');
  });
}
