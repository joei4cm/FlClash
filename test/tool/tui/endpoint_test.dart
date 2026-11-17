import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../tool/tui/endpoint.dart';

void main() {
  test('env endpoint wins over files', () async {
    final endpoint = await resolveEndpoint(
      environment: {
        'FLCLASH_API': 'http://127.0.0.1:9090',
        'FLCLASH_SECRET': 's3cret',
      },
      searchPaths: const ['/no/such/file.json'],
    );
    expect(endpoint?.url, 'http://127.0.0.1:9090');
    expect(endpoint?.secret, 's3cret');
  });

  test('reads controller json from search path', () async {
    final dir = await Directory.systemTemp.createTemp('flclash-tui-');
    final file = File('${dir.path}/tui-controller.json');
    await file.writeAsString(
      '{"url":"http://127.0.0.1:9090","secret":"token","address":"127.0.0.1:9090"}',
    );
    final endpoint = await resolveEndpoint(
      environment: const {},
      searchPaths: [file.path],
    );
    expect(endpoint?.secret, 'token');
    expect(endpoint?.url, 'http://127.0.0.1:9090');
    await dir.delete(recursive: true);
  });

  test('controllerSearchPaths are platform-specific', () {
    final mac = controllerSearchPaths(
      env: const {'HOME': '/Users/me'},
      isMacOS: true,
      isWindows: false,
    );
    expect(mac.first, contains('Application Support'));
    final win = controllerSearchPaths(
      env: const {
        'HOME': r'C:\Users\me',
        'APPDATA': r'C:\Users\me\AppData\Roaming',
      },
      isMacOS: false,
      isWindows: true,
    );
    expect(win.single, contains('AppData'));
  });
}
