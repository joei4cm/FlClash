import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;

const tailscaleApiBaseUrl = 'https://api.tailscale.com/api/v2';

class TailscaleApiException implements Exception {
  TailscaleApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class TailscaleCreatedAuthKey {
  const TailscaleCreatedAuthKey({
    required this.key,
    required this.id,
    this.description = '',
  });

  final String key;
  final String id;
  final String description;
}

/// Creates a device auth key via the Tailscale Keys API.
///
/// [accessToken] may be a user API access token (`tskey-api-…`) or a short-lived
/// OAuth access token. When [tags] is non-empty (required for OAuth clients with
/// the `auth_keys` scope), those tags are attached to the key.
Future<TailscaleCreatedAuthKey> createTailscaleAuthKey({
  required String accessToken,
  required Dio dio,
  List<String> tags = const [],
  bool ephemeral = false,
  bool reusable = false,
  bool preauthorized = true,
  int expirySeconds = 86400 * 7,
  String description = 'FlClash',
  @visibleForTesting String baseUrl = tailscaleApiBaseUrl,
}) async {
  final token = accessToken.trim();
  if (token.isEmpty) {
    throw TailscaleApiException('API access token is empty');
  }
  final cleanedTags = [
    for (final tag in tags)
      if (tag.trim().isNotEmpty) tag.trim(),
  ];
  final body = <String, dynamic>{
    'capabilities': {
      'devices': {
        'create': {
          'reusable': reusable,
          'ephemeral': ephemeral,
          'preauthorized': preauthorized,
          if (cleanedTags.isNotEmpty) 'tags': cleanedTags,
        },
      },
    },
    'expirySeconds': expirySeconds,
    if (description.trim().isNotEmpty) 'description': description.trim(),
  };
  try {
    final response = await dio.post<Map<String, dynamic>>(
      '$baseUrl/tailnet/-/keys',
      data: body,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    final data = response.data;
    if (response.statusCode != 200 || data == null) {
      throw TailscaleApiException(
        _tailscaleApiErrorMessage(data, response.statusCode),
      );
    }
    final key = data['key']?.toString() ?? '';
    if (key.isEmpty) {
      throw TailscaleApiException('Tailscale API returned an empty auth key');
    }
    return TailscaleCreatedAuthKey(
      key: key,
      id: data['id']?.toString() ?? '',
      description: data['description']?.toString() ?? description,
    );
  } on DioException catch (error) {
    throw TailscaleApiException(
      _tailscaleApiErrorMessage(
        error.response?.data,
        error.response?.statusCode,
      ),
    );
  }
}

String _tailscaleApiErrorMessage(Object? data, int? statusCode) {
  if (data is Map) {
    final message = data['message']?.toString();
    if (message != null && message.isNotEmpty) {
      return message;
    }
  }
  if (data is String && data.trim().isNotEmpty) {
    try {
      final decoded = jsonDecode(data);
      if (decoded is Map && decoded['message'] is String) {
        return decoded['message'] as String;
      }
    } on FormatException {
      return data.trim();
    }
    return data.trim();
  }
  return 'Tailscale API request failed${statusCode == null ? '' : ' ($statusCode)'}';
}
