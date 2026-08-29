/// Heuristic geo/region tags inferred from proxy or group names.
///
/// Used by auto-select sticky policy to keep url-test/fallback picks within
/// the same region while nodes remain available.
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

String resolveAutoSelectStickyGeo({
  required String? configuredGeo,
  required bool geoIdentityEnabled,
  required String proxyName,
}) {
  if (configuredGeo != null && configuredGeo.isNotEmpty) {
    return configuredGeo;
  }
  if (geoIdentityEnabled) {
    return 'US';
  }
  return inferProxyGeoRegion(proxyName) ?? 'ANY';
}
