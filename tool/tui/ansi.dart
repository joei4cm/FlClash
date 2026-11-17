/// Minimal ANSI helpers. No third-party deps so `dart run tool/tui.dart` stays
/// a plain script beside the Flutter app.
library;

const reset = '\x1b[0m';
const bold = '\x1b[1m';
const dim = '\x1b[2m';
const reverse = '\x1b[7m';

const fgCyan = '\x1b[36m';
const fgGreen = '\x1b[32m';
const fgYellow = '\x1b[33m';
const fgRed = '\x1b[31m';
const fgGray = '\x1b[90m';
const fgWhite = '\x1b[37m';

const clearScreen = '\x1b[2J\x1b[H';
const clearLine = '\x1b[2K';
const hideCursor = '\x1b[?25l';
const showCursor = '\x1b[?25h';
const cursorHome = '\x1b[H';

String paint(String text, String style) => '$style$text$reset';

String truncate(String text, int width) {
  if (width <= 0) {
    return '';
  }
  if (text.runes.length <= width) {
    return text;
  }
  if (width == 1) {
    return '…';
  }
  final runes = text.runes.toList();
  return '${String.fromCharCodes(runes.take(width - 1))}…';
}

String padRight(String text, int width) {
  final len = text.runes.length;
  if (len >= width) {
    return truncate(text, width);
  }
  return '$text${' ' * (width - len)}';
}

String horizontalRule(int width, {String char = '─'}) {
  if (width <= 0) {
    return '';
  }
  return List.filled(width, char).join();
}
