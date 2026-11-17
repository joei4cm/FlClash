import 'dart:io';

import 'ansi.dart';
import 'api.dart';
import 'format.dart';

const helpText = '''
FlClash desktop TUI

Interactive (TTY):
  dart run tool/tui.dart

One-shot:
  dart run tool/tui.dart status
  dart run tool/tui.dart mode [rule|global|direct]
  dart run tool/tui.dart groups
  dart run tool/tui.dart group <name>
  dart run tool/tui.dart use <group> <proxy>
  dart run tool/tui.dart traffic
  dart run tool/tui.dart watch [n]

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
  stdout.writeln('version  ${version['version']}');
  stdout.writeln('mode     ${configs['mode'] ?? '?'}');
  stdout.writeln('port     ${configs['mixed-port'] ?? configs['port'] ?? '?'}');
  stdout.writeln(
    'traffic  ↑ ${formatRate(traffic['up'])}  ↓ ${formatRate(traffic['down'])}',
  );
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
