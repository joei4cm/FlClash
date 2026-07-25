import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final enabled = ref.read(geoIdentitySettingProvider).enable;
      if (enabled && ref.read(isStartProvider)) {
        _validateNetwork(quiet: true);
      }
    });
  }

  @override
  void dispose() {
    _cancelToken?.cancel();
    super.dispose();
  }

  Future<void> _copyTerminalProxyExports() async {
    final mixedPort = ref.read(
      patchClashConfigProvider.select((state) => state.mixedPort),
    );
    final text = system.isWindows
        ? GeoIdentityHost.buildTerminalProxyExportsPowerShell(
            mixedPort: mixedPort,
          )
        : GeoIdentityHost.buildTerminalProxyExports(mixedPort: mixedPort);
    await Clipboard.setData(ClipboardData(text: text));
  }

  Future<GeoIdentityNetworkReport?> _validateNetwork({
    bool quiet = false,
  }) async {
    final l10n = context.appLocalizations;
    if (!ref.read(isStartProvider)) {
      if (!quiet && mounted) {
        setState(() {
          _report = null;
          _statusMessage = l10n.geoIdentityNeedStart;
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
        _statusMessage = result.message.isNotEmpty
            ? result.message
            : l10n.geoIdentityCheckFailed;
      });
      return null;
    }
    final report = result.data!;
    setState(() {
      _busy = false;
      _report = report;
      _statusMessage = report.isProtected
          ? l10n.geoIdentityNetworkGood
          : l10n.geoIdentityNetworkBad;
    });
    return report;
  }

  Future<void> _alignOsTimezoneIfNeeded() async {
    if (system.isAndroid) {
      return;
    }
    final target = _report?.timezone;
    if (target == null || target.isEmpty) {
      return;
    }
    final previous =
        await GeoIdentityHost.readOsTimezoneId() ??
        ref.read(geoIdentitySettingProvider).previousOsTimezone;
    final error = await GeoIdentityHost.setOsTimezone(target);
    if (error != null || !mounted) {
      return;
    }
    ref
        .read(geoIdentitySettingProvider.notifier)
        .setTimezoneHistory(
          previousOsTimezone: previous,
          appliedOsTimezone: target,
        );
  }

  Future<void> _restoreOsTimezoneIfNeeded() async {
    if (system.isAndroid) {
      return;
    }
    final previous = ref.read(geoIdentitySettingProvider).previousOsTimezone;
    if (previous == null || previous.isEmpty) {
      return;
    }
    final error = await GeoIdentityHost.setOsTimezone(previous);
    if (error == null && mounted) {
      ref.read(geoIdentitySettingProvider.notifier).clearTimezoneHistory();
    }
  }

  /// Full checklist when turning protect ON.
  Future<void> _enableProtect() async {
    final l10n = context.appLocalizations;
    setState(() {
      _busy = true;
      _statusMessage = l10n.geoIdentitySetupRunning;
      _report = null;
    });

    try {
      final geoNotifier = ref.read(geoIdentitySettingProvider.notifier);
      geoNotifier.setEnable(true);
      geoNotifier.setUseUsAcceptLanguage(true);

      if (system.isDesktop) {
        final network = ref.read(networkSettingProvider);
        if (!network.systemProxy) {
          ref
              .read(networkSettingProvider.notifier)
              .update((state) => state.copyWith(systemProxy: true));
        }
        if (!ref.read(patchClashConfigProvider).tun.enable) {
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith.tun(enable: true));
        }
      } else if (system.isAndroid) {
        if (!ref.read(vpnSettingProvider).enable) {
          ref
              .read(vpnSettingProvider.notifier)
              .update((state) => state.copyWith(enable: true));
        }
      }

      if (!ref.read(isStartProvider)) {
        setState(() => _statusMessage = l10n.geoIdentitySetupStarting);
        await ref.read(setupActionProvider.notifier).updateStatus(true);
        await Future<void>.delayed(const Duration(milliseconds: 800));
      } else {
        ref
            .read(setupActionProvider.notifier)
            .applyProfileDebounce(silence: true);
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }
      if (!mounted) {
        return;
      }

      final report = await _validateNetwork(quiet: true);
      if (!mounted) {
        return;
      }

      if (system.isDesktop) {
        setState(() => _statusMessage = l10n.geoIdentitySetupTimezone);
        await _alignOsTimezoneIfNeeded();
      }

      final virtualNic = system.isAndroid
          ? ref.read(vpnSettingProvider).enable
          : ref.read(patchClashConfigProvider).tun.enable;
      if (!virtualNic) {
        await _copyTerminalProxyExports();
      }

      if (!mounted) {
        return;
      }
      final protected = report?.isProtected == true;
      setState(() {
        _busy = false;
        _statusMessage = protected
            ? l10n.geoIdentityNetworkGood
            : l10n.geoIdentityNetworkBad;
      });
      if (!protected) {
        context.showNotifier(l10n.geoIdentitySetupDoneNeedUsNode);
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      // Roll back the toggle if setup failed hard.
      ref.read(geoIdentitySettingProvider.notifier).setEnable(false);
      setState(() {
        _busy = false;
        _report = null;
        _statusMessage = e.toString();
      });
      context.showNotifier(e.toString());
    }
  }

  /// Turn protect OFF without tearing down the user's VPN/proxy prefs.
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
    } else if (protected) {
      accent = context.colorScheme.primary;
      icon = Icons.verified_user_outlined;
      title = l10n.geoIdentityNetworkGood;
    } else {
      accent = context.colorScheme.error;
      icon = Icons.warning_amber_outlined;
      title = _statusMessage ?? l10n.geoIdentityNetworkBad;
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
          ],
        ),
      ),
    );
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
          ListItem.switchItem(
            leading: const Icon(Icons.shield_outlined),
            title: Text(l10n.geoIdentityProtectEnable),
            subtitle: Text(l10n.geoIdentityProtectToggleDesc),
            delegate: SwitchDelegate(
              value: enabled,
              onChanged: _busy ? null : _handleToggle,
            ),
          ),
          _buildStatusBanner(context),
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
