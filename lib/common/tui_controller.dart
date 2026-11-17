import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/clash_config.dart';
import 'package:path/path.dart';

/// Desktop TUI discovery file written while the Core's external controller is
/// open. The TUI reads it without taking the GUI single-instance lock.
///
/// File I/O is best-effort: stop/teardown must not fail when the data directory
/// is unavailable (unit tests without path_provider, or a missing home dir).
class TuiControllerEndpoint {
  static const fileName = 'tui-controller.json';

  static Future<String> pathFor({AppPath? paths, String? homeDir}) async =>
      join(homeDir ?? await (paths ?? appPath).homeDirPath, fileName);

  /// Publishes or clears the endpoint based on [patch] after a successful Core
  /// push. No-op on mobile: TUI is desktop-only.
  static Future<void> syncFromPatch(
    PatchClashConfig patch, {
    AppPath? paths,
    String? homeDir,
    bool isDesktop = true,
  }) async {
    if (!isDesktop) {
      return;
    }
    if (patch.externalController == ExternalControllerStatus.open &&
        patch.secret.isNotEmpty) {
      await publish(
        address: ExternalControllerStatus.open.value,
        secret: patch.secret,
        paths: paths,
        homeDir: homeDir,
      );
      return;
    }
    await clear(paths: paths, homeDir: homeDir);
  }

  static Future<void> publish({
    required String address,
    required String secret,
    AppPath? paths,
    String? homeDir,
  }) async {
    await _bestEffort(() async {
      final file = File(await pathFor(paths: paths, homeDir: homeDir));
      final body = jsonEncode({
        'address': address,
        'secret': secret,
        'url': 'http://$address',
      });
      await file.writeAsString(body);
    });
  }

  static Future<void> clear({AppPath? paths, String? homeDir}) async {
    await _bestEffort(() async {
      final file = File(await pathFor(paths: paths, homeDir: homeDir));
      if (await file.exists()) {
        await file.delete();
      }
    });
  }

  static Future<({String url, String secret})?> read({
    AppPath? paths,
    String? homeDir,
  }) async {
    try {
      final file = File(await pathFor(paths: paths, homeDir: homeDir));
      if (!await file.exists()) {
        return null;
      }
      final json =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      final url = (json['url'] as String?)?.trim();
      final secret = (json['secret'] as String?)?.trim() ?? '';
      if (url == null || url.isEmpty) {
        return null;
      }
      return (url: url, secret: secret);
    } catch (_) {
      return null;
    }
  }

  static Future<void> _bestEffort(Future<void> Function() run) async {
    try {
      await run();
    } catch (_) {
      // Discovery file is optional; Core stop / config push must continue.
    }
  }
}
