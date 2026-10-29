import 'package:fl_clash/common/common.dart';
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

class _LocationMapCard extends StatefulWidget {
  const _LocationMapCard({required this.info});

  final IpInfo info;

  @override
  State<_LocationMapCard> createState() => _LocationMapCardState();
}

class _LocationMapCardState extends State<_LocationMapCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final point = resolveOutboundMapPoint(widget.info);
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colorScheme.surfaceContainerHighest,
        shape: AppShape.lg,
      ),
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
              : InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: AnimatedBuilder(
                    animation: _pulse,
                    builder: (context, _) => CustomPaint(
                      painter: _OutboundWorldMapPainter(
                        latitude: point.$1,
                        longitude: point.$2,
                        ocean: Color.alphaBlend(
                          colorScheme.primary.withValues(alpha: 0.06),
                          colorScheme.surfaceContainerHighest,
                        ),
                        land: colorScheme.surfaceContainer,
                        grid: colorScheme.outlineVariant.withValues(
                          alpha: 0.35,
                        ),
                        pin: colorScheme.primary,
                        pulse: Curves.easeOut.transform(_pulse.value),
                        label: widget.info.countryCode.toUpperCase(),
                        labelStyle: AppTextStyle.caption2
                            .of(context, emphasized: true)
                            .copyWith(color: colorScheme.onPrimary),
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _OutboundWorldMapPainter extends CustomPainter {
  const _OutboundWorldMapPainter({
    required this.latitude,
    required this.longitude,
    required this.ocean,
    required this.land,
    required this.grid,
    required this.pin,
    required this.pulse,
    required this.label,
    required this.labelStyle,
  });

  final double latitude;
  final double longitude;
  final Color ocean;
  final Color land;
  final Color grid;
  final Color pin;
  final double pulse;
  final String label;
  final TextStyle labelStyle;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = ocean);
    _paintLand(canvas, size);
    _paintGrid(canvas, size);
    final marker = outboundLatLonToOffset(latitude, longitude, size);
    final ring = Paint()
      ..color = pin.withValues(alpha: 0.18 * (1 - pulse))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(marker, 18 + 22 * pulse, ring);
    canvas.drawCircle(marker, 7.5, Paint()..color = pin);
    canvas.drawCircle(
      marker,
      3.2,
      Paint()..color = Color.lerp(pin, Colors.white, 0.85)!,
    );
    _paintLabel(canvas, marker, size);
  }

  void _paintGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = grid
      ..strokeWidth = 1;
    for (var lon = -150.0; lon <= 150; lon += 30) {
      final x = outboundLatLonToOffset(0, lon, size).dx;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var lat = -60.0; lat <= 60; lat += 30) {
      final y = outboundLatLonToOffset(lat, 0, size).dy;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  /// Simplified continental blobs — enough silhouette for orientation, not a
  /// cartographic survey.
  void _paintLand(Canvas canvas, Size size) {
    final paint = Paint()..color = land;
    for (final continent in _continents) {
      final path = Path();
      for (var i = 0; i < continent.length; i++) {
        final point = outboundLatLonToOffset(
          continent[i].$1,
          continent[i].$2,
          size,
        );
        if (i == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  void _paintLabel(Canvas canvas, Offset marker, Size size) {
    final painter = TextPainter(
      text: TextSpan(text: label, style: labelStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    final badgeSize = Size(painter.width + 14, painter.height + 8);
    var origin = Offset(marker.dx + 12, marker.dy - badgeSize.height - 8);
    origin = Offset(
      origin.dx.clamp(8, size.width - badgeSize.width - 8),
      origin.dy.clamp(8, size.height - badgeSize.height - 8),
    );
    final badge = RSuperellipse.fromRectAndRadius(
      origin & badgeSize,
      const Radius.circular(999),
    );
    canvas.drawRSuperellipse(badge, Paint()..color = pin);
    painter.paint(
      canvas,
      Offset(
        origin.dx + (badgeSize.width - painter.width) / 2,
        origin.dy + (badgeSize.height - painter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _OutboundWorldMapPainter oldDelegate) {
    return oldDelegate.latitude != latitude ||
        oldDelegate.longitude != longitude ||
        oldDelegate.pulse != pulse ||
        oldDelegate.ocean != ocean ||
        oldDelegate.land != land ||
        oldDelegate.pin != pin ||
        oldDelegate.label != label;
  }
}

const _continents = <List<(double, double)>>[
  // North America
  [
    (70, -165),
    (70, -50),
    (50, -55),
    (30, -80),
    (15, -90),
    (8, -78),
    (15, -100),
    (30, -115),
    (50, -130),
    (60, -150),
  ],
  // South America
  [(12, -75), (5, -35), (-55, -70), (-20, -70), (0, -80)],
  // Europe + Africa
  [
    (70, -10),
    (70, 40),
    (40, 40),
    (35, 10),
    (-35, 20),
    (-35, 40),
    (0, 50),
    (15, 15),
    (35, -5),
    (55, -10),
  ],
  // Asia
  [(70, 40), (70, 180), (40, 145), (10, 120), (0, 100), (25, 60), (40, 45)],
  // Australia
  [(-10, 115), (-15, 150), (-40, 150), (-35, 115)],
];
