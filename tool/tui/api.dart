import 'dart:convert';
import 'dart:io';

import 'format.dart';

class ClashApiException implements Exception {
  ClashApiException(this.message);
  final String message;
  @override
  String toString() => message;
}

class ProxyGroup {
  const ProxyGroup({
    required this.name,
    required this.type,
    required this.now,
    required this.all,
  });

  final String name;
  final String type;
  final String now;
  final List<String> all;

  bool get selectable => type == 'Selector';
}

class ProxyNode {
  const ProxyNode({required this.name, this.delayMs});

  final String name;
  final int? delayMs;

  ProxyNode withDelay(int? delay) => ProxyNode(name: name, delayMs: delay);
}

class ConnectionSnapshot {
  const ConnectionSnapshot({
    required this.downloadTotal,
    required this.uploadTotal,
    required this.memory,
    required this.connections,
  });

  final int downloadTotal;
  final int uploadTotal;
  final int memory;
  final List<Map<String, dynamic>> connections;

  int get count => connections.length;

  factory ConnectionSnapshot.fromJson(Map<String, dynamic> json) {
    final raw = json['connections'];
    return ConnectionSnapshot(
      downloadTotal: (json['downloadTotal'] as num?)?.toInt() ?? 0,
      uploadTotal: (json['uploadTotal'] as num?)?.toInt() ?? 0,
      memory: (json['memory'] as num?)?.toInt() ?? 0,
      connections: raw is List
          ? [
              for (final item in raw)
                if (item is Map) item.cast<String, dynamic>(),
            ]
          : const [],
    );
  }
}

class ClashApi {
  ClashApi(this.baseUrl, this.secret, {HttpClient? client})
    : _client =
          client ??
          (HttpClient()..connectionTimeout = const Duration(seconds: 3)),
      _ownsClient = client == null;

  final String baseUrl;
  final String secret;
  final HttpClient _client;
  final bool _ownsClient;

  static const defaultTestUrl = 'https://www.gstatic.com/generate_204';

  void close() {
    if (_ownsClient) {
      _client.close(force: true);
    }
  }

  Future<Map<String, dynamic>> getVersion() async =>
      _getJson('/') as Map<String, dynamic>;

  Future<Map<String, dynamic>> getConfigs() async =>
      _getJson('/configs') as Map<String, dynamic>;

  Future<void> patchConfigs(Map<String, dynamic> body) =>
      _patchJson('/configs', body);

  Future<Map<String, dynamic>> getProxiesMap() async {
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

  Future<List<ProxyGroup>> listGroups() async {
    final proxies = await getProxiesMap();
    final groups = <ProxyGroup>[];
    final names = proxies.keys.toList()..sort();
    for (final name in names) {
      final raw = proxies[name];
      if (raw is! Map) {
        continue;
      }
      final type = raw['type']?.toString() ?? '';
      if (!isProxyGroupType(type)) {
        continue;
      }
      final all = raw['all'];
      groups.add(
        ProxyGroup(
          name: name,
          type: type,
          now: raw['now']?.toString() ?? '',
          all: all is List
              ? [for (final item in all) item.toString()]
              : const [],
        ),
      );
    }
    return groups;
  }

  Future<ProxyGroup?> getGroup(String name) async {
    final proxies = await getProxiesMap();
    final raw = proxies[name];
    if (raw is! Map) {
      return null;
    }
    final type = raw['type']?.toString() ?? '';
    final all = raw['all'];
    return ProxyGroup(
      name: name,
      type: type,
      now: raw['now']?.toString() ?? '',
      all: all is List ? [for (final item in all) item.toString()] : const [],
    );
  }

  Future<List<ProxyNode>> listGroupNodes(String groupName) async {
    final proxies = await getProxiesMap();
    final group = proxies[groupName];
    if (group is! Map) {
      return const [];
    }
    final all = group['all'];
    if (all is! List) {
      return const [];
    }
    return [
      for (final item in all)
        ProxyNode(
          name: item.toString(),
          delayMs: latestHistoryDelay(
            proxies[item.toString()] is Map
                ? (proxies[item.toString()] as Map)['history']
                : null,
          ),
        ),
    ];
  }

  Future<void> selectProxy(String group, String proxy) =>
      _putJson('/proxies/${Uri.encodeComponent(group)}', {'name': proxy});

  Future<int?> testDelay(
    String proxy, {
    Duration timeout = const Duration(seconds: 5),
    String url = defaultTestUrl,
  }) async {
    final path =
        '/proxies/${Uri.encodeComponent(proxy)}/delay'
        '?timeout=${timeout.inMilliseconds}&url=${Uri.encodeQueryComponent(url)}';
    try {
      final body = await _getJson(path);
      if (body is Map && body['delay'] is num) {
        return (body['delay'] as num).round();
      }
    } on ClashApiException {
      return null;
    }
    return null;
  }

  /// Tests every member of a group. Returns name → delay ms (0 = fail/timeout).
  Future<Map<String, int>> testGroupDelay(
    String group, {
    Duration timeout = const Duration(seconds: 5),
    String url = defaultTestUrl,
  }) async {
    final path =
        '/group/${Uri.encodeComponent(group)}/delay'
        '?timeout=${timeout.inMilliseconds}&url=${Uri.encodeQueryComponent(url)}';
    final body = await _getJson(path);
    if (body is! Map) {
      return {};
    }
    return {
      for (final entry in body.entries)
        if (entry.value is num) entry.key.toString(): (entry.value as num).round(),
    };
  }

  Future<ConnectionSnapshot> getConnections() async {
    final body = await _getJson('/connections');
    if (body is Map<String, dynamic>) {
      return ConnectionSnapshot.fromJson(body);
    }
    if (body is Map) {
      return ConnectionSnapshot.fromJson(body.cast<String, dynamic>());
    }
    return const ConnectionSnapshot(
      downloadTotal: 0,
      uploadTotal: 0,
      memory: 0,
      connections: [],
    );
  }

  Future<void> closeConnection(String id) =>
      _delete('/connections/${Uri.encodeComponent(id)}');

  Future<void> closeAllConnections() => _delete('/connections');

  Future<Map<String, dynamic>> getTrafficOnce() async {
    await for (final sample in trafficStream()) {
      return sample;
    }
    return {};
  }

  Stream<Map<String, dynamic>> trafficStream() async* {
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
        yield json;
      } else if (json is Map) {
        yield json.cast<String, dynamic>();
      }
    }
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

  Future<void> _patchJson(String path, Map<String, dynamic> body) async {
    final request = await _client.openUrl('PATCH', Uri.parse('$baseUrl$path'));
    _authorize(request);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));
    final response = await request.close();
    final text = await response.transform(utf8.decoder).join();
    if (response.statusCode >= 400) {
      throw ClashApiException('HTTP ${response.statusCode} PATCH $path: $text');
    }
  }

  Future<void> _delete(String path) async {
    final request = await _client.deleteUrl(Uri.parse('$baseUrl$path'));
    _authorize(request);
    final response = await request.close();
    final text = await response.transform(utf8.decoder).join();
    if (response.statusCode >= 400) {
      throw ClashApiException('HTTP ${response.statusCode} DELETE $path: $text');
    }
  }

  void _authorize(HttpClientRequest request) {
    if (secret.isNotEmpty) {
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $secret');
    }
  }
}
