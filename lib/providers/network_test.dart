import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const flClashAutoGroupName = 'FlClash Auto';
const flClashProxyGroupName = 'PROXY';

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

/// Restores existing url-test/fallback selection, or creates a simple
/// overwrite url-test group when the subscription has none (fallback only).
///
/// On upstream/dev, service probing lives in core `service_check` /
/// `service_status`; this helper only covers auto-select fallback UX.
Future<AutoSelectResult> enableAutoSelectWithContainer(WidgetRef ref) async {
  final groups = ref.read(groupsProvider);
  final existingAuto = groups.cast<Group?>().firstWhere(
    (group) => group?.type.isComputedSelected == true,
    orElse: () => null,
  );
  if (existingAuto != null) {
    final autoGroups = groups
        .where((group) => group.type.isComputedSelected)
        .toList();
    for (final group in autoGroups) {
      ref
          .read(profilesActionProvider.notifier)
          .clearCurrentSelectedMap(group.name);
      await ref
          .read(proxiesActionProvider.notifier)
          .changeProxy(
            groupName: group.name,
            proxyName: '',
            closeConnections: false,
          );
    }
    ref
        .read(proxiesActionProvider.notifier)
        .updateCurrentGroupName(existingAuto.name);
    ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
    return AutoSelectResult(
      enabledExisting: true,
      groupName: existingAuto.name,
    );
  }

  final profile = ref.read(currentProfileProvider);
  if (profile == null) {
    return const AutoSelectResult(message: 'no_profile');
  }

  final testUrl = ref.read(appSettingProvider.select((state) => state.testUrl));
  final groupsNotifier = ref.read(proxyGroupsProvider(profile.id).notifier);
  final existingCustom = ref.read(proxyGroupsProvider(profile.id)).value ?? [];

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
    ref
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

  ref
      .read(profilesActionProvider.notifier)
      .clearCurrentSelectedMap(flClashAutoGroupName);
  ref
      .read(proxiesActionProvider.notifier)
      .updateCurrentGroupName(
        existingCustom.isEmpty ? flClashProxyGroupName : flClashAutoGroupName,
      );

  await ref
      .read(setupActionProvider.notifier)
      .applyProfile(silence: true, force: true);

  return const AutoSelectResult(
    createdGroups: true,
    groupName: flClashAutoGroupName,
  );
}
