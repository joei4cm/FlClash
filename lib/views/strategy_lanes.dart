import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/auto_select_sticky.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Business → strategy UI: show subscription routing and let users override it.
class StrategyLanesView extends ConsumerStatefulWidget {
  const StrategyLanesView({super.key});

  @override
  ConsumerState<StrategyLanesView> createState() => _StrategyLanesViewState();
}

class _StrategyLanesViewState extends ConsumerState<StrategyLanesView> {
  bool _busy = false;

  String _laneLabel(AppLocalizations l10n, StrategyLaneId id) {
    return switch (id) {
      StrategyLaneId.streaming => l10n.strategyLaneKindStreaming,
      StrategyLaneId.ai => l10n.strategyLaneKindAi,
      StrategyLaneId.messaging => l10n.strategyLaneKindMessaging,
      StrategyLaneId.social => l10n.strategyLaneKindSocial,
      StrategyLaneId.search => l10n.strategyLaneKindSearch,
      StrategyLaneId.gaming => l10n.strategyLaneKindGaming,
    };
  }

  String _policyLabel(
    AppLocalizations l10n,
    StrategyLanePolicy policy,
    StrategyLaneDiscovery discovery,
  ) {
    return switch (policy.kind) {
      StrategyLanePolicyKind.follow => discovery.hasGroup
          ? l10n.strategyLaneFollowWithGroup(discovery.groupName!)
          : l10n.strategyLaneFollowSubscription,
      StrategyLanePolicyKind.auto => l10n.strategyLanePolicyAuto,
      StrategyLanePolicyKind.direct => 'DIRECT',
      StrategyLanePolicyKind.reject => 'REJECT',
      StrategyLanePolicyKind.group =>
        l10n.strategyLanePolicyGroup(policy.target ?? ''),
      StrategyLanePolicyKind.proxy =>
        l10n.strategyLanePolicyProxy(policy.target ?? ''),
    };
  }

  Future<void> _setPolicy(StrategyLaneId laneId, StrategyLanePolicy policy) async {
    final profileId = ref.read(currentProfileIdProvider);
    if (profileId == null) {
      return;
    }
    final key = strategyLanePolicyKey(profileId, laneId);
    ref.read(appSettingProvider.notifier).update((state) {
      final next = Map<String, String>.from(state.strategyLanePolicies);
      if (policy.isFollow) {
        next.remove(key);
      } else {
        next[key] = policy.encode();
      }
      return state.copyWith(strategyLanePolicies: next);
    });
    await _applyProfile();
  }

  Future<void> _applyProfile() async {
    if (_busy) {
      return;
    }
    setState(() => _busy = true);
    try {
      await ref
          .read(setupActionProvider.notifier)
          .applyProfile(silence: true, force: true);
      ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
      if (mounted) {
        context.showNotifier(context.appLocalizations.strategyLanesApplied);
      }
    } catch (error) {
      if (mounted) {
        context.showNotifier(
          error.toString(),
          level: MessageLevel.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _pickPolicy({
    required StrategyLaneRow row,
    required List<ProxyGroup> groups,
    required List<Proxy> proxies,
  }) async {
    final l10n = context.appLocalizations;
    final options = <String>[
      'follow',
      'auto',
      'direct',
      'reject',
      for (final group in groups) 'group:${group.name}',
      for (final proxy in proxies.take(80)) 'proxy:${proxy.name}',
    ];
    final current = row.policy.encode();
    final selected = await dialogs.showCommonDialog<String>(
      child: OptionsDialog<String>(
        title: _laneLabel(l10n, row.id),
        options: options,
        value: options.contains(current) ? current : 'follow',
        textBuilder: (value) {
          final policy = StrategyLanePolicy.parse(value);
          return _policyLabel(l10n, policy, row.discovery);
        },
      ),
    );
    if (selected == null || !mounted) {
      return;
    }
    await _setPolicy(row.id, StrategyLanePolicy.parse(selected));
  }

  Future<void> _followExtra(StrategyExtraGroup group) async {
    AutoSelectSticky.clearStickyGeoForGroup(ref, group.groupName);
    ref
        .read(profilesActionProvider.notifier)
        .clearCurrentSelectedMap(group.groupName);
    await ref
        .read(proxiesActionProvider.notifier)
        .changeProxy(groupName: group.groupName, proxyName: '');
    ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
  }

  Future<void> _selectExtraOutlet(StrategyExtraGroup group, String outlet) async {
    await ref
        .read(proxiesActionProvider.notifier)
        .changeProxy(groupName: group.groupName, proxyName: outlet);
    ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    final profileId = ref.watch(currentProfileIdProvider);
    final policies = ref.watch(
      appSettingProvider.select((state) => state.strategyLanePolicies),
    );
    final runtimeGroups = ref.watch(currentGroupsStateProvider).value;
    final selectedMap = ref.watch(
      currentProfileProvider.select((state) => state?.selectedMap ?? {}),
    );

    final clashAsync = profileId == null
        ? null
        : ref.watch(clashConfigProvider(profileId));

    return CommonScaffold(
      title: l10n.strategyLanes,
      body: clashAsync == null
          ? ListView(
              children: [
                ListItem(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.strategyLanesNeedProfile),
                ),
              ],
            )
          : clashAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ListView(
                children: [
                  ListItem(
                    leading: const Icon(Icons.error_outline),
                    title: Text(l10n.strategyLanesLoadFailed),
                    subtitle: Text(error.toString()),
                  ),
                ],
              ),
              data: (clashConfig) {
                final rules = clashConfig.rules
                    .map((item) => item.rawValue)
                    .toList();
                final rows = buildStrategyLaneRows(
                  profileId: profileId!,
                  policies: policies,
                  proxyGroups: clashConfig.proxyGroups,
                  rules: rules,
                );
                final claimed = claimedStrategyGroupNames(rows);
                final extras = buildStrategyExtraGroups(
                  groups: runtimeGroups.isNotEmpty
                      ? runtimeGroups
                      : [
                          for (final group in clashConfig.proxyGroups)
                            Group(
                              name: group.name,
                              type: group.type,
                              all: [
                                for (final name in group.proxies ?? const <String>[])
                                  Proxy(name: name, type: 'ss'),
                              ],
                            ),
                        ],
                  selectedMap: selectedMap,
                  claimedGroupNames: claimed,
                );
                final leafProxies = clashConfig.proxies
                    .where((item) => item.name.isNotEmpty)
                    .toList();

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
                  if (_busy)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: LinearProgressIndicator(),
                    ),
                  ...generateSection(
                    title: l10n.strategyLanesBusinessTitle,
                    items: [
                      for (final row in rows)
                        ListItem(
                          leading: Icon(
                            row.policy.isFollow
                                ? Icons.account_tree_outlined
                                : Icons.tune,
                          ),
                          title: Text(_laneLabel(l10n, row.id)),
                          subtitle: Text(
                            [
                              _policyLabel(l10n, row.policy, row.discovery),
                              if (row.effectiveTarget != null)
                                l10n.strategyLaneEffective(
                                  row.effectiveTarget!,
                                ),
                              if (row.policy.isFollow && !row.discovery.hasGroup)
                                l10n.strategyLaneUncovered,
                            ].join('\n'),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: _busy
                              ? null
                              : () => _pickPolicy(
                                  row: row,
                                  groups: clashConfig.proxyGroups,
                                  proxies: leafProxies,
                                ),
                        ),
                    ],
                  ),
                  if (extras.isNotEmpty)
                    ...generateSection(
                      title: l10n.strategyLanesExtraTitle,
                      items: [
                        for (final group in extras)
                          _ExtraGroupItem(
                            group: group,
                            followLabel: l10n.strategyLaneFollowSubscription,
                            currentLabel: l10n.strategyLaneCurrent(
                              group.currentOutlet,
                            ),
                            overrideLabel: group.hasOverride
                                ? l10n.strategyLaneOverridden
                                : l10n.strategyLaneFollowing,
                            onFollow: () => _followExtra(group),
                            onSelect: (outlet) =>
                                _selectExtraOutlet(group, outlet),
                          ),
                      ],
                    ),
                ];

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) => items[index],
                  padding: const EdgeInsets.only(bottom: 20),
                );
              },
            ),
    );
  }
}

class _ExtraGroupItem extends StatelessWidget {
  const _ExtraGroupItem({
    required this.group,
    required this.followLabel,
    required this.currentLabel,
    required this.overrideLabel,
    required this.onFollow,
    required this.onSelect,
  });

  static const _followSentinel = '__flclash_follow_subscription__';

  final StrategyExtraGroup group;
  final String followLabel;
  final String currentLabel;
  final String overrideLabel;
  final VoidCallback onFollow;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final outlets = <String>[
      if (group.overrideOutlet != null &&
          !group.outlets.contains(group.overrideOutlet))
        group.overrideOutlet!,
      ...group.outlets,
    ];
    final options = <String>[_followSentinel, ...outlets];
    final selected = group.hasOverride
        ? (group.overrideOutlet ?? _followSentinel)
        : _followSentinel;

    return ListItem(
      leading: Icon(
        group.hasOverride ? Icons.tune : Icons.account_tree_outlined,
      ),
      title: Text(group.groupName),
      subtitle: Text('$overrideLabel\n$currentLabel'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final value = await dialogs.showCommonDialog<String>(
          child: OptionsDialog<String>(
            title: group.groupName,
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
