import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/tailscale_api.dart';
import 'package:flutter_test/flutter_test.dart';

class _KeysAdapter implements HttpClientAdapter {
  _KeysAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test(
    'createTailscaleAuthKey posts capabilities and returns the key',
    () async {
      final dio = Dio();
      Map<String, dynamic>? posted;
      String? authorization;
      dio.httpClientAdapter = _KeysAdapter((options) async {
        authorization = options.headers['Authorization']?.toString();
        final raw = options.data;
        posted = raw is String
            ? jsonDecode(raw) as Map<String, dynamic>
            : Map<String, dynamic>.from(raw as Map);
        return ResponseBody.fromString(
          jsonEncode({
            'key': 'tskey-auth-test',
            'id': 'k123',
            'description': 'FlClash',
          }),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      final created = await createTailscaleAuthKey(
        accessToken: 'tskey-api-test',
        dio: dio,
        baseUrl: 'https://api.tailscale.test/api/v2',
        tags: const ['tag:flclash'],
      );
      expect(created.key, 'tskey-auth-test');
      expect(created.id, 'k123');
      expect(authorization, 'Bearer tskey-api-test');
      expect(posted?['capabilities'], isA<Map>());
      expect(
        (((posted?['capabilities'] as Map)['devices'] as Map)['create']
            as Map)['tags'],
        ['tag:flclash'],
      );
    },
  );

  test('createTailscaleAuthKey surfaces API message on failure', () async {
    final dio = Dio();
    dio.httpClientAdapter = _KeysAdapter((options) async {
      return ResponseBody.fromString(
        jsonEncode({'message': 'missing scope'}),
        403,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    });

    expect(
      () => createTailscaleAuthKey(
        accessToken: 'tskey-api-test',
        dio: dio,
        baseUrl: 'https://api.tailscale.test/api/v2',
      ),
      throwsA(
        isA<TailscaleApiException>().having(
          (error) => error.message,
          'message',
          'missing scope',
        ),
      ),
    );
  });

  test('createTailscaleAuthKey rejects an empty token', () async {
    expect(
      () => createTailscaleAuthKey(accessToken: '  ', dio: Dio()),
      throwsA(isA<TailscaleApiException>()),
    );
  });
}
