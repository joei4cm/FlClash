import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/geo_identity.dart';
import 'package:fl_clash/views/strategy_lanes.dart';
import 'package:fl_clash/views/tailscale.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/host_scaffold.dart';
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
      find.text(currentAppLocalizations.tailscaleStatusDisabled),
      findsOneWidget,
    );
    expect(
      find.text(currentAppLocalizations.tailscaleUsageTitle),
      findsOneWidget,
    );
    expect(
      find.text(currentAppLocalizations.tailscaleAdvancedTitle),
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
      find.text(currentAppLocalizations.tailscaleStatusNoNodes),
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
      find.text(currentAppLocalizations.tailscaleStatusNeedStart),
      findsOneWidget,
    );
    expect(
      find.text(currentAppLocalizations.tailscaleRoutesCount(1)),
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
      find.text(currentAppLocalizations.geoIdentityOffStatus),
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
      find.text(currentAppLocalizations.geoIdentityNeedStart),
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
      find.text(currentAppLocalizations.strategyLanesNeedProfile),
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
        find.text(currentAppLocalizations.tailscaleUsageTitle),
        findsOneWidget,
      );
      await tester.tap(
        find.text(currentAppLocalizations.tailscaleAdvancedTitle),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(currentAppLocalizations.tailscaleBypass),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.text(currentAppLocalizations.addTailscaleNode),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(currentAppLocalizations.addTailscaleNode), findsWidgets);
    },
  );

  testWidgets('TailscaleNodeDialog builds add and edit forms', (tester) async {
    final container = _containerFor(tester);

    await _pumpView(
      tester,
      container,
      const HostScaffold(body: TailscaleNodeDialog(existingNames: ['taken'])),
    );
    await tester.pumpAndSettle();

    expect(find.text(currentAppLocalizations.addTailscaleNode), findsOneWidget);
    expect(find.text(currentAppLocalizations.tailscaleAuthKey), findsOneWidget);
    expect(find.text(currentAppLocalizations.tailscaleRoutes), findsOneWidget);
    // New nodes keep advanced collapsed so the dialog fits short screens.
    expect(find.text(currentAppLocalizations.showAdvanced), findsOneWidget);
    expect(find.text(currentAppLocalizations.tailscaleHostname), findsNothing);

    await tester.tap(find.text(currentAppLocalizations.showAdvanced));
    await tester.pumpAndSettle();
    expect(find.text(currentAppLocalizations.hideAdvanced), findsOneWidget);
    expect(
      find.text(currentAppLocalizations.tailscaleHostname),
      findsOneWidget,
    );
    expect(
      find.text(currentAppLocalizations.tailscaleControlUrl),
      findsOneWidget,
    );
  });

  testWidgets('TailscaleNodeDialog edit mode expands hostname fields', (
    tester,
  ) async {
    final container = _containerFor(tester);

    await _pumpView(
      tester,
      container,
      const HostScaffold(
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
      find.text(currentAppLocalizations.editTailscaleNode),
      findsOneWidget,
    );
    expect(
      find.text(currentAppLocalizations.tailscaleHostname),
      findsOneWidget,
    );
  });
}
