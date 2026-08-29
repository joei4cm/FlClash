import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/common.dart';

/// Business-facing category for a subscription strategy group.
///
/// Heuristic only — providers name groups differently. Unmatched groups stay
/// [StrategyLaneKind.other] so the UI still shows the full strategy map.
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

/// One selectable strategy group surfaced as a "lane" in the UI.
class StrategyLane {
  const StrategyLane({
    required this.groupName,
    required this.groupType,
    required this.kind,
    required this.outlets,
    required this.currentOutlet,
    this.overrideOutlet,
  });

  final String groupName;
  final GroupType groupType;
  final StrategyLaneKind kind;
  final List<String> outlets;

  /// Effective outbound currently used by the group.
  final String currentOutlet;

  /// Non-empty when the profile [selectedMap] pins an outlet.
  final String? overrideOutlet;

  bool get hasOverride =>
      overrideOutlet != null && overrideOutlet!.isNotEmpty;
}

const _kindKeywords = <StrategyLaneKind, List<String>>{
  StrategyLaneKind.streaming: [
    'streaming',
    'stream',
    'netflix',
    'disney',
    'youtube',
    'hbo',
    'hulu',
    'prime',
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
  StrategyLaneKind.ai: [
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
  StrategyLaneKind.social: [
    'social',
    'twitter',
    'facebook',
    'instagram',
    'reddit',
    '社交',
  ],
  StrategyLaneKind.search: [
    'google',
    'bing',
    'search',
    'scholar',
    '搜索',
  ],
  StrategyLaneKind.messaging: [
    'telegram',
    'discord',
    'whatsapp',
    'signal',
    'imessage',
    'messaging',
    '消息',
    '通讯',
  ],
  StrategyLaneKind.gaming: [
    'game',
    'gaming',
    'steam',
    'xbox',
    'playstation',
    'nintendo',
    '游戏',
  ],
  StrategyLaneKind.proxy: [
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
  ],
};

/// Classify a proxy-group name into a [StrategyLaneKind].
StrategyLaneKind classifyStrategyLaneName(String name) {
  final normalized = name.trim().toLowerCase();
  if (normalized.isEmpty) {
    return StrategyLaneKind.other;
  }
  // Prefer more specific kinds before the catch-all "proxy" / "ai".
  const order = <StrategyLaneKind>[
    StrategyLaneKind.streaming,
    StrategyLaneKind.messaging,
    StrategyLaneKind.social,
    StrategyLaneKind.search,
    StrategyLaneKind.gaming,
    StrategyLaneKind.ai,
    StrategyLaneKind.proxy,
  ];
  for (final kind in order) {
    final keywords = _kindKeywords[kind]!;
    for (final keyword in keywords) {
      if (normalized.contains(keyword.toLowerCase())) {
        return kind;
      }
    }
  }
  return StrategyLaneKind.other;
}

bool _isStrategyGroup(Group group) {
  if (group.name == GroupName.GLOBAL.name) {
    return false;
  }
  if (group.hidden == true) {
    return false;
  }
  // Leaf-looking empty groups are not useful lanes.
  return group.all.isNotEmpty;
}

int _kindSortOrder(StrategyLaneKind kind) => switch (kind) {
  StrategyLaneKind.streaming => 0,
  StrategyLaneKind.ai => 1,
  StrategyLaneKind.messaging => 2,
  StrategyLaneKind.social => 3,
  StrategyLaneKind.search => 4,
  StrategyLaneKind.gaming => 5,
  StrategyLaneKind.proxy => 6,
  StrategyLaneKind.other => 7,
};

/// Build UI lanes from runtime groups + the profile selected map.
///
/// Classified business groups sort first; remaining strategy groups stay
/// visible under [StrategyLaneKind.other] so provider-specific names are not
/// dropped.
List<StrategyLane> buildStrategyLanes({
  required List<Group> groups,
  required Map<String, String> selectedMap,
}) {
  final lanes = <StrategyLane>[];
  for (final group in groups) {
    if (!_isStrategyGroup(group)) {
      continue;
    }
    final override = selectedMap[group.name];
    final overrideOutlet =
        (override != null && override.isNotEmpty) ? override : null;
    final current = group.getCurrentSelectedName(override ?? '');
    lanes.add(
      StrategyLane(
        groupName: group.name,
        groupType: group.type,
        kind: classifyStrategyLaneName(group.name),
        outlets: group.all.map((proxy) => proxy.name).toList(growable: false),
        currentOutlet: current,
        overrideOutlet: overrideOutlet,
      ),
    );
  }
  lanes.sort((a, b) {
    final kindCmp = _kindSortOrder(a.kind).compareTo(_kindSortOrder(b.kind));
    if (kindCmp != 0) {
      return kindCmp;
    }
    return a.groupName.toLowerCase().compareTo(b.groupName.toLowerCase());
  });
  return lanes;
}

/// Group lanes by category for sectioned UI.
Map<StrategyLaneKind, List<StrategyLane>> groupStrategyLanesByKind(
  List<StrategyLane> lanes,
) {
  final map = <StrategyLaneKind, List<StrategyLane>>{};
  for (final lane in lanes) {
    map.putIfAbsent(lane.kind, () => <StrategyLane>[]).add(lane);
  }
  return map;
}
