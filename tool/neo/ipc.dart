import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

/// Length-prefixed little-endian frames — same layout as Core `writeFrame`.
class NeoIpcFrame {
  static const maxSize = 64 * 1024 * 1024;

  static Uint8List encode(List<int> payload) {
    if (payload.length > maxSize) {
      throw StateError('IPC frame exceeds $maxSize bytes');
    }
    final header = ByteData(4)..setUint32(0, payload.length, Endian.little);
    final out = BytesBuilder(copy: false)
      ..add(header.buffer.asUint8List())
      ..add(payload);
    return out.takeBytes();
  }
}

/// Byte buffer that turns a socket byte stream into IPC frames.
class NeoIpcReader {
  final BytesBuilder _buf = BytesBuilder(copy: false);

  void add(List<int> data) => _buf.add(data);

  List<Uint8List> takeFrames() {
    final frames = <Uint8List>[];
    final bytes = _buf.takeBytes();
    var offset = 0;
    while (offset + 4 <= bytes.length) {
      final length = ByteData.sublistView(
        Uint8List.fromList(bytes),
        offset,
        offset + 4,
      ).getUint32(0, Endian.little);
      if (length > NeoIpcFrame.maxSize) {
        throw StateError('IPC frame exceeds ${NeoIpcFrame.maxSize} bytes');
      }
      if (offset + 4 + length > bytes.length) {
        break;
      }
      frames.add(
        Uint8List.fromList(bytes.sublist(offset + 4, offset + 4 + length)),
      );
      offset += 4 + length;
    }
    if (offset < bytes.length) {
      _buf.add(bytes.sublist(offset));
    }
    return frames;
  }
}

class NeoIpcServer {
  NeoIpcServer._(this._server, this.address);

  final ServerSocket _server;
  final String address;

  StreamSubscription<Socket>? _acceptSub;
  Socket? _peer;
  final _frames = StreamController<Uint8List>.broadcast();
  final _connected = Completer<void>();
  final NeoIpcReader _reader = NeoIpcReader();

  Stream<Uint8List> get frames => _frames.stream;

  Future<void> get whenConnected => _connected.future;

  static Future<NeoIpcServer> bindUnix(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
    final server = await ServerSocket.bind(
      InternetAddress(path, type: InternetAddressType.unix),
      0,
    );
    try {
      await Process.run('chmod', ['600', path]);
    } catch (_) {}
    return NeoIpcServer._(server, path);
  }

  void listen() {
    _acceptSub = _server.listen((socket) {
      if (_peer != null) {
        socket.destroy();
        return;
      }
      _peer = socket;
      if (!_connected.isCompleted) {
        _connected.complete();
      }
      socket.listen(
        (data) {
          _reader.add(data);
          for (final frame in _reader.takeFrames()) {
            if (!_frames.isClosed) {
              _frames.add(frame);
            }
          }
        },
        onDone: () {
          _peer = null;
        },
        onError: (_) {
          _peer = null;
        },
        cancelOnError: true,
      );
    });
  }

  void send(List<int> payload) {
    final peer = _peer;
    if (peer == null) {
      throw StateError('no Core peer connected');
    }
    peer.add(NeoIpcFrame.encode(payload));
  }

  Future<void> close() async {
    await _acceptSub?.cancel();
    await _peer?.close();
    await _server.close();
    if (!_frames.isClosed) {
      await _frames.close();
    }
    try {
      final file = File(address);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }
}
