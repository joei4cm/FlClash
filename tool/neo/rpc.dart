import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'ipc.dart';

final _utf8Json = utf8.decoder.fuse(json.decoder);

class NeoRpcException implements Exception {
  NeoRpcException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => 'NeoRpcException($code): $message';
}

class NeoRpc {
  NeoRpc(this._server) {
    _sub = _server.frames.listen(_onFrame);
  }

  final NeoIpcServer _server;
  late final StreamSubscription<Uint8List> _sub;
  final Map<String, Completer<Object?>> _pending = {};
  var _nextId = 0;

  Future<Object?> invoke(String method, [Object? arguments]) async {
    final id = '${++_nextId}';
    final completer = Completer<Object?>();
    _pending[id] = completer;
    final body = jsonEncode({
      'id': id,
      'method': method,
      'arguments': arguments ?? <String, Object?>{},
    });
    _server.send(utf8.encode(body));
    return completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        _pending.remove(id);
        throw TimeoutException('Core method $method timed out');
      },
    );
  }

  void _onFrame(Uint8List frame) {
    final decoded = _utf8Json.convert(frame);
    if (decoded is! Map) {
      return;
    }
    final map = Map<String, Object?>.from(decoded);
    final method = map['method'];
    // Core event batches use method "message" and have no id completion.
    if (method == 'message') {
      return;
    }
    final id = map['id'] as String?;
    if (id == null) {
      return;
    }
    final completer = _pending.remove(id);
    if (completer == null || completer.isCompleted) {
      return;
    }
    final error = map['error'];
    if (error is Map) {
      completer.completeError(
        NeoRpcException(
          error['code']?.toString() ?? 'core_error',
          error['message']?.toString() ?? 'unknown error',
        ),
      );
      return;
    }
    if (map['file'] is String) {
      // Large spilled responses — read later if needed.
      completer.complete({'file': map['file']});
      return;
    }
    completer.complete(map['result']);
  }

  Future<void> close() async {
    await _sub.cancel();
    for (final pending in _pending.values) {
      if (!pending.isCompleted) {
        pending.completeError(
          NeoRpcException('transport_disconnected', 'RPC closed'),
        );
      }
    }
    _pending.clear();
  }
}
