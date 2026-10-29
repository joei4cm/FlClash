/// Values that become Clash rule or adapter fields must stay a single CSV cell.
final _unsafeClashField = RegExp(r'[\x00-\x1f,]');

/// IANA zones as `Area/Location` (and optional deeper parts), plus UTC aliases.
final _ianaTimezone = RegExp(
  r'^(?:UTC|Etc/UTC|Etc/GMT|[A-Za-z]+(?:[_+-]?[A-Za-z0-9]+)(?:/[A-Za-z0-9_+-]+)+)$',
);

final _ipv4 = RegExp(r'^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$');

bool isSafeClashField(String value) {
  final trimmed = value.trim();
  return trimmed.isNotEmpty && !_unsafeClashField.hasMatch(trimmed);
}

bool isValidIanaTimezoneId(String value) {
  final trimmed = value.trim();
  return trimmed.isNotEmpty && _ianaTimezone.hasMatch(trimmed);
}

/// HTTPS control planes only; rejects userinfo, non-https, and private/metadata
/// hosts that would turn Tailscale into an SSRF trampoline.
bool isSafeTailscaleControlUrl(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return true;
  }
  final uri = Uri.tryParse(trimmed);
  if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
    return false;
  }
  if (uri.userInfo.isNotEmpty) {
    return false;
  }
  if (_isBlockedControlHost(uri.host)) {
    return false;
  }
  return true;
}

bool _isBlockedControlHost(String host) {
  final normalized = host.trim().toLowerCase();
  if (normalized == 'localhost' ||
      normalized.endsWith('.localhost') ||
      normalized.endsWith('.local') ||
      normalized.endsWith('.internal') ||
      normalized == 'metadata.google.internal') {
    return true;
  }
  final match = _ipv4.firstMatch(normalized);
  if (match != null) {
    final octets = [for (var i = 1; i <= 4; i++) int.parse(match.group(i)!)];
    if (octets.any((part) => part > 255)) {
      return true;
    }
    final a = octets[0];
    final b = octets[1];
    if (a == 10 || a == 127) {
      return true;
    }
    if (a == 169 && b == 254) {
      return true;
    }
    if (a == 172 && b >= 16 && b <= 31) {
      return true;
    }
    if (a == 192 && b == 168) {
      return true;
    }
    return false;
  }
  final v6 = normalized.startsWith('[') && normalized.endsWith(']')
      ? normalized.substring(1, normalized.length - 1)
      : normalized;
  if (v6.contains(':')) {
    if (v6 == '::1' ||
        v6.startsWith('fe80:') ||
        v6.startsWith('fc') ||
        v6.startsWith('fd')) {
      return true;
    }
  }
  return false;
}

/// Rejects traversal and control characters. Absolute paths are allowed so a
/// user can point at an existing Tailscale state directory.
bool isSafeTailscaleStateDir(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return true;
  }
  if (trimmed.contains('\x00') || trimmed.contains('..')) {
    return false;
  }
  return true;
}
