import 'ansi.dart';
import 'api.dart';
import 'format.dart';
import 'keys.dart';
import 'term.dart';
import 'widgets.dart';

/// Full-screen interactive FlClash controller for a real terminal.
class TuiApp {
  TuiApp(this.client, this.term);

  final ClashApi client;
  final Terminal term;

  String? _statusLine;
  String _mode = '?';
  String _port = '?';
  String _version = '?';
  String _up = '0 B/s';
  String _down = '0 B/s';

  Future<void> run() async {
    term
      ..enableRaw()
      ..hideCursor();
    try {
      await _refreshHeader();
      while (true) {
        await _drawHome();
        final key = await term.readKey(timeout: const Duration(seconds: 1));
        if (key == null) {
          await _refreshTrafficQuiet();
          continue;
        }
        if (key.kind == KeyKind.escape || key.matchesChar('q')) {
          return;
        }
        if (key.matchesChar('r')) {
          await _refreshHeader();
          _flash('Refreshed');
          continue;
        }

        final shortcut = _shortcut(key);
        if (shortcut == _ignore) {
          continue;
        }
        final action = shortcut == _menu ? await _openMainMenu() : shortcut;
        if (action == null) {
          continue;
        }
        switch (action) {
          case 'status':
            await _refreshHeader();
            _flash('Status updated');
          case 'mode':
            await _switchMode();
          case 'groups':
            await _browseGroups();
          case 'traffic':
            await _liveTraffic();
          case 'quit':
            return;
        }
      }
    } finally {
      term
        ..clear()
        ..restore();
      term.writeln(paint('FlClash TUI closed.', dim));
    }
  }

  static const _menu = '__menu__';
  static const _ignore = '__ignore__';

  String _shortcut(KeyEvent key) {
    if (key.matchesChar('1') || key.matchesChar('s')) {
      return 'status';
    }
    if (key.matchesChar('2') || key.matchesChar('m')) {
      return 'mode';
    }
    if (key.matchesChar('3') || key.matchesChar('g')) {
      return 'groups';
    }
    if (key.matchesChar('4') || key.matchesChar('t')) {
      return 'traffic';
    }
    if (key.kind == KeyKind.enter ||
        key.kind == KeyKind.down ||
        key.matchesChar('j') ||
        key.matchesChar('?') ||
        key.matchesChar('h')) {
      return _menu;
    }
    return _ignore;
  }

  Future<String?> _openMainMenu() {
    return showMenu(
      term,
      title: 'FlClash TUI',
      subtitle: _headerSubtitle(),
      items: const [
        (
          id: 'status',
          label: '1  Refresh status',
          detail: 'version / mode / port / traffic',
        ),
        (id: 'mode', label: '2  Switch mode', detail: 'rule · global · direct'),
        (
          id: 'groups',
          label: '3  Browse groups',
          detail: 'pick a group, then a node',
        ),
        (
          id: 'traffic',
          label: '4  Live traffic',
          detail: 'in-place up/down rates',
        ),
        (id: 'quit', label: 'q  Quit', detail: null),
      ],
    );
  }

  String _headerSubtitle() {
    return 'mihomo $_version  ·  mode $_mode  ·  port $_port  ·  '
        '↑ $_up  ↓ $_down'
        '${_statusLine == null ? '' : '  ·  $_statusLine'}';
  }

  Future<void> _drawHome() async {
    final width = term.columns.clamp(40, 120);
    final buffer = StringBuffer()
      ..write(clearScreen)
      ..writeln(
        paint('FlClash TUI', bold + fgCyan) + paint('  desktop companion', dim),
      )
      ..writeln(paint(horizontalRule(width), dim))
      ..writeln(paint(_headerSubtitle(), fgWhite))
      ..writeln()
      ..writeln(paint('Shortcuts', bold))
      ..writeln()
      ..writeln('  ${paint('1/s', bold)}  Refresh status')
      ..writeln(
        '  ${paint('2/m', bold)}  Switch mode          ${paint('($_mode)', dim)}',
      )
      ..writeln('  ${paint('3/g', bold)}  Browse groups → node')
      ..writeln('  ${paint('4/t', bold)}  Live traffic')
      ..writeln(
        '  ${paint('Enter', bold)} Menu · ${paint('r', bold)} refresh · ${paint('q', bold)} quit',
      )
      ..writeln()
      ..writeln(
        paint('Traffic auto-refreshes every second while you stay here.', dim),
      );
    if (_statusLine != null) {
      buffer
        ..writeln()
        ..writeln(paint('✓ $_statusLine', fgGreen));
    }
    term.write(buffer.toString());
  }

  void _flash(String message) {
    _statusLine = message;
  }

  Future<void> _refreshHeader() async {
    try {
      final version = await client.getVersion();
      final configs = await client.getConfigs();
      final traffic = await client.getTrafficOnce();
      _version = version['version']?.toString() ?? '?';
      _mode = configs['mode']?.toString() ?? '?';
      _port = (configs['mixed-port'] ?? configs['port'] ?? '?').toString();
      _up = formatRate(traffic['up']);
      _down = formatRate(traffic['down']);
    } on ClashApiException catch (error) {
      _flash('API error: $error');
    }
  }

  Future<void> _refreshTrafficQuiet() async {
    try {
      final traffic = await client.getTrafficOnce();
      _up = formatRate(traffic['up']);
      _down = formatRate(traffic['down']);
    } catch (_) {}
  }

  Future<void> _switchMode() async {
    final selected = await showMenu(
      term,
      title: 'Switch mode',
      subtitle: 'Current: $_mode',
      initialIndex: switch (_mode) {
        'global' => 1,
        'direct' => 2,
        _ => 0,
      },
      items: const [
        (id: 'rule', label: 'rule', detail: 'match by rules (default)'),
        (
          id: 'global',
          label: 'global',
          detail: 'send all traffic through GLOBAL',
        ),
        (id: 'direct', label: 'direct', detail: 'bypass proxies'),
      ],
    );
    if (selected == null) {
      return;
    }
    try {
      await client.patchConfigs({'mode': selected});
      _mode = selected;
      _flash('Mode → $selected');
    } on ClashApiException catch (error) {
      await showMessage(
        term,
        title: 'Mode failed',
        lines: [paint(error.toString(), fgRed)],
      );
    }
  }

  Future<void> _browseGroups() async {
    while (true) {
      final List<ProxyGroup> groups;
      try {
        groups = await client.listGroups();
      } on ClashApiException catch (error) {
        await showMessage(
          term,
          title: 'Groups failed',
          lines: [paint(error.toString(), fgRed)],
        );
        return;
      }
      if (groups.isEmpty) {
        await showMessage(
          term,
          title: 'No groups',
          lines: const [
            'The Core has no selectable proxy groups yet.',
            'Start the proxy in the GUI and open a profile first.',
          ],
        );
        return;
      }
      final selected = await showFilteredPicker(
        term,
        title: 'Proxy groups',
        items: [
          for (final group in groups)
            (
              id: group.name,
              label: group.name,
              trailing:
                  '${group.type} → ${group.now.isEmpty ? '—' : group.now}',
            ),
        ],
      );
      if (selected == null) {
        return;
      }
      final stay = await _browseGroup(selected);
      if (!stay) {
        return;
      }
    }
  }

  /// Returns true to return to the group list, false to leave browsing.
  Future<bool> _browseGroup(String groupName) async {
    while (true) {
      final group = await client.getGroup(groupName);
      if (group == null) {
        _flash('Group not found: $groupName');
        return true;
      }
      final nodes = await client.listGroupNodes(groupName);
      final picked = await showFilteredPicker(
        term,
        title: '${group.name}  [${group.type}]',
        currentId: group.now,
        items: [
          for (final node in nodes)
            (
              id: node.name,
              label: node.name,
              trailing: node.delayMs == null ? null : formatDelay(node.delayMs),
            ),
        ],
      );
      if (picked == null) {
        return true;
      }
      try {
        await client.selectProxy(group.name, picked);
        _flash('${group.name} → $picked');
        final again = await showMenu(
          term,
          title: 'Selected',
          subtitle: '${group.name} → $picked',
          items: const [
            (
              id: 'again',
              label: 'Pick another node in this group',
              detail: null,
            ),
            (id: 'groups', label: 'Back to groups', detail: null),
            (id: 'home', label: 'Home', detail: null),
          ],
        );
        if (again == 'again') {
          continue;
        }
        if (again == 'groups') {
          return true;
        }
        return false;
      } on ClashApiException catch (error) {
        await showMessage(
          term,
          title: 'Select failed',
          lines: [paint(error.toString(), fgRed)],
        );
        return true;
      }
    }
  }

  Future<void> _liveTraffic() async {
    term.write(clearScreen);
    term.writeln(paint('Live traffic', bold + fgCyan));
    term.writeln(paint('Esc or q to stop', dim));
    term.writeln();
    try {
      await for (final sample in client.trafficStream()) {
        _up = formatRate(sample['up']);
        _down = formatRate(sample['down']);
        term.write(
          '\r$clearLine↑ ${paint(_up, fgGreen)}    ↓ ${paint(_down, fgCyan)}   ',
        );
        final key = await term.readKey(
          timeout: const Duration(milliseconds: 20),
        );
        if (key != null &&
            (key.kind == KeyKind.escape || key.matchesChar('q'))) {
          break;
        }
      }
    } on ClashApiException catch (error) {
      await showMessage(
        term,
        title: 'Traffic failed',
        lines: [paint(error.toString(), fgRed)],
      );
    }
    term.writeln();
    _flash('Traffic watch stopped');
  }
}
