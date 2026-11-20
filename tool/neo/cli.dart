import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'host.dart';
import 'paths.dart';

const helpText = '''
FlClash Neo — experimental headless host (desktop)

Usage:
  flclash-neo run [--config PATH] [--core PATH] [--home DIR]
  flclash-neo status [--home DIR]
  flclash-neo stop [--home DIR]
  flclash-neo help

Env:
  FLCLASH_CORE       Path to FlClashCore
  FLCLASH_NEO_HOME   Neo data directory (default: ~/.config/flclash-neo)

Notes:
  - Linux/macOS only in this slice (Unix IPC).
  - Does not use the GUI lock or production data dir.
  - TUN/Helper not wired yet — use mixed-port (or socks) in the config.
''';

Future<int> runNeo(List<String> args) async {
  if (args.isEmpty ||
      args.first == 'help' ||
      args.first == '-h' ||
      args.first == '--help') {
    stdout.write(helpText);
    return 0;
  }

  final command = args.first;
  final rest = args.skip(1).toList();
  final options = _parseOptions(rest);

  final paths = NeoPaths(home: options.home, corePath: options.core);

  switch (command) {
    case 'run':
      return _runForeground(paths, options.config);
    case 'status':
      return _printStatus(paths);
    case 'stop':
      return _stopFromState(paths);
    default:
      stderr.writeln('unknown command: $command\n');
      stdout.write(helpText);
      return 2;
  }
}

Future<int> _runForeground(NeoPaths paths, String? config) async {
  final host = NeoHost(paths: paths, configPath: config);
  final done = Completer<void>();
  var stopping = false;
  Future<void> shutdown() async {
    if (stopping) {
      return;
    }
    stopping = true;
    stderr.writeln('neo: shutting down…');
    try {
      await host.stop();
    } finally {
      if (!done.isCompleted) {
        done.complete();
      }
    }
  }

  ProcessSignal.sigint.watch().listen((_) => unawaited(shutdown()));
  if (!Platform.isWindows) {
    ProcessSignal.sigterm.watch().listen((_) => unawaited(shutdown()));
  }

  try {
    stderr.writeln('neo: starting Core at ${paths.corePath}');
    stderr.writeln('neo: home ${paths.home}');
    await host.start();
    final status = await host.status();
    stdout.writeln(const JsonEncoder.withIndent('  ').convert(status));
    stderr.writeln('neo: running — Ctrl+C to stop');
    await done.future;
    return 0;
  } on Object catch (error, stack) {
    stderr.writeln('neo: failed: $error');
    stderr.writeln('$stack');
    await host.stop();
    return 1;
  }
}

Future<int> _printStatus(NeoPaths paths) async {
  final file = File(paths.statePath);
  if (!await file.exists()) {
    stdout.writeln(jsonEncode({'status': 'stopped', 'home': paths.home}));
    return 0;
  }
  stdout.writeln(await file.readAsString());
  return 0;
}

Future<int> _stopFromState(NeoPaths paths) async {
  final file = File(paths.statePath);
  if (!await file.exists()) {
    stderr.writeln('neo: not running');
    return 0;
  }
  try {
    final json = jsonDecode(await file.readAsString()) as Map<String, Object?>;
    final pid = json['pid'];
    if (pid is int) {
      Process.killPid(pid, ProcessSignal.sigterm);
      stderr.writeln('neo: sent SIGTERM to $pid');
    }
  } catch (error) {
    stderr.writeln('neo: stop failed: $error');
    return 1;
  }
  return 0;
}

({String? home, String? core, String? config}) _parseOptions(
  List<String> args,
) {
  String? home;
  String? core;
  String? config;
  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    String value() {
      if (i + 1 >= args.length) {
        throw FormatException('missing value for $arg');
      }
      return args[++i];
    }

    switch (arg) {
      case '--home':
        home = value();
      case '--core':
        core = value();
      case '--config':
        config = value();
      default:
        throw FormatException('unknown option: $arg');
    }
  }
  return (home: home, core: core, config: config);
}

// Avoid importing dart:async just for unawaited in older analysis — use local.
void unawaited(Future<void> future) {
  future.ignore();
}
