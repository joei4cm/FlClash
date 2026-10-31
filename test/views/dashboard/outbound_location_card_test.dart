import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/service_probe.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/outbound_ip.dart';
import 'package:fl_clash/providers/routed_probe.dart';
import 'package:fl_clash/views/dashboard/layout.dart';
import 'package:fl_clash/views/dashboard/widgets/outbound_location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/test_app.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await WorldMapData.load();
  });

  Future<void> pumpCard(
    WidgetTester tester, {
    required DashboardDensity density,
    IpInfo? info,
    ProbePhase? phase,
  }) async {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      TestApp(
        locale: const Locale('en'),
        overrides: [
          outboundIpProbeProvider.overrideWithBuild(
            (_, _) => RoutedProbeState({
              routedOutbound: ProbeEntry(
                phase:
                    phase ??
                    (info == null ? ProbePhase.empty : ProbePhase.fresh),
                value: info,
              ),
            }),
          ),
        ],
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 420,
            height: density.isDesktop ? 220 : null,
            child: DashboardDensityScope(
              density: density,
              scale: 1,
              child: const OutboundLocationCard(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('shows the exit country on the desktop map', (tester) async {
    await pumpCard(
      tester,
      density: DashboardDensity.standard,
      info: const IpInfo(
        ip: '8.8.8.8',
        countryCode: 'us',
        latitude: 37.39,
        longitude: -122.08,
      ),
    );

    expect(find.text('Exit location'), findsOneWidget);
    expect(find.text('US'), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a phone lays the same map out at the world aspect', (
    tester,
  ) async {
    await pumpCard(tester, density: DashboardDensity.mobile);

    expect(find.text('Exit location'), findsOneWidget);
    expect(find.text('US'), findsNothing);
    final card = tester.getSize(find.byType(OutboundLocationCard));
    expect(card.width, 420);
    expect(card.height, greaterThan(420 / 2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('a failed probe shows the error instead of a blank map', (
    tester,
  ) async {
    await pumpCard(
      tester,
      density: DashboardDensity.standard,
      phase: ProbePhase.failed,
    );

    expect(find.text('Exit location'), findsOneWidget);
    expect(find.text('Check failed'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
