import 'dart:io';

import 'ansi.dart';
import 'api.dart';
import 'format.dart';

const helpText = '''
FlClash desktop TUI

Interactive (TTY):
  flclash-tui

One-shot:
  flclash-tui status
  flclash-tui mode [rule|global|direct]
  flclash-tui groups
  flclash-tui group <name>
  flclash-tui use <group> <proxy>
  flclash-tui delay <proxy>
  flclash-tui delay-group <group>
  flclash-tui connections
  flclash-tui close <id>
  flclash-tui close-all
  flclash-tui traffic
  flclash-tui watch [n]

From a source checkout: dart run tool/tui.dart …

Env:
  FLCLASH_API=http://127.0.0.1:9090
  FLCLASH_SECRET=...
''';

Future<void> runCli(ClashApi client, List<String> parts) async {
  switch (parts.first) {
    case 'status':
    case 's':
      await printStatus(client);
    case 'mode':
    case 'm':
      if (parts.length == 1) {
        final configs = await client.getConfigs();
        stdout.writeln('mode  ${configs['mode'] ?? '?'}');
        break;
      }
      final mode = parts[1].toLowerCase();
      if (mode != 'rule' && mode != 'global' && mode != 'direct') {
        throw const FormatException('usage: mode [rule|global|direct]');
      }
      await client.patchConfigs({'mode': mode});
      stdout.writeln('mode → $mode');
    case 'groups':
    case 'g':
      await printGroups(client);
    case 'group':
      if (parts.length < 2) {
        throw const FormatException('usage: group <name>');
      }
      await printGroup(client, parts.sublist(1).join(' '));
    case 'use':
    case 'u':
      if (parts.length < 3) {
        throw const FormatException('usage: use <group> <proxy>');
      }
      await client.selectProxy(parts[1], parts.sublist(2).join(' '));
      stdout.writeln('selected ${parts.sublist(2).join(' ')} in ${parts[1]}');
    case 'delay':
    case 'd':
      if (parts.length < 2) {
        throw const FormatException('usage: delay <proxy>');
      }
      await printDelay(client, parts.sublist(1).join(' '));
    case 'delay-group':
    case 'dg':
      if (parts.length < 2) {
        throw const FormatException('usage: delay-group <group>');
      }
      await printGroupDelay(client, parts.sublist(1).join(' '));
    case 'connections':
    case 'c':
    case 'conn':
      await printConnections(client);
    case 'close':
      if (parts.length < 2) {
        throw const FormatException('usage: close <id>');
      }
      await client.closeConnection(parts[1]);
      stdout.writeln('closed ${parts[1]}');
    case 'close-all':
      await client.closeAllConnections();
      stdout.writeln('closed all connections');
    case 'traffic':
    case 't':
      await printTraffic(client);
    case 'watch':
    case 'w':
      final count = parts.length > 1 ? int.tryParse(parts[1]) ?? 10 : 10;
      await watchTraffic(client, count.clamp(1, 120));
    case 'help':
    case 'h':
    case '?':
      stdout.write(helpText);
    default:
      throw FormatException('unknown command: ${parts.first}\n$helpText');
  }
}

Future<void> printStatus(ClashApi client) async {
  final version = await client.getVersion();
  final configs = await client.getConfigs();
  final traffic = await client.getTrafficOnce();
  final snapshot = await client.getConnections();
  final groups = await client.listGroups();
  stdout.writeln('version  ${version['version']}');
  stdout.writeln('mode     ${configs['mode'] ?? '?'}');
  stdout.writeln('port     ${configs['mixed-port'] ?? configs['port'] ?? '?'}');
  stdout.writeln(
    'traffic  ↑ ${formatRate(traffic['up'])}  ↓ ${formatRate(traffic['down'])}',
  );
  stdout.writeln(
    'session  ↑ ${formatBytes(snapshot.uploadTotal)}  '
    '↓ ${formatBytes(snapshot.downloadTotal)}  '
    'mem ${formatBytes(snapshot.memory)}',
  );
  stdout.writeln('links    ${snapshot.count} open');
  stdout.writeln('groups   ${groups.length}');
}

Future<void> printGroups(ClashApi client) async {
  final groups = await client.listGroups();
  if (groups.isEmpty) {
    stdout.writeln(paint('(no proxy groups)', dim));
    return;
  }
  for (final group in groups) {
    stdout.writeln(
      '${group.name}  [${group.type}]  → ${group.now}  (${group.all.length})',
    );
  }
}

Future<void> printGroup(ClashApi client, String name) async {
  final group = await client.getGroup(name);
  if (group == null) {
    stdout.writeln('group not found: $name');
    return;
  }
  stdout.writeln('${group.name}  [${group.type}]  → ${group.now}');
  final nodes = await client.listGroupNodes(name);
  for (final node in nodes) {
    final mark = node.name == group.now ? '*' : ' ';
    final delay = node.delayMs == null ? '' : '  ${formatDelay(node.delayMs)}';
    stdout.writeln('  $mark ${node.name}$delay');
  }
}

Future<void> printDelay(ClashApi client, String proxy) async {
  final delay = await client.testDelay(proxy);
  if (delay == null) {
    stdout.writeln('$proxy  timeout');
    return;
  }
  stdout.writeln('$proxy  ${formatDelay(delay)}');
}

Future<void> printGroupDelay(ClashApi client, String group) async {
  final results = await client.testGroupDelay(group);
  if (results.isEmpty) {
    stdout.writeln('(no delay results for $group)');
    return;
  }
  final sorted = results.entries.toList()
    ..sort((a, b) {
      final av = a.value <= 0 ? 1 << 30 : a.value;
      final bv = b.value <= 0 ? 1 << 30 : b.value;
      return av.compareTo(bv);
    });
  for (final entry in sorted) {
    stdout.writeln('${entry.key}  ${formatDelay(entry.value)}');
  }
}

Future<void> printConnections(ClashApi client) async {
  final snapshot = await client.getConnections();
  stdout.writeln(
    '${snapshot.count} connections  '
    '↓${formatBytes(snapshot.downloadTotal)}  '
    '↑${formatBytes(snapshot.uploadTotal)}  '
    'mem ${formatBytes(snapshot.memory)}',
  );
  for (final conn in snapshot.connections) {
    final id = conn['id']?.toString() ?? '?';
    stdout.writeln(
      '  $id  ${connectionLabel(conn)}  '
      '↓${formatBytes(conn['download'])} ↑${formatBytes(conn['upload'])}',
    );
  }
}

Future<void> printTraffic(ClashApi client) async {
  final sample = await client.getTrafficOnce();
  stdout.writeln(
    '↑ ${formatRate(sample['up'])}   ↓ ${formatRate(sample['down'])}',
  );
}

Future<void> watchTraffic(ClashApi client, int samples) async {
  stdout.writeln('watching $samples samples…');
  var seen = 0;
  await for (final sample in client.trafficStream()) {
    stdout.writeln(
      '↑ ${formatRate(sample['up'])}   ↓ ${formatRate(sample['down'])}',
    );
    seen += 1;
    if (seen >= samples) {
      break;
    }
  }
}
