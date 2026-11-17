import 'dart:async';

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
  int _connCount = 0;
  int _uploadTotal = 0;
  int _downloadTotal = 0;
  int _memory = 0;
  int _groupCount = 0;
  String _topGroupSummary = '—';
  StreamSubscription<Map<String, dynamic>>? _trafficSub;

  Future<void> run() async {
    term
      ..enableRaw()
      ..hideCursor();
    try {
      await _refreshHeader();
      await _startBackgroundTraffic();
      while (true) {
        await _drawHome();
        final key = await term.readKey(
          timeout: const Duration(milliseconds: 400),
        );
        if (key == null) {
          // Background SSE already updated rates; redraw the home header.
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
          case 'connections':
            await _browseConnections();
          case 'traffic':
            await _liveTraffic();
            await _startBackgroundTraffic();
          case 'quit':
            return;
        }
      }
    } finally {
      await _stopBackgroundTraffic();
      term
        ..clear()
        ..restore();
      term.writeln(paint('FlClash TUI closed.', dim));
    }
  }

  Future<void> _startBackgroundTraffic() async {
    await _stopBackgroundTraffic();
    // Cancelled in _stopBackgroundTraffic / run()'s finally.
    // ignore: cancel_subscriptions
    final sub = client.trafficStream().listen(
      (sample) {
        _up = formatRate(sample['up']);
        _down = formatRate(sample['down']);
      },
      onError: (_) {},
      cancelOnError: false,
    );
    _trafficSub = sub;
  }

  Future<void> _stopBackgroundTraffic() async {
    final sub = _trafficSub;
    _trafficSub = null;
    if (sub != null) {
      await sub.cancel();
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
    if (key.matchesChar('4') || key.matchesChar('c')) {
      return 'connections';
    }
    if (key.matchesChar('5') || key.matchesChar('t')) {
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
      items: [
        (
          id: 'status',
          label: '1  Refresh status',
          detail: 'version / mode / port / totals',
        ),
        (id: 'mode', label: '2  Switch mode', detail: 'rule · global · direct'),
        (
          id: 'groups',
          label: '3  Browse groups',
          detail: 'pick · delay-test · select',
        ),
        (
          id: 'connections',
          label: '4  Connections',
          detail: '$_connCount open · close one / all',
        ),
        (
          id: 'traffic',
          label: '5  Live traffic',
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
      ..writeln(paint('Dashboard', bold))
      ..writeln()
      ..writeln(
        '  ${paint('Mode', dim)}        ${paint(_mode, bold)}'
        '    ${paint('Port', dim)}  ${paint(_port, bold)}',
      )
      ..writeln(
        '  ${paint('Traffic', dim)}     ↑ ${paint(_up, fgGreen)}'
        '  ↓ ${paint(_down, fgCyan)}',
      )
      ..writeln(
        '  ${paint('Session', dim)}     ↑ ${formatBytes(_uploadTotal)}'
        '  ↓ ${formatBytes(_downloadTotal)}'
        '  · mem ${formatBytes(_memory)}',
      )
      ..writeln(
        '  ${paint('Links', dim)}       ${paint('$_connCount', bold)} open'
        '    ${paint('Groups', dim)}  ${paint('$_groupCount', bold)}'
        '  $_topGroupSummary',
      )
      ..writeln()
      ..writeln(paint('Shortcuts', bold))
      ..writeln()
      ..writeln('  ${paint('1/s', bold)}  Refresh status')
      ..writeln(
        '  ${paint('2/m', bold)}  Switch mode          ${paint('($_mode)', dim)}',
      )
      ..writeln('  ${paint('3/g', bold)}  Browse groups → delay / select')
      ..writeln(
        '  ${paint('4/c', bold)}  Connections          ${paint('($_connCount)', dim)}',
      )
      ..writeln('  ${paint('5/t', bold)}  Live traffic')
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
      _version = version['version']?.toString() ?? '?';
      _mode = configs['mode']?.toString() ?? '?';
      _port = (configs['mixed-port'] ?? configs['port'] ?? '?').toString();

      final groups = await client.listGroups();
      _groupCount = groups.length;
      if (groups.isEmpty) {
        _topGroupSummary = '—';
      } else {
        final primary = groups.firstWhere(
          (g) => g.name == 'GLOBAL' || g.name.toLowerCase() == 'proxy',
          orElse: () => groups.first,
        );
        _topGroupSummary = '→ ${primary.name}: ${primary.now.isEmpty ? '—' : primary.now}';
      }

      final snapshot = await client.getConnections();
      _connCount = snapshot.count;
      _uploadTotal = snapshot.uploadTotal;
      _downloadTotal = snapshot.downloadTotal;
      _memory = snapshot.memory;
      // Rates keep updating from the background /traffic stream.
    } on ClashApiException catch (error) {
      _flash('API error: $error');
    }
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
    final delayCache = <String, int>{};
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
      final picked = await showFilteredPicker(
        term,
        title: 'Proxy groups',
        hotkeys: const {'d': 'delay'},
        footerHint:
            'Type to filter · ↑↓ move · Enter open · d=delay-test group · Esc back',
        items: [
          for (final group in groups)
            (
              id: group.name,
              label: group.name,
              trailing: _groupTrailing(group, delayCache),
            ),
        ],
      );
      if (picked == null) {
        return;
      }
      if (picked.action == 'delay') {
        final name = picked.id;
        if (name == null) {
          continue;
        }
        await _delayTestGroup(name, delayCache);
        continue;
      }
      final stay = await _browseGroup(picked.id!, delayCache);
      if (!stay) {
        return;
      }
    }
  }

  String _groupTrailing(ProxyGroup group, Map<String, int> delayCache) {
    final delay = delayCache[group.now];
    final delayPart = delay == null ? '' : '  ${formatDelay(delay)}';
    return '${group.type} → ${group.now.isEmpty ? '—' : group.now}$delayPart';
  }

  Future<void> _delayTestGroup(
    String groupName,
    Map<String, int> delayCache,
  ) async {
    term.write(clearScreen);
    term.writeln(paint('Delay test', bold + fgCyan));
    term.writeln(paint(horizontalRule(term.columns.clamp(40, 120)), dim));
    term.writeln('Testing group ${paint(groupName, bold)}…');
    term.writeln(paint('This may take a few seconds.', dim));
    try {
      final results = await client.testGroupDelay(groupName);
      if (results.isEmpty) {
        // Fallback: probe current node only.
        final group = await client.getGroup(groupName);
        if (group != null && group.now.isNotEmpty) {
          final delay = await client.testDelay(group.now);
          if (delay != null) {
            delayCache[group.now] = delay;
          }
        }
        _flash('Group delay API empty; probed current node');
        return;
      }
      for (final entry in results.entries) {
        delayCache[entry.key] = entry.value;
      }
      final sorted = results.entries.toList()
        ..sort((a, b) {
          final av = a.value <= 0 ? 1 << 30 : a.value;
          final bv = b.value <= 0 ? 1 << 30 : b.value;
          return av.compareTo(bv);
        });
      final lines = <String>[
        'Group ${paint(groupName, bold)} — ${results.length} nodes',
        '',
      ];
      for (final entry in sorted.take(20)) {
        lines.add(
          '  ${padRight(truncate(entry.key, 36), 36)}  ${formatDelay(entry.value)}',
        );
      }
      if (sorted.length > 20) {
        lines.add(paint('  … ${sorted.length - 20} more', dim));
      }
      await showMessage(term, title: 'Delay results', lines: lines);
      _flash('Delay tested $groupName (${results.length})');
    } on ClashApiException catch (error) {
      await showMessage(
        term,
        title: 'Delay failed',
        lines: [paint(error.toString(), fgRed)],
      );
    }
  }

  /// Returns true to return to the group list, false to leave browsing.
  Future<bool> _browseGroup(
    String groupName,
    Map<String, int> delayCache,
  ) async {
    while (true) {
      final group = await client.getGroup(groupName);
      if (group == null) {
        _flash('Group not found: $groupName');
        return true;
      }
      var nodes = await client.listGroupNodes(groupName);
      nodes = [
        for (final node in nodes)
          node.withDelay(delayCache[node.name] ?? node.delayMs),
      ];
      final picked = await showFilteredPicker(
        term,
        title: '${group.name}  [${group.type}]',
        currentId: group.now,
        hotkeys: const {'d': 'delay', 'a': 'delay-all'},
        footerHint:
            'Type to filter · ↑↓ · Enter select · d=delay · a=delay-all · Esc back',
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
      if (picked.action == 'delay-all') {
        await _delayTestGroup(groupName, delayCache);
        continue;
      }
      if (picked.action == 'delay') {
        final name = picked.id;
        if (name == null) {
          continue;
        }
        await _delayTestNode(name, delayCache);
        continue;
      }
      try {
        await client.selectProxy(group.name, picked.id!);
        _flash('${group.name} → ${picked.id}');
        final again = await showMenu(
          term,
          title: 'Selected',
          subtitle: '${group.name} → ${picked.id}',
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

  Future<void> _delayTestNode(
    String proxy,
    Map<String, int> delayCache,
  ) async {
    term.write(clearScreen);
    term.writeln(paint('Delay test', bold + fgCyan));
    term.writeln('Testing ${paint(proxy, bold)}…');
    final delay = await client.testDelay(proxy);
    if (delay == null) {
      delayCache[proxy] = 0;
      await showMessage(
        term,
        title: 'Delay result',
        lines: [
          paint(proxy, bold),
          '',
          paint('timeout / unreachable', fgRed),
        ],
      );
      _flash('$proxy → timeout');
      return;
    }
    delayCache[proxy] = delay;
    await showMessage(
      term,
      title: 'Delay result',
      lines: [
        paint(proxy, bold),
        '',
        paint(formatDelay(delay), fgGreen + bold),
      ],
    );
    _flash('$proxy → ${formatDelay(delay)}');
  }

  Future<void> _browseConnections() async {
    while (true) {
      final ConnectionSnapshot snapshot;
      try {
        snapshot = await client.getConnections();
      } on ClashApiException catch (error) {
        await showMessage(
          term,
          title: 'Connections failed',
          lines: [paint(error.toString(), fgRed)],
        );
        return;
      }
      _connCount = snapshot.count;
      _uploadTotal = snapshot.uploadTotal;
      _downloadTotal = snapshot.downloadTotal;
      _memory = snapshot.memory;

      final items = <PickerItem>[
        for (final conn in snapshot.connections)
          (
            id: conn['id']?.toString() ?? '',
            label: connectionLabel(conn),
            trailing:
                '↓${formatBytes(conn['download'])} ↑${formatBytes(conn['upload'])}',
          ),
      ];

      final picked = await showFilteredPicker(
        term,
        title:
            'Connections  (${snapshot.count})  ·  '
            '↓${formatBytes(snapshot.downloadTotal)} '
            '↑${formatBytes(snapshot.uploadTotal)}  ·  '
            'mem ${formatBytes(snapshot.memory)}',
        emptyLabel: 'No open connections',
        hotkeys: const {
          'x': 'close',
          'X': 'close-all',
          'r': 'refresh',
        },
        footerHint:
            'Type to filter · ↑↓ · Enter details · x=close · X=close-all · r=refresh · Esc back',
        items: items.where((item) => item.id.isNotEmpty).toList(),
      );
      if (picked == null) {
        return;
      }
      if (picked.action == 'refresh') {
        continue;
      }
      if (picked.action == 'close-all') {
        final ok = await confirm(
          term,
          title: 'Close all connections?',
          message: 'This drops every active link (${snapshot.count}).',
        );
        if (ok) {
          try {
            await client.closeAllConnections();
            _flash('Closed all connections');
          } on ClashApiException catch (error) {
            await showMessage(
              term,
              title: 'Close all failed',
              lines: [paint(error.toString(), fgRed)],
            );
          }
        }
        continue;
      }
      if (picked.action == 'close') {
        final id = picked.id;
        if (id == null || id.isEmpty) {
          continue;
        }
        try {
          await client.closeConnection(id);
          _flash('Closed connection');
        } on ClashApiException catch (error) {
          await showMessage(
            term,
            title: 'Close failed',
            lines: [paint(error.toString(), fgRed)],
          );
        }
        continue;
      }

      final id = picked.id!;
      Map<String, dynamic>? conn;
      for (final item in snapshot.connections) {
        if (item['id']?.toString() == id) {
          conn = item;
          break;
        }
      }
      if (conn == null) {
        continue;
      }
      await _showConnectionDetail(conn);
    }
  }

  Future<void> _showConnectionDetail(Map<String, dynamic> conn) async {
    final meta = conn['metadata'];
    final metadata = meta is Map
        ? meta.cast<String, dynamic>()
        : const <String, dynamic>{};
    final chains = conn['chains'];
    final chainText = chains is List ? chains.join(' ← ') : '—';
    await showMessage(
      term,
      title: 'Connection',
      lines: [
        paint(connectionLabel(conn), bold),
        '',
        'id       ${conn['id']}',
        'network  ${metadata['network'] ?? '?'}  ${metadata['type'] ?? ''}',
        'source   ${metadata['sourceIP'] ?? '?'}:${metadata['sourcePort'] ?? '?'}',
        'dest     ${connectionHost(metadata)}:${metadata['destinationPort'] ?? '?'}',
        'process  ${metadata['process'] ?? metadata['processPath'] ?? '—'}',
        'rule     ${conn['rule'] ?? '—'} ${conn['rulePayload'] ?? ''}',
        'chains   $chainText',
        'traffic  ↓${formatBytes(conn['download'])}  ↑${formatBytes(conn['upload'])}',
      ],
      prompt: 'Press any key for actions',
    );
    final action = await showMenu(
      term,
      title: 'Connection',
      subtitle: connectionHost(metadata),
      items: const [
        (id: 'close', label: 'Close this connection', detail: 'DELETE'),
        (id: 'back', label: 'Back', detail: null),
      ],
    );
    if (action != 'close') {
      return;
    }
    final id = conn['id']?.toString();
    if (id == null) {
      return;
    }
    try {
      await client.closeConnection(id);
      _flash('Closed connection');
    } on ClashApiException catch (error) {
      await showMessage(
        term,
        title: 'Close failed',
        lines: [paint(error.toString(), fgRed)],
      );
    }
  }

  Future<void> _liveTraffic() async {
    await _stopBackgroundTraffic();
    term.write(clearScreen);
    term.writeln(paint('Live traffic', bold + fgCyan));
    term.writeln(paint('Esc or q to stop', dim));
    term.writeln();
    var stop = false;
    final sub = client.trafficStream().listen(
      (sample) {
        _up = formatRate(sample['up']);
        _down = formatRate(sample['down']);
        term.write(
          '\r$clearLine↑ ${paint(_up, fgGreen)}    ↓ ${paint(_down, fgCyan)}   ',
        );
      },
      onError: (Object error) {
        stop = true;
        _flash('Traffic error: $error');
      },
      cancelOnError: true,
    );
    try {
      while (!stop) {
        final key = await term.readKey(
          timeout: const Duration(milliseconds: 200),
        );
        if (key != null &&
            (key.kind == KeyKind.escape || key.matchesChar('q'))) {
          break;
        }
      }
    } finally {
      await sub.cancel();
    }
    term.writeln();
    _flash('Traffic watch stopped');
  }
}
