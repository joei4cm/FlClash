#!/usr/bin/env dart

// Experimental headless FlClash host + CLI (Neo).
// Lives on cursor/neo-* branches — do not ship on production until ready.
//
//   dart run tool/neo.dart run --config ./config.yaml
//   dart run tool/neo.dart status
//   dart run tool/neo.dart stop

import 'dart:io';

import 'neo/cli.dart';

Future<void> main(List<String> args) async {
  if (Platform.isAndroid || Platform.isIOS) {
    stderr.writeln('FlClash Neo is desktop-only.');
    exit(2);
  }
  exit(await runNeo(args));
}
