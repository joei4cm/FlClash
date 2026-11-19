import 'package:fl_clash/enum/enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LauncherIcon.fromId maps known ids and falls back', () {
    expect(LauncherIcon.fromId('tide'), LauncherIcon.tide);
    expect(LauncherIcon.fromId(null), LauncherIcon.classic);
    expect(LauncherIcon.fromId('missing'), LauncherIcon.classic);
  });

  test('LauncherIcon assets stay under app_icons', () {
    for (final icon in LauncherIcon.values) {
      expect(icon.asset, 'assets/images/app_icons/${icon.name}.png');
      expect(icon.id, icon.name);
    }
  });
}
