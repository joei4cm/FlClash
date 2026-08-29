import 'package:fl_clash/common/proxy_geo.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Geo-aware recovery for url-test / fallback groups.
///
/// Flutter does **not** own continuous selection. Core url-test/fallback keeps
/// picking. This policy only nudges when the current node is unhealthy and a
/// known-healthy node exists in the preferred region — without writing
/// `selectedMap` (which would lock auto mode) and without closing all
/// connections (which felt like random disconnects).
class AutoSelectSticky {
  AutoSelectSticky._();

  static final Map<String, DateTime> _lastSwitchAtByGroup = {};

  static Duration cooldown = const Duration(seconds: 60);

  /// Test-only.
  static void debugResetCooldown() => _lastSwitchAtByGroup.clear();

  static Future<void> enforce(Ref ref, List<Group> groups) async {
    final appSetting = ref.read(appSettingProvider);
    if (!appSetting.autoSelectStickyGeo) {
      return;
    }
    final geoIdentityEnabled = ref.read(
      geoIdentitySettingProvider.select((state) => state.enable),
    );
    final selectedMap = ref.read(
      currentProfileProvider.select((state) => state?.selectedMap ?? {}),
    );
    final testUrl = appSetting.testUrl;
    final delayMap = ref.read(delayDataSourceProvider);
    final stickyByGroup = appSetting.autoSelectStickyGeoByGroup;
    final now = DateTime.now();

    for (final group in groups) {
      if (!group.type.isComputedSelected) {
        continue;
      }
      // Strategy-lane managed url-test groups should keep include-all behavior.
      if (group.name.startsWith('FlClash-')) {
        continue;
      }
      final preferredGeo = resolvePreferredStickyGeo(
        configuredGeo: stickyByGroup[group.name],
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

  static void setStickyGeoForGroup(
    WidgetRef ref, {
    required String groupName,
    required String proxyName,
  }) {
    final geo = resolveAutoSelectStickyGeo(
      configuredGeo: null,
      geoIdentityEnabled: ref.read(
        geoIdentitySettingProvider.select((state) => state.enable),
      ),
      proxyName: proxyName,
    );
    ref.read(appSettingProvider.notifier).update((state) {
      final next = Map<String, String>.from(state.autoSelectStickyGeoByGroup)
        ..[groupName] = geo;
      return state.copyWith(autoSelectStickyGeoByGroup: next);
    });
  }

  static void clearStickyGeoForGroup(WidgetRef ref, String groupName) {
    ref.read(appSettingProvider.notifier).update((state) {
      if (!state.autoSelectStickyGeoByGroup.containsKey(groupName)) {
        return state;
      }
      final next = Map<String, String>.from(state.autoSelectStickyGeoByGroup)
        ..remove(groupName);
      return state.copyWith(autoSelectStickyGeoByGroup: next);
    });
    _lastSwitchAtByGroup.remove(groupName);
  }
}
