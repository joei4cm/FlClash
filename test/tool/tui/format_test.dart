import 'package:flutter_test/flutter_test.dart';

import '../../../tool/tui/format.dart';

void main() {
  test('formatRate scales units', () {
    expect(formatRate(512), '512 B/s');
    expect(formatRate(2048), '2.0 KB/s');
    expect(formatRate(2 * 1024 * 1024), '2.00 MB/s');
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
}
