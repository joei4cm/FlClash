import 'dart:math' as math;

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/ui/ui.dart';
import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';

/// The country map shared by the exit sheet and the dashboard card.
///
/// [framed] keeps the exit in view for a small card. [interactive] is the
/// sheet: scroll, pinch, and double-tap zoom, starting from the whole world.
class OutboundMapView extends StatefulWidget {
  const OutboundMapView({
    super.key,
    this.latitude,
    this.longitude,
    this.iso = '',
    this.label = '',
    this.interactive = false,
    this.framed = false,
  });

  final double? latitude;
  final double? longitude;
  final String iso;
  final String label;
  final bool interactive;
  final bool framed;

  @override
  State<OutboundMapView> createState() => _OutboundMapViewState();
}

class _OutboundMapViewState extends State<OutboundMapView>
    with SingleTickerProviderStateMixin {
  static const _minScale = 1.0;
  static const _maxScale = 8.0;

  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );
  WorldMapData? _map;
  var _scale = _minScale;
  var _translation = Offset.zero;
  var _gestureScale = _minScale;
  var _gestureTranslation = Offset.zero;
  var _gestureFocal = Offset.zero;
  Size? _pathSize;
  List<Path>? _countryPaths;
  Offset _doubleTapFocal = Offset.zero;

  @override
  void initState() {
    super.initState();
    _loadMap();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.disableAnimations) {
      _pulse
        ..stop()
        ..value = 0;
    } else if (!_pulse.isAnimating) {
      _pulse.repeat();
    }
  }

  Future<void> _loadMap() async {
    final map = await WorldMapData.load();
    if (mounted) {
      setState(() => _map = map);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  List<Path> _paths(Size size, WorldMapData map) {
    if (_countryPaths != null && _pathSize == size) {
      return _countryPaths!;
    }
    _pathSize = size;
    return _countryPaths = [
      for (final country in map.countries) country.path(size),
    ];
  }

  void _zoomAt(Offset focal, double nextScale, Size viewport) {
    final scale = nextScale.clamp(_minScale, _maxScale);
    final mapPoint = (focal - _translation) / _scale;
    setState(() {
      _scale = scale;
      _translation = focal - mapPoint * scale;
      _clamp(viewport);
    });
  }

  void _scaleFromGesture(Offset focal, double nextScale, Size viewport) {
    final scale = nextScale.clamp(_minScale, _maxScale);
    final mapPoint = (_gestureFocal - _gestureTranslation) / _gestureScale;
    setState(() {
      _scale = scale;
      _translation = focal - mapPoint * scale;
      _clamp(viewport);
    });
  }

  void _clamp(Size viewport) {
    final minX = viewport.width * (1 - _scale);
    final minY = viewport.height * (1 - _scale);
    _translation = Offset(
      _translation.dx.clamp(minX, 0),
      _translation.dy.clamp(minY, 0),
    );
  }

  (double, Offset) _view(Size viewport) {
    final latitude = widget.latitude;
    final longitude = widget.longitude;
    if (widget.framed && latitude != null && longitude != null) {
      return frameOutboundMap(
        viewport: viewport,
        latitude: latitude,
        longitude: longitude,
      );
    }
    return (_scale, _translation);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final ocean = Color.alphaBlend(
      colorScheme.primary.withValues(alpha: 0.14),
      colorScheme.surface,
    );
    final latitude = widget.latitude;
    final longitude = widget.longitude;
    final iso = widget.iso.trim().toUpperCase();
    return ColoredBox(
      color: ocean,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final viewport = Size(constraints.maxWidth, constraints.maxHeight);
          final map = _map;
          final (scale, translation) = _view(viewport);
          final canvas = _MapCanvas(
            map: map,
            paths: map == null ? const [] : _paths(viewport, map),
            latitude: latitude,
            longitude: longitude,
            scale: scale,
            translation: translation,
            pulse: _pulse,
            iso: iso,
            ocean: ocean,
            land: colorScheme.surfaceContainerHigh,
            highlight: colorScheme.primary.withValues(alpha: 0.55),
            border: colorScheme.outlineVariant,
            grid: colorScheme.outlineVariant.withValues(alpha: 0.28),
            pin: colorScheme.primary,
            label: widget.label,
            labelStyle: AppTextStyle.caption2
                .of(context, emphasized: true)
                .copyWith(color: colorScheme.onPrimary),
          );
          if (!widget.interactive || widget.framed || map == null) {
            return canvas;
          }
          return Listener(
            onPointerSignal: (event) {
              if (event is! PointerScrollEvent) {
                return;
              }
              final factor = math.exp(-event.scrollDelta.dy / 200);
              _zoomAt(event.localPosition, _scale * factor, viewport);
            },
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: (details) {
                _gestureScale = _scale;
                _gestureTranslation = _translation;
                _gestureFocal = details.localFocalPoint;
              },
              onScaleUpdate: (details) {
                _scaleFromGesture(
                  details.localFocalPoint,
                  _gestureScale * details.scale,
                  viewport,
                );
              },
              onDoubleTapDown: (details) =>
                  _doubleTapFocal = details.localPosition,
              onDoubleTap: () => _zoomAt(
                _doubleTapFocal,
                _scale < 2 ? 3 : _minScale,
                viewport,
              ),
              child: canvas,
            ),
          );
        },
      ),
    );
  }
}

class _MapCanvas extends StatelessWidget {
  const _MapCanvas({
    required this.map,
    required this.paths,
    required this.latitude,
    required this.longitude,
    required this.scale,
    required this.translation,
    required this.pulse,
    required this.iso,
    required this.ocean,
    required this.land,
    required this.highlight,
    required this.border,
    required this.grid,
    required this.pin,
    required this.label,
    required this.labelStyle,
  });

  final WorldMapData? map;
  final List<Path> paths;
  final double? latitude;
  final double? longitude;
  final double scale;
  final Offset translation;
  final Animation<double> pulse;
  final String iso;
  final Color ocean;
  final Color land;
  final Color highlight;
  final Color border;
  final Color grid;
  final Color pin;
  final String label;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    final map = this.map;
    final latitude = this.latitude;
    final longitude = this.longitude;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (map != null)
          RepaintBoundary(
            child: CustomPaint(
              painter: _CountryMapPainter(
                countries: map.countries,
                paths: paths,
                scale: scale,
                translation: translation,
                iso: iso,
                ocean: ocean,
                land: land,
                highlight: highlight,
                border: border,
                grid: grid,
              ),
              child: const SizedBox.expand(),
            ),
          )
        else
          const SizedBox.expand(),
        if (latitude != null && longitude != null)
          AnimatedBuilder(
            animation: pulse,
            builder: (context, _) => CustomPaint(
              painter: _LocationPinPainter(
                latitude: latitude,
                longitude: longitude,
                scale: scale,
                translation: translation,
                pulse: Curves.easeOut.transform(pulse.value),
                pin: pin,
                label: label,
                labelStyle: labelStyle,
              ),
              child: const SizedBox.expand(),
            ),
          ),
      ],
    );
  }
}

class _CountryMapPainter extends CustomPainter {
  const _CountryMapPainter({
    required this.countries,
    required this.paths,
    required this.scale,
    required this.translation,
    required this.iso,
    required this.ocean,
    required this.land,
    required this.highlight,
    required this.border,
    required this.grid,
  });

  final List<WorldCountry> countries;
  final List<Path> paths;
  final double scale;
  final Offset translation;
  final String iso;
  final Color ocean;
  final Color land;
  final Color highlight;
  final Color border;
  final Color grid;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = ocean);
    canvas
      ..save()
      ..translate(translation.dx, translation.dy)
      ..scale(scale);
    _paintGrid(canvas, size);
    final landPaint = Paint()..color = land;
    final highlightPaint = Paint()..color = highlight;
    for (var index = 0; index < paths.length; index++) {
      canvas.drawPath(
        paths[index],
        countries[index].iso == iso && iso.isNotEmpty
            ? highlightPaint
            : landPaint,
      );
    }
    final borderPaint = Paint()
      ..color = border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6 / scale;
    for (final path in paths) {
      canvas.drawPath(path, borderPaint);
    }
    canvas.restore();
  }

  void _paintGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = grid
      ..strokeWidth = 1 / scale;
    for (var longitude = -150.0; longitude <= 150; longitude += 30) {
      final x = outboundLatLonToOffset(0, longitude, size).dx;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var latitude = -60.0; latitude <= 60; latitude += 30) {
      final y = outboundLatLonToOffset(latitude, 0, size).dy;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CountryMapPainter oldDelegate) {
    return oldDelegate.scale != scale ||
        oldDelegate.translation != translation ||
        oldDelegate.iso != iso ||
        oldDelegate.ocean != ocean ||
        oldDelegate.land != land ||
        oldDelegate.highlight != highlight ||
        oldDelegate.border != border ||
        oldDelegate.grid != grid ||
        !identical(oldDelegate.paths, paths);
  }
}

class _LocationPinPainter extends CustomPainter {
  const _LocationPinPainter({
    required this.latitude,
    required this.longitude,
    required this.scale,
    required this.translation,
    required this.pulse,
    required this.pin,
    required this.label,
    required this.labelStyle,
  });

  final double latitude;
  final double longitude;
  final double scale;
  final Offset translation;
  final double pulse;
  final Color pin;
  final String label;
  final TextStyle labelStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final mapPoint = outboundLatLonToOffset(latitude, longitude, size);
    final marker = mapPoint * scale + translation;
    canvas.drawCircle(
      marker,
      18 + 22 * pulse,
      Paint()..color = pin.withValues(alpha: 0.18 * (1 - pulse)),
    );
    canvas.drawCircle(marker, 7.5, Paint()..color = pin);
    canvas.drawCircle(
      marker,
      3.2,
      Paint()..color = Color.lerp(pin, Colors.white, 0.85)!,
    );
    if (label.isEmpty) {
      return;
    }
    _paintLabel(canvas, marker, size);
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
      origin.dx.clamp(8, math.max(8, size.width - badgeSize.width - 8)),
      origin.dy.clamp(8, math.max(8, size.height - badgeSize.height - 8)),
    );
    final badge = RSuperellipse.fromRectAndRadius(
      origin & badgeSize,
      const Radius.circular(AppCorner.full),
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
  bool shouldRepaint(covariant _LocationPinPainter oldDelegate) {
    return oldDelegate.latitude != latitude ||
        oldDelegate.longitude != longitude ||
        oldDelegate.scale != scale ||
        oldDelegate.translation != translation ||
        oldDelegate.pulse != pulse ||
        oldDelegate.pin != pin ||
        oldDelegate.label != label;
  }
}
