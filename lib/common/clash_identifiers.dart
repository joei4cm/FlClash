/// Values that become Clash rule or adapter fields must stay a single CSV cell.
final _unsafeClashField = RegExp(r'[\x00-\x1f,]');

/// IANA zones as `Area/Location` (and optional deeper parts), plus UTC aliases.
final _ianaTimezone = RegExp(
  r'^(?:UTC|Etc/UTC|Etc/GMT|[A-Za-z]+(?:[_+-]?[A-Za-z0-9]+)(?:/[A-Za-z0-9_+-]+)+)$',
);

bool isSafeClashField(String value) {
  final trimmed = value.trim();
  return trimmed.isNotEmpty && !_unsafeClashField.hasMatch(trimmed);
}

bool isValidIanaTimezoneId(String value) {
  final trimmed = value.trim();
  return trimmed.isNotEmpty && _ianaTimezone.hasMatch(trimmed);
}

/// HTTPS control planes only; rejects userinfo and non-https schemes.
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
  return true;
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
