import 'dart:io';

import 'package:path/path.dart' as p;

/// Neo keeps its own home so it never races the GUI data dir / FlClash.lock.
class NeoPaths {
  NeoPaths({String? home, String? corePath})
    : home = home ?? _defaultHome(),
      corePath = corePath ?? _resolveCore();

  final String home;
  final String corePath;

  String get statePath => p.join(home, 'neo-state.json');
  String get lockPath => p.join(home, 'neo.lock');
  String get controllerPath => p.join(home, 'tui-controller.json');
  String get socketPath => p.join(home, 'neo.sock');

  static String _defaultHome() {
    final override = Platform.environment['FLCLASH_NEO_HOME'];
    if (override != null && override.trim().isNotEmpty) {
      return override.trim();
    }
    final home =
        Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        Directory.systemTemp.path;
    return p.join(home, '.config', 'flclash-neo');
  }

  static String _resolveCore() {
    final env = Platform.environment['FLCLASH_CORE'];
    if (env != null && env.trim().isNotEmpty) {
      return env.trim();
    }
    final name = 'FlClashCore${Platform.isWindows ? '.exe' : ''}';
    final exeDir = p.dirname(Platform.resolvedExecutable);
    final beside = p.join(exeDir, name);
    if (File(beside).existsSync()) {
      return beside;
    }
    // Source checkout: libclash/<os>/FlClashCore
    final relative = p.join('libclash', Platform.operatingSystem, name);
    final file = File(relative);
    if (file.existsSync()) {
      return file.absolute.path;
    }
    return beside;
  }

  Future<void> ensureHome() async {
    await Directory(home).create(recursive: true);
  }
}
