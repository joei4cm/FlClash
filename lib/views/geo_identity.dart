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
  String? _checkError;
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

  GeoIdentityCaptureMode _captureMode({
    required bool isStart,
    required bool systemProxy,
    required bool tunEnable,
    required bool vpnEnable,
  }) {
    if (!isStart) {
      return GeoIdentityCaptureMode.inactive;
    }
    final virtualNic = system.isAndroid ? vpnEnable : tunEnable;
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

  Color _riskColor(BuildContext context, GeoIdentityRiskLevel level) {
    final scheme = context.colorScheme;
    return switch (level) {
      GeoIdentityRiskLevel.low => scheme.primary,
      GeoIdentityRiskLevel.medium => scheme.tertiary,
      GeoIdentityRiskLevel.high => scheme.error,
    };
  }

  IconData _riskIcon(GeoIdentityRiskLevel level) {
    return switch (level) {
      GeoIdentityRiskLevel.low => Icons.verified_outlined,
      GeoIdentityRiskLevel.medium => Icons.warning_amber_outlined,
      GeoIdentityRiskLevel.high => Icons.report_outlined,
    };
  }

  String _riskTitle(BuildContext context, GeoIdentityRiskLevel level) {
    final l10n = context.appLocalizations;
    return switch (level) {
      GeoIdentityRiskLevel.low => l10n.geoIdentityRiskLow,
      GeoIdentityRiskLevel.medium => l10n.geoIdentityRiskMedium,
      GeoIdentityRiskLevel.high => l10n.geoIdentityRiskHigh,
    };
  }

  String _riskBody(BuildContext context, GeoIdentityRiskLevel level) {
    final l10n = context.appLocalizations;
    return switch (level) {
      GeoIdentityRiskLevel.low => l10n.geoIdentityRiskLowDesc,
      GeoIdentityRiskLevel.medium => l10n.geoIdentityRiskMediumDesc,
      GeoIdentityRiskLevel.high => l10n.geoIdentityRiskHighDesc,
    };
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

  Future<void> _handleVerify() async {
    final l10n = context.appLocalizations;
    if (!ref.read(isStartProvider)) {
      context.showNotifier(l10n.geoIdentityNeedStart);
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

  Future<void> _alignOsTimezone() async {
    final l10n = context.appLocalizations;
    if (system.isAndroid) {
      context.showNotifier(l10n.geoIdentityTimezoneAndroidTip);
      return;
    }
    var target = _report?.timezone;
    if (target == null || target.isEmpty) {
      if (!ref.read(isStartProvider)) {
        context.showNotifier(l10n.geoIdentityNeedStart);
        return;
      }
      await _handleVerify();
      if (!mounted) {
        return;
      }
      target = _report?.timezone;
    }
    if (target == null || target.isEmpty) {
      context.showNotifier(l10n.geoIdentityTimezoneMissing);
      return;
    }
    final previous =
        await GeoIdentityHost.readOsTimezoneId() ??
        ref.read(geoIdentitySettingProvider).previousOsTimezone;
    final error = await GeoIdentityHost.setOsTimezone(target);
    if (!mounted) {
      return;
    }
    if (error != null) {
      if (error.startsWith('unsupported-windows-timezone:')) {
        context.showNotifier(l10n.geoIdentityTimezoneUnsupported(target));
      } else if (error == 'android-unsupported') {
        context.showNotifier(l10n.geoIdentityTimezoneAndroidTip);
      } else {
        context.showNotifier(l10n.geoIdentityTimezoneManual(error));
      }
      return;
    }
    ref
        .read(geoIdentitySettingProvider.notifier)
        .setTimezoneHistory(
          previousOsTimezone: previous,
          appliedOsTimezone: target,
        );
    context.showNotifier(l10n.geoIdentityTimezoneApplied(target));
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    final snapshot = _snapshot();
    final riskColor = _riskColor(context, snapshot.riskLevel);
    final props = ref.watch(geoIdentitySettingProvider);
    final isStart = ref.watch(isStartProvider);
    final systemProxy = ref.watch(
      networkSettingProvider.select((state) => state.systemProxy),
    );
    final tunEnable = ref.watch(
      patchClashConfigProvider.select((state) => state.tun.enable),
    );
    final vpnEnable = ref.watch(
      vpnSettingProvider.select((state) => state.enable),
    );
    final captureMode = _captureMode(
      isStart: isStart,
      systemProxy: system.isAndroid
          ? ref.watch(vpnSettingProvider.select((state) => state.systemProxy))
          : systemProxy,
      tunEnable: tunEnable,
      vpnEnable: vpnEnable,
    );

    return CommonScaffold(
      title: l10n.geoIdentity,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: riskColor.opacity12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(_riskIcon(snapshot.riskLevel), color: riskColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _riskTitle(context, snapshot.riskLevel),
                          style: context.textTheme.titleMedium?.copyWith(
                            color: riskColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _riskBody(context, snapshot.riskLevel),
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
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
                onTap: _checking ? null : _handleVerify,
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
              ListItem(
                leading: Icon(
                  snapshot.looksChinaTimezoneName ||
                          GeoIdentityHost.isClaudeCodeChinaTimezone(
                            props.appliedOsTimezone,
                          )
                      ? Icons.warning_amber_outlined
                      : Icons.schedule_outlined,
                ),
                title: Text(l10n.geoIdentityClaudeCodeTimezoneTipTitle),
                subtitle: Text(l10n.geoIdentityClaudeCodeTimezoneTipBody),
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
                  onTap: _alignOsTimezone,
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
            title: l10n.geoIdentityOverviewTitle,
            items: [
              ListItem(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.geoIdentityOverviewTitle),
                subtitle: Text(l10n.geoIdentityOverviewBody),
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
            title: l10n.geoIdentityChecklistTitle,
            items: [
              ListItem(
                leading: const Icon(Icons.filter_1),
                title: Text(l10n.geoIdentityStep1Title),
                subtitle: Text(l10n.geoIdentityStep1Body),
              ),
              ListItem(
                leading: const Icon(Icons.filter_2),
                title: Text(l10n.geoIdentityStep2Title),
                subtitle: Text(l10n.geoIdentityStep2Body),
              ),
              ListItem(
                leading: const Icon(Icons.filter_3),
                title: Text(l10n.geoIdentityStep3Title),
                subtitle: Text(l10n.geoIdentityStep3Body),
              ),
              ListItem(
                leading: const Icon(Icons.filter_4),
                title: Text(l10n.geoIdentityStep4Title),
                subtitle: Text(l10n.geoIdentityStep4Body),
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
}
