import 'dart:io';

import 'package:fl_clash/common/system.dart';

/// Host-level helpers for Claude Code / terminal geo identity.
///
/// Claude Code reads the **OS timezone** (not GeoMirror). Terminal traffic is
/// captured by TUN/VPN automatically; with system-proxy-only mode, Node often
/// needs explicit `HTTP(S)_PROXY` exports pointed at FlClash's mixed port.
abstract final class GeoIdentityHost {
  /// Common IANA → Windows `tzutil` display names for US exits.
  static const windowsTimezoneNames = <String, String>{
    'America/Los_Angeles': 'Pacific Standard Time',
    'America/Vancouver': 'Pacific Standard Time',
    'America/New_York': 'Eastern Standard Time',
    'America/Toronto': 'Eastern Standard Time',
    'America/Chicago': 'Central Standard Time',
    'America/Denver': 'Mountain Standard Time',
    'America/Phoenix': 'US Mountain Standard Time',
    'America/Anchorage': 'Alaskan Standard Time',
    'Pacific/Honolulu': 'Hawaiian Standard Time',
    'UTC': 'UTC',
    'Etc/UTC': 'UTC',
    'Etc/GMT': 'UTC',
  };

  /// Build shell exports so Claude Code / Node honor FlClash in system-proxy mode.
  static String buildTerminalProxyExports({
    required int mixedPort,
    String host = '127.0.0.1',
  }) {
    final proxy = 'http://$host:$mixedPort';
    return [
      'export http_proxy=$proxy',
      'export https_proxy=$proxy',
      'export HTTP_PROXY=$proxy',
      'export HTTPS_PROXY=$proxy',
      'export ALL_PROXY=$proxy',
      'export all_proxy=$proxy',
      '# Optional: keep local / LAN direct',
      'export NO_PROXY=localhost,127.0.0.1,::1',
      'export no_proxy=localhost,127.0.0.1,::1',
    ].join('\n');
  }

  /// PowerShell equivalents for Windows terminals.
  static String buildTerminalProxyExportsPowerShell({
    required int mixedPort,
    String host = '127.0.0.1',
  }) {
    final proxy = 'http://$host:$mixedPort';
    return [
      '\$env:http_proxy="$proxy"',
      '\$env:https_proxy="$proxy"',
      '\$env:HTTP_PROXY="$proxy"',
      '\$env:HTTPS_PROXY="$proxy"',
      '\$env:ALL_PROXY="$proxy"',
      '\$env:all_proxy="$proxy"',
      '\$env:NO_PROXY="localhost,127.0.0.1,::1"',
      '\$env:no_proxy="localhost,127.0.0.1,::1"',
    ].join('\n');
  }

  static Future<String?> readOsTimezoneId() async {
    try {
      if (system.isLinux) {
        final result = await Process.run('timedatectl', [
          'show',
          '-p',
          'Timezone',
          '--value',
        ]);
        if (result.exitCode == 0) {
          final value = (result.stdout as String).trim();
          if (value.isNotEmpty) {
            return value;
          }
        }
      }
      if (system.isMacOS) {
        final result = await Process.run('readlink', ['/etc/localtime']);
        if (result.exitCode == 0) {
          final path = (result.stdout as String).trim();
          const marker = '/zoneinfo/';
          final index = path.indexOf(marker);
          if (index != -1) {
            return path.substring(index + marker.length);
          }
        }
      }
      if (system.isWindows) {
        final result = await Process.run('tzutil', ['/g']);
        if (result.exitCode == 0) {
          final windowsName = (result.stdout as String).trim();
          for (final entry in windowsTimezoneNames.entries) {
            if (entry.value == windowsName) {
              return entry.key;
            }
          }
          return windowsName;
        }
      }
    } catch (_) {}
    return null;
  }

  /// Apply an IANA timezone on desktop hosts. Returns null on success, else an
  /// error / manual-command hint.
  static Future<String?> setOsTimezone(String ianaTimezone) async {
    final timezone = ianaTimezone.trim();
    if (timezone.isEmpty) {
      return 'empty timezone';
    }
    if (system.isAndroid) {
      return 'android-unsupported';
    }
    try {
      if (system.isLinux) {
        var result = await Process.run('timedatectl', [
          'set-timezone',
          timezone,
        ]);
        if (result.exitCode == 0) {
          return null;
        }
        result = await Process.run('pkexec', [
          'timedatectl',
          'set-timezone',
          timezone,
        ]);
        if (result.exitCode == 0) {
          return null;
        }
        return 'timedatectl set-timezone $timezone';
      }
      if (system.isMacOS) {
        final escaped = timezone.replaceAll('"', '\\"');
        final result = await Process.run('osascript', [
          '-e',
          'do shell script "systemsetup -settimezone $escaped" with administrator privileges',
        ]);
        if (result.exitCode == 0) {
          return null;
        }
        return 'sudo systemsetup -settimezone $timezone';
      }
      if (system.isWindows) {
        final windowsName =
            windowsTimezoneNames[timezone] ??
            (timezone.contains('/') ? null : timezone);
        if (windowsName == null) {
          return 'unsupported-windows-timezone:$timezone';
        }
        final result = await Process.run('tzutil', ['/s', windowsName]);
        if (result.exitCode == 0) {
          return null;
        }
        return 'tzutil /s "$windowsName"';
      }
    } catch (e) {
      return e.toString();
    }
    return 'unsupported-platform';
  }

  /// True when [timezone] is a known Claude Code China-timezone hit.
  static bool isClaudeCodeChinaTimezone(String? timezone) {
    if (timezone == null || timezone.isEmpty) {
      return false;
    }
    final value = timezone.trim();
    return value == 'Asia/Shanghai' || value == 'Asia/Urumqi';
  }
}
