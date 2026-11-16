import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/proxies/auto_group_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/host_scaffold.dart';
import '../helpers/test_app.dart';

void main() {
  testWidgets('AutoGroupBar shows region chips from node names', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        appSettingProvider.overrideWithBuild(
          (_, _) => const AppSettingProps(autoSelectStickyGeo: true),
        ),
        currentProfileIdProvider.overrideWithBuild((_, _) => 1),
      ],
    );
    addTearDown(container.dispose);
    globalState.container = container;

    const group = Group(
      name: 'Auto',
      type: GroupType.URLTest,
      now: 'US-Node',
      all: [
        Proxy(name: 'US-Node', type: 'Shadowsocks'),
        Proxy(name: 'HK-01', type: 'Shadowsocks'),
        Proxy(name: 'JP-Tokyo', type: 'Shadowsocks'),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TestApp(
          child: HostScaffold(body: AutoGroupBar(group: group)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final l10n = AppLocalizations.current;
    expect(find.text(l10n.autoGroupPickRegion), findsOneWidget);
    expect(find.text(l10n.autoGroupRegionNodes('HK', 1)), findsOneWidget);
    expect(find.text(l10n.autoGroupRegionNodes('JP', 1)), findsOneWidget);
    expect(find.text(l10n.autoGroupRegionNodes('US', 1)), findsOneWidget);
    expect(find.text(l10n.autoGroupStickyRegion('US')), findsOneWidget);
  });
}
