import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/features/ip_quality/outbound_map.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/ui/icons/icons.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

Future<void> showOutboundLocationSheet(
  BuildContext context, {
  required IpInfo info,
  VoidCallback? onRefresh,
}) {
  if (isSheetPage(context)) {
    return Navigator.of(context).push(
      PagedSheetRoute(
        builder: (_) =>
            _OutboundLocationSheet(info: info, onRefresh: onRefresh),
      ),
    );
  }
  return showSheet<void>(
    context: context,
    builder: (_) => _OutboundLocationSheet(info: info, onRefresh: onRefresh),
  );
}

class _OutboundLocationSheet extends StatelessWidget {
  const _OutboundLocationSheet({required this.info, this.onRefresh});

  final IpInfo info;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final localizations = context.appLocalizations;
    return CommonScaffold(
      title: localizations.outboundLocation,
      actions: [
        if (onRefresh != null)
          AppBarActionButton(
            data: IconButtonData(
              glyph: AppGlyphs.refresh,
              tooltip: localizations.retry,
              onPressed: onRefresh,
            ),
          ),
      ],
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
          bottom: 20 + context.bottomInset,
          top: context.contentTopPadding,
        ),
        children: [
          _LocationHeadline(info: info),
          const SizedBox(height: 16),
          _LocationMapCard(info: info),
          const SizedBox(height: 16),
          generateSection(
            title: localizations.basicInfo,
            items: [
              DetailRow(
                title: localizations.ipAddress,
                copyText: info.ip,
                value: Text(info.ip),
              ),
              DetailRow(
                title: localizations.outboundLocationCountry,
                value: Text(info.countryCode.toUpperCase()),
              ),
              if (info.localityLabel != null)
                DetailRow(
                  title: localizations.outboundLocationLocality,
                  value: Text(info.localityLabel!),
                ),
              if (info.hasCoordinates)
                DetailRow(
                  title: localizations.outboundLocationCoordinates,
                  value: Text(
                    '${info.latitude!.toStringAsFixed(4)}, '
                    '${info.longitude!.toStringAsFixed(4)}',
                  ),
                ),
            ],
          ),
          if (isApproximateOutboundLocation(info))
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
              child: Text(
                localizations.outboundLocationApproximate,
                style: AppTextStyle.body
                    .of(context)
                    .copyWith(color: context.colorScheme.onSurfaceVariant),
              ),
            ),
        ],
      ),
    );
  }
}

class _LocationHeadline extends StatelessWidget {
  const _LocationHeadline({required this.info});

  final IpInfo info;

  @override
  Widget build(BuildContext context) {
    final locality = info.localityLabel;
    final title = locality ?? info.countryCode.toUpperCase();
    final subtitle = locality == null ? null : info.countryCode.toUpperCase();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.title2.of(context, emphasized: true)),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyle.subheadline
                .of(context)
                .copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
        ],
      ],
    );
  }
}

class _LocationMapCard extends StatelessWidget {
  const _LocationMapCard({required this.info});

  final IpInfo info;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final point = resolveOutboundMapPoint(info);
    final ocean = Color.alphaBlend(
      colorScheme.primary.withValues(alpha: 0.14),
      colorScheme.surface,
    );
    return DecoratedBox(
      decoration: ShapeDecoration(color: ocean, shape: AppShape.lg),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: AppShape.lg,
          textDirection: Directionality.of(context),
        ),
        child: AspectRatio(
          aspectRatio: 2,
          child: point == null
              ? Center(
                  child: Text(
                    context.appLocalizations.outboundLocationUnknown,
                    style: AppTextStyle.body
                        .of(context)
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                )
              : OutboundMapView(
                  latitude: point.$1,
                  longitude: point.$2,
                  iso: info.countryCode,
                  label: info.countryCode.toUpperCase(),
                  interactive: true,
                ),
        ),
      ),
    );
  }
}
