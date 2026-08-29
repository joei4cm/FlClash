/// Heuristic geo/region tags inferred from proxy or group names.
///
/// Used by auto-select sticky policy to prefer a region when the current
/// url-test/fallback node becomes unhealthy.
String? inferProxyGeoRegion(String name) {
  final normalized = name.trim().toUpperCase();
  if (normalized.isEmpty) {
    return null;
  }

  const rules = <String, List<String>>{
    'US': [
      'US',
      'USA',
      'UNITED STATES',
      'AMERICA',
      '洛杉矶',
      '旧金山',
      '西雅图',
      '纽约',
      '芝加哥',
      '达拉斯',
      '凤凰城',
      '硅谷',
      '美西',
      '美东',
    ],
    'HK': ['HK', 'HONG KONG', 'HONGKONG', '香港'],
    'TW': ['TW', 'TAIWAN', '台湾', '台北', '台中', '高雄'],
    'JP': ['JP', 'JAPAN', '日本', '东京', 'TOKYO', '大阪', 'OSAKA'],
    'SG': ['SG', 'SINGAPORE', '新加坡', '狮城'],
    'KR': ['KR', 'KOREA', '韩国', '首尔'],
    'EU': [
      'EU',
      'EUROPE',
      '欧洲',
      'DE',
      'GERMANY',
      'FR',
      'FRANCE',
      'NL',
      'UK',
      'LONDON',
    ],
    'CN': ['CN', 'CHINA', '中国', '国内', '直连'],
  };

  for (final entry in rules.entries) {
    for (final token in entry.value) {
      if (_nameContainsGeoToken(normalized, token)) {
        return entry.key;
      }
    }
  }
  return null;
}

bool _nameContainsGeoToken(String normalized, String token) {
  final upperToken = token.toUpperCase();
  if (RegExp(r'^[A-Z0-9]+$').hasMatch(upperToken)) {
    return RegExp(
      '(^|[^A-Z0-9])${RegExp.escape(upperToken)}([^A-Z0-9]|\$)',
    ).hasMatch(normalized);
  }
  return normalized.contains(upperToken);
}

/// Preferred sticky region for policy / UI.
///
/// Returns `null` when Flutter should not override core url-test/fallback.
String? resolvePreferredStickyGeo({
  required String? configuredGeo,
  required bool geoIdentityEnabled,
}) {
  if (configuredGeo != null &&
      configuredGeo.isNotEmpty &&
      configuredGeo != 'ANY') {
    return configuredGeo;
  }
  if (geoIdentityEnabled) {
    return 'US';
  }
  return null;
}

/// Display helper for sticky banners / Stick-to-region action.
String resolveAutoSelectStickyGeo({
  required String? configuredGeo,
  required bool geoIdentityEnabled,
  required String proxyName,
}) {
  return resolvePreferredStickyGeo(
        configuredGeo: configuredGeo,
        geoIdentityEnabled: geoIdentityEnabled,
      ) ??
      inferProxyGeoRegion(proxyName) ??
      'ANY';
}

/// Whether a delay sample means the node is usable right now.
bool isProxyDelayHealthy(int? delay) => delay != null && delay > 0;

/// Pure auto-select decision used by [AutoSelectSticky].
///
/// Policy:
/// - never fight an explicit user override (`selectedMap`)
/// - never switch a healthy current node (no flapping / connection drops)
/// - when current is unhealthy, prefer a known-healthy node in [preferredGeo]
/// - never fall back to untested nodes
class AutoSelectDecision {
  const AutoSelectDecision({required this.proxyName, required this.reason});

  final String proxyName;
  final String reason;
}

AutoSelectDecision? decideAutoSelectSwitch({
  required String currentName,
  required String? userOverride,
  required String? preferredGeo,
  required bool currentHealthy,
  required String? bestHealthyInPreferredGeo,
  required DateTime now,
  DateTime? lastSwitchAt,
  Duration cooldown = const Duration(seconds: 60),
}) {
  if (userOverride != null && userOverride.isNotEmpty) {
    return null;
  }
  if (preferredGeo == null || preferredGeo.isEmpty || preferredGeo == 'ANY') {
    return null;
  }
  if (lastSwitchAt != null && now.difference(lastSwitchAt) < cooldown) {
    return null;
  }
  if (currentName.isEmpty) {
    return null;
  }
  // Healthy current node always wins — even if it is outside the preferred geo.
  if (currentHealthy) {
    return null;
  }
  final candidate = bestHealthyInPreferredGeo;
  if (candidate == null || candidate.isEmpty || candidate == currentName) {
    return null;
  }
  return AutoSelectDecision(
    proxyName: candidate,
    reason: 'current_unhealthy_prefer_$preferredGeo',
  );
}

String? pickBestHealthyProxyInGeo({
  required Iterable<String> proxyNames,
  required String preferredGeo,
  required String testUrl,
  required Map<String, Map<String, int?>> delayMap,
}) {
  String? bestName;
  int? bestDelay;
  for (final name in proxyNames) {
    if (inferProxyGeoRegion(name) != preferredGeo) {
      continue;
    }
    final delay = delayMap[testUrl]?[name];
    if (!isProxyDelayHealthy(delay)) {
      continue;
    }
    if (bestDelay == null || delay! < bestDelay) {
      bestDelay = delay;
      bestName = name;
    }
  }
  return bestName;
}
