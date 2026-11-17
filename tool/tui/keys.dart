library;

enum KeyKind {
  char,
  enter,
  escape,
  backspace,
  clearLine,
  up,
  down,
  left,
  right,
  home,
  end,
  pageUp,
  pageDown,
  tab,
  unknown,
}

class KeyEvent {
  const KeyEvent(this.kind, {this.char});

  final KeyKind kind;
  final String? char;

  bool get isChar => kind == KeyKind.char && char != null;

  bool matchesChar(String value) =>
      isChar && char!.toLowerCase() == value.toLowerCase();
}

/// Parse one logical key from a byte stream. Arrow keys arrive as CSI sequences.
KeyEvent parseKey(List<int> bytes) {
  if (bytes.isEmpty) {
    return const KeyEvent(KeyKind.unknown);
  }
  if (bytes.length == 1) {
    final b = bytes.first;
    return switch (b) {
      3 || 4 => const KeyEvent(KeyKind.escape), // Ctrl+C / Ctrl+D
      9 => const KeyEvent(KeyKind.tab),
      10 || 13 => const KeyEvent(KeyKind.enter),
      21 => const KeyEvent(KeyKind.clearLine), // Ctrl+U
      27 => const KeyEvent(KeyKind.escape),
      8 || 127 => const KeyEvent(KeyKind.backspace),
      _ when b >= 32 && b < 127 => KeyEvent(
        KeyKind.char,
        char: String.fromCharCode(b),
      ),
      _ => const KeyEvent(KeyKind.unknown),
    };
  }

  // ESC [ A/B/C/D  or ESC O A/B...
  final text = String.fromCharCodes(bytes);
  return switch (text) {
    '\x1b[A' || '\x1bOA' => const KeyEvent(KeyKind.up),
    '\x1b[B' || '\x1bOB' => const KeyEvent(KeyKind.down),
    '\x1b[C' || '\x1bOC' => const KeyEvent(KeyKind.right),
    '\x1b[D' || '\x1bOD' => const KeyEvent(KeyKind.left),
    '\x1b[H' || '\x1b[1~' => const KeyEvent(KeyKind.home),
    '\x1b[F' || '\x1b[4~' => const KeyEvent(KeyKind.end),
    '\x1b[5~' => const KeyEvent(KeyKind.pageUp),
    '\x1b[6~' => const KeyEvent(KeyKind.pageDown),
    '\x1b' => const KeyEvent(KeyKind.escape),
    _ => const KeyEvent(KeyKind.unknown),
  };
}

/// Whether [bytes] may still grow into a longer escape sequence.
bool mayNeedMoreBytes(List<int> bytes) {
  if (bytes.isEmpty) {
    return false;
  }
  if (bytes.first != 27) {
    return false;
  }
  if (bytes.length == 1) {
    return true;
  }
  if (bytes.length == 2 && (bytes[1] == 91 || bytes[1] == 79)) {
    return true;
  }
  // CSI ... ~  (home/end/page)
  if (bytes.length >= 3 && bytes[1] == 91) {
    final last = bytes.last;
    if (last >= 0x40 && last <= 0x7e) {
      return false;
    }
    return bytes.length < 8;
  }
  return false;
}
