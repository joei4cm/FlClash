import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceReachability extends ConsumerStatefulWidget {
  const ServiceReachability({super.key});

  @override
  ConsumerState<ServiceReachability> createState() =>
      _ServiceReachabilityState();
}

class _ServiceReachabilityState extends ConsumerState<ServiceReachability> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(isStartProvider, (prev, next) {
      if (next == true && prev != true) {
        unawaited(ref.read(serviceReachabilityProvider.notifier).run());
      } else if (next == false) {
        ref.read(serviceReachabilityProvider.notifier).reset();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isStart = ref.read(isStartProvider);
      final state = ref.read(serviceReachabilityProvider);
      if (isStart && state.testedCount == 0 && !state.isRunning) {
        unawaited(ref.read(serviceReachabilityProvider.notifier).run());
      }
    });
  }

  String _categoryLabel(AppLocalizations l10n, ServiceProbeCategory category) {
    return switch (category) {
      ServiceProbeCategory.search => l10n.serviceProbeCategorySearch,
      ServiceProbeCategory.social => l10n.serviceProbeCategorySocial,
      ServiceProbeCategory.ai => l10n.serviceProbeCategoryAi,
      ServiceProbeCategory.streaming => l10n.serviceProbeCategoryStreaming,
      ServiceProbeCategory.general => l10n.serviceProbeCategoryGeneral,
    };
  }

  String _summaryText(
    AppLocalizations l10n,
    ServiceReachabilityState state,
    bool isStart,
  ) {
    if (!isStart) {
      return l10n.serviceProbeNeedStart;
    }
    if (state.proxyName == null || state.proxyName!.isEmpty) {
      return l10n.serviceProbeNoProxy;
    }
    if (state.isRunning) {
      return l10n.serviceProbeRunning;
    }
    if (state.testedCount == 0) {
      return l10n.serviceProbeTapToTest;
    }
    return l10n.serviceProbeSummary(state.successCount, state.failCount);
  }

  Future<void> _openDetails() async {
    final appLocalizations = context.appLocalizations;
    await showSheet(
      context: context,
      props: const SheetProps(isScrollControlled: true),
      builder: (_) {
        return AdaptiveSheetScaffold(
          title: appLocalizations.serviceReachability,
          body: const ServiceReachabilitySheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final isStart = ref.watch(isStartProvider);
    final state = ref.watch(serviceReachabilityProvider);
    return SizedBox(
      height: getWidgetHeight(2),
      child: CommonCard(
        info: Info(
          label: appLocalizations.serviceReachability,
          iconData: Icons.travel_explore,
        ),
        onPressed: _openDetails,
        child: Padding(
          padding: baseInfoEdgeInsets.copyWith(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      state.proxyName?.isNotEmpty == true
                          ? state.proxyName!
                          : appLocalizations.serviceProbeNoProxy,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: appLocalizations.delayTest,
                    onPressed: !isStart || state.isRunning
                        ? null
                        : () {
                            unawaited(
                              ref
                                  .read(serviceReachabilityProvider.notifier)
                                  .run(force: true),
                            );
                          },
                    icon: state.isRunning
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: context.colorScheme.primary,
                            ),
                          )
                        : const Icon(Icons.refresh, size: 20),
                  ),
                ],
              ),
              Text(
                _summaryText(appLocalizations, state, isStart),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.toLighter,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final category in ServiceProbeCategory.values)
                        _CategoryChip(
                          label: _categoryLabel(appLocalizations, category),
                          delay: state.categoryBestDelay(category),
                          hasFailure: state.categoryHasFailure(category),
                          loading: state.isRunning,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final int? delay;
  final bool hasFailure;
  final bool loading;

  const _CategoryChip({
    required this.label,
    required this.delay,
    required this.hasFailure,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final Color color;
    final String trailing;
    if (loading && delay == null) {
      color = context.colorScheme.outline;
      trailing = '…';
    } else if (delay != null && delay! > 0) {
      color = getDelayColor(delay) ?? context.colorScheme.primary;
      trailing = '${delay}ms';
    } else if (hasFailure) {
      color = Colors.red;
      trailing = '×';
    } else {
      color = context.colorScheme.outlineVariant;
      trailing = '-';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color.opacity15,
      ),
      child: Text(
        '$label $trailing',
        style: context.textTheme.labelSmall?.copyWith(color: color),
      ),
    );
  }
}

class ServiceReachabilitySheet extends ConsumerWidget {
  const ServiceReachabilitySheet({super.key});

  String _categoryLabel(AppLocalizations l10n, ServiceProbeCategory category) {
    return switch (category) {
      ServiceProbeCategory.search => l10n.serviceProbeCategorySearch,
      ServiceProbeCategory.social => l10n.serviceProbeCategorySocial,
      ServiceProbeCategory.ai => l10n.serviceProbeCategoryAi,
      ServiceProbeCategory.streaming => l10n.serviceProbeCategoryStreaming,
      ServiceProbeCategory.general => l10n.serviceProbeCategoryGeneral,
    };
  }

  String _delayLabel(int? value, AppLocalizations l10n) {
    if (value == null) {
      return '-';
    }
    if (value == 0) {
      return l10n.serviceProbeTesting;
    }
    if (value < 0) {
      return l10n.timeout;
    }
    return '${value}ms';
  }

  Future<void> _handleEnableAuto(BuildContext context, WidgetRef ref) async {
    final l10n = context.appLocalizations;
    final groups = ref.read(groupsProvider);
    final hasAuto = groups.any((group) => group.type.isComputedSelected);
    if (!hasAuto) {
      final confirmed = await dialogs.showMessage(
        title: l10n.enableAutoSelect,
        message: TextSpan(text: l10n.enableAutoSelectCreateTip),
      );
      if (confirmed != true) {
        return;
      }
    }
    final result = await enableAutoSelectWithContainer(ref);
    if (!context.mounted) {
      return;
    }
    final message = switch (result.message) {
      'no_profile' => l10n.nullProfileDesc,
      'create_failed' => l10n.enableAutoSelectFailed,
      _ when result.enabledExisting => l10n.enableAutoSelectRestored(
        result.groupName ?? '',
      ),
      _ when result.createdGroups => l10n.enableAutoSelectCreated(
        result.groupName ?? '',
      ),
      _ => l10n.enableAutoSelectFailed,
    };
    dialogs.showNotifier(message);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.appLocalizations;
    final isStart = ref.watch(isStartProvider);
    final state = ref.watch(serviceReachabilityProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.serviceProbeCurrentNode),
          subtitle: Text(
            state.proxyName?.isNotEmpty == true
                ? '${state.groupName ?? ''} · ${state.proxyName}'
                : l10n.serviceProbeNoProxy,
          ),
          trailing: IconButton(
            tooltip: l10n.serviceProbeTapToTest,
            onPressed: !isStart || state.isRunning
                ? null
                : () {
                    unawaited(
                      ref
                          .read(serviceReachabilityProvider.notifier)
                          .run(force: true),
                    );
                  },
            icon: state.isRunning
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
          ),
        ),
        Text(
          l10n.serviceProbeDisclaimer,
          style: context.textTheme.bodySmall?.toLighter,
        ),
        const SizedBox(height: 12),
        FilledButton.tonalIcon(
          onPressed: () => _handleEnableAuto(context, ref),
          icon: const Icon(Icons.auto_mode),
          label: Text(l10n.enableAutoSelect),
        ),
        const SizedBox(height: 16),
        for (final category in ServiceProbeCategory.values) ...[
          Text(
            _categoryLabel(l10n, category),
            style: context.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          for (final probe in category.probes)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(probe.brand),
              subtitle: Text(
                probe.url,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                _delayLabel(state.results[probe.id], l10n),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: getDelayColor(state.results[probe.id]),
                ),
              ),
            ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
