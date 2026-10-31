import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/service_probe.dart';
import 'package:fl_clash/features/features.dart';
import 'package:fl_clash/features/ip_quality/outbound_map.dart';
import 'package:fl_clash/providers/ip_quality.dart';
import 'package:fl_clash/providers/outbound_ip.dart';
import 'package:fl_clash/providers/routed_probe.dart';
import 'package:fl_clash/ui/color.dart';
import 'package:fl_clash/ui/context.dart';
import 'package:fl_clash/ui/icons/icons.dart';
import 'package:fl_clash/views/dashboard/layout.dart';
import 'package:fl_clash/views/dashboard/probe_start_hold.dart';
import 'package:fl_clash/views/dashboard/style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'card.dart';

/// The exit on the country map. Desktop keeps it in the grid; a phone adds
/// it like any other card. Tap opens the sheet.
class OutboundLocationCard extends ConsumerStatefulWidget {
  const OutboundLocationCard({super.key});

  @override
  ConsumerState<OutboundLocationCard> createState() =>
      _OutboundLocationCardState();
}

class _OutboundLocationCardState extends ConsumerState<OutboundLocationCard>
    with ProbeStartHold<OutboundLocationCard> {
  late final OutboundIpProbe _probe;

  @override
  void initState() {
    super.initState();
    _probe = ref.read(outboundIpProbeProvider.notifier)..watch(routedOutbound);
  }

  @override
  void dispose() {
    _probe.unwatch(routedOutbound);
    super.dispose();
  }

  void _refresh(String? ip) {
    _probe.refresh(const [routedOutbound]);
    if (ip != null && ref.read(ipQualityProvider(ip)).hasError) {
      ref.invalidate(ipQualityProvider(ip));
    }
  }

  @override
  Widget build(BuildContext context) {
    final density = DashboardDensityScope.of(context);
    final mobile = !density.isDesktop;
    final localizations = context.appLocalizations;
    final entry = ref.watch(
      outboundIpProbeProvider.select((state) => state.entryOf(routedOutbound)),
    );
    final info = entry.value;
    final phase = shownPhase(entry);
    final failed = phase == ProbePhase.failed && info == null;
    final probing = phase == ProbePhase.probing && info == null;
    final point = info == null ? null : resolveOutboundMapPoint(info);
    final code = info?.countryCode.trim().toUpperCase();
    final titleStyle = mobile
        ? DashboardText.mobileCardTitle(context)
        : DashboardText.cardTitle(context);
    final header = Padding(
      padding: dashboardCardPadding(density).copyWith(bottom: 8),
      child: DashboardCardHeader(
        glyph: AppGlyphs.pin,
        title: localizations.outboundLocation,
        chevron: info != null,
        trailing: [
          if (code != null && code.isNotEmpty)
            Text(
              code,
              style: titleStyle.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
    final Widget map;
    if (failed) {
      map = _StatusPane(
        title: localizations.serviceFailed,
        detail: localizations.tapToRetry,
        titleStyle: titleStyle.copyWith(color: context.colorScheme.error),
        detailStyle: DashboardText.label(context),
      );
    } else if (probing) {
      map = _StatusPane(
        title: localizations.loading,
        titleStyle: titleStyle.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
      );
    } else if (info == null) {
      map = _StatusPane(
        title: localizations.outboundLocationUnknown,
        detail: localizations.tapToRetry,
        titleStyle: titleStyle.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
        detailStyle: DashboardText.label(context),
      );
    } else {
      map = OutboundMapView(
        latitude: point?.$1,
        longitude: point?.$2,
        iso: code ?? '',
        label: code ?? '',
        framed: point != null,
      );
    }
    return DashboardCard(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      semanticLabel: localizations.outboundLocation,
      onTap: probing
          ? null
          : () {
              final known = info;
              if (known == null) {
                _refresh(null);
                return;
              }
              showOutboundLocationSheet(
                context,
                info: known,
                onRefresh: () => _refresh(known.ip),
              );
            },
      child: mobile
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header,
                AspectRatio(aspectRatio: 2, child: map),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header,
                Expanded(child: map),
              ],
            ),
    );
  }
}

class _StatusPane extends StatelessWidget {
  const _StatusPane({
    required this.title,
    required this.titleStyle,
    this.detail,
    this.detailStyle,
  });

  final String title;
  final TextStyle titleStyle;
  final String? detail;
  final TextStyle? detailStyle;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.surfaceContainerHighest.opacity38,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, textAlign: TextAlign.center, style: titleStyle),
              if (detail != null) ...[
                const SizedBox(height: 4),
                Text(detail!, textAlign: TextAlign.center, style: detailStyle),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
