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
  testWidgets('AutoGroupBar shows restore when override is set', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        groupsProvider.overrideWithBuild(
          (_, _) => [
            const Group(
              name: 'AUTO',
              type: GroupType.URLTest,
              now: 'node-a',
              all: [Proxy(name: 'node-a', type: 'ss')],
            ),
          ],
        ),
        currentProfileProvider.overrideWithValue(
          const Profile(
            id: 1,
            autoUpdateDuration: Duration.zero,
            selectedMap: {'AUTO': 'node-a'},
            currentGroupName: 'AUTO',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    globalState.container = container;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TestApp(
          child: HostScaffold(
            body: AutoGroupBar(
              group: Group(
                name: 'AUTO',
                type: GroupType.URLTest,
                now: 'node-a',
                all: [Proxy(name: 'node-a', type: 'ss')],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.textContaining('node-a'), findsWidgets);
    expect(
      find.text(AppLocalizations.current.restoreAutoSelect),
      findsOneWidget,
    );
  });
}
