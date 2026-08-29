import 'package:fl_clash/common/strategy_lane.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/clash_config.dart';
import 'package:fl_clash/models/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('classifyStrategyLaneName', () {
    test('detects common provider group names', () {
      expect(classifyStrategyLaneName('Netflix'), StrategyLaneKind.streaming);
      expect(classifyStrategyLaneName('流媒体'), StrategyLaneKind.streaming);
      expect(classifyStrategyLaneName('OpenAI'), StrategyLaneKind.ai);
      expect(classifyStrategyLaneName('ChatGPT'), StrategyLaneKind.ai);
      expect(classifyStrategyLaneName('Telegram'), StrategyLaneKind.messaging);
      expect(classifyStrategyLaneName('Discord'), StrategyLaneKind.messaging);
      expect(classifyStrategyLaneName('PROXY'), StrategyLaneKind.proxy);
      expect(classifyStrategyLaneName('节点选择'), StrategyLaneKind.proxy);
      expect(classifyStrategyLaneName('Steam'), StrategyLaneKind.gaming);
      expect(classifyStrategyLaneName('Google'), StrategyLaneKind.search);
      expect(classifyStrategyLaneName('Random-HK-01'), StrategyLaneKind.other);
    });
  });

  group('buildStrategyLanes', () {
    test('classifies, sorts, and reports overrides', () {
      final groups = [
        const Group(
          name: 'PROXY',
          type: GroupType.Selector,
          now: 'AUTO',
          all: const [
            Proxy(name: 'AUTO', type: 'ss'),
            Proxy(name: 'DIRECT', type: 'ss'),
            Proxy(name: 'US-01', type: 'ss'),
          ],
        ),
        const Group(
          name: 'Netflix',
          type: GroupType.Selector,
          now: 'US-01',
          all: const [Proxy(name: 'PROXY', type: 'ss'), Proxy(name: 'US-01', type: 'ss')],
        ),
        const Group(
          name: 'OpenAI',
          type: GroupType.URLTest,
          now: 'JP-01',
          all: const [Proxy(name: 'JP-01', type: 'ss'), Proxy(name: 'US-02', type: 'ss')],
        ),
        const Group(
          name: 'GLOBAL',
          type: GroupType.Selector,
          all: const [Proxy(name: 'DIRECT', type: 'ss')],
        ),
        const Group(
          name: 'Hidden',
          type: GroupType.Selector,
          hidden: true,
          all: const [Proxy(name: 'DIRECT', type: 'ss')],
        ),
      ];

      final lanes = buildStrategyLanes(
        groups: groups,
        selectedMap: const {
          'Netflix': 'US-01',
          'OpenAI': '',
        },
      );

      expect(lanes.map((lane) => lane.groupName).toList(), [
        'Netflix',
        'OpenAI',
        'PROXY',
      ]);
      expect(lanes[0].kind, StrategyLaneKind.streaming);
      expect(lanes[0].hasOverride, isTrue);
      expect(lanes[0].overrideOutlet, 'US-01');
      expect(lanes[0].currentOutlet, 'US-01');

      expect(lanes[1].kind, StrategyLaneKind.ai);
      expect(lanes[1].hasOverride, isFalse);
      expect(lanes[1].currentOutlet, 'JP-01');

      expect(lanes[2].kind, StrategyLaneKind.proxy);
      expect(lanes[2].hasOverride, isFalse);
      expect(lanes[2].currentOutlet, 'AUTO');
    });

    test('keeps provider-specific names under other', () {
      final lanes = buildStrategyLanes(
        groups: [
          const Group(
            name: 'Company-Special',
            type: GroupType.Fallback,
            now: 'a',
            all: const [Proxy(name: 'a', type: 'ss'), Proxy(name: 'b', type: 'ss')],
          ),
        ],
        selectedMap: const {},
      );
      expect(lanes, hasLength(1));
      expect(lanes.single.kind, StrategyLaneKind.other);
      expect(lanes.single.groupType, GroupType.Fallback);
    });
  });

  group('groupStrategyLanesByKind', () {
    test('buckets lanes by kind', () {
      final lanes = buildStrategyLanes(
        groups: [
          const Group(
            name: 'Netflix',
            type: GroupType.Selector,
            all: const [Proxy(name: 'a', type: 'ss')],
          ),
          const Group(
            name: 'OpenAI',
            type: GroupType.Selector,
            all: const [Proxy(name: 'b', type: 'ss')],
          ),
        ],
        selectedMap: const {},
      );
      final byKind = groupStrategyLanesByKind(lanes);
      expect(byKind[StrategyLaneKind.streaming], hasLength(1));
      expect(byKind[StrategyLaneKind.ai], hasLength(1));
      expect(byKind.containsKey(StrategyLaneKind.other), isFalse);
    });
  });
}
