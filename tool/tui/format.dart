library;

String formatRate(Object? bytesPerSec) {
  final n = bytesPerSec is num ? bytesPerSec.toDouble() : 0.0;
  if (n < 1024) {
    return '${n.toStringAsFixed(0)} B/s';
  }
  if (n < 1024 * 1024) {
    return '${(n / 1024).toStringAsFixed(1)} KB/s';
  }
  if (n < 1024 * 1024 * 1024) {
    return '${(n / (1024 * 1024)).toStringAsFixed(2)} MB/s';
  }
  return '${(n / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB/s';
}

String formatDelay(Object? delayMs) {
  if (delayMs is! num) {
    return '—';
  }
  final ms = delayMs.round();
  if (ms <= 0) {
    return 'timeout';
  }
  return '${ms}ms';
}

/// Latest delay from a mihomo proxy `history` array, if present.
int? latestHistoryDelay(Object? history) {
  if (history is! List || history.isEmpty) {
    return null;
  }
  final last = history.last;
  if (last is Map && last['delay'] is num) {
    return (last['delay'] as num).round();
  }
  return null;
}

bool isProxyGroupType(String type) {
  return type == 'Selector' ||
      type == 'URLTest' ||
      type == 'Fallback' ||
      type == 'LoadBalance';
}

List<String> filterNames(List<String> names, String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) {
    return names;
  }
  return [
    for (final name in names)
      if (name.toLowerCase().contains(q)) name,
  ];
}

int clampIndex(int index, int length) {
  if (length <= 0) {
    return 0;
  }
  if (index < 0) {
    return 0;
  }
  if (index >= length) {
    return length - 1;
  }
  return index;
}
