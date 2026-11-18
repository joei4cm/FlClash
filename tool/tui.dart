#!/usr/bin/env dart

// Desktop-only FlClash TUI. Talks to mihomo's external-controller HTTP API so
// it can coexist with the GUI (no data-dir lock). Requires the GUI (or another
// owner) to have the Core running with external controller + secret enabled;
// FlClash writes tui-controller.json when that is the case.
//
// Installed builds ship `flclash-tui` on PATH (Linux/Windows) or inside the
// macOS app bundle. From a source checkout:
//   dart run tool/tui.dart
//   dart run tool/tui.dart status
//   FLCLASH_API=http://127.0.0.1:9090 FLCLASH_SECRET=xxx dart run tool/tui.dart

import 'dart:io';

import 'tui/api.dart';
import 'tui/app.dart';
import 'tui/cli.dart';
import 'tui/endpoint.dart';
import 'tui/term.dart';

Future<void> main(List<String> args) async {
  if (Platform.isAndroid || Platform.isIOS) {
    stderr.writeln('FlClash TUI is desktop-only.');
    exit(2);
  }

  if (args.isNotEmpty &&
      (args.first == 'help' || args.first == '-h' || args.first == '--help')) {
    stdout.write(helpText);
    return;
  }

  final endpoint = await resolveEndpoint();
  if (endpoint == null) {
    stderr.writeln('''
No FlClash controller endpoint found.

1. Open FlClash GUI → Tools → General
2. Enable External controller and set a secret
3. Start the proxy
4. Re-run: flclash-tui

Or set FLCLASH_API and FLCLASH_SECRET manually.
''');
    exit(1);
  }

  final client = ClashApi(endpoint.url, endpoint.secret);
  final term = Terminal();
  try {
    if (args.isEmpty) {
      if (!term.hasTerminal) {
        stderr.writeln(
          'No TTY detected. Use one-shot commands, for example:\n'
          '  flclash-tui status\n'
          'Or run inside a real terminal for the interactive UI.',
        );
        await runCli(client, const ['status']);
        return;
      }
      await TuiApp(client, term).run();
      return;
    }
    await runCli(client, args);
  } on ClashApiException catch (error) {
    stderr.writeln('API error: $error');
    exit(1);
  } on FormatException catch (error) {
    stderr.writeln('$error');
    exit(2);
  } finally {
    term.restore();
    client.close();
  }
}
