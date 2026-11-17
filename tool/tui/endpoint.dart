import 'dart:convert';
import 'dart:io';

class ControllerEndpoint {
  const ControllerEndpoint({required this.url, required this.secret});

  final String url;
  final String secret;
}

Future<ControllerEndpoint?> resolveEndpoint({
  Map<String, String>? environment,
  List<String>? searchPaths,
}) async {
  final env = environment ?? Platform.environment;
  final envUrl = env['FLCLASH_API']?.trim();
  final envSecret = env['FLCLASH_SECRET']?.trim() ?? '';
  if (envUrl != null && envUrl.isNotEmpty) {
    return ControllerEndpoint(url: envUrl, secret: envSecret);
  }

  for (final path in searchPaths ?? controllerSearchPaths(env: env)) {
    final file = File(path);
    if (!await file.exists()) {
      continue;
    }
    try {
      final json =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      final url = (json['url'] as String?)?.trim();
      final secret = (json['secret'] as String?)?.trim() ?? '';
      if (url != null && url.isNotEmpty) {
        return ControllerEndpoint(url: url, secret: secret);
      }
    } catch (_) {
      continue;
    }
  }
  return null;
}

List<String> controllerSearchPaths({
  Map<String, String>? env,
  bool? isMacOS,
  bool? isWindows,
}) {
  final environment = env ?? Platform.environment;
  final home = environment['HOME'] ?? environment['USERPROFILE'] ?? '';
  final mac = isMacOS ?? Platform.isMacOS;
  final win = isWindows ?? Platform.isWindows;
  if (mac) {
    return [
      '$home/Library/Application Support/com.follow.clash/tui-controller.json',
      '$home/Library/Application Support/com.follow.clash.debug/tui-controller.json',
    ];
  }
  if (win) {
    final appData = environment['APPDATA'] ?? '$home/AppData/Roaming';
    return ['$appData/com.follow.clash/tui-controller.json'];
  }
  return [
    '$home/.local/share/com.follow.clash/tui-controller.json',
    '$home/.config/com.follow.clash/tui-controller.json',
  ];
}
