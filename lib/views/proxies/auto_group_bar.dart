import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/proxy_geo.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/auto_select_sticky.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Banner for url-test / fallback groups: show live node and restore auto mode.
class AutoGroupBar extends ConsumerWidget {
  final Group group;

  const AutoGroupBar({super.key, required this.group});

  Future<void> _restoreAuto(WidgetRef ref) async {
    AutoSelectSticky.clearStickyGeoForGroup(ref, group.name);
    ref
        .read(profilesActionProvider.notifier)
        .clearCurrentSelectedMap(group.name);
    await ref
        .read(proxiesActionProvider.notifier)
        .changeProxy(groupName: group.name, proxyName: '');
    ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
  }

  void _stickToRegion(WidgetRef ref, String proxyName) {
    AutoSelectSticky.setStickyGeoForGroup(
      ref,
      groupName: group.name,
      proxyName: proxyName,
    );
    ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!group.type.isComputedSelected) {
      return const SizedBox.shrink();
    }
    final l10n = context.appLocalizations;
    final overrideName = ref.watch(proxyNameProvider(group.name));
    final selectedName = ref.watch(selectedProxyNameProvider(group.name));
    final stickyEnabled = ref.watch(
      appSettingProvider.select((state) => state.autoSelectStickyGeo),
    );
    final stickyGeo = ref.watch(
      appSettingProvider.select(
        (state) => state.autoSelectStickyGeoByGroup[group.name],
      ),
    );
    final hasOverride = overrideName != null && overrideName.isNotEmpty;
    final currentName = selectedName ?? group.realNow;
    final typeLabel = group.type == GroupType.URLTest
        ? l10n.groupTypeUrlTest
        : l10n.groupTypeFallback;
    final inferredGeo = inferProxyGeoRegion(currentName);

    return Material(
      color: context.colorScheme.secondaryContainer.opacity60,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
        child: Row(
          children: [
            Icon(
              Icons.auto_mode,
              size: 18,
              color: context.colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.autoGroupTitle(typeLabel),
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onSecondaryContainer,
                    ),
                  ),
                  Text(
                    hasOverride
                        ? l10n.autoGroupOverride(selectedName ?? overrideName)
                        : l10n.autoGroupCurrent(currentName),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSecondaryContainer
                          .opacity80,
                    ),
                  ),
                  if (stickyEnabled && (stickyGeo != null || inferredGeo != null))
                    Text(
                      l10n.autoGroupStickyRegion(
                        stickyGeo ?? inferredGeo ?? '',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSecondaryContainer
                            .opacity80,
                      ),
                    ),
                ],
              ),
            ),
            if (stickyEnabled && currentName.isNotEmpty)
              TextButton(
                onPressed: () => _stickToRegion(ref, currentName),
                child: Text(l10n.stickToRegion),
              ),
            if (hasOverride)
              TextButton(
                onPressed: () => _restoreAuto(ref),
                child: Text(l10n.restoreAutoSelect),
              ),
          ],
        ),
      ),
    );
  }
}
