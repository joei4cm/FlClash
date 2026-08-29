import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeoIdentityView extends ConsumerStatefulWidget {
  const GeoIdentityView({super.key});

  @override
  ConsumerState<GeoIdentityView> createState() => _GeoIdentityViewState();
}

class _GeoIdentityViewState extends ConsumerState<GeoIdentityView> {
  bool _busy = false;
  String? _statusMessage;
  GeoIdentityNetworkReport? _report;
  CancelToken? _cancelToken;
  String? _timezoneNote;
  bool _copiedProxyExports = false;

  @override
  void initState() {
    super.initState();
    ref.listenManual(isStartProvider, (prev, next) {
      if (!mounted) {
        return;
      }
      final enabled = ref.read(geoIdentitySettingProvider).enable;
      if (!enabled) {
        return;
      }
      if (prev != true && next == true) {
        _validateNetwork(quiet: true);
      } else if (next == false) {
        setState(() {
          _report = null;
          _statusMessage = context.appLocalizations.geoIdentityNeedStart;
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final enabled = ref.read(geoIdentitySettingProvider).enable;
      if (enabled && ref.read(isStartProvider)) {
        _validateNetwork(quiet: true);
      } else if (enabled && mounted) {
        setState(() {
          _statusMessage = context.appLocalizations.geoIdentityNeedStart;
        });
      }
    });
  }

  @override
  void dispose() {
    _cancelToken?.cancel();
    super.dispose();
  }

  String _localizeCheckError(String raw) {
    final l10n = context.appLocalizations;
    if (raw == 'cancelled' || raw.toLowerCase().contains('cancel')) {
      return l10n.geoIdentityCheckCancelled;
    }
    return l10n.geoIdentityCheckFailed;
  }

  String _messageForReport(GeoIdentityNetworkReport report) {
    final l10n = context.appLocalizations;
    if (report.isProtected) {
      return l10n.geoIdentityNetworkGood;
    }
    if (!report.looksUsExit) {
      return l10n.geoIdentityNetworkBad;
    }
    return l10n.geoIdentityNetworkExposed;
  }

  Future<void> _copyTerminalProxyExports({bool notify = true}) async {
    final mixedPort = ref.read(
      patchClashConfigProvider.select((state) => state.mixedPort),
    );
    final text = system.isWindows
        ? GeoIdentityHost.buildTerminalProxyExportsPowerShell(
            mixedPort: mixedPort,
          )
        : GeoIdentityHost.buildTerminalProxyExports(mixedPort: mixedPort);
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) {
      return;
    }
    setState(() => _copiedProxyExports = true);
    if (notify) {
      context.showNotifier(context.appLocalizations.copySuccess);
    }
  }

  Future<void> _awaitCaptureReady() async {
    final deadline = DateTime.now().add(const Duration(seconds: 6));
    while (DateTime.now().isBefore(deadline)) {
      if (!mounted) {
        return;
      }
      if (!ref.read(isStartProvider)) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        continue;
      }
      if (system.isDesktop) {
        final systemProxy = ref.read(networkSettingProvider).systemProxy;
        final tunReady = ref.read(autoSetSystemDnsStateProvider).tunReady;
        if (systemProxy || tunReady) {
          await Future<void>.delayed(const Duration(milliseconds: 400));
          return;
        }
      } else {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
  }

  Future<GeoIdentityNetworkReport?> _validateNetwork({
    bool quiet = false,
  }) async {
    final l10n = context.appLocalizations;
    if (!ref.read(isStartProvider)) {
      if (mounted) {
        setState(() {
          _report = null;
          _statusMessage = l10n.geoIdentityNeedStart;
          if (!quiet) {
            _busy = false;
          }
        });
      }
      return null;
    }
    final props = ref.read(geoIdentitySettingProvider);
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    if (mounted) {
      setState(() {
        _busy = true;
        _statusMessage = l10n.geoIdentitySetupVerifying;
      });
    }
    final result = await request.checkGeoIdentity(
      acceptLanguage: props.useUsAcceptLanguage
          ? geoIdentityUsAcceptLanguage
          : null,
      cancelToken: _cancelToken,
    );
    if (!mounted) {
      return null;
    }
    if (result.isError || result.data == null) {
      setState(() {
        _busy = false;
        _report = null;
        _statusMessage = result.isError
            ? _localizeCheckError(result.message)
            : l10n.geoIdentityCheckFailed;
      });
      return null;
    }
    final report = result.data!;
    setState(() {
      _busy = false;
      _report = report;
      _statusMessage = _messageForReport(report);
    });
    return report;
  }

  Future<String?> _alignOsTimezoneIfNeeded() async {
    if (system.isAndroid) {
      return null;
    }
    final target = _report?.timezone;
    if (target == null || target.isEmpty) {
      return context.appLocalizations.geoIdentityTimezoneMissing;
    }
    final previous =
        await GeoIdentityHost.readOsTimezoneId() ??
        ref.read(geoIdentitySettingProvider).previousOsTimezone;
    final error = await GeoIdentityHost.setOsTimezone(target);
    if (!mounted) {
      return error;
    }
    if (error != null) {
      return error;
    }
    ref
        .read(geoIdentitySettingProvider.notifier)
        .setTimezoneHistory(
          previousOsTimezone: previous,
          appliedOsTimezone: target,
        );
    return null;
  }

  Future<void> _restoreOsTimezoneIfNeeded({bool notify = false}) async {
    if (system.isAndroid) {
      return;
    }
    final previous = ref.read(geoIdentitySettingProvider).previousOsTimezone;
    if (previous == null || previous.isEmpty) {
      if (notify && mounted) {
        context.showNotifier(
          context.appLocalizations.geoIdentityTimezoneNothingToRestore,
        );
      }
      return;
    }
    final error = await GeoIdentityHost.setOsTimezone(previous);
    if (error == null && mounted) {
      ref.read(geoIdentitySettingProvider.notifier).clearTimezoneHistory();
      setState(() => _timezoneNote = null);
      if (notify) {
        context.showNotifier(
          context.appLocalizations.geoIdentityTimezoneRestored(previous),
        );
      }
    } else if (notify && mounted && error != null) {
      context.showNotifier(
        context.appLocalizations.geoIdentityTimezoneAlignFailed(error),
      );
    }
  }

  bool get _hasVirtualNicCapture {
    if (system.isAndroid) {
      return ref.read(vpnSettingProvider).enable;
    }
    final tunEnable = ref.read(patchClashConfigProvider).tun.enable;
    final authorized =
        ref.read(authorizedTunEnableProvider) ==
        TunAuthorizationState.authorized;
    return tunEnable && authorized;
  }

  /// Full checklist when turning protect ON.
  Future<void> _enableProtect() async {
    final l10n = context.appLocalizations;
    setState(() {
      _busy = true;
      _statusMessage = l10n.geoIdentitySetupRunning;
      _report = null;
      _timezoneNote = null;
      _copiedProxyExports = false;
    });

    try {
      final geoNotifier = ref.read(geoIdentitySettingProvider.notifier);
      geoNotifier.setEnable(true);
      geoNotifier.setUseUsAcceptLanguage(true);

      final capture = resolveGeoIdentityCaptureActions(
        mode: ref.read(geoIdentitySettingProvider).captureMode,
        isDesktop: system.isDesktop,
        currentSystemProxy: ref.read(networkSettingProvider).systemProxy,
        currentTunEnable: ref.read(patchClashConfigProvider).tun.enable,
        currentVpnEnable: ref.read(vpnSettingProvider).enable,
      );
      if (capture.setSystemProxy == true) {
        ref
            .read(networkSettingProvider.notifier)
            .update((state) => state.copyWith(systemProxy: true));
      }
      if (capture.setTunEnable == true) {
        ref
            .read(patchClashConfigProvider.notifier)
            .update((state) => state.copyWith.tun(enable: true));
      }
      if (capture.setVpnEnable == true) {
        ref
            .read(vpnSettingProvider.notifier)
            .update((state) => state.copyWith(enable: true));
      }

      if (!ref.read(isStartProvider)) {
        setState(() => _statusMessage = l10n.geoIdentitySetupStarting);
        await ref.read(setupActionProvider.notifier).setRunning(true);
      } else {
        await ref
            .read(setupActionProvider.notifier)
            .applyProfile(silence: true);
      }
      if (!mounted) {
        return;
      }
      await _awaitCaptureReady();
      if (!mounted) {
        return;
      }

      final report = await _validateNetwork(quiet: true);
      if (!mounted) {
        return;
      }

      if (system.isDesktop) {
        setState(() => _statusMessage = l10n.geoIdentitySetupTimezone);
        final timezoneError = await _alignOsTimezoneIfNeeded();
        if (timezoneError != null && mounted) {
          setState(() => _timezoneNote = timezoneError);
        }
      }

      if (!_hasVirtualNicCapture) {
        await _copyTerminalProxyExports(notify: false);
      }

      if (!mounted) {
        return;
      }
      final protected = report?.isProtected == true;
      setState(() {
        _busy = false;
        _statusMessage = report == null
            ? (_statusMessage ?? l10n.geoIdentityCheckFailed)
            : _messageForReport(report);
      });
      if (protected) {
        context.showNotifier(l10n.geoIdentitySetupDoneProtected);
      } else if (report == null) {
        context.showNotifier(l10n.geoIdentityCheckFailed);
      } else if (!report.looksUsExit) {
        context.showNotifier(l10n.geoIdentitySetupDoneNeedUsNode);
      } else {
        context.showNotifier(l10n.geoIdentityNetworkExposed);
      }
      if (_timezoneNote != null) {
        context.showNotifier(
          l10n.geoIdentityTimezoneAlignFailed(_timezoneNote!),
        );
      } else if (_copiedProxyExports) {
        context.showNotifier(l10n.copySuccess);
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      ref.read(geoIdentitySettingProvider.notifier).setEnable(false);
      setState(() {
        _busy = false;
        _report = null;
        _statusMessage = _localizeCheckError(e.toString());
      });
      context.showNotifier(_localizeCheckError(e.toString()));
    }
  }

  Future<void> _disableProtect() async {
    final l10n = context.appLocalizations;
    setState(() {
      _busy = true;
      _statusMessage = l10n.geoIdentityTurningOff;
    });
    ref.read(geoIdentitySettingProvider.notifier).setEnable(false);
    await _restoreOsTimezoneIfNeeded();
    if (!mounted) {
      return;
    }
    setState(() {
      _busy = false;
      _report = null;
      _timezoneNote = null;
      _copiedProxyExports = false;
      _statusMessage = l10n.geoIdentityOffStatus;
    });
  }

  Future<void> _handleToggle(bool enable) async {
    if (_busy) {
      return;
    }
    if (enable) {
      await _enableProtect();
    } else {
      await _disableProtect();
    }
  }

  Widget _buildStatusBanner(BuildContext context) {
    final l10n = context.appLocalizations;
    final enabled = ref.watch(geoIdentitySettingProvider).enable;
    final isStart = ref.watch(isStartProvider);
    final protected = _report?.isProtected == true;
    final Color accent;
    final IconData icon;
    final String title;
    if (_busy) {
      accent = context.colorScheme.tertiary;
      icon = Icons.hourglass_top_outlined;
      title = _statusMessage ?? l10n.geoIdentitySetupRunning;
    } else if (!enabled) {
      accent = context.colorScheme.onSurfaceVariant;
      icon = Icons.shield_outlined;
      title = _statusMessage ?? l10n.geoIdentityOffStatus;
    } else if (!isStart) {
      accent = context.colorScheme.tertiary;
      icon = Icons.play_circle_outline;
      title = _statusMessage ?? l10n.geoIdentityNeedStart;
    } else if (_report == null) {
      accent = context.colorScheme.tertiary;
      icon = Icons.info_outline;
      title = _statusMessage ?? l10n.geoIdentityPendingCheck;
    } else if (protected) {
      accent = context.colorScheme.primary;
      icon = Icons.verified_user_outlined;
      title = l10n.geoIdentityNetworkGood;
    } else {
      accent = context.colorScheme.error;
      icon = Icons.warning_amber_outlined;
      title = _statusMessage ?? _messageForReport(_report!);
    }

    final detail = _report == null
        ? null
        : [
            if (_report!.country != null) _report!.country,
            if (_report!.timezone != null) _report!.timezone,
            '${_report!.band} · ${_report!.score}',
          ].whereType<String>().join(' · ');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: accent.opacity12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (_busy)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: accent,
                    ),
                  )
                else
                  Icon(icon, color: accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (enabled && !_busy && !isStart)
                  TextButton(
                    onPressed: () {
                      ref.read(setupActionProvider.notifier).setRunning(true);
                    },
                    child: Text(l10n.start),
                  ),
                if (enabled &&
                    !_busy &&
                    isStart &&
                    _report != null &&
                    _report!.isProtected != true)
                  TextButton(
                    onPressed: () {
                      ref
                          .read(currentPageLabelProvider.notifier)
                          .toPage(PageLabel.proxies);
                    },
                    child: Text(l10n.proxies),
                  ),
                if (enabled && !_busy)
                  TextButton(
                    onPressed: () => _validateNetwork(),
                    child: Text(l10n.geoIdentityRecheck),
                  ),
              ],
            ),
            if (detail != null) ...[
              const SizedBox(height: 8),
              Text(
                detail,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (_timezoneNote != null) ...[
              const SizedBox(height: 8),
              Text(
                l10n.geoIdentityTimezoneAlignFailed(_timezoneNote!),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecoveryActions(BuildContext context) {
    final l10n = context.appLocalizations;
    final previous = ref.watch(
      geoIdentitySettingProvider.select((state) => state.previousOsTimezone),
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          ListItem(
            leading: const Icon(Icons.content_copy_outlined),
            title: Text(l10n.geoIdentityCopyTerminalProxy),
            subtitle: Text(l10n.geoIdentityCopyTerminalProxyShort),
            onTap: _busy ? null : () => _copyTerminalProxyExports(),
          ),
          ListItem(
            leading: const Icon(Icons.extension_outlined),
            title: Text(l10n.geoIdentityOpenGeoMirror),
            subtitle: Text(l10n.geoIdentityOpenGeoMirrorShort),
            onTap: () {
              dialogs.openUrl(GeoIdentityLinks.geoMirror);
            },
          ),
          if (!system.isAndroid && previous != null && previous.isNotEmpty)
            ListItem(
              leading: const Icon(Icons.restore_outlined),
              title: Text(l10n.geoIdentityRestoreOsTimezone),
              subtitle: Text(l10n.geoIdentityRestoreOsTimezoneDesc(previous)),
              onTap: _busy
                  ? null
                  : () => _restoreOsTimezoneIfNeeded(notify: true),
            ),
        ],
      ),
    );
  }

  String _captureModeLabel(
    AppLocalizations l10n,
    GeoIdentityCaptureMode mode,
  ) {
    return switch (mode) {
      GeoIdentityCaptureMode.auto => l10n.geoIdentityCaptureModeAuto,
      GeoIdentityCaptureMode.tun => l10n.geoIdentityCaptureModeTun,
      GeoIdentityCaptureMode.systemProxy =>
        l10n.geoIdentityCaptureModeSystemProxy,
      GeoIdentityCaptureMode.both => l10n.geoIdentityCaptureModeBoth,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    final enabled = ref.watch(geoIdentitySettingProvider).enable;

    return CommonScaffold(
      title: l10n.geoIdentity,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              l10n.geoIdentityPurposeBody,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ListItem.toggle(
            leading: const Icon(Icons.shield_outlined),
            title: Text(l10n.geoIdentityProtectEnable),
            subtitle: Text(l10n.geoIdentityProtectToggleDesc),
            value: enabled,
            onChanged: _busy ? null : _handleToggle,
          ),
          ListItem.options(
            leading: const Icon(Icons.tune_outlined),
            title: Text(l10n.geoIdentityCaptureMode),
            subtitle: Text(
              _captureModeLabel(
                l10n,
                ref.watch(
                  geoIdentitySettingProvider.select((s) => s.captureMode),
                ),
              ),
            ),
            dialogTitle: l10n.geoIdentityCaptureMode,
            options: GeoIdentityCaptureMode.values,
            value: ref.watch(
              geoIdentitySettingProvider.select((s) => s.captureMode),
            ),
            textBuilder: (mode) => _captureModeLabel(l10n, mode),
            onChanged: (mode) {
              if (_busy || mode == null) {
                return;
              }
              ref
                  .read(geoIdentitySettingProvider.notifier)
                  .setCaptureMode(mode);
            },
          ),
          _buildStatusBanner(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              l10n.geoIdentityHonestyLine,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (system.isAndroid && enabled)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                l10n.geoIdentityTimezoneAndroidTip,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          const SizedBox(height: 8),
          _buildRecoveryActions(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
