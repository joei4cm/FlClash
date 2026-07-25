import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Request {
  late final Dio dio;
  late final Dio _clashDio;
  String? userAgent;

  Request() {
    dio = Dio(BaseOptions(headers: {'User-Agent': browserUa}));
    _clashDio = Dio();
    _clashDio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.findProxy = (Uri uri) {
          client.userAgent = globalState.ua;
          return FlClashHttpOverrides.handleFindProxy(uri);
        };
        return client;
      },
    );
  }

  Future<Response<Uint8List>> getFileResponseForUrl(String url) async {
    try {
      return await _clashDio.get<Uint8List>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
    } catch (e) {
      commonPrint.log('getFileResponseForUrl error ${e.toString()}');
      if (e is DioException) {
        if (e.type == DioExceptionType.unknown) {
          throw currentAppLocalizations.unknownNetworkError;
        } else if (e.type == DioExceptionType.badResponse) {
          throw currentAppLocalizations.networkException;
        }
        rethrow;
      }
      throw currentAppLocalizations.unknownNetworkError;
    }
  }

  Future<Response<String>> getTextResponseForUrl(String url) async {
    final response = await _clashDio.get<String>(
      url,
      options: Options(responseType: ResponseType.plain),
    );
    return response;
  }

  Future<MemoryImage?> getImage(String url) async {
    if (url.isEmpty) return null;
    final response = await dio.get<Uint8List>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final data = response.data;
    if (data == null) return null;
    return MemoryImage(data);
  }

  Future<Map<String, dynamic>?> checkForUpdate() async {
    try {
      final response = await dio.get(
        'https://api.github.com/repos/$repository/releases/latest',
        options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode != 200) return null;
      final data = response.data as Map<String, dynamic>;
      final remoteVersion = data['tag_name'];
      final version = globalState.packageInfo.version;
      final hasUpdate =
          utils.compareVersions(remoteVersion.replaceAll('v', ''), version) > 0;
      if (!hasUpdate) return null;
      return data;
    } catch (e) {
      commonPrint.log('checkForUpdate failed', logLevel: LogLevel.warning);
      return null;
    }
  }

  final Map<String, IpInfo Function(Map<String, dynamic>)> _ipInfoSources = {
    'https://ipwho.is': IpInfo.fromIpWhoIsJson,
    'https://api.myip.com': IpInfo.fromMyIpJson,
    'https://ipapi.co/json': IpInfo.fromIpApiCoJson,
    'https://ident.me/json': IpInfo.fromIdentMeJson,
    'http://ip-api.com/json': IpInfo.fromIpAPIJson,
    'https://api.ip.sb/geoip': IpInfo.fromIpSbJson,
    'https://ipinfo.io/json': IpInfo.fromIpInfoIoJson,
  };

  Future<Result<IpInfo?>> checkIp({CancelToken? cancelToken}) async {
    var failureCount = 0;
    final token = cancelToken ?? CancelToken();
    final futures = _ipInfoSources.entries.map((source) async {
      final Completer<Result<IpInfo?>> completer = Completer();
      void handleFailRes() {
        if (!completer.isCompleted && failureCount == _ipInfoSources.length) {
          completer.complete(Result.success(null));
        }
      }

      final future = dio
          .get<Map<String, dynamic>>(
            source.key,
            cancelToken: token,
            options: Options(responseType: ResponseType.json),
          )
          .timeout(const Duration(seconds: 10));
      future
          .then((res) {
            if (res.statusCode == HttpStatus.ok && res.data != null) {
              completer.complete(Result.success(source.value(res.data!)));
              return;
            }
            commonPrint.log('checkIp data empty', logLevel: LogLevel.info);
            failureCount++;
            handleFailRes();
          })
          .catchError((e) {
            failureCount++;
            if (e is DioException && e.type == DioExceptionType.cancel) {
              completer.complete(Result.error('cancelled'));
              return;
            }
            commonPrint.log('checkIp error $e', logLevel: LogLevel.warning);
            handleFailRes();
          });
      return completer.future;
    });
    final res = await Future.any(futures);
    token.cancel();
    return res;
  }

  /// Server-side FuckClaude estimate via the FlClash mixed-port stack.
  ///
  /// Works for both system-proxy and TUN/VPN modes as long as the core is
  /// started: [dio] honors [FlClashHttpOverrides] and exits through the
  /// selected outbound. Optional [acceptLanguage] overrides the request header
  /// so protect mode can probe with a US language profile.
  Future<Result<GeoIdentityNetworkReport?>> checkGeoIdentity({
    String? acceptLanguage,
    CancelToken? cancelToken,
  }) async {
    try {
      final headers = <String, dynamic>{};
      if (acceptLanguage != null && acceptLanguage.isNotEmpty) {
        headers['Accept-Language'] = acceptLanguage;
      }
      final response = await dio
          .get<Map<String, dynamic>>(
            geoIdentityCheckApiUrl,
            cancelToken: cancelToken,
            options: Options(
              responseType: ResponseType.json,
              headers: headers.isEmpty ? null : headers,
            ),
          )
          .timeout(const Duration(seconds: 12));
      if (response.statusCode != HttpStatus.ok || response.data == null) {
        return Result.success(null);
      }
      return Result.success(GeoIdentityNetworkReport.fromJson(response.data!));
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return Result.error('cancelled');
      }
      commonPrint.log('checkGeoIdentity error $e', logLevel: LogLevel.warning);
      return Result.error(e.toString());
    }
  }

  Future<bool> pingHelper() async {
    if (kDebugMode) return true;
    try {
      final response = await dio
          .get(
            'http://$localhost:$helperPort/ping',
            options: Options(responseType: ResponseType.plain),
          )
          .timeout(const Duration(milliseconds: 2000));
      if (response.statusCode != HttpStatus.ok) {
        return false;
      }
      return (response.data as String) == globalState.coreSHA256;
    } catch (_) {
      return false;
    }
  }

  Future<bool> startCoreByHelper(String arg) async {
    try {
      final response = await dio
          .post(
            'http://$localhost:$helperPort/start',
            data: json.encode({'path': appPath.corePath, 'arg': arg}),
            options: Options(responseType: ResponseType.plain),
          )
          .timeout(const Duration(milliseconds: 2000));
      if (response.statusCode != HttpStatus.ok) {
        return false;
      }
      final data = response.data as String;
      return data.isEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> stopCoreByHelper() async {
    try {
      final response = await dio
          .post(
            'http://$localhost:$helperPort/stop',
            options: Options(responseType: ResponseType.plain),
          )
          .timeout(const Duration(milliseconds: 2000));
      if (response.statusCode != HttpStatus.ok) {
        return false;
      }
      final data = response.data as String;
      return data.isEmpty;
    } catch (_) {
      return false;
    }
  }
}

final request = Request();
