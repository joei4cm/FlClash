import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show visibleForTesting;

typedef DesktopProcessRunner =
    Future<ProcessResult> Function(String executable, List<String> arguments);

/// Running process names for desktop App routing pickers.
///
/// Uses OS tools (`ps` / `tasklist`) so no platform channel is required.
/// Names are normalized for mihomo PROCESS-NAME rules (basename; keep
/// `.exe` on Windows).
class DesktopProcesses {
  DesktopProcesses({DesktopProcessRunner? runProcess})
    : _runProcess = runProcess ?? Process.run;

  final DesktopProcessRunner _runProcess;

  static final _kernelThread = RegExp(r'^\[.+]$');
  static final _pathLike = RegExp(r'[/\\]');

  /// Unique, case-insensitive sorted process names suitable for PROCESS-NAME.
  Future<List<String>> listNames({
    bool? windows,
    bool? macOS,
    bool? linux,
  }) async {
    final isWindows = windows ?? Platform.isWindows;
    final isMacOS = macOS ?? Platform.isMacOS;
    final isLinux = linux ?? Platform.isLinux;
    if (!isWindows && !isMacOS && !isLinux) {
      return const [];
    }
    final raw = isWindows
        ? await _listWindows()
        : await _listUnix(macOS: isMacOS);
    return normalizeNames(raw, keepExe: isWindows);
  }

  Future<List<String>> _listWindows() async {
    final result = await _runProcess('tasklist', const ['/FO', 'CSV', '/NH']);
    if (result.exitCode != 0) {
      throw ProcessException(
        'tasklist',
        const ['/FO', 'CSV', '/NH'],
        (result.stderr as String?)?.trim() ?? 'tasklist failed',
        result.exitCode,
      );
    }
    return parseWindowsTasklistCsv(result.stdout as String);
  }

  Future<List<String>> _listUnix({required bool macOS}) async {
    // `-axc` / `-eo` with `comm=` yields the executable name mihomo matches.
    final args = macOS ? const ['-axc', '-o', 'comm='] : const ['-eo', 'comm='];
    final result = await _runProcess('ps', args);
    if (result.exitCode != 0) {
      throw ProcessException(
        'ps',
        args,
        (result.stderr as String?)?.trim() ?? 'ps failed',
        result.exitCode,
      );
    }
    return parseUnixCommList(result.stdout as String);
  }

  @visibleForTesting
  static List<String> parseWindowsTasklistCsv(String stdout) {
    final names = <String>[];
    for (final line in const LineSplitter().convert(stdout)) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        continue;
      }
      // "chrome.exe","1234","Console","1","12,345 K"
      if (trimmed.startsWith('"')) {
        final end = trimmed.indexOf('"', 1);
        if (end > 1) {
          names.add(trimmed.substring(1, end));
          continue;
        }
      }
      final comma = trimmed.indexOf(',');
      names.add(comma < 0 ? trimmed : trimmed.substring(0, comma));
    }
    return names;
  }

  @visibleForTesting
  static List<String> parseUnixCommList(String stdout) {
    return [
      for (final line in const LineSplitter().convert(stdout))
        if (line.trim().isNotEmpty) line.trim(),
    ];
  }

  @visibleForTesting
  static List<String> normalizeNames(
    Iterable<String> raw, {
    required bool keepExe,
  }) {
    final byLower = <String, String>{};
    for (final item in raw) {
      var name = item.trim();
      if (name.isEmpty || _kernelThread.hasMatch(name)) {
        continue;
      }
      if (_pathLike.hasMatch(name)) {
        // path.basename follows the host OS; Windows paths may appear while
        // tests or tooling run on Unix, so split on both separators.
        final slash = name.lastIndexOf('/');
        final backslash = name.lastIndexOf('\\');
        final cut = slash > backslash ? slash : backslash;
        name = cut < 0 ? name : name.substring(cut + 1);
      }
      if (!keepExe && name.toLowerCase().endsWith('.exe')) {
        name = name.substring(0, name.length - 4);
      }
      if (name.isEmpty || name == '-') {
        continue;
      }
      byLower.putIfAbsent(name.toLowerCase(), () => name);
    }
    final sorted = byLower.values.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return sorted;
  }
}

final desktopProcesses = DesktopProcesses();
