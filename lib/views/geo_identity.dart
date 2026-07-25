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

  GeoIdentityCaptureMode _captureMode({
    required bool isStart,
    required bool systemProxy,
    required bool tunEnable,
    required bool vpnEnable,
  }) {
    if (!isStart) {
      return GeoIdentityCaptureMode.inactive;
    }
    final virtualNic = _virtualNicEnabled(
      tunEnable: tunEnable,
      vpnEnable: vpnEnable,
    );
    if (virtualNic && systemProxy) {
      return GeoIdentityCaptureMode.both;
    }
    if (virtualNic) {
      return GeoIdentityCaptureMode.virtualNic;
    }
    if (systemProxy) {
      return GeoIdentityCaptureMode.systemProxy;
    }
    return GeoIdentityCaptureMode.mixedPortOnly;
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

  /// One-click newbie setup: protect → capture → start → verify → timezone.
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
        // Give the core a moment to bind mixed-port before probing.
        await Future<void>.delayed(const Duration(milliseconds: 800));
      } else {
        // Re-apply so newly enabled TUN / system proxy take effect.
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

  Widget _buildGuideStep(BuildContext context, int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(text, style: context.textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckRow(
    BuildContext context, {
    required bool done,
    required String title,
    required String subtitle,
  }) {
    final color = done
        ? context.colorScheme.primary
        : context.colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 20,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewbieCard(
    BuildContext context, {
    required GeoIdentityChecklistState checklist,
  }) {
    final l10n = context.appLocalizations;
    final isAndroid = system.isAndroid;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer.opacity38,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isAndroid ? Icons.phone_android : Icons.computer,
                  size: 20,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isAndroid
                        ? l10n.geoIdentityScenarioAndroidTitle
                        : l10n.geoIdentityScenarioDesktopTitle,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isAndroid
                  ? l10n.geoIdentityScenarioAndroidBody
                  : l10n.geoIdentityScenarioDesktopBody,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  Icons.checklist_outlined,
                  size: 20,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.geoIdentityLiveChecklistTitle(
                    checklist.completedCount,
                    checklist.totalCount,
                  ),
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildCheckRow(
              context,
              done: checklist.protectEnabled,
              title: l10n.geoIdentityCheckProtectTitle,
              subtitle: l10n.geoIdentityCheckProtectBody,
            ),
            _buildCheckRow(
              context,
              done: checklist.coreStarted,
              title: l10n.geoIdentityCheckStartedTitle,
              subtitle: l10n.geoIdentityCheckStartedBody,
            ),
            _buildCheckRow(
              context,
              done: checklist.captureReady,
              title: l10n.geoIdentityCheckCaptureTitle,
              subtitle: isAndroid
                  ? l10n.geoIdentityCheckCaptureAndroidBody
                  : l10n.geoIdentityCheckCaptureDesktopBody,
            ),
            _buildCheckRow(
              context,
              done: checklist.networkProtected,
              title: l10n.geoIdentityCheckNetworkTitle,
              subtitle: checklist.networkChecked
                  ? (_report?.isProtected == true
                        ? l10n.geoIdentityNetworkProtected
                        : l10n.geoIdentityNetworkExposed)
                  : l10n.geoIdentityCheckNetworkBody,
            ),
            _buildCheckRow(
              context,
              done: checklist.timezoneReady,
              title: l10n.geoIdentityCheckTimezoneTitle,
              subtitle: isAndroid
                  ? l10n.geoIdentityTimezoneAndroidTip
                  : l10n.geoIdentityCheckTimezoneBody,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _settingUp || _checking ? null : _handleOneClickSetup,
                icon: _settingUp
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
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
                style: context.textTheme.bodySmall?.copyWith(
                  color: checklist.isComplete
                      ? context.colorScheme.primary
                      : context.colorScheme.tertiary,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              l10n.geoIdentityGuideTitle,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (isAndroid) ...[
              _buildGuideStep(context, 1, l10n.geoIdentityAndroidStep1),
              _buildGuideStep(context, 2, l10n.geoIdentityAndroidStep2),
              _buildGuideStep(context, 3, l10n.geoIdentityAndroidStep3),
              _buildGuideStep(context, 4, l10n.geoIdentityAndroidStep4),
            ] else ...[
              _buildGuideStep(context, 1, l10n.geoIdentityDesktopStep1),
              _buildGuideStep(context, 2, l10n.geoIdentityDesktopStep2),
              _buildGuideStep(context, 3, l10n.geoIdentityDesktopStep3),
              _buildGuideStep(context, 4, l10n.geoIdentityDesktopStep4),
            ],
            Text(
              l10n.geoIdentityOneClickTip,
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
    final captureMode = _captureMode(
      isStart: isStart,
      systemProxy: effectiveSystemProxy,
      tunEnable: tunEnable,
      vpnEnable: vpnEnable,
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
          _buildNewbieCard(context, checklist: checklist),
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
              if (props.enable)
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
              ListItem(
                leading: Icon(
                  captureMode == GeoIdentityCaptureMode.inactive
                      ? Icons.link_off
                      : Icons.route_outlined,
                ),
                title: Text(_captureTitle(context, captureMode)),
                subtitle: Text(_captureBody(context, captureMode)),
              ),
            ],
          ),
          ...generateSection(
            title: l10n.geoIdentityNetworkCheckTitle,
            items: [
              ListItem(
                leading: _checking
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        _report?.isProtected == true
                            ? Icons.verified_user_outlined
                            : Icons.travel_explore_outlined,
                      ),
                title: Text(l10n.geoIdentityVerifyNetwork),
                subtitle: Text(l10n.geoIdentityVerifyNetworkDesc),
                onTap: _checking || _settingUp ? null : _handleVerify,
              ),
              if (_checkError != null)
                ListItem(
                  leading: Icon(
                    Icons.error_outline,
                    color: context.colorScheme.error,
                  ),
                  title: Text(l10n.geoIdentityCheckFailed),
                  subtitle: Text(_checkError!),
                ),
              if (_report != null) ...[
                ListItem(
                  leading: Icon(
                    _report!.isProtected
                        ? Icons.check_circle_outline
                        : Icons.warning_amber_outlined,
                    color: _report!.isProtected
                        ? context.colorScheme.primary
                        : context.colorScheme.error,
                  ),
                  title: Text(
                    _report!.isProtected
                        ? l10n.geoIdentityNetworkProtected
                        : l10n.geoIdentityNetworkExposed,
                  ),
                  subtitle: Text(
                    '${_report!.verdict} · ${_report!.band} · score ${_report!.score}',
                  ),
                ),
                ListItem(
                  leading: const Icon(Icons.public_outlined),
                  title: Text(l10n.geoIdentityExitCountry),
                  subtitle: Text(
                    [
                      if (_report!.country != null) _report!.country,
                      if (_report!.timezone != null) _report!.timezone,
                    ].whereType<String>().join(' · '),
                  ),
                ),
                ListItem(
                  leading: const Icon(Icons.language_outlined),
                  title: Text(l10n.geoIdentityProbeLanguage),
                  subtitle: Text(
                    _report!.language?.isNotEmpty == true
                        ? _report!.language!
                        : l10n.geoIdentityProbeLanguageUnknown,
                  ),
                ),
              ],
            ],
          ),
          ...generateSection(
            title: l10n.geoIdentityClaudeCodeTitle,
            items: [
              ListItem(
                leading: const Icon(Icons.terminal_outlined),
                title: Text(l10n.geoIdentityClaudeCodeTitle),
                subtitle: Text(l10n.geoIdentityClaudeCodeBody),
              ),
              if (system.isDesktop)
                ListItem(
                  leading: const Icon(Icons.punch_clock_outlined),
                  title: Text(l10n.geoIdentityAlignOsTimezone),
                  subtitle: Text(
                    props.appliedOsTimezone == null
                        ? l10n.geoIdentityAlignOsTimezoneDesc
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
              if (system.isAndroid)
                ListItem(
                  leading: const Icon(Icons.phonelink_setup_outlined),
                  title: Text(l10n.geoIdentityAlignOsTimezone),
                  subtitle: Text(l10n.geoIdentityTimezoneAndroidTip),
                ),
              ListItem(
                leading: const Icon(Icons.content_copy_outlined),
                title: Text(l10n.geoIdentityCopyTerminalProxy),
                subtitle: Text(l10n.geoIdentityCopyTerminalProxyDesc),
                onTap: _copyTerminalProxyExports,
              ),
              ListItem(
                leading: const Icon(Icons.link_outlined),
                title: Text(l10n.geoIdentityClaudeCodeBaseUrlTitle),
                subtitle: Text(l10n.geoIdentityClaudeCodeBaseUrlBody),
              ),
            ],
          ),
          ...generateSection(
            title: l10n.geoIdentityLocalSignalsTitle,
            items: [
              ListItem(
                leading: const Icon(Icons.schedule_outlined),
                title: Text(l10n.geoIdentityTimezone),
                subtitle: Text(
                  '${snapshot.timeZoneName} (${snapshot.offsetLabel})',
                ),
              ),
              ListItem(
                leading: const Icon(Icons.language_outlined),
                title: Text(l10n.geoIdentitySystemLocale),
                subtitle: Text(snapshot.systemLocale),
              ),
              ListItem(
                leading: const Icon(Icons.tips_and_updates_outlined),
                title: Text(l10n.geoIdentityLocalTipTitle),
                subtitle: Text(l10n.geoIdentityLocalTipBody),
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
                onTap: () => globalState.openUrl(GeoIdentityLinks.fuckClaude),
              ),
              ListItem(
                leading: const Icon(Icons.extension_outlined),
                title: Text(l10n.geoIdentityOpenGeoMirror),
                subtitle: Text(l10n.geoIdentityOpenGeoMirrorDesc),
                onTap: () => globalState.openUrl(GeoIdentityLinks.geoMirror),
              ),
              ListItem(
                leading: const Icon(Icons.download_outlined),
                title: Text(l10n.geoIdentityOpenGeoMirrorReleases),
                subtitle: Text(l10n.geoIdentityOpenGeoMirrorReleasesDesc),
                onTap: () =>
                    globalState.openUrl(GeoIdentityLinks.geoMirrorReleases),
              ),
            ],
          ),
          ...generateSection(
            title: l10n.geoIdentityLimitsTitle,
            items: [
              ListItem(
                leading: const Icon(Icons.gavel_outlined),
                title: Text(l10n.geoIdentityLimitsTitle),
                subtitle: Text(l10n.geoIdentityLimitsBody),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _captureTitle(BuildContext context, GeoIdentityCaptureMode mode) {
    final l10n = context.appLocalizations;
    return switch (mode) {
      GeoIdentityCaptureMode.inactive => l10n.geoIdentityCaptureInactive,
      GeoIdentityCaptureMode.mixedPortOnly =>
        l10n.geoIdentityCaptureMixedPortOnly,
      GeoIdentityCaptureMode.systemProxy => l10n.geoIdentityCaptureSystemProxy,
      GeoIdentityCaptureMode.virtualNic => l10n.geoIdentityCaptureVirtualNic,
      GeoIdentityCaptureMode.both => l10n.geoIdentityCaptureBoth,
    };
  }

  String _captureBody(BuildContext context, GeoIdentityCaptureMode mode) {
    final l10n = context.appLocalizations;
    return switch (mode) {
      GeoIdentityCaptureMode.inactive => l10n.geoIdentityCaptureInactiveDesc,
      GeoIdentityCaptureMode.mixedPortOnly =>
        l10n.geoIdentityCaptureMixedPortOnlyDesc,
      GeoIdentityCaptureMode.systemProxy =>
        l10n.geoIdentityCaptureSystemProxyDesc,
      GeoIdentityCaptureMode.virtualNic =>
        l10n.geoIdentityCaptureVirtualNicDesc,
      GeoIdentityCaptureMode.both => l10n.geoIdentityCaptureBothDesc,
    };
  }
}
