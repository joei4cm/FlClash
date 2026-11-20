import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'ipc.dart';
import 'paths.dart';
import 'rpc.dart';

class NeoHost {
  NeoHost({required this.paths, this.configPath});

  final NeoPaths paths;
  final String? configPath;

  NeoIpcServer? _ipc;
  NeoRpc? _rpc;
  Process? _core;
  var _running = false;

  bool get isRunning => _running;

  Future<void> start() async {
    if (Platform.isWindows) {
      throw UnsupportedError(
        'Neo Windows named-pipe host is not ready yet. '
        'Use Linux/macOS for this slice, or set up GUI + flclash-tui.',
      );
    }
    if (_running) {
      return;
    }
    await paths.ensureHome();
    final coreFile = File(paths.corePath);
    if (!await coreFile.exists()) {
      throw StateError(
        'FlClashCore not found at ${paths.corePath}. '
        'Pass --core or set FLCLASH_CORE.',
      );
    }

    final ipc = await NeoIpcServer.bindUnix(paths.socketPath);
    ipc.listen();
    _ipc = ipc;

    final process = await Process.start(paths.corePath, [paths.socketPath]);
    _core = process;
    process.stderr.transform(utf8.decoder).listen((line) {
      stderr.write('[core] $line');
    });
    process.stdout.listen((_) {});

    await ipc.whenConnected.timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw TimeoutException('Core did not connect to IPC'),
    );

    final rpc = NeoRpc(ipc);
    _rpc = rpc;

    await rpc.invoke('core.init', {'home-dir': paths.home, 'version': 1});
    final ready = await rpc.invoke('core.initialized');
    if (ready != true) {
      throw StateError('core.initialized returned $ready');
    }

    if (configPath != null) {
      await applyConfig(configPath!);
    } else {
      // Empty setup still loads Core's default / home config.yaml if present.
      await rpc.invoke('config.setup', {
        'selected-map': <String, String>{},
        'options': {
          'test-url': 'https://www.gstatic.com/generate_204',
          'skip-cert-verify': false,
          'delay-test-timeout': 5000,
          'mitm-capture': false,
        },
      });
    }

    await rpc.invoke('listener.start');
    _running = true;
    await _writeState(status: 'running');
    await _publishControllerHint();
  }

  Future<void> applyConfig(String path) async {
    final rpc = _rpc;
    if (rpc == null) {
      throw StateError('host is not running');
    }
    final file = File(path);
    if (!await file.exists()) {
      throw StateError('config not found: $path');
    }
    await rpc.invoke('config.setup', {
      'base': {'path': file.absolute.path, 'overlay': ''},
      'selected-map': <String, String>{},
      'options': {
        'test-url': 'https://www.gstatic.com/generate_204',
        'skip-cert-verify': false,
        'delay-test-timeout': 5000,
        'mitm-capture': false,
      },
    });
    await _publishControllerHint();
  }

  Future<Map<String, Object?>> status() async {
    final rpc = _rpc;
    if (rpc == null || !_running) {
      return {'status': 'stopped', 'home': paths.home};
    }
    Object? memory;
    try {
      memory = await rpc.invoke('core.memory');
    } catch (_) {}
    return {
      'status': 'running',
      'home': paths.home,
      'core': paths.corePath,
      'pid': _core?.pid,
      'memory': memory,
      'config': configPath,
    };
  }

  Future<void> stop() async {
    final rpc = _rpc;
    try {
      await rpc?.invoke('listener.stop');
    } catch (_) {}
    await rpc?.close();
    _rpc = null;
    await _ipc?.close();
    _ipc = null;
    final process = _core;
    _core = null;
    if (process != null) {
      process.kill();
      try {
        await process.exitCode.timeout(const Duration(seconds: 3));
      } on TimeoutException {
        process.kill(ProcessSignal.sigkill);
      }
    }
    _running = false;
    await _clearController();
    await _writeState(status: 'stopped');
  }

  Future<void> _writeState({required String status}) async {
    final body = jsonEncode({
      'status': status,
      'pid': _core?.pid,
      'home': paths.home,
      'socket': paths.socketPath,
      'core': paths.corePath,
      'config': configPath,
    });
    await File(paths.statePath).writeAsString(body);
  }

  /// Best-effort: if the applied YAML opened an external controller with a
  /// secret, point flclash-tui at neo's home via env (file is neo-local).
  Future<void> _publishControllerHint() async {
    // Neo does not parse YAML yet; operators can set FLCLASH_API / SECRET.
    // Placeholder file documents the neo home for discovery experiments.
    final body = jsonEncode({
      'neo': true,
      'home': paths.home,
      'hint':
          'Set FLCLASH_API / FLCLASH_SECRET to match external-controller in the '
          'applied config, then run flclash-tui.',
    });
    await File(paths.controllerPath).writeAsString(body);
  }

  Future<void> _clearController() async {
    try {
      final file = File(paths.controllerPath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }
}
