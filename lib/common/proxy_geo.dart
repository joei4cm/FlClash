/// Preferred display order for region chips on a proxy group.
const proxyGeoRegionOrder = [
  'HK',
  'TW',
  'JP',
  'SG',
  'KR',
  'US',
  'CA',
  'AU',
  'EU',
  'GB',
  'DE',
  'FR',
  'NL',
  'IN',
  'TR',
  'AE',
  'MY',
  'TH',
  'PH',
  'VN',
  'ID',
  'CN',
];

String? inferProxyGeoRegion(String name) {
  final normalized = name.trim().toUpperCase();
  if (normalized.isEmpty) {
    return null;
  }

  // First match wins. Keep more specific / multi-word tokens ahead of short
  // codes so "United States" and city names beat a stray letter pair.
  const rules = <String, List<String>>{
    'US': [
      'UNITED STATES',
      'UNITEDSTATES',
      'AMERICA',
      'USA',
      'US',
      '美国',
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
      '美北',
      '美南',
    ],
    'HK': ['HONG KONG', 'HONGKONG', 'HKG', 'HK', '香港'],
    'TW': ['TAIWAN', 'TPE', 'TW', '台湾', '台灣', '台北', '台中', '高雄'],
    'JP': [
      'JAPAN',
      'TOKYO',
      'OSAKA',
      'NRT',
      'HND',
      'KIX',
      'JP',
      '日本',
      '东京',
      '東京',
      '大阪',
    ],
    'SG': ['SINGAPORE', 'SGP', 'SG', '新加坡', '狮城'],
    'KR': ['KOREA', 'SEOUL', 'ICN', 'KR', '韩国', '韓國', '首尔', '首爾'],
    'CA': [
      'CANADA',
      'TORONTO',
      'VANCOUVER',
      'YVR',
      'YYZ',
      'CA',
      '加拿大',
      '温哥华',
      '多伦多',
    ],
    'AU': ['AUSTRALIA', 'SYDNEY', 'MELBOURNE', 'AU', '澳大利亚', '澳洲', '悉尼', '墨尔本'],
    'GB': ['UNITED KINGDOM', 'ENGLAND', 'LONDON', 'UK', 'GB', '英国', '倫敦', '伦敦'],
    'DE': ['GERMANY', 'FRANKFURT', 'BERLIN', 'DE', '德国', '德國', '法兰克福'],
    'FR': ['FRANCE', 'PARIS', 'FR', '法国', '法國', '巴黎'],
    'NL': ['NETHERLANDS', 'AMSTERDAM', 'NL', '荷兰', '荷蘭', '阿姆斯特丹'],
    'EU': ['EUROPE', 'EU', '欧洲', '歐洲'],
    'IN': ['INDIA', 'MUMBAI', 'IN', '印度', '孟买'],
    'TR': ['TURKEY', 'ISTANBUL', 'TR', '土耳其', '伊斯坦布尔'],
    'AE': ['DUBAI', 'UAE', 'AE', '迪拜', '阿联酋'],
    'MY': ['MALAYSIA', 'KUL', 'MY', '马来西亚', '马来', '吉隆坡'],
    'TH': ['THAILAND', 'BANGKOK', 'BKK', 'TH', '泰国', '泰國', '曼谷'],
    'PH': ['PHILIPPINES', 'MANILA', 'PH', '菲律宾', '菲律賓', '马尼拉'],
    'VN': ['VIETNAM', 'HO CHI MINH', 'VN', '越南', '胡志明'],
    'ID': ['INDONESIA', 'JAKARTA', 'ID', '印尼', '印度尼西亚', '雅加达'],
    'CN': ['CHINA', 'CN', '中国', '國內', '国内', '直连', '直連'],
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
    // Letter boundary only: "US01" / "US-01" match, "PLUS" / "BUS" do not.
    // Digits after a country code are common in airport node names.
    return RegExp(
      '(^|[^A-Z])${RegExp.escape(upperToken)}(?=[^A-Z]|\$)',
    ).hasMatch(normalized);
  }
  return normalized.contains(upperToken);
}

/// Groups leaf proxy names by inferred region. Names with no region are omitted.
Map<String, List<String>> groupProxyNamesByGeo(Iterable<String> names) {
  final grouped = <String, List<String>>{};
  for (final name in names) {
    final geo = inferProxyGeoRegion(name);
    if (geo == null) {
      continue;
    }
    (grouped[geo] ??= []).add(name);
  }
  return grouped;
}

/// Regions present in [names], ordered for the chip row.
List<String> geosPresentIn(Iterable<String> names) {
  final present = groupProxyNamesByGeo(names).keys.toSet();
  return [
    for (final geo in proxyGeoRegionOrder)
      if (present.contains(geo)) geo,
    for (final geo in present)
      if (!proxyGeoRegionOrder.contains(geo)) geo,
  ];
}

String stickyGeoStorageKey({
  required int? profileId,
  required String groupName,
}) {
  if (profileId == null) {
    return groupName;
  }
  return '$profileId::$groupName';
}

String? stickyGeoForGroup(
  Map<String, String> byGroup, {
  required int? profileId,
  required String groupName,
}) {
  final keyed = stickyGeoStorageKey(profileId: profileId, groupName: groupName);
  return byGroup[keyed] ?? byGroup[groupName];
}

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

bool isProxyDelayHealthy(int? delay) => delay != null && delay > 0;

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

/// User tapped a region chip: move to the best healthy node in that geo even
/// when the current node is still healthy but elsewhere.
AutoSelectDecision? decideGeoPickSwitch({
  required String currentName,
  required String preferredGeo,
  required String? bestHealthyInPreferredGeo,
}) {
  if (preferredGeo.isEmpty || preferredGeo == 'ANY') {
    return null;
  }
  final candidate = bestHealthyInPreferredGeo;
  if (candidate == null || candidate.isEmpty) {
    return null;
  }
  if (candidate == currentName) {
    return null;
  }
  return AutoSelectDecision(
    proxyName: candidate,
    reason: 'user_picked_$preferredGeo',
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
