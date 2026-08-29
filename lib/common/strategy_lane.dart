import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/clash_config.dart';
import 'package:fl_clash/models/common.dart';

/// Fixed business lanes shown in the Strategy Lanes UI.
enum StrategyLaneId {
  streaming,
  ai,
  messaging,
  social,
  search,
  gaming,
}

/// How a business lane should pick its outbound.
enum StrategyLanePolicyKind {
  /// Keep subscription routing; do not inject rules for this lane.
  follow,

  /// Inject a FlClash url-test group (include-all-proxies) for this lane.
  auto,

  /// Send matching traffic DIRECT.
  direct,

  /// Send matching traffic REJECT.
  reject,

  /// Use an existing proxy-group from the subscription / profile.
  group,

  /// Pin a leaf proxy via an injected select group.
  proxy,
}

/// Parsed per-lane policy stored as a string in app settings.
class StrategyLanePolicy {
  const StrategyLanePolicy._(this.kind, {this.target});

  const StrategyLanePolicy.follow() : this._(StrategyLanePolicyKind.follow);

  const StrategyLanePolicy.auto() : this._(StrategyLanePolicyKind.auto);

  const StrategyLanePolicy.direct() : this._(StrategyLanePolicyKind.direct);

  const StrategyLanePolicy.reject() : this._(StrategyLanePolicyKind.reject);

  const StrategyLanePolicy.group(String name)
    : this._(StrategyLanePolicyKind.group, target: name);

  const StrategyLanePolicy.proxy(String name)
    : this._(StrategyLanePolicyKind.proxy, target: name);

  final StrategyLanePolicyKind kind;
  final String? target;

  bool get isFollow => kind == StrategyLanePolicyKind.follow;

  String encode() => switch (kind) {
    StrategyLanePolicyKind.follow => 'follow',
    StrategyLanePolicyKind.auto => 'auto',
    StrategyLanePolicyKind.direct => 'direct',
    StrategyLanePolicyKind.reject => 'reject',
    StrategyLanePolicyKind.group => 'group:${target ?? ''}',
    StrategyLanePolicyKind.proxy => 'proxy:${target ?? ''}',
  };

  static StrategyLanePolicy parse(String? raw) {
    if (raw == null || raw.isEmpty || raw == 'follow') {
      return const StrategyLanePolicy.follow();
    }
    if (raw == 'auto') {
      return const StrategyLanePolicy.auto();
    }
    if (raw == 'direct') {
      return const StrategyLanePolicy.direct();
    }
    if (raw == 'reject') {
      return const StrategyLanePolicy.reject();
    }
    if (raw.startsWith('group:')) {
      final name = raw.substring('group:'.length).trim();
      if (name.isEmpty) {
        return const StrategyLanePolicy.follow();
      }
      return StrategyLanePolicy.group(name);
    }
    if (raw.startsWith('proxy:')) {
      final name = raw.substring('proxy:'.length).trim();
      if (name.isEmpty) {
        return const StrategyLanePolicy.follow();
      }
      return StrategyLanePolicy.proxy(name);
    }
    return const StrategyLanePolicy.follow();
  }
}

/// Preset catalog entry: geosite codes + domain fallbacks + name hints.
class StrategyLanePreset {
  const StrategyLanePreset({
    required this.id,
    required this.geositeCodes,
    required this.domainSuffixes,
    required this.groupNameHints,
  });

  final StrategyLaneId id;
  final List<String> geositeCodes;
  final List<String> domainSuffixes;
  final List<String> groupNameHints;
}

const strategyLanePresets = <StrategyLanePreset>[
  StrategyLanePreset(
    id: StrategyLaneId.streaming,
    geositeCodes: [
      'netflix',
      'disney',
      'youtube',
      'hbo',
      'spotify',
      'bilibili',
      'tiktok',
      'twitch',
      'primevideo',
    ],
    domainSuffixes: [
      'netflix.com',
      'nflxvideo.net',
      'disneyplus.com',
      'youtube.com',
      'youtu.be',
      'spotify.com',
      'tiktok.com',
      'twitch.tv',
    ],
    groupNameHints: [
      'streaming',
      'stream',
      'netflix',
      'disney',
      'youtube',
      'spotify',
      'bilibili',
      'emby',
      'tiktok',
      'twitch',
      'media',
      '流媒体',
      '影视',
      '视频',
      '解锁',
    ],
  ),
  StrategyLanePreset(
    id: StrategyLaneId.ai,
    geositeCodes: ['openai'],
    domainSuffixes: [
      'openai.com',
      'chatgpt.com',
      'anthropic.com',
      'claude.ai',
      'gemini.google.com',
      'cursor.sh',
      'cursor.com',
    ],
    groupNameHints: [
      'openai',
      'chatgpt',
      'claude',
      'gemini',
      'copilot',
      'ai',
      'gpt',
      'anthropic',
      '人工智能',
    ],
  ),
  StrategyLanePreset(
    id: StrategyLaneId.messaging,
    geositeCodes: ['telegram', 'discord'],
    domainSuffixes: [
      'telegram.org',
      't.me',
      'discord.com',
      'discord.gg',
      'discordapp.com',
    ],
    groupNameHints: [
      'telegram',
      'discord',
      'whatsapp',
      'signal',
      'messaging',
      '消息',
      '通讯',
    ],
  ),
  StrategyLanePreset(
    id: StrategyLaneId.social,
    geositeCodes: ['twitter', 'facebook', 'instagram', 'reddit'],
    domainSuffixes: [
      'x.com',
      'twitter.com',
      'facebook.com',
      'instagram.com',
      'reddit.com',
    ],
    groupNameHints: [
      'social',
      'twitter',
      'facebook',
      'instagram',
      'reddit',
      '社交',
    ],
  ),
  StrategyLanePreset(
    id: StrategyLaneId.search,
    geositeCodes: ['google'],
    domainSuffixes: [
      'google.com',
      'googleapis.com',
      'gstatic.com',
      'wikipedia.org',
      'bing.com',
    ],
    groupNameHints: ['google', 'bing', 'search', 'scholar', '搜索'],
  ),
  StrategyLanePreset(
    id: StrategyLaneId.gaming,
    geositeCodes: ['steam', 'epicgames'],
    domainSuffixes: [
      'steampowered.com',
      'steamcommunity.com',
      'epicgames.com',
      'xbox.com',
      'playstation.com',
      'nintendo.com',
    ],
    groupNameHints: [
      'game',
      'gaming',
      'steam',
      'xbox',
      'playstation',
      'nintendo',
      '游戏',
    ],
  ),
];

StrategyLanePreset? strategyLanePresetById(StrategyLaneId id) {
  for (final preset in strategyLanePresets) {
    if (preset.id == id) {
      return preset;
    }
  }
  return null;
}

String strategyLanePolicyKey(int profileId, StrategyLaneId laneId) =>
    '$profileId::${laneId.name}';

String strategyLaneManagedGroupName(StrategyLaneId laneId) =>
    'FlClash-${laneId.name}';

/// Result of discovering how the subscription already routes a lane.
class StrategyLaneDiscovery {
  const StrategyLaneDiscovery({
    this.groupName,
    this.source = StrategyLaneDiscoverySource.none,
  });

  final String? groupName;
  final StrategyLaneDiscoverySource source;

  bool get hasGroup => groupName != null && groupName!.isNotEmpty;
}

enum StrategyLaneDiscoverySource { none, rules, groupName }

/// Groups + rules to inject (Tailscale-style) for overridden lanes.
class StrategyLaneInjection {
  const StrategyLaneInjection({
    this.groups = const [],
    this.rules = const [],
    this.skippedLanes = const [],
  });

  final List<Map<String, dynamic>> groups;
  final List<String> rules;

  /// Non-follow policies that were not injected (missing group/proxy, etc.).
  final List<StrategyLaneId> skippedLanes;

  bool get isEmpty =>
      groups.isEmpty && rules.isEmpty && skippedLanes.isEmpty;

  bool get hasSkipped => skippedLanes.isNotEmpty;
}

/// UI row for one business lane.
class StrategyLaneRow {
  const StrategyLaneRow({
    required this.id,
    required this.policy,
    required this.discovery,
    required this.effectiveTarget,
  });

  final StrategyLaneId id;
  final StrategyLanePolicy policy;
  final StrategyLaneDiscovery discovery;

  /// Group / DIRECT / REJECT that will actually receive matching traffic after
  /// apply (or the discovered subscription group when following).
  final String? effectiveTarget;
}

StrategyLaneDiscovery discoverStrategyLane({
  required StrategyLanePreset preset,
  required List<ProxyGroup> proxyGroups,
  required List<String> rules,
}) {
  for (final raw in rules) {
    final parsed = Rule.parse(raw);
    final target = parsed.ruleTarget;
    if (target == null || target.isEmpty) {
      continue;
    }
    if (parsed.ruleAction == RuleAction.GEOSITE) {
      final code = (parsed.content ?? '').toLowerCase();
      if (preset.geositeCodes.any((item) => item.toLowerCase() == code)) {
        return StrategyLaneDiscovery(
          groupName: target,
          source: StrategyLaneDiscoverySource.rules,
        );
      }
    }
    if (parsed.ruleAction == RuleAction.DOMAIN_SUFFIX ||
        parsed.ruleAction == RuleAction.DOMAIN ||
        parsed.ruleAction == RuleAction.DOMAIN_KEYWORD) {
      final content = (parsed.content ?? '').toLowerCase();
      if (preset.domainSuffixes.any(
        (item) => _domainMatches(content, item.toLowerCase()),
      )) {
        return StrategyLaneDiscovery(
          groupName: target,
          source: StrategyLaneDiscoverySource.rules,
        );
      }
    }
    if (parsed.ruleAction == RuleAction.RULE_SET) {
      final provider = (parsed.ruleProvider ?? parsed.content ?? '')
          .toLowerCase();
      if (provider.isNotEmpty &&
          (_matchHint(provider, preset.groupNameHints) ||
              preset.geositeCodes.any(
                (code) => provider.contains(code.toLowerCase()),
              ))) {
        return StrategyLaneDiscovery(
          groupName: target,
          source: StrategyLaneDiscoverySource.rules,
        );
      }
    }
  }

  for (final group in proxyGroups) {
    if (_matchHint(group.name, preset.groupNameHints)) {
      return StrategyLaneDiscovery(
        groupName: group.name,
        source: StrategyLaneDiscoverySource.groupName,
      );
    }
  }
  return const StrategyLaneDiscovery();
}

bool _domainMatches(String content, String suffix) {
  if (content == suffix) {
    return true;
  }
  // Require a label boundary so evilnetflix.com does not match netflix.com.
  return content.endsWith('.$suffix');
}

bool _matchHint(String name, List<String> hints) {
  final normalized = name.trim().toLowerCase();
  if (normalized.isEmpty) {
    return false;
  }
  for (final hint in hints) {
    final needle = hint.toLowerCase();
    if (needle.isEmpty) {
      continue;
    }
    // ASCII words use token boundaries so Mainstream ≠ streaming(stream).
    if (_isAsciiWord(needle)) {
      if (_hasToken(normalized, needle)) {
        return true;
      }
      continue;
    }
    if (normalized.contains(needle)) {
      return true;
    }
  }
  return false;
}

bool _isAsciiWord(String value) => RegExp(r'^[a-z0-9]+$').hasMatch(value);

bool _hasToken(String haystack, String token) {
  if (haystack == token) {
    return true;
  }
  final parts = haystack
      .split(RegExp(r'[^a-z0-9\u4e00-\u9fff]+'))
      .where((part) => part.isNotEmpty);
  for (final part in parts) {
    if (part == token) {
      return true;
    }
  }
  return false;
}

List<StrategyLaneRow> buildStrategyLaneRows({
  required int profileId,
  required Map<String, String> policies,
  required List<ProxyGroup> proxyGroups,
  required List<String> rules,
}) {
  return [
    for (final preset in strategyLanePresets)
      () {
        final discovery = discoverStrategyLane(
          preset: preset,
          proxyGroups: proxyGroups,
          rules: rules,
        );
        final policy = StrategyLanePolicy.parse(
          policies[strategyLanePolicyKey(profileId, preset.id)],
        );
        final effective = resolveStrategyLaneTarget(
          policy: policy,
          discovery: discovery,
          laneId: preset.id,
        );
        return StrategyLaneRow(
          id: preset.id,
          policy: policy,
          discovery: discovery,
          effectiveTarget: effective,
        );
      }(),
  ];
}

String? resolveStrategyLaneTarget({
  required StrategyLanePolicy policy,
  required StrategyLaneDiscovery discovery,
  required StrategyLaneId laneId,
}) {
  return switch (policy.kind) {
    StrategyLanePolicyKind.follow => discovery.groupName,
    StrategyLanePolicyKind.auto => strategyLaneManagedGroupName(laneId),
    StrategyLanePolicyKind.direct => 'DIRECT',
    StrategyLanePolicyKind.reject => 'REJECT',
    StrategyLanePolicyKind.group => policy.target,
    StrategyLanePolicyKind.proxy => strategyLaneManagedGroupName(laneId),
  };
}

List<String> buildStrategyLaneRulesForTarget({
  required StrategyLanePreset preset,
  required String target,
}) {
  final rules = <String>[];
  for (final code in preset.geositeCodes) {
    rules.add('GEOSITE,$code,$target');
  }
  for (final domain in preset.domainSuffixes) {
    rules.add('DOMAIN-SUFFIX,$domain,$target');
  }
  return rules;
}

Map<String, dynamic> buildStrategyLaneAutoGroup({
  required StrategyLaneId laneId,
  required String testUrl,
}) {
  return {
    'name': strategyLaneManagedGroupName(laneId),
    'type': 'url-test',
    'include-all-proxies': true,
    'url': testUrl,
    'interval': 300,
    'lazy': true,
  };
}

Map<String, dynamic> buildStrategyLaneProxyGroup({
  required StrategyLaneId laneId,
  required String proxyName,
}) {
  return {
    'name': strategyLaneManagedGroupName(laneId),
    'type': 'select',
    'proxies': [proxyName, 'DIRECT', 'REJECT'],
  };
}

/// Build inject payload for all non-follow policies of [profileId].
///
/// Skips policies that would produce unloadable config (missing group/proxy).
StrategyLaneInjection buildStrategyLaneInjection({
  required int profileId,
  required Map<String, String> policies,
  required List<ProxyGroup> proxyGroups,
  required List<String> rules,
  required String testUrl,
  Set<String>? availableProxyNames,
  bool enable = true,
}) {
  if (!enable) {
    return const StrategyLaneInjection();
  }
  final groups = <Map<String, dynamic>>[];
  final injectedRules = <String>[];
  final skippedLanes = <StrategyLaneId>[];
  final existingNames = {
    ...proxyGroups.map((item) => item.name),
    'DIRECT',
    'REJECT',
  };

  for (final preset in strategyLanePresets) {
    final policy = StrategyLanePolicy.parse(
      policies[strategyLanePolicyKey(profileId, preset.id)],
    );
    if (policy.isFollow) {
      continue;
    }
    final target = resolveStrategyLaneTarget(
      policy: policy,
      discovery: const StrategyLaneDiscovery(),
      laneId: preset.id,
    );
    if (target == null || target.isEmpty) {
      skippedLanes.add(preset.id);
      continue;
    }
    if (policy.kind == StrategyLanePolicyKind.auto) {
      groups.add(
        buildStrategyLaneAutoGroup(laneId: preset.id, testUrl: testUrl),
      );
    } else if (policy.kind == StrategyLanePolicyKind.proxy) {
      final proxyName = policy.target;
      // Always require an explicit allow-list; empty/null cannot verify nodes.
      if (proxyName == null ||
          proxyName.isEmpty ||
          availableProxyNames == null ||
          !availableProxyNames.contains(proxyName)) {
        skippedLanes.add(preset.id);
        continue;
      }
      groups.add(
        buildStrategyLaneProxyGroup(
          laneId: preset.id,
          proxyName: proxyName,
        ),
      );
    } else if (policy.kind == StrategyLanePolicyKind.group) {
      if (!existingNames.contains(target)) {
        skippedLanes.add(preset.id);
        continue;
      }
    }
    injectedRules.addAll(
      buildStrategyLaneRulesForTarget(preset: preset, target: target),
    );
  }
  return StrategyLaneInjection(
    groups: groups,
    rules: injectedRules,
    skippedLanes: skippedLanes,
  );
}

/// Effective groups/rules/proxies for strategy-lane discovery + inject.
///
/// Mirrors `getProfile` so the UI and apply path stay aligned under custom
/// overwrite.
({List<ProxyGroup> groups, List<String> rules, Set<String> proxyNames})
resolveStrategyLaneConfigInputs({
  required OverwriteType overwriteType,
  required List<ProxyGroup> subscriptionGroups,
  required List<Rule> subscriptionRules,
  required List<Proxy> subscriptionProxies,
  required List<ProxyGroup> customGroups,
  required List<Rule> customRules,
}) {
  final useCustomGroups =
      overwriteType == OverwriteType.custom && customGroups.isNotEmpty;
  final useCustomRules =
      overwriteType == OverwriteType.custom && customRules.isNotEmpty;
  final groups = useCustomGroups ? customGroups : subscriptionGroups;
  final rules = useCustomRules
      ? customRules.map((item) => item.rawValue).toList(growable: false)
      : subscriptionRules.map((item) => item.rawValue).toList(growable: false);
  return (
    groups: groups,
    rules: rules,
    proxyNames: {
      ...subscriptionProxies.map((item) => item.name),
      for (final group in groups) ...?group.proxies,
    },
  );
}

/// Merge injected strategy-lane groups into a raw clash config map.
Map<String, dynamic> mergeStrategyLaneGroupsInto(
  Map<String, dynamic> rawConfig,
  List<Map<String, dynamic>> groups,
) {
  if (groups.isEmpty) {
    return Map<String, dynamic>.from(rawConfig);
  }
  final next = Map<String, dynamic>.from(rawConfig);
  final existing = <dynamic>[...?(next['proxy-groups'] as List?)];
  final names = groups
      .map((item) => item['name']?.toString())
      .whereType<String>()
      .toSet();
  existing.removeWhere(
    (item) => item is Map && names.contains(item['name']?.toString()),
  );
  existing.addAll(groups);
  next['proxy-groups'] = existing;
  return next;
}

/// Extra subscription groups not covered by business presets (outlet tweaks).
class StrategyExtraGroup {
  const StrategyExtraGroup({
    required this.groupName,
    required this.groupType,
    required this.outlets,
    required this.currentOutlet,
    this.overrideOutlet,
  });

  final String groupName;
  final GroupType groupType;
  final List<String> outlets;
  final String currentOutlet;
  final String? overrideOutlet;

  bool get hasOverride =>
      overrideOutlet != null && overrideOutlet!.isNotEmpty;
}

List<StrategyExtraGroup> buildStrategyExtraGroups({
  required List<Group> groups,
  required Map<String, String> selectedMap,
  required Set<String> claimedGroupNames,
}) {
  final extras = <StrategyExtraGroup>[];
  for (final group in groups) {
    if (group.name == GroupName.GLOBAL.name || group.hidden == true) {
      continue;
    }
    if (group.all.isEmpty) {
      continue;
    }
    if (claimedGroupNames.contains(group.name)) {
      continue;
    }
    // Skip FlClash-managed inject groups from the extras list clutter.
    if (group.name.startsWith('FlClash-')) {
      continue;
    }
    final override = selectedMap[group.name];
    final overrideOutlet =
        (override != null && override.isNotEmpty) ? override : null;
    extras.add(
      StrategyExtraGroup(
        groupName: group.name,
        groupType: group.type,
        outlets: group.all.map((proxy) => proxy.name).toList(growable: false),
        currentOutlet: group.getCurrentSelectedName(override ?? ''),
        overrideOutlet: overrideOutlet,
      ),
    );
  }
  extras.sort(
    (a, b) => a.groupName.toLowerCase().compareTo(b.groupName.toLowerCase()),
  );
  return extras;
}

Set<String> claimedStrategyGroupNames(List<StrategyLaneRow> rows) {
  return {
    for (final row in rows)
      if (row.discovery.groupName != null) row.discovery.groupName!,
    for (final row in rows)
      if (row.policy.kind == StrategyLanePolicyKind.group &&
          row.policy.target != null)
        row.policy.target!,
  };
}

// ---------------------------------------------------------------------------
// Legacy helpers kept for outlet-only listing (extras section / tests).
// ---------------------------------------------------------------------------

enum StrategyLaneKind {
  streaming,
  ai,
  social,
  search,
  messaging,
  gaming,
  proxy,
  other,
}

StrategyLaneKind classifyStrategyLaneName(String name) {
  final normalized = name.trim().toLowerCase();
  if (normalized.isEmpty) {
    return StrategyLaneKind.other;
  }
  for (final preset in strategyLanePresets) {
    if (_matchHint(normalized, preset.groupNameHints)) {
      return switch (preset.id) {
        StrategyLaneId.streaming => StrategyLaneKind.streaming,
        StrategyLaneId.ai => StrategyLaneKind.ai,
        StrategyLaneId.messaging => StrategyLaneKind.messaging,
        StrategyLaneId.social => StrategyLaneKind.social,
        StrategyLaneId.search => StrategyLaneKind.search,
        StrategyLaneId.gaming => StrategyLaneKind.gaming,
      };
    }
  }
  const proxyHints = [
    'proxy',
    'proxies',
    'select',
    'selector',
    'node',
    'manual',
    '主选',
    '节点选择',
    '手动选择',
    '代理',
  ];
  if (_matchHint(normalized, proxyHints)) {
    return StrategyLaneKind.proxy;
  }
  return StrategyLaneKind.other;
}
