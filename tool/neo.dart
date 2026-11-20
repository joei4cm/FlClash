#!/usr/bin/env dart

// Experimental headless FlClash host + CLI (Neo).
// Lives on cursor/neo-* branches — do not ship on production until ready.
//
// Build:
//   bash tool/build_neo.sh
//   # -> libclash/<os>/flclash-neo
//
// Run:
//   ./libclash/linux/flclash-neo run --config ./config.yaml
//   ./libclash/linux/flclash-neo status
//   ./libclash/linux/flclash-neo stop

import 'dart:io';

import 'neo/cli.dart';

Future<void> main(List<String> args) async {
  if (Platform.isAndroid || Platform.isIOS) {
    stderr.writeln('FlClash Neo is desktop-only.');
    exit(2);
  }
  exit(await runNeo(args));
}
