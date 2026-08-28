import 'package:fl_clash/common/proxy_geo.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Applies geo-sticky policy for url-test / fallback groups.
///
/// When enabled, auto groups prefer staying in the configured region while at
/// least one alive node in that region remains available.
class AutoSelectSticky {
  AutoSelectSticky._();

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

    for (final group in groups) {
      if (!group.type.isComputedSelected) {
        continue;
      }
      final override = selectedMap[group.name];
      if (override != null && override.isNotEmpty) {
        continue;
      }

      final currentName = group.getCurrentSelectedName(
        selectedMap[group.name] ?? '',
      );
      if (currentName.isEmpty) {
        continue;
      }

      final stickyGeo = resolveAutoSelectStickyGeo(
        configuredGeo: stickyByGroup[group.name],
        geoIdentityEnabled: geoIdentityEnabled,
        proxyName: currentName,
      );
      if (stickyGeo == 'ANY') {
        continue;
      }

      final currentGeo = inferProxyGeoRegion(currentName);
      if (currentGeo == stickyGeo) {
        continue;
      }

      final replacement = _pickBestInGeo(
        group: group,
        stickyGeo: stickyGeo,
        testUrl: testUrl,
        delayMap: delayMap,
      );
      if (replacement == null || replacement == currentName) {
        continue;
      }

      await ref
          .read(proxiesActionProvider.notifier)
          .changeProxy(groupName: group.name, proxyName: replacement);
    }
  }

  static String? _pickBestInGeo({
    required Group group,
    required String stickyGeo,
    required String testUrl,
    required Map<String, Map<String, int?>> delayMap,
  }) {
    String? bestName;
    int? bestDelay;
    String? fallbackName;
    for (final proxy in group.all) {
      if (inferProxyGeoRegion(proxy.name) != stickyGeo) {
        continue;
      }
      fallbackName ??= proxy.name;
      final delay = delayMap[testUrl]?[proxy.name];
      if (delay == null || delay <= 0) {
        continue;
      }
      if (bestDelay == null || delay < bestDelay) {
        bestDelay = delay;
        bestName = proxy.name;
      }
    }
    return bestName ?? fallbackName;
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
  }
}
