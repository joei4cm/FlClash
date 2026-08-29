import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/auto_select_sticky.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Surfaces subscription strategy groups so users can pick or override outlets.
class StrategyLanesView extends ConsumerWidget {
  const StrategyLanesView({super.key});

  String _kindLabel(AppLocalizations l10n, StrategyLaneKind kind) {
    return switch (kind) {
      StrategyLaneKind.streaming => l10n.strategyLaneKindStreaming,
      StrategyLaneKind.ai => l10n.strategyLaneKindAi,
      StrategyLaneKind.social => l10n.strategyLaneKindSocial,
      StrategyLaneKind.search => l10n.strategyLaneKindSearch,
      StrategyLaneKind.messaging => l10n.strategyLaneKindMessaging,
      StrategyLaneKind.gaming => l10n.strategyLaneKindGaming,
      StrategyLaneKind.proxy => l10n.strategyLaneKindProxy,
      StrategyLaneKind.other => l10n.strategyLaneKindOther,
    };
  }

  String _typeLabel(AppLocalizations l10n, GroupType type) {
    return switch (type) {
      GroupType.URLTest => l10n.groupTypeUrlTest,
      GroupType.Fallback => l10n.groupTypeFallback,
      GroupType.Selector => l10n.strategyLaneTypeSelector,
      GroupType.LoadBalance => l10n.strategyLaneTypeLoadBalance,
      GroupType.Relay => l10n.strategyLaneTypeRelay,
    };
  }

  Future<void> _followSubscription(WidgetRef ref, StrategyLane lane) async {
    AutoSelectSticky.clearStickyGeoForGroup(ref, lane.groupName);
    ref
        .read(profilesActionProvider.notifier)
        .clearCurrentSelectedMap(lane.groupName);
    await ref
        .read(proxiesActionProvider.notifier)
        .changeProxy(groupName: lane.groupName, proxyName: '');
    ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
  }

  Future<void> _selectOutlet(
    WidgetRef ref,
    StrategyLane lane,
    String outlet,
  ) async {
    await ref
        .read(proxiesActionProvider.notifier)
        .changeProxy(groupName: lane.groupName, proxyName: outlet);
    ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.appLocalizations;
    final isStart = ref.watch(isStartProvider);
    final groups = ref.watch(currentGroupsStateProvider).value;
    final selectedMap = ref.watch(
      currentProfileProvider.select((state) => state?.selectedMap ?? {}),
    );
    final lanes = buildStrategyLanes(
      groups: groups,
      selectedMap: selectedMap,
    );
    final byKind = groupStrategyLanesByKind(lanes);

    final items = <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Text(
          l10n.strategyLanesTip,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      if (!isStart)
        ListItem(
          leading: const Icon(Icons.play_circle_outline),
          title: Text(l10n.strategyLanesNeedStart),
        )
      else if (lanes.isEmpty)
        ListItem(
          leading: const Icon(Icons.account_tree_outlined),
          title: Text(l10n.strategyLanesEmpty),
          subtitle: Text(l10n.strategyLanesEmptyDesc),
        )
      else
        for (final kind in StrategyLaneKind.values)
          if (byKind[kind] case final kindLanes?)
            ...generateSection(
              title: _kindLabel(l10n, kind),
              items: [
                for (final lane in kindLanes)
                  _StrategyLaneItem(
                    lane: lane,
                    typeLabel: _typeLabel(l10n, lane.groupType),
                    followLabel: l10n.strategyLaneFollowSubscription,
                    currentLabel: l10n.strategyLaneCurrent(lane.currentOutlet),
                    overrideLabel: lane.hasOverride
                        ? l10n.strategyLaneOverridden
                        : l10n.strategyLaneFollowing,
                    onFollow: () => _followSubscription(ref, lane),
                    onSelect: (outlet) => _selectOutlet(ref, lane, outlet),
                  ),
              ],
            ),
    ];

    return CommonScaffold(
      title: l10n.strategyLanes,
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) => items[index],
        padding: const EdgeInsets.only(bottom: 20),
      ),
    );
  }
}

class _StrategyLaneItem extends StatelessWidget {
  const _StrategyLaneItem({
    required this.lane,
    required this.typeLabel,
    required this.followLabel,
    required this.currentLabel,
    required this.overrideLabel,
    required this.onFollow,
    required this.onSelect,
  });

  static const _followSentinel = '__flclash_follow_subscription__';

  final StrategyLane lane;
  final String typeLabel;
  final String followLabel;
  final String currentLabel;
  final String overrideLabel;
  final VoidCallback onFollow;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final outlets = <String>[
      if (lane.overrideOutlet != null &&
          !lane.outlets.contains(lane.overrideOutlet))
        lane.overrideOutlet!,
      ...lane.outlets,
    ];
    final options = <String>[_followSentinel, ...outlets];
    final selected = lane.hasOverride
        ? (lane.overrideOutlet ?? _followSentinel)
        : _followSentinel;

    return ListItem(
      leading: Icon(
        lane.hasOverride ? Icons.tune : Icons.account_tree_outlined,
      ),
      title: Text(lane.groupName),
      subtitle: Text('$typeLabel · $overrideLabel\n$currentLabel'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final value = await dialogs.showCommonDialog<String>(
          child: OptionsDialog<String>(
            title: lane.groupName,
            options: options,
            value: selected,
            textBuilder: (option) =>
                option == _followSentinel ? followLabel : option,
          ),
        );
        if (value == null) {
          return;
        }
        if (value == _followSentinel) {
          onFollow();
        } else {
          onSelect(value);
        }
      },
    );
  }
}
