import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:io' as io show stderr, stdin, stdout;

import 'ansi.dart';
import 'keys.dart';

class Terminal {
  Terminal({Stdin? input, Stdout? output, Stdout? error})
    : stdin = input ?? io.stdin,
      stdout = output ?? io.stdout,
      stderr = error ?? io.stderr;

  final Stdin stdin;
  final Stdout stdout;
  final Stdout stderr;

  bool _raw = false;
  bool _cursorHidden = false;
  StreamSubscription<List<int>>? _subscription;
  final Queue<int> _queue = Queue<int>();
  Completer<int?>? _waiter;

  bool get hasTerminal => stdin.hasTerminal && stdout.hasTerminal;

  int get columns {
    try {
      return stdout.terminalColumns;
    } catch (_) {
      return 80;
    }
  }

  int get rows {
    try {
      return stdout.terminalLines;
    } catch (_) {
      return 24;
    }
  }

  void enableRaw() {
    if (!hasTerminal || _raw) {
      return;
    }
    stdin
      ..echoMode = false
      ..lineMode = false;
    _subscription = stdin.listen(
      (chunk) {
        for (final byte in chunk) {
          final waiter = _waiter;
          if (waiter != null && !waiter.isCompleted) {
            _waiter = null;
            waiter.complete(byte);
          } else {
            _queue.add(byte);
          }
        }
      },
      onError: (_) {},
      cancelOnError: false,
    );
    _raw = true;
  }

  void disableRaw() {
    if (!_raw) {
      return;
    }
    unawaited(_subscription?.cancel());
    _subscription = null;
    _queue.clear();
    final waiter = _waiter;
    _waiter = null;
    if (waiter != null && !waiter.isCompleted) {
      waiter.complete(null);
    }
    try {
      stdin
        ..lineMode = true
        ..echoMode = true;
    } catch (_) {}
    _raw = false;
  }

  void hideCursor() {
    if (!hasTerminal) {
      return;
    }
    stdout.write(hideCursor);
    _cursorHidden = true;
  }

  void showCursor() {
    if (!_cursorHidden) {
      return;
    }
    stdout.write(showCursor);
    _cursorHidden = false;
  }

  void clear() {
    if (hasTerminal) {
      stdout.write(clearScreen);
    }
  }

  void write(String text) => stdout.write(text);

  void writeln([String text = '']) => stdout.writeln(text);

  void restore() {
    showCursor();
    disableRaw();
  }

  /// Read one key. When [timeout] elapses with no input, returns null.
  Future<KeyEvent?> readKey({Duration? timeout}) async {
    final buffer = <int>[];
    while (true) {
      final next = await _readByte(
        timeout: buffer.isEmpty ? timeout : const Duration(milliseconds: 35),
      );
      if (next == null) {
        if (buffer.isEmpty) {
          return null;
        }
        if (buffer.length == 1 && buffer.first == 27) {
          return const KeyEvent(KeyKind.escape);
        }
        return parseKey(buffer);
      }
      buffer.add(next);
      if (!mayNeedMoreBytes(buffer)) {
        return parseKey(buffer);
      }
    }
  }

  Future<int?> _readByte({Duration? timeout}) async {
    if (_queue.isNotEmpty) {
      return _queue.removeFirst();
    }
    final completer = Completer<int?>();
    _waiter = completer;
    Timer? timer;
    if (timeout != null) {
      timer = Timer(timeout, () {
        if (!completer.isCompleted) {
          if (identical(_waiter, completer)) {
            _waiter = null;
          }
          completer.complete(null);
        }
      });
    }
    try {
      return await completer.future;
    } finally {
      timer?.cancel();
    }
  }
}
