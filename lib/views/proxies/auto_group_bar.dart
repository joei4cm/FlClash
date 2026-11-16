import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/auto_select_sticky.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/ui/icons/icons.dart';
import 'package:fl_clash/ui/ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Banner for url-test / fallback groups: region chips from node names, plus
/// restore-auto when the user has pinned a proxy.
class AutoGroupBar extends ConsumerStatefulWidget {
  final Group group;

  const AutoGroupBar({super.key, required this.group});

  @override
  ConsumerState<AutoGroupBar> createState() => _AutoGroupBarState();
}

class _AutoGroupBarState extends ConsumerState<AutoGroupBar> {
  String? _testingGeo;

  Group get group => widget.group;

  Future<void> _restoreAuto() async {
    AutoSelectSticky.clearStickyGeoForGroup(ref, group.name);
    ref
        .read(profilesActionProvider.notifier)
        .clearCurrentSelectedMap(group.name);
    await ref
        .read(proxiesActionProvider.notifier)
        .changeProxy(groupName: group.name, proxyName: '');
    ref.read(proxiesActionProvider.notifier).updateGroupsDebounce();
  }

  Future<void> _pickGeo(String geo) async {
    if (_testingGeo != null) {
      return;
    }
    setState(() => _testingGeo = geo);
    try {
      await AutoSelectSticky.selectGeo(ref, group: group, geo: geo);
    } finally {
      if (mounted) {
        setState(() => _testingGeo = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!group.type.isComputedSelected) {
      return const SizedBox.shrink();
    }
    final l10n = context.appLocalizations;
    final overrideName = ref.watch(proxyNameProvider(group.name));
    final selectedName = ref.watch(selectedProxyNameProvider(group.name));
    final profileId = ref.watch(currentProfileIdProvider);
    final stickyGeo = ref.watch(
      appSettingProvider.select(
        (state) => stickyGeoForGroup(
          state.autoSelectStickyGeoByGroup,
          profileId: profileId,
          groupName: group.name,
        ),
      ),
    );
    final hasOverride = overrideName != null && overrideName.isNotEmpty;
    final currentName = selectedName ?? group.realNow;
    final typeLabel = group.type == GroupType.URLTest
        ? l10n.groupTypeUrlTest
        : l10n.groupTypeFallback;
    final byGeo = groupProxyNamesByGeo(group.all.map((proxy) => proxy.name));
    final geos = [
      for (final geo in proxyGeoRegionOrder)
        if (byGeo.containsKey(geo)) geo,
      for (final geo in byGeo.keys)
        if (!proxyGeoRegionOrder.contains(geo)) geo,
    ];
    final activeGeo =
        stickyGeo ??
        (currentName.isEmpty ? null : inferProxyGeoRegion(currentName));

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: context.colorScheme.secondaryContainer.opacity60,
        shape: AppShape.md,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GlyphIcon(
                  AppGlyphs.bolt,
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
                        style: AppTextStyle.subheadline
                            .of(context)
                            .copyWith(
                              color: context.colorScheme.onSecondaryContainer,
                            ),
                      ),
                      Text(
                        hasOverride
                            ? l10n.autoGroupOverride(
                                selectedName ?? overrideName,
                              )
                            : l10n.autoGroupCurrent(currentName),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.footnote
                            .of(context)
                            .copyWith(
                              color: context
                                  .colorScheme
                                  .onSecondaryContainer
                                  .opacity80,
                            ),
                      ),
                      if (activeGeo != null)
                        Text(
                          _testingGeo != null
                              ? l10n.autoGroupTestingRegion(_testingGeo!)
                              : l10n.autoGroupStickyRegion(activeGeo),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.footnote
                              .of(context)
                              .copyWith(
                                color: context
                                    .colorScheme
                                    .onSecondaryContainer
                                    .opacity80,
                              ),
                        ),
                    ],
                  ),
                ),
                if (hasOverride && _testingGeo == null)
                  TextButton(
                    onPressed: _restoreAuto,
                    child: Text(l10n.restoreAutoSelect),
                  ),
              ],
            ),
            if (geos.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                l10n.autoGroupPickRegion,
                style: AppTextStyle.footnote
                    .of(context)
                    .copyWith(
                      color: context.colorScheme.onSecondaryContainer.opacity80,
                    ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final geo in geos)
                    _GeoChip(
                      label: l10n.autoGroupRegionNodes(
                        geo,
                        byGeo[geo]?.length ?? 0,
                      ),
                      selected: activeGeo == geo,
                      busy: _testingGeo == geo,
                      enabled: _testingGeo == null,
                      onPressed: () => _pickGeo(geo),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _GeoChip extends StatelessWidget {
  const _GeoChip({
    required this.label,
    required this.selected,
    required this.busy,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final bool busy;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final background = selected
        ? scheme.primary
        : scheme.surfaceContainerHighest;
    final foreground = selected ? scheme.onPrimary : scheme.onSurface;
    return PressSurface(
      fill: background,
      shape: AppShape.sm,
      foreground: foreground,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      inert: !enabled,
      selected: selected,
      onPressed: enabled ? onPressed : null,
      child: Text(
        busy ? '… $label' : label,
        style: AppTextStyle.footnote.of(context).copyWith(color: foreground),
      ),
    );
  }
}
