import 'package:fl_clash/common/proxy_geo.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Keeps url-test / fallback groups on a preferred region inferred from node
/// names: failover when the current node is unhealthy, and an explicit pick
/// when the user taps a region chip.
class AutoSelectSticky {
  AutoSelectSticky._();

  static final Map<String, DateTime> _lastSwitchAtByGroup = {};

  static Duration cooldown = const Duration(seconds: 60);

  static void debugResetCooldown() => _lastSwitchAtByGroup.clear();

  static Future<void> enforce(Ref ref, List<Group> groups) async {
    final appSetting = ref.read(appSettingProvider);
    if (!appSetting.autoSelectStickyGeo) {
      return;
    }
    final geoIdentityEnabled = ref.read(
      geoIdentitySettingProvider.select((state) => state.enable),
    );
    final profileId = ref.read(currentProfileIdProvider);
    final selectedMap = ref.read(
      currentProfileProvider.select((state) => state?.selectedMap ?? {}),
    );
    final testUrl = ref.read(realTestUrlProvider());
    final delayMap = ref.read(delayDataSourceProvider);
    final stickyByGroup = appSetting.autoSelectStickyGeoByGroup;
    final now = DateTime.now();

    for (final group in groups) {
      if (!group.type.isComputedSelected) {
        continue;
      }
      if (group.name.startsWith('FlClash-')) {
        continue;
      }
      final preferredGeo = resolvePreferredStickyGeo(
        configuredGeo: stickyGeoForGroup(
          stickyByGroup,
          profileId: profileId,
          groupName: group.name,
        ),
        geoIdentityEnabled: geoIdentityEnabled,
      );
      if (preferredGeo == null) {
        continue;
      }

      final override = selectedMap[group.name];
      final currentName = group.getCurrentSelectedName(override ?? '');
      if (currentName.isEmpty) {
        continue;
      }

      final currentHealthy = isProxyDelayHealthy(
        delayMap[testUrl]?[currentName],
      );
      final bestInGeo = pickBestHealthyProxyInGeo(
        proxyNames: group.all.map((proxy) => proxy.name),
        preferredGeo: preferredGeo,
        testUrl: testUrl,
        delayMap: delayMap,
      );

      final AutoSelectDecision? decision = decideAutoSelectSwitch(
        currentName: currentName,
        userOverride: override,
        preferredGeo: preferredGeo,
        currentHealthy: currentHealthy,
        bestHealthyInPreferredGeo: bestInGeo,
        now: now,
        lastSwitchAt: _lastSwitchAtByGroup[group.name],
        cooldown: cooldown,
      );
      if (decision == null) {
        continue;
      }

      final switched = await ref
          .read(proxiesActionProvider.notifier)
          .changeProxy(
            groupName: group.name,
            proxyName: decision.proxyName,
            persistOverride: false,
            closeConnections: false,
          );
      if (switched) {
        _lastSwitchAtByGroup[group.name] = now;
      }
    }
  }

  /// Pins [geo] for the current profile's [group] and switches to the best
  /// healthy node in that region after a delay test of those members.
  static Future<bool> selectGeo(
    WidgetRef ref, {
    required Group group,
    required String geo,
  }) async {
    if (!group.type.isComputedSelected || geo.isEmpty || geo == 'ANY') {
      return false;
    }
    final members = [
      for (final proxy in group.all)
        if (inferProxyGeoRegion(proxy.name) == geo) proxy,
    ];
    if (members.isEmpty) {
      return false;
    }

    final profileId = ref.read(currentProfileIdProvider);
    _writeStickyGeo(
      ref,
      profileId: profileId,
      groupName: group.name,
      geo: geo,
      enable: true,
    );
    ref
        .read(profilesActionProvider.notifier)
        .clearCurrentSelectedMap(group.name);

    final proxies = ref.read(proxiesActionProvider.notifier);
    await proxies.delayTest(members, group.testUrl);

    final testUrl = ref.read(realTestUrlProvider(group.testUrl));
    final delayMap = ref.read(delayDataSourceProvider);
    final override = ref.read(proxyNameProvider(group.name));
    final currentName = group.getCurrentSelectedName(override ?? '');
    final best = pickBestHealthyProxyInGeo(
      proxyNames: members.map((proxy) => proxy.name),
      preferredGeo: geo,
      testUrl: testUrl,
      delayMap: delayMap,
    );
    final decision = decideGeoPickSwitch(
      currentName: currentName,
      preferredGeo: geo,
      bestHealthyInPreferredGeo: best,
    );
    if (decision == null) {
      ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
      return best != null;
    }

    final switched = await proxies.changeProxy(
      groupName: group.name,
      proxyName: decision.proxyName,
      persistOverride: false,
      closeConnections: false,
    );
    if (switched) {
      _lastSwitchAtByGroup[group.name] = DateTime.now();
    }
    ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
    return switched;
  }

  static void clearStickyGeoForGroup(WidgetRef ref, String groupName) {
    final keyed = stickyGeoStorageKey(
      profileId: ref.read(currentProfileIdProvider),
      groupName: groupName,
    );
    ref.read(appSettingProvider.notifier).update((state) {
      if (!state.autoSelectStickyGeoByGroup.containsKey(keyed) &&
          !state.autoSelectStickyGeoByGroup.containsKey(groupName)) {
        return state;
      }
      final next = Map<String, String>.from(state.autoSelectStickyGeoByGroup)
        ..remove(keyed)
        ..remove(groupName);
      return state.copyWith(autoSelectStickyGeoByGroup: next);
    });
    _lastSwitchAtByGroup.remove(groupName);
  }

  static void _writeStickyGeo(
    WidgetRef ref, {
    required int? profileId,
    required String groupName,
    required String geo,
    required bool enable,
  }) {
    final keyed = stickyGeoStorageKey(
      profileId: profileId,
      groupName: groupName,
    );
    ref.read(appSettingProvider.notifier).update((state) {
      final next = Map<String, String>.from(state.autoSelectStickyGeoByGroup)
        ..remove(groupName)
        ..[keyed] = geo;
      return state.copyWith(
        autoSelectStickyGeo: enable || state.autoSelectStickyGeo,
        autoSelectStickyGeoByGroup: next,
      );
    });
  }
}
