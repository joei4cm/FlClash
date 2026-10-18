import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/proxies/auto_group_bar.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AutoGroupBar shows stick to region action', (tester) async {
    final container = ProviderContainer(
      overrides: [
        appSettingProvider.overrideWithBuild(
          (_, _) => const AppSettingProps(autoSelectStickyGeo: true),
        ),
      ],
    );
    addTearDown(container.dispose);
    globalState.container = container;

    const group = Group(
      name: 'Auto',
      type: GroupType.URLTest,
      now: 'US-Node',
      all: [Proxy(name: 'US-Node', type: 'Shadowsocks')],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          home: const Scaffold(body: AutoGroupBar(group: group)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppLocalizations.current.stickToRegion), findsOneWidget);
  });
}
