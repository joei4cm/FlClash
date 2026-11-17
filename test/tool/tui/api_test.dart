import 'package:flutter_test/flutter_test.dart';

import '../../../tool/tui/api.dart';

void main() {
  test('ConnectionSnapshot.fromJson parses totals and rows', () {
    final snapshot = ConnectionSnapshot.fromJson({
      'downloadTotal': 1024,
      'uploadTotal': 512,
      'memory': 4096,
      'connections': [
        {
          'id': 'abc',
          'download': 10,
          'upload': 20,
          'metadata': {'host': 'a.test', 'destinationPort': 443},
          'chains': ['Node'],
        },
        'skip-me',
      ],
    });
    expect(snapshot.count, 1);
    expect(snapshot.downloadTotal, 1024);
    expect(snapshot.uploadTotal, 512);
    expect(snapshot.memory, 4096);
    expect(snapshot.connections.single['id'], 'abc');
  });

  test('ConnectionSnapshot tolerates missing connections', () {
    final snapshot = ConnectionSnapshot.fromJson(const {});
    expect(snapshot.count, 0);
    expect(snapshot.downloadTotal, 0);
  });

  test('ProxyNode.withDelay preserves name', () {
    const node = ProxyNode(name: 'HK', delayMs: 10);
    expect(node.withDelay(42).delayMs, 42);
    expect(node.withDelay(null).name, 'HK');
  });
}
