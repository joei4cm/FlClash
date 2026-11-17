import 'ansi.dart';
import 'format.dart';
import 'keys.dart';
import 'term.dart';

typedef MenuItem = ({String id, String label, String? detail});

/// Arrow-key (or j/k) menu. Returns the selected item id, or null on cancel.
Future<String?> showMenu(
  Terminal term, {
  required String title,
  required List<MenuItem> items,
  String? subtitle,
  String? footer,
  int initialIndex = 0,
}) async {
  if (items.isEmpty) {
    return null;
  }
  var index = clampIndex(initialIndex, items.length);
  while (true) {
    final width = term.columns.clamp(40, 120);
    final buffer = StringBuffer()
      ..write(clearScreen)
      ..writeln(paint(title, bold + fgCyan))
      ..writeln(paint(horizontalRule(width), dim));
    if (subtitle != null && subtitle.isNotEmpty) {
      buffer.writeln(paint(subtitle, dim));
      buffer.writeln();
    }
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final selected = i == index;
      final marker = selected ? '❯' : ' ';
      final label = padRight(item.label, (width * 0.45).floor().clamp(12, 40));
      final detail = item.detail == null
          ? ''
          : paint(truncate(item.detail!, width - label.runes.length - 4), dim);
      final line = '$marker $label $detail';
      buffer.writeln(selected ? paint(line, reverse) : line);
    }
    buffer
      ..writeln()
      ..writeln(
        paint(footer ?? '↑↓/jk move · Enter select · 1-9 jump · Esc back', dim),
      );
    term.write(buffer.toString());

    final key = await term.readKey();
    if (key == null) {
      continue;
    }
    switch (key.kind) {
      case KeyKind.up:
        index = (index - 1) % items.length;
      case KeyKind.down:
      case KeyKind.tab:
        index = (index + 1) % items.length;
      case KeyKind.enter:
        return items[index].id;
      case KeyKind.escape:
        return null;
      case KeyKind.char:
        final ch = key.char!;
        if (ch == 'q' || ch == 'Q') {
          return null;
        }
        if (ch == 'k') {
          index = (index - 1) % items.length;
          break;
        }
        if (ch == 'j') {
          index = (index + 1) % items.length;
          break;
        }
        final digit = int.tryParse(ch);
        if (digit != null && digit >= 1 && digit <= items.length) {
          return items[digit - 1].id;
        }
      default:
        break;
    }
  }
}

/// Filterable list picker. Type to filter; Enter confirms; Esc cancels.
Future<String?> showFilteredPicker(
  Terminal term, {
  required String title,
  required List<({String id, String label, String? trailing})> items,
  String? currentId,
  String emptyLabel = 'No matches',
}) async {
  var query = '';
  var index = 0;
  if (currentId != null) {
    final currentIndex = items.indexWhere((item) => item.id == currentId);
    if (currentIndex >= 0) {
      index = currentIndex;
    }
  }

  List<({String id, String label, String? trailing})> visibleOf() {
    final q = query.toLowerCase();
    if (q.isEmpty) {
      return items;
    }
    return [
      for (final item in items)
        if (item.label.toLowerCase().contains(q) ||
            item.id.toLowerCase().contains(q))
          item,
    ];
  }

  while (true) {
    final visible = visibleOf();
    index = clampIndex(index, visible.length);
    final width = term.columns.clamp(40, 120);
    final buffer = StringBuffer()
      ..write(clearScreen)
      ..writeln(paint(title, bold + fgCyan))
      ..writeln(paint(horizontalRule(width), dim))
      ..writeln(
        'Filter: ${paint(query.isEmpty ? '(type to search)' : query, query.isEmpty ? dim : bold)}',
      )
      ..writeln();

    if (visible.isEmpty) {
      buffer.writeln(paint(emptyLabel, dim));
    } else {
      final maxRows = (term.rows - 8).clamp(5, 40);
      var start = 0;
      if (index >= maxRows) {
        start = index - maxRows + 1;
      }
      final end = (start + maxRows).clamp(0, visible.length);
      for (var i = start; i < end; i++) {
        final item = visible[i];
        final selected = i == index;
        final marker = item.id == currentId
            ? (selected ? '❯*' : ' *')
            : (selected ? '❯ ' : '  ');
        final trailing = item.trailing == null
            ? ''
            : paint(' ${item.trailing}', item.id == currentId ? fgGreen : dim);
        final bodyWidth = width - 4 - (item.trailing?.length ?? 0);
        final line =
            '$marker${padRight(truncate(item.label, bodyWidth), bodyWidth)}$trailing';
        buffer.writeln(selected ? paint(line, reverse) : line);
      }
      if (visible.length > maxRows) {
        buffer.writeln(paint('  ${start + 1}–$end / ${visible.length}', dim));
      }
    }
    buffer
      ..writeln()
      ..writeln(
        paint(
          'Type to filter · ↑↓ move · Enter select · Backspace delete · Ctrl+U clear · Esc back',
          dim,
        ),
      );
    term.write(buffer.toString());

    final key = await term.readKey();
    if (key == null) {
      continue;
    }
    switch (key.kind) {
      case KeyKind.up:
        if (visible.isNotEmpty) {
          index = (index - 1) % visible.length;
        }
      case KeyKind.down:
        if (visible.isNotEmpty) {
          index = (index + 1) % visible.length;
        }
      case KeyKind.enter:
        if (visible.isEmpty) {
          break;
        }
        return visible[index].id;
      case KeyKind.escape:
        return null;
      case KeyKind.backspace:
        if (query.isNotEmpty) {
          query = query.substring(0, query.length - 1);
          index = 0;
        }
      case KeyKind.clearLine:
        query = '';
        index = 0;
      case KeyKind.char:
        query += key.char!;
        index = 0;
      default:
        break;
    }
  }
}

Future<void> showMessage(
  Terminal term, {
  required String title,
  required List<String> lines,
  String prompt = 'Press any key to continue',
}) async {
  final width = term.columns.clamp(40, 120);
  final buffer = StringBuffer()
    ..write(clearScreen)
    ..writeln(paint(title, bold + fgCyan))
    ..writeln(paint(horizontalRule(width), dim));
  for (final line in lines) {
    buffer.writeln(line);
  }
  buffer
    ..writeln()
    ..writeln(paint(prompt, dim));
  term.write(buffer.toString());
  await term.readKey();
}
