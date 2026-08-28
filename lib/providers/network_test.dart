import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Per-probe delay: `null` idle, `0` running, `>0` ms, `-1` failed.
class ServiceReachabilityState {
  final String? proxyName;
  final String? groupName;
  final bool isRunning;
  final Map<String, int?> results;
  final DateTime? lastRunAt;

  const ServiceReachabilityState({
    this.proxyName,
    this.groupName,
    this.isRunning = false,
    this.results = const {},
    this.lastRunAt,
  });

  ServiceReachabilityState copyWith({
    String? proxyName,
    String? groupName,
    bool? isRunning,
    Map<String, int?>? results,
    DateTime? lastRunAt,
  }) {
    return ServiceReachabilityState(
      proxyName: proxyName ?? this.proxyName,
      groupName: groupName ?? this.groupName,
      isRunning: isRunning ?? this.isRunning,
      results: results ?? this.results,
      lastRunAt: lastRunAt ?? this.lastRunAt,
    );
  }

  int get successCount =>
      results.values.where((value) => value != null && value > 0).length;

  int get failCount => results.values.where((value) => value == -1).length;

  int get testedCount =>
      results.values.where((value) => value != null && value != 0).length;

  int? categoryBestDelay(ServiceProbeCategory category) {
    final delays = category.probes
        .map((probe) => results[probe.id])
        .whereType<int>()
        .where((value) => value > 0)
        .toList();
    if (delays.isEmpty) {
      return null;
    }
    delays.sort();
    return delays.first;
  }

  bool categoryHasFailure(ServiceProbeCategory category) {
    return category.probes.any((probe) => results[probe.id] == -1);
  }
}

class ServiceReachabilityNotifier extends Notifier<ServiceReachabilityState> {
  @override
  ServiceReachabilityState build() => const ServiceReachabilityState();

  /// Resolve the leaf outbound currently used by the active proxy group.
  ({String? groupName, String proxyName}) resolveTarget() {
    final groups = ref.read(groupsProvider);
    if (groups.isEmpty) {
      return (groupName: null, proxyName: '');
    }
    final profile = ref.read(currentProfileProvider);
    final preferredName = profile?.currentGroupName;
    final group =
        groups.getGroup(preferredName ?? '') ??
        groups.cast<Group?>().firstWhere(
          (item) => item?.name.toUpperCase() == 'PROXY',
          orElse: () => null,
        ) ??
        groups.first;
    final selectedMap = profile?.selectedMap ?? {};
    final selected = computeRealSelectedProxyState(
      group.name,
      groups: groups,
      selectedMap: selectedMap,
    );
    return (groupName: group.name, proxyName: selected.proxyName);
  }

  Future<void> run({bool force = false}) async {
    if (state.isRunning && !force) {
      return;
    }
    if (!ref.read(isStartProvider)) {
      state = const ServiceReachabilityState();
      return;
    }
    final target = resolveTarget();
    if (target.proxyName.isEmpty) {
      state = ServiceReachabilityState(
        groupName: target.groupName,
        proxyName: '',
      );
      return;
    }

    final pending = <String, int?>{
      for (final probe in serviceProbes) probe.id: 0,
    };
    state = ServiceReachabilityState(
      proxyName: target.proxyName,
      groupName: target.groupName,
      isRunning: true,
      results: pending,
    );

    final batches = serviceProbes.batch(maxConcurrentServiceProbes);
    final results = Map<String, int?>.from(pending);
    for (final batch in batches) {
      await Future.wait(
        batch.map((probe) async {
          try {
            final delay = await coreController.getDelay(
              probe.url,
              target.proxyName,
            );
            results[probe.id] = delay.value ?? -1;
          } catch (error) {
            commonPrint.log(
              'Service probe ${probe.id} failed: $error',
              logLevel: coreFailureLogLevel(error),
            );
            results[probe.id] = -1;
          }
          if (ref.mounted) {
            state = state.copyWith(results: Map<String, int?>.from(results));
          }
        }),
      );
    }
    if (!ref.mounted) {
      return;
    }
    state = state.copyWith(
      isRunning: false,
      results: results,
      lastRunAt: DateTime.now(),
    );
  }

  void reset() {
    state = const ServiceReachabilityState();
  }
}

final serviceReachabilityProvider =
    NotifierProvider<ServiceReachabilityNotifier, ServiceReachabilityState>(
      ServiceReachabilityNotifier.new,
    );

class AutoSelectResult {
  final bool enabledExisting;
  final bool createdGroups;
  final String? groupName;
  final String? message;

  const AutoSelectResult({
    this.enabledExisting = false,
    this.createdGroups = false,
    this.groupName,
    this.message,
  });
}

/// Enables Clash url-test/fallback auto selection, or creates a simple
/// overwrite url-test group when none exists.
Future<AutoSelectResult> enableAutoSelectWithContainer(
  ProviderContainer container,
) async {
  final groups = container.read(groupsProvider);
  final existingAuto = groups.cast<Group?>().firstWhere(
    (group) => group?.type.isComputedSelected == true,
    orElse: () => null,
  );
  if (existingAuto != null) {
    container
        .read(profilesActionProvider.notifier)
        .clearCurrentSelectedMap(existingAuto.name);
    container
        .read(proxiesActionProvider.notifier)
        .updateCurrentGroupName(existingAuto.name);
    await container
        .read(proxiesActionProvider.notifier)
        .changeProxy(groupName: existingAuto.name, proxyName: '');
    container.read(proxiesActionProvider.notifier).updateGroupsDebounce();
    return AutoSelectResult(
      enabledExisting: true,
      groupName: existingAuto.name,
    );
  }

  final profile = container.read(currentProfileProvider);
  if (profile == null) {
    return const AutoSelectResult(message: 'no_profile');
  }

  final testUrl = container.read(
    appSettingProvider.select((state) => state.testUrl),
  );
  final groupsNotifier = container.read(
    proxyGroupsProvider(profile.id).notifier,
  );
  final existingCustom =
      container.read(proxyGroupsProvider(profile.id)).value ?? [];

  ProxyGroup newAutoGroup() => ProxyGroup(
    id: snowflake.id,
    name: flClashAutoGroupName,
    type: GroupType.URLTest,
    includeAllProxies: true,
    url: testUrl,
    interval: 300,
    lazy: true,
  );
  ProxyGroup newProxyGroup() => ProxyGroup(
    id: snowflake.id,
    name: flClashProxyGroupName,
    type: GroupType.Selector,
    proxies: [flClashAutoGroupName, 'DIRECT', 'REJECT'],
  );

  if (profile.overwriteType != OverwriteType.custom) {
    container
        .read(profilesProvider.notifier)
        .put(profile.copyWith(overwriteType: OverwriteType.custom));
  }

  // Replace empty custom groups with a minimal Auto + PROXY setup. If the
  // user already authored custom groups, only ensure FlClash Auto exists.
  if (existingCustom.isEmpty) {
    final okAuto = groupsNotifier.put(newAutoGroup());
    final okProxy = groupsNotifier.put(newProxyGroup());
    if (!okAuto || !okProxy) {
      return const AutoSelectResult(message: 'create_failed');
    }
  } else {
    final hasAuto = existingCustom.any(
      (item) => item.name == flClashAutoGroupName,
    );
    if (!hasAuto) {
      final ok = groupsNotifier.put(newAutoGroup());
      if (!ok) {
        return const AutoSelectResult(message: 'create_failed');
      }
    }
  }

  container
      .read(profilesActionProvider.notifier)
      .clearCurrentSelectedMap(flClashAutoGroupName);
  container
      .read(proxiesActionProvider.notifier)
      .updateCurrentGroupName(
        existingCustom.isEmpty ? flClashProxyGroupName : flClashAutoGroupName,
      );

  await container
      .read(setupActionProvider.notifier)
      .applyProfile(silence: true, force: true);

  return const AutoSelectResult(
    createdGroups: true,
    groupName: flClashAutoGroupName,
  );
}
