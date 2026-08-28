import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _dayThresholdMs = Duration.millisecondsPerDay;
const _widthAnimationDuration = Duration(milliseconds: 200);
const _buttonHeight = 56.0;

TextStyle? _runTimeTextStyle(BuildContext context) {
  return context.textTheme.titleMedium?.toSoftBold.copyWith(
    color: context.colorScheme.onPrimaryContainer,
  );
}

TextStyle? _leadingTextStyle(BuildContext context) {
  return context.textTheme.titleMedium?.toSoftBold.copyWith(
    color: context.colorScheme.primary,
    fontWeight: FontWeight.w600,
  );
}

/// [Measure.computeTextSize] only reads [Text.data], so use plain [Text].
double _measureRunTimeWidth(BuildContext context, {required bool hasDays}) {
  final clockWidth = globalState.measure
      .computeTextSize(
        Text('23:59:59', style: _runTimeTextStyle(context)),
      )
      .width;
  if (!hasDays) {
    return clockWidth + 16;
  }
  // Wide enough for multi-week uptimes such as `999d 23:59:59`.
  final dayWidth = globalState.measure
      .computeTextSize(
        Text('999d ', style: _leadingTextStyle(context)),
      )
      .width;
  return dayWidth + clockWidth + 16;
}

class RunTimeText extends StatelessWidget {
  final int? timeStamp;

  const RunTimeText({super.key, required this.timeStamp});

  @override
  Widget build(BuildContext context) {
    final text = utils.getTimeText(timeStamp);
    final style = _runTimeTextStyle(context);
    final daySeparator = text.indexOf('d ');
    if (daySeparator < 0) {
      return Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.visible,
        style: style,
      );
    }
    return Text.rich(
      TextSpan(
        text: text.substring(0, daySeparator + 2),
        style: _leadingTextStyle(context),
        children: [
          TextSpan(
            text: text.substring(daySeparator + 2),
            style: style,
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.visible,
      style: style,
    );
  }
}

class StartButton extends ConsumerStatefulWidget {
  const StartButton({super.key});

  @override
  ConsumerState<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends ConsumerState<StartButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;
  final ValueNotifier<int?> _displayRunTime = ValueNotifier<int?>(null);
  double? _clockTextWidth;
  double? _dayTextWidth;
  double? _suspendedTextWidth;

  @override
  void initState() {
    super.initState();
    final isStart = ref.read(isStartProvider);
    _displayRunTime.value = ref.read(runTimeProvider);
    _controller = AnimationController(
      vsync: this,
      value: isStart ? 1 : 0,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOutBack,
    );
    ref.listenManual(runTimeProvider, (_, next) {
      _updateDisplayRunTime(next);
    });
    ref.listenManual(isStartProvider, (prev, next) {
      updateController(next);
    }, fireImmediately: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _clockTextWidth = null;
    _dayTextWidth = null;
    _suspendedTextWidth = null;
  }

  @override
  void dispose() {
    _displayRunTime.dispose();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  void handleSwitchStart() {
    ref.read(commonActionProvider.notifier).toggleRunning();
  }

  void _updateDisplayRunTime(int? runTime) {
    if (!mounted ||
        _displayRunTime.value == runTime ||
        (runTime == null && !(_controller?.isDismissed ?? true))) {
      return;
    }
    final wasMultiDay = (_displayRunTime.value ?? 0) >= _dayThresholdMs;
    final isMultiDay = (runTime ?? 0) >= _dayThresholdMs;
    _displayRunTime.value = runTime;
    // Only rebuild the FAB chrome when the width template must change.
    if (wasMultiDay != isMultiDay && mounted) {
      setState(() {});
    }
  }

  void updateController(bool isStart) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final controller = _controller;
      if (controller == null) {
        return;
      }
      if (isStart) {
        controller.forward();
        return;
      }
      controller.reverse().whenCompleteOrCancel(() {
        if (mounted && controller.isDismissed) {
          _updateDisplayRunTime(ref.read(runTimeProvider));
        }
      });
    });
  }

  double _getRunTimeTextWidth(
    BuildContext context, {
    required bool hasDays,
  }) {
    if (hasDays) {
      return _dayTextWidth ??= _measureRunTimeWidth(context, hasDays: true);
    }
    return _clockTextWidth ??= _measureRunTimeWidth(context, hasDays: false);
  }

  double _getSuspendedTextWidth(BuildContext context, String suspendedText) {
    return _suspendedTextWidth ??=
        globalState.measure
            .computeTextSize(
              Text(suspendedText, style: context.textTheme.titleMedium),
            )
            .width +
        24;
  }

  @override
  Widget build(BuildContext context) {
    final hasProfile = ref.watch(
      profilesProvider.select((state) => state.isNotEmpty),
    );
    if (!hasProfile) {
      return Container();
    }
    final suspend = ref.watch(suspendProvider);
    final hasDays = (_displayRunTime.value ?? 0) >= _dayThresholdMs;
    final theme = Theme.of(context);
    final appLocalizations = context.appLocalizations;
    final textWidth = suspend
        ? _getSuspendedTextWidth(context, appLocalizations.suspended)
        : _getRunTimeTextWidth(context, hasDays: hasDays);
    return RepaintBoundary(
      child: Theme(
        data: theme.copyWith(
          floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
            sizeConstraints: const BoxConstraints(
              minWidth: 56,
              // Room for `999d 23:59:59` plus Curves.easeOutBack overshoot.
              maxWidth: 360,
              minHeight: _buttonHeight,
              maxHeight: _buttonHeight,
            ),
          ),
        ),
        child: FloatingActionButton(
          clipBehavior: Clip.antiAlias,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          heroTag: null,
          onPressed: () {
            handleSwitchStart();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (_, child) {
                  return Container(
                    height: _buttonHeight,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16 - 8 * _animation.value,
                    ),
                    alignment: Alignment.centerLeft,
                    child: child,
                  );
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: _animation,
                ),
              ),
              SizeTransition(
                axis: Axis.horizontal,
                alignment: Alignment.centerLeft,
                sizeFactor: _animation,
                child: AnimatedContainer(
                  width: textWidth,
                  duration: _widthAnimationDuration,
                  curve: Curves.easeOut,
                  child: suspend
                      ? Text(
                          appLocalizations.suspended,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: context.colorScheme.onPrimaryContainer,
                              ),
                        )
                      : ValueListenableBuilder<int?>(
                          valueListenable: _displayRunTime,
                          builder: (_, runTime, _) {
                            return RunTimeText(timeStamp: runTime);
                          },
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
