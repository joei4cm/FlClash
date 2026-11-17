#!/usr/bin/env dart

// Desktop-only FlClash TUI. Talks to mihomo's external-controller HTTP API so
// it can coexist with the GUI (no data-dir lock). Requires the GUI (or another
// owner) to have the Core running with external controller + secret enabled;
// FlClash writes ~/.…/tui-controller.json when that is the case.
//
//   dart run tool/tui.dart
//   FLCLASH_API=http://127.0.0.1:9090 FLCLASH_SECRET=xxx dart run tool/tui.dart

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  if (Platform.isAndroid || Platform.isIOS) {
    stderr.writeln('FlClash TUI is desktop-only.');
    exit(2);
  }

  final endpoint = await _resolveEndpoint();
  if (endpoint == null) {
    stderr.writeln('''
No FlClash controller endpoint found.

1. Open FlClash GUI → Tools → General
2. Enable External controller and set a secret
3. Start the proxy
4. Re-run: dart run tool/tui.dart

Or set FLCLASH_API and FLCLASH_SECRET manually.
''');
    exit(1);
  }

  final client = ClashApi(endpoint.url, endpoint.secret);
  try {
    final version = await client.getVersion();
    stdout.writeln('FlClash TUI  ·  mihomo ${version['version'] ?? '?'}');
    stdout.writeln('API ${endpoint.url}');
    stdout.writeln(
      'Commands: status | groups | use <group> <proxy> | traffic | quit',
    );
    stdout.writeln('');
    await _repl(client);
  } on ClashApiException catch (error) {
    stderr.writeln('API error: $error');
    exit(1);
  } finally {
    client.close();
  }
}

Future<({String url, String secret})?> _resolveEndpoint() async {
  final envUrl = Platform.environment['FLCLASH_API']?.trim();
  final envSecret = Platform.environment['FLCLASH_SECRET']?.trim() ?? '';
  if (envUrl != null && envUrl.isNotEmpty) {
    return (url: envUrl, secret: envSecret);
  }

  for (final path in _controllerPaths()) {
    final file = File(path);
    if (!await file.exists()) {
      continue;
    }
    try {
      final json =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      final url = (json['url'] as String?)?.trim();
      final secret = (json['secret'] as String?)?.trim() ?? '';
      if (url != null && url.isNotEmpty) {
        return (url: url, secret: secret);
      }
    } catch (_) {
      continue;
    }
  }
  return null;
}

List<String> _controllerPaths() {
  final home =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';
  final paths = <String>[];
  if (Platform.isMacOS) {
    paths
      ..add(
        '$home/Library/Application Support/com.follow.clash/tui-controller.json',
      )
      ..add(
        '$home/Library/Application Support/com.follow.clash.debug/tui-controller.json',
      );
  } else if (Platform.isWindows) {
    final appData = Platform.environment['APPDATA'] ?? '$home/AppData/Roaming';
    paths.add('$appData/com.follow.clash/tui-controller.json');
  } else {
    paths
      ..add('$home/.local/share/com.follow.clash/tui-controller.json')
      ..add('$home/.config/com.follow.clash/tui-controller.json');
  }
  return paths;
}

Future<void> _repl(ClashApi client) async {
  while (true) {
    stdout.write('flclash> ');
    final line = stdin.readLineSync()?.trim();
    if (line == null || line == 'quit' || line == 'exit' || line == 'q') {
      stdout.writeln('bye');
      return;
    }
    if (line.isEmpty) {
      continue;
    }
    final parts = line.split(RegExp(r'\s+'));
    try {
      switch (parts.first) {
        case 'status':
        case 's':
          await _printStatus(client);
        case 'groups':
        case 'g':
          await _printGroups(client);
        case 'use':
        case 'u':
          if (parts.length < 3) {
            stdout.writeln('usage: use <group> <proxy>');
            break;
          }
          await client.selectProxy(parts[1], parts.sublist(2).join(' '));
          stdout.writeln(
            'selected ${parts.sublist(2).join(' ')} in ${parts[1]}',
          );
        case 'traffic':
        case 't':
          await _printTraffic(client);
        case 'help':
        case 'h':
        case '?':
          stdout.writeln(
            'status | groups | use <group> <proxy> | traffic | quit',
          );
        default:
          stdout.writeln('unknown command: ${parts.first} (try help)');
      }
    } on ClashApiException catch (error) {
      stdout.writeln('error: $error');
    }
  }
}

Future<void> _printStatus(ClashApi client) async {
  final version = await client.getVersion();
  final configs = await client.getConfigs();
  final mode = configs['mode'] ?? '?';
  final port = configs['mixed-port'] ?? configs['port'] ?? '?';
  stdout.writeln('version  ${version['version']}');
  stdout.writeln('mode     $mode');
  stdout.writeln('port     $port');
}

Future<void> _printGroups(ClashApi client) async {
  final proxies = await client.getProxies();
  final names = (proxies.keys.toList()..sort());
  for (final name in names) {
    final group = proxies[name];
    if (group is! Map) {
      continue;
    }
    final type = group['type']?.toString() ?? '';
    if (type != 'Selector' &&
        type != 'URLTest' &&
        type != 'Fallback' &&
        type != 'LoadBalance') {
      continue;
    }
    final now = group['now']?.toString() ?? '';
    final all = group['all'];
    final count = all is List ? all.length : 0;
    stdout.writeln('$name  [$type]  → $now  ($count)');
  }
}

Future<void> _printTraffic(ClashApi client) async {
  final sample = await client.getTrafficOnce();
  final up = sample['up'] ?? 0;
  final down = sample['down'] ?? 0;
  stdout.writeln('↑ ${_formatRate(up)}   ↓ ${_formatRate(down)}');
}

String _formatRate(Object? bytesPerSec) {
  final n = bytesPerSec is num ? bytesPerSec.toDouble() : 0.0;
  if (n < 1024) {
    return '${n.toStringAsFixed(0)} B/s';
  }
  if (n < 1024 * 1024) {
    return '${(n / 1024).toStringAsFixed(1)} KB/s';
  }
  return '${(n / (1024 * 1024)).toStringAsFixed(2)} MB/s';
}

class ClashApiException implements Exception {
  ClashApiException(this.message);
  final String message;
  @override
  String toString() => message;
}

class ClashApi {
  ClashApi(this.baseUrl, this.secret)
    : _client = HttpClient()..connectionTimeout = const Duration(seconds: 3);

  final String baseUrl;
  final String secret;
  final HttpClient _client;

  void close() => _client.close(force: true);

  Future<Map<String, dynamic>> getVersion() async =>
      _getJson('/') as Map<String, dynamic>;

  Future<Map<String, dynamic>> getConfigs() async =>
      _getJson('/configs') as Map<String, dynamic>;

  Future<Map<String, dynamic>> getProxies() async {
    final body = await _getJson('/proxies') as Map<String, dynamic>;
    final proxies = body['proxies'];
    if (proxies is Map<String, dynamic>) {
      return proxies;
    }
    if (proxies is Map) {
      return proxies.cast<String, dynamic>();
    }
    return {};
  }

  Future<void> selectProxy(String group, String proxy) async {
    await _putJson('/proxies/${Uri.encodeComponent(group)}', {'name': proxy});
  }

  Future<Map<String, dynamic>> getTrafficOnce() async {
    // /traffic is an SSE stream; read the first event line.
    final request = await _client.getUrl(Uri.parse('$baseUrl/traffic'));
    _authorize(request);
    final response = await request.close();
    if (response.statusCode >= 400) {
      throw ClashApiException('HTTP ${response.statusCode} GET /traffic');
    }
    await for (final line
        in response.transform(utf8.decoder).transform(const LineSplitter())) {
      final trimmed = line.trim();
      if (trimmed.isEmpty || trimmed.startsWith(':')) {
        continue;
      }
      final payload = trimmed.startsWith('data:')
          ? trimmed.substring(5).trim()
          : trimmed;
      final json = jsonDecode(payload);
      if (json is Map<String, dynamic>) {
        return json;
      }
      if (json is Map) {
        return json.cast<String, dynamic>();
      }
    }
    return {};
  }

  Future<Object?> _getJson(String path) async {
    final request = await _client.getUrl(Uri.parse('$baseUrl$path'));
    _authorize(request);
    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();
    if (response.statusCode >= 400) {
      throw ClashApiException('HTTP ${response.statusCode} GET $path: $body');
    }
    return body.isEmpty ? {} : jsonDecode(body);
  }

  Future<void> _putJson(String path, Map<String, dynamic> body) async {
    final request = await _client.putUrl(Uri.parse('$baseUrl$path'));
    _authorize(request);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));
    final response = await request.close();
    final text = await response.transform(utf8.decoder).join();
    if (response.statusCode >= 400) {
      throw ClashApiException('HTTP ${response.statusCode} PUT $path: $text');
    }
  }

  void _authorize(HttpClientRequest request) {
    if (secret.isNotEmpty) {
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $secret');
    }
  }
}
