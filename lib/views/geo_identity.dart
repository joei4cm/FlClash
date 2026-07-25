import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
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
  bool _checking = false;
  bool _settingUp = false;
  bool _showAdvanced = false;
  String? _checkError;
  String? _setupMessage;
  GeoIdentityNetworkReport? _report;
  CancelToken? _cancelToken;

  @override
  void dispose() {
    _cancelToken?.cancel();
    super.dispose();
  }

  GeoIdentitySnapshot _snapshot() {
    return GeoIdentitySnapshot.fromClock(
      now: DateTime.now(),
      systemLocale: Platform.localeName,
    );
  }

  bool _virtualNicEnabled({
    required bool tunEnable,
    required bool vpnEnable,
  }) {
    return system.isAndroid ? vpnEnable : tunEnable;
  }

  bool _systemProxyEnabled({
    required bool desktopSystemProxy,
    required bool vpnSystemProxy,
  }) {
    return system.isAndroid ? vpnSystemProxy : desktopSystemProxy;
  }

  GeoIdentityChecklistState _checklist({
    required GeoIdentityProps props,
    required bool isStart,
    required bool systemProxy,
    required bool tunEnable,
    required bool vpnEnable,
    required GeoIdentitySnapshot snapshot,
  }) {
    final captureReady =
        isStart &&
        (_virtualNicEnabled(tunEnable: tunEnable, vpnEnable: vpnEnable) ||
            systemProxy);
    final timezoneReady = system.isAndroid
        ? true
        : props.appliedOsTimezone != null || !snapshot.looksChinaTimezoneName;
    return GeoIdentityChecklistState(
      protectEnabled: props.enable,
      coreStarted: isStart,
      captureReady: captureReady,
      networkProtected: _report?.isProtected == true,
      networkChecked: _report != null,
      timezoneReady: timezoneReady,
    );
  }

  Future<void> _handleVerify({bool quiet = false}) async {
    final l10n = context.appLocalizations;
    if (!ref.read(isStartProvider)) {
      if (!quiet) {
        context.showNotifier(l10n.geoIdentityNeedStart);
      }
      return;
    }
    final props = ref.read(geoIdentitySettingProvider);
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    setState(() {
      _checking = true;
      _checkError = null;
    });
    final result = await request.checkGeoIdentity(
      acceptLanguage: props.useUsAcceptLanguage
          ? geoIdentityUsAcceptLanguage
          : null,
      cancelToken: _cancelToken,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _checking = false;
      if (result.isError) {
        _checkError = result.message.isNotEmpty
            ? result.message
            : l10n.geoIdentityCheckFailed;
        _report = null;
      } else {
        _report = result.data;
        if (_report == null) {
          _checkError = l10n.geoIdentityCheckFailed;
        }
      }
    });
  }

  Future<void> _copyTerminalProxyExports() async {
    final l10n = context.appLocalizations;
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
    context.showNotifier(l10n.copySuccess);
  }

  Future<bool> _alignOsTimezone({bool quiet = false}) async {
    final l10n = context.appLocalizations;
    if (system.isAndroid) {
      if (!quiet) {
        context.showNotifier(l10n.geoIdentityTimezoneAndroidTip);
      }
      return false;
    }
    var target = _report?.timezone;
    if (target == null || target.isEmpty) {
      if (!ref.read(isStartProvider)) {
        if (!quiet) {
          context.showNotifier(l10n.geoIdentityNeedStart);
        }
        return false;
      }
      await _handleVerify(quiet: quiet);
      if (!mounted) {
        return false;
      }
      target = _report?.timezone;
    }
    if (target == null || target.isEmpty) {
      if (!quiet) {
        context.showNotifier(l10n.geoIdentityTimezoneMissing);
      }
      return false;
    }
    final previous =
        await GeoIdentityHost.readOsTimezoneId() ??
        ref.read(geoIdentitySettingProvider).previousOsTimezone;
    final error = await GeoIdentityHost.setOsTimezone(target);
    if (!mounted) {
      return false;
    }
    if (error != null) {
      if (!quiet) {
        if (error.startsWith('unsupported-windows-timezone:')) {
          context.showNotifier(l10n.geoIdentityTimezoneUnsupported(target));
        } else {
          context.showNotifier(l10n.geoIdentityTimezoneManual(error));
        }
      }
      return false;
    }
    ref
        .read(geoIdentitySettingProvider.notifier)
        .setTimezoneHistory(
          previousOsTimezone: previous,
          appliedOsTimezone: target,
        );
    if (!quiet) {
      context.showNotifier(l10n.geoIdentityTimezoneApplied(target));
    }
    setState(() {});
    return true;
  }

  Future<void> _restoreOsTimezone() async {
    final l10n = context.appLocalizations;
    final previous = ref.read(geoIdentitySettingProvider).previousOsTimezone;
    if (previous == null || previous.isEmpty) {
      context.showNotifier(l10n.geoIdentityTimezoneNothingToRestore);
      return;
    }
    final error = await GeoIdentityHost.setOsTimezone(previous);
    if (!mounted) {
      return;
    }
    if (error != null) {
      context.showNotifier(l10n.geoIdentityTimezoneManual(error));
      return;
    }
    ref.read(geoIdentitySettingProvider.notifier).clearTimezoneHistory();
    context.showNotifier(l10n.geoIdentityTimezoneRestored(previous));
    setState(() {});
  }

  Future<void> _handleOneClickSetup() async {
    final l10n = context.appLocalizations;
    if (_settingUp) {
      return;
    }
    setState(() {
      _settingUp = true;
      _setupMessage = l10n.geoIdentitySetupRunning;
      _checkError = null;
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
        final tunOn = ref.read(patchClashConfigProvider).tun.enable;
        if (!tunOn) {
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith.tun(enable: true));
        }
      } else if (system.isAndroid) {
        final vpn = ref.read(vpnSettingProvider);
        if (!vpn.enable) {
          ref
              .read(vpnSettingProvider.notifier)
              .update((state) => state.copyWith(enable: true));
        }
      }

      if (!ref.read(isStartProvider)) {
        setState(() => _setupMessage = l10n.geoIdentitySetupStarting);
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

      setState(() => _setupMessage = l10n.geoIdentitySetupVerifying);
      await _handleVerify(quiet: true);
      if (!mounted) {
        return;
      }

      var timezoneOk = false;
      if (system.isDesktop) {
        setState(() => _setupMessage = l10n.geoIdentitySetupTimezone);
        timezoneOk = await _alignOsTimezone(quiet: true);
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
      final protected = _report?.isProtected == true;
      final message = protected
          ? (timezoneOk || system.isAndroid
                ? l10n.geoIdentitySetupDoneProtected
                : l10n.geoIdentitySetupDoneNeedTimezone)
          : l10n.geoIdentitySetupDoneNeedUsNode;
      setState(() => _setupMessage = message);
      context.showNotifier(message);
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() => _setupMessage = e.toString());
      context.showNotifier(e.toString());
    } finally {
      if (mounted) {
        setState(() => _settingUp = false);
      }
    }
  }

  Widget _buildStatusCard(
    BuildContext context, {
    required GeoIdentityChecklistState checklist,
    required GeoIdentitySnapshot snapshot,
  }) {
    final l10n = context.appLocalizations;
    final complete = checklist.isComplete;
    final accent = complete
        ? context.colorScheme.primary
        : context.colorScheme.tertiary;
    final statusTitle = complete
        ? l10n.geoIdentityStatusReadyTitle
        : l10n.geoIdentityStatusSetupTitle;
    final statusBody = complete
        ? l10n.geoIdentityStatusReadyBody
        : l10n.geoIdentityStatusSetupBody;
    final exitLabel = [
      if (_report?.country != null) _report!.country,
      if (_report?.timezone != null) _report!.timezone,
      if (_report != null) '${_report!.band} · ${_report!.score}',
    ].whereType<String>().join(' · ');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Container(
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
                Icon(
                  complete
                      ? Icons.verified_user_outlined
                      : Icons.shield_outlined,
                  color: accent,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    statusTitle,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${checklist.completedCount}/${checklist.totalCount}',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(statusBody, style: context.textTheme.bodyMedium),
            if (exitLabel.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                exitLabel,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _StatusChip(
                  done: checklist.protectEnabled,
                  label: l10n.geoIdentityChipProtect,
                ),
                _StatusChip(
                  done: checklist.coreStarted,
                  label: l10n.geoIdentityChipStarted,
                ),
                _StatusChip(
                  done: checklist.captureReady,
                  label: l10n.geoIdentityChipCapture,
                ),
                _StatusChip(
                  done: checklist.networkProtected,
                  label: l10n.geoIdentityChipNetwork,
                ),
                _StatusChip(
                  done: checklist.timezoneReady,
                  label: l10n.geoIdentityChipTimezone,
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _settingUp || _checking
                    ? null
                    : _handleOneClickSetup,
                icon: _settingUp
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: context.colorScheme.onPrimary,
                        ),
                      )
                    : const Icon(Icons.flash_on_outlined),
                label: Text(
                  _settingUp
                      ? (_setupMessage ?? l10n.geoIdentitySetupRunning)
                      : l10n.geoIdentityOneClickSetup,
                ),
              ),
            ),
            if (_setupMessage != null && !_settingUp) ...[
              const SizedBox(height: 8),
              Text(
                _setupMessage!,
                style: context.textTheme.bodySmall?.copyWith(color: accent),
              ),
            ],
            if (_checkError != null) ...[
              const SizedBox(height: 8),
              Text(
                _checkError!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              '${l10n.geoIdentityTimezone}: ${snapshot.timeZoneName} · ${snapshot.systemLocale}',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    final snapshot = _snapshot();
    final props = ref.watch(geoIdentitySettingProvider);
    final isStart = ref.watch(isStartProvider);
    final systemProxy = ref.watch(
      networkSettingProvider.select((state) => state.systemProxy),
    );
    final vpnSystemProxy = ref.watch(
      vpnSettingProvider.select((state) => state.systemProxy),
    );
    final tunEnable = ref.watch(
      patchClashConfigProvider.select((state) => state.tun.enable),
    );
    final vpnEnable = ref.watch(
      vpnSettingProvider.select((state) => state.enable),
    );
    final effectiveSystemProxy = _systemProxyEnabled(
      desktopSystemProxy: systemProxy,
      vpnSystemProxy: vpnSystemProxy,
    );
    final checklist = _checklist(
      props: props,
      isStart: isStart,
      systemProxy: effectiveSystemProxy,
      tunEnable: tunEnable,
      vpnEnable: vpnEnable,
      snapshot: snapshot,
    );

    return CommonScaffold(
      title: l10n.geoIdentity,
      body: ListView(
        children: [
          _buildStatusCard(
            context,
            checklist: checklist,
            snapshot: snapshot,
          ),
          ...generateSection(
            title: l10n.geoIdentityQuickActionsTitle,
            items: [
              ListItem(
                leading: _checking
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.travel_explore_outlined),
                title: Text(l10n.geoIdentityVerifyNetwork),
                subtitle: Text(l10n.geoIdentityVerifyNetworkShort),
                onTap: _checking || _settingUp
                    ? null
                    : () => _handleVerify(),
              ),
              if (system.isDesktop)
                ListItem(
                  leading: const Icon(Icons.punch_clock_outlined),
                  title: Text(l10n.geoIdentityAlignOsTimezone),
                  subtitle: Text(
                    props.appliedOsTimezone == null
                        ? l10n.geoIdentityAlignOsTimezoneShort
                        : l10n.geoIdentityAlignOsTimezoneApplied(
                            props.appliedOsTimezone!,
                          ),
                  ),
                  onTap: _settingUp ? null : () => _alignOsTimezone(),
                ),
              if (system.isDesktop && props.previousOsTimezone != null)
                ListItem(
                  leading: const Icon(Icons.history),
                  title: Text(l10n.geoIdentityRestoreOsTimezone),
                  subtitle: Text(
                    l10n.geoIdentityRestoreOsTimezoneDesc(
                      props.previousOsTimezone!,
                    ),
                  ),
                  onTap: _restoreOsTimezone,
                ),
              ListItem(
                leading: const Icon(Icons.content_copy_outlined),
                title: Text(l10n.geoIdentityCopyTerminalProxy),
                subtitle: Text(l10n.geoIdentityCopyTerminalProxyShort),
                onTap: _copyTerminalProxyExports,
              ),
              ListItem(
                leading: const Icon(Icons.extension_outlined),
                title: Text(l10n.geoIdentityOpenGeoMirror),
                subtitle: Text(l10n.geoIdentityOpenGeoMirrorShort),
                onTap: () => globalState.openUrl(GeoIdentityLinks.geoMirror),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextButton.icon(
              onPressed: () {
                setState(() => _showAdvanced = !_showAdvanced);
              },
              icon: Icon(
                _showAdvanced
                    ? Icons.expand_less
                    : Icons.expand_more,
              ),
              label: Text(
                _showAdvanced
                    ? l10n.geoIdentityHideAdvanced
                    : l10n.geoIdentityShowAdvanced,
              ),
            ),
          ),
          if (_showAdvanced) ...[
            ...generateSection(
              title: l10n.geoIdentityProtectTitle,
              items: [
                ListItem.switchItem(
                  leading: const Icon(Icons.shield_outlined),
                  title: Text(l10n.geoIdentityProtectEnable),
                  subtitle: Text(l10n.geoIdentityProtectEnableDesc),
                  delegate: SwitchDelegate(
                    value: props.enable,
                    onChanged: (value) {
                      ref
                          .read(geoIdentitySettingProvider.notifier)
                          .setEnable(value);
                    },
                  ),
                ),
                ListItem.switchItem(
                  leading: const Icon(Icons.translate_outlined),
                  title: Text(l10n.geoIdentityUsAcceptLanguage),
                  subtitle: Text(l10n.geoIdentityUsAcceptLanguageDesc),
                  delegate: SwitchDelegate(
                    value: props.useUsAcceptLanguage,
                    onChanged: (value) {
                      ref
                          .read(geoIdentitySettingProvider.notifier)
                          .setUseUsAcceptLanguage(value);
                    },
                  ),
                ),
              ],
            ),
            ...generateSection(
              title: l10n.geoIdentityActionsTitle,
              items: [
                ListItem(
                  leading: const Icon(Icons.open_in_browser_outlined),
                  title: Text(l10n.geoIdentityOpenSelfCheck),
                  subtitle: Text(l10n.geoIdentityOpenSelfCheckDesc),
                  onTap: () =>
                      globalState.openUrl(GeoIdentityLinks.fuckClaude),
                ),
                ListItem(
                  leading: const Icon(Icons.download_outlined),
                  title: Text(l10n.geoIdentityOpenGeoMirrorReleases),
                  subtitle: Text(l10n.geoIdentityOpenGeoMirrorReleasesDesc),
                  onTap: () => globalState.openUrl(
                    GeoIdentityLinks.geoMirrorReleases,
                  ),
                ),
                ListItem(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.geoIdentityLimitsTitle),
                  subtitle: Text(l10n.geoIdentityLimitsBody),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.done, required this.label});

  final bool done;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = done
        ? context.colorScheme.primary
        : context.colorScheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: done
            ? context.colorScheme.primary.opacity12
            : context.colorScheme.surfaceContainerHighest.opacity38,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            done ? Icons.check_circle : Icons.circle_outlined,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
