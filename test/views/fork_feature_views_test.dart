import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/geo_identity.dart';
import 'package:fl_clash/views/strategy_lanes.dart';
import 'package:fl_clash/views/tailscale.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

ProviderContainer _containerFor(WidgetTester tester) {
  const size = Size(1200, 1000);
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final container = ProviderContainer();
  addTearDown(container.dispose);
  globalState.container = container;
  container.read(viewSizeProvider.notifier).value = size;
  return container;
}

Future<void> _pumpView(
  WidgetTester tester,
  ProviderContainer container,
  Widget view,
) async {
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: TestApp(child: view),
    ),
  );
  await tester.pump();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('TailscaleView renders the default disabled status', (
    tester,
  ) async {
    final container = _containerFor(tester);
    await _pumpView(tester, container, const TailscaleView());

    expect(find.byType(TailscaleView), findsOneWidget);
    expect(
      find.text(AppLocalizations.current.tailscaleStatusDisabled),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizations.current.tailscaleGuideTitle),
      findsOneWidget,
    );
  });

  testWidgets('TailscaleView shows no-nodes status when enabled empty', (
    tester,
  ) async {
    final container = _containerFor(tester);
    final hold = container.listen(tailscaleSettingProvider, (_, _) {});
    addTearDown(hold.close);
    container.read(tailscaleSettingProvider.notifier).setEnable(true);

    await _pumpView(tester, container, const TailscaleView());

    expect(
      find.text(AppLocalizations.current.tailscaleStatusNoNodes),
      findsOneWidget,
    );
  });

  testWidgets('TailscaleView lists a configured node and route status', (
    tester,
  ) async {
    final container = _containerFor(tester);
    final hold = container.listen(tailscaleSettingProvider, (_, _) {});
    addTearDown(hold.close);
    final notifier = container.read(tailscaleSettingProvider.notifier);
    notifier.setEnable(true);
    notifier.addOrUpdate(
      const TailscaleProxy(
        name: 'home-exit',
        authKey: 'tskey-auth-test',
        routes: ['192.168.1.0/24'],
      ),
    );

    await _pumpView(tester, container, const TailscaleView());

    expect(find.text('home-exit'), findsWidgets);
    expect(
      find.text(AppLocalizations.current.tailscaleStatusNeedStart),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizations.current.tailscaleRoutesCount(1)),
      findsOneWidget,
    );
  });

  testWidgets('GeoIdentityView renders the off status by default', (
    tester,
  ) async {
    final container = _containerFor(tester);
    await _pumpView(tester, container, const GeoIdentityView());

    expect(find.byType(GeoIdentityView), findsOneWidget);
    expect(
      find.text(AppLocalizations.current.geoIdentityOffStatus),
      findsOneWidget,
    );
  });

  testWidgets('GeoIdentityView asks to start when enabled while stopped', (
    tester,
  ) async {
    final container = _containerFor(tester);
    final hold = container.listen(geoIdentitySettingProvider, (_, _) {});
    addTearDown(hold.close);
    container.read(geoIdentitySettingProvider.notifier).setEnable(true);

    await _pumpView(tester, container, const GeoIdentityView());

    expect(
      find.text(AppLocalizations.current.geoIdentityNeedStart),
      findsOneWidget,
    );
  });

  testWidgets('StrategyLanesView asks for a profile when none is selected', (
    tester,
  ) async {
    final container = _containerFor(tester);
    await _pumpView(tester, container, const StrategyLanesView());

    expect(find.byType(StrategyLanesView), findsOneWidget);
    expect(
      find.text(AppLocalizations.current.strategyLanesNeedProfile),
      findsOneWidget,
    );
  });

  testWidgets(
    'TailscaleView exposes add-node and bypass controls when enabled',
    (tester) async {
      final container = _containerFor(tester);
      final hold = container.listen(tailscaleSettingProvider, (_, _) {});
      addTearDown(hold.close);
      container.read(tailscaleSettingProvider.notifier).setEnable(true);

      await _pumpView(tester, container, const TailscaleView());
      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizations.current.tailscaleBypass),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.addTailscaleNode),
        findsWidgets,
      );
    },
  );

  testWidgets('TailscaleNodeDialog builds add and edit forms', (tester) async {
    final container = _containerFor(tester);

    await _pumpView(
      tester,
      container,
      const Scaffold(body: TailscaleNodeDialog(existingNames: ['taken'])),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizations.current.addTailscaleNode),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizations.current.tailscaleAuthKey),
      findsOneWidget,
    );
    expect(find.text(AppLocalizations.current.tailscaleRoutes), findsOneWidget);
    // Default proxy has udp=false, so advanced fields start expanded.
    expect(find.text(AppLocalizations.current.hideAdvanced), findsOneWidget);
    expect(
      find.text(AppLocalizations.current.tailscaleHostname),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizations.current.tailscaleControlUrl),
      findsOneWidget,
    );

    await tester.tap(find.text(AppLocalizations.current.hideAdvanced));
    await tester.pumpAndSettle();
    expect(find.text(AppLocalizations.current.showAdvanced), findsOneWidget);
  });

  testWidgets('TailscaleNodeDialog edit mode expands hostname fields', (
    tester,
  ) async {
    final container = _containerFor(tester);

    await _pumpView(
      tester,
      container,
      const Scaffold(
        body: TailscaleNodeDialog(
          proxy: TailscaleProxy(
            name: 'home-exit',
            authKey: 'tskey-auth-test',
            hostname: 'phone',
            udp: true,
            routes: ['10.0.0.0/8'],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizations.current.editTailscaleNode),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizations.current.tailscaleHostname),
      findsOneWidget,
    );
  });
}
