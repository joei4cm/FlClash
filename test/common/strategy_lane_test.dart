import 'package:fl_clash/common/strategy_lane.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/clash_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StrategyLanePolicy', () {
    test('round-trips encodings', () {
      expect(StrategyLanePolicy.parse(null).isFollow, isTrue);
      expect(StrategyLanePolicy.parse('auto').kind, StrategyLanePolicyKind.auto);
      expect(
        StrategyLanePolicy.parse('group:Netflix').target,
        'Netflix',
      );
      expect(
        const StrategyLanePolicy.proxy('US-01').encode(),
        'proxy:US-01',
      );
    });
  });

  group('discoverStrategyLane', () {
    test('finds target from GEOSITE rules', () {
      final discovery = discoverStrategyLane(
        preset: strategyLanePresetById(StrategyLaneId.streaming)!,
        proxyGroups: const [],
        rules: const ['GEOSITE,netflix,Netflix', 'MATCH,PROXY'],
      );
      expect(discovery.groupName, 'Netflix');
      expect(discovery.source, StrategyLaneDiscoverySource.rules);
    });

    test('falls back to group name hints', () {
      final discovery = discoverStrategyLane(
        preset: strategyLanePresetById(StrategyLaneId.ai)!,
        proxyGroups: [
          ProxyGroup(
            id: 1,
            name: 'OpenAI',
            type: GroupType.Selector,
            proxies: const ['US-01'],
          ),
        ],
        rules: const ['MATCH,PROXY'],
      );
      expect(discovery.groupName, 'OpenAI');
      expect(discovery.source, StrategyLaneDiscoverySource.groupName);
    });
  });

  group('buildStrategyLaneInjection', () {
    test('follow policies inject nothing', () {
      final injection = buildStrategyLaneInjection(
        profileId: 1,
        policies: const {},
        proxyGroups: const [],
        rules: const [],
        testUrl: 'https://www.gstatic.com/generate_204',
      );
      expect(injection.isEmpty, isTrue);
    });

    test('auto injects url-test group and geosite rules', () {
      final key = strategyLanePolicyKey(7, StrategyLaneId.ai);
      final injection = buildStrategyLaneInjection(
        profileId: 7,
        policies: {key: 'auto'},
        proxyGroups: const [],
        rules: const [],
        testUrl: 'https://www.gstatic.com/generate_204',
      );
      expect(injection.groups, hasLength(1));
      expect(injection.groups.single['name'], 'FlClash-ai');
      expect(injection.groups.single['type'], 'url-test');
      expect(injection.groups.single['include-all-proxies'], isTrue);
      expect(
        injection.rules.any((rule) => rule.startsWith('GEOSITE,openai,')),
        isTrue,
      );
      expect(
        injection.rules.any(
          (rule) => rule == 'DOMAIN-SUFFIX,chatgpt.com,FlClash-ai',
        ),
        isTrue,
      );
    });

    test('group policy prepends rules to existing group', () {
      final key = strategyLanePolicyKey(1, StrategyLaneId.streaming);
      final injection = buildStrategyLaneInjection(
        profileId: 1,
        policies: {key: 'group:Netflix'},
        proxyGroups: [
          ProxyGroup(
            id: 2,
            name: 'Netflix',
            type: GroupType.Selector,
            proxies: const ['US-01'],
          ),
        ],
        rules: const [],
        testUrl: 'https://www.gstatic.com/generate_204',
      );
      expect(injection.groups, isEmpty);
      expect(
        injection.rules.any((rule) => rule == 'GEOSITE,netflix,Netflix'),
        isTrue,
      );
    });

    test('proxy policy injects select group', () {
      final key = strategyLanePolicyKey(1, StrategyLaneId.messaging);
      final injection = buildStrategyLaneInjection(
        profileId: 1,
        policies: {key: 'proxy:TG-01'},
        proxyGroups: const [],
        rules: const [],
        testUrl: 'https://www.gstatic.com/generate_204',
      );
      expect(injection.groups.single['type'], 'select');
      expect(injection.groups.single['proxies'], ['TG-01', 'DIRECT', 'REJECT']);
    });
  });

  group('mergeStrategyLaneGroupsInto', () {
    test('upserts by name', () {
      final merged = mergeStrategyLaneGroupsInto(
        {
          'proxy-groups': [
            {'name': 'PROXY', 'type': 'select'},
            {'name': 'FlClash-ai', 'type': 'select'},
          ],
        },
        [
          {
            'name': 'FlClash-ai',
            'type': 'url-test',
            'include-all-proxies': true,
          },
        ],
      );
      final groups = merged['proxy-groups'] as List;
      expect(groups, hasLength(2));
      expect(
        groups.whereType<Map>().singleWhere(
          (item) => item['name'] == 'FlClash-ai',
        )['type'],
        'url-test',
      );
    });
  });

  group('buildStrategyLaneRows', () {
    test('surfaces discovery and overrides', () {
      final rows = buildStrategyLaneRows(
        profileId: 3,
        policies: {
          strategyLanePolicyKey(3, StrategyLaneId.ai): 'direct',
        },
        proxyGroups: [
          ProxyGroup(
            id: 1,
            name: 'Netflix',
            type: GroupType.Selector,
            proxies: const ['a'],
          ),
        ],
        rules: const ['GEOSITE,netflix,Netflix'],
      );
      final streaming = rows.firstWhere(
        (row) => row.id == StrategyLaneId.streaming,
      );
      expect(streaming.policy.isFollow, isTrue);
      expect(streaming.discovery.groupName, 'Netflix');
      expect(streaming.effectiveTarget, 'Netflix');

      final ai = rows.firstWhere((row) => row.id == StrategyLaneId.ai);
      expect(ai.policy.kind, StrategyLanePolicyKind.direct);
      expect(ai.effectiveTarget, 'DIRECT');
    });
  });

  group('classifyStrategyLaneName', () {
    test('still classifies common names', () {
      expect(classifyStrategyLaneName('Netflix'), StrategyLaneKind.streaming);
      expect(classifyStrategyLaneName('OpenAI'), StrategyLaneKind.ai);
      expect(classifyStrategyLaneName('Random-HK'), StrategyLaneKind.other);
    });
  });
}
