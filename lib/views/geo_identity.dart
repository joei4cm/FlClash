import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GeoIdentityView extends StatelessWidget {
  const GeoIdentityView({super.key});

  GeoIdentitySnapshot _snapshot() {
    return GeoIdentitySnapshot.fromClock(
      now: DateTime.now(),
      systemLocale: Platform.localeName,
    );
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    final snapshot = _snapshot();
    final riskColor = _riskColor(context, snapshot.riskLevel);

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
                leading: const Icon(Icons.travel_explore_outlined),
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
