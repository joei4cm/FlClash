import 'package:fl_clash/enum/enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LauncherIcon.fromId maps known ids and falls back', () {
    expect(LauncherIcon.fromId('tide'), LauncherIcon.tide);
    expect(LauncherIcon.fromId('kitty_cheese'), LauncherIcon.kittyCheese);
    expect(LauncherIcon.fromId('puppy_corgi'), LauncherIcon.puppyCorgi);
    expect(LauncherIcon.fromId('otter'), LauncherIcon.otter);
    expect(LauncherIcon.fromId('mascot_fox'), LauncherIcon.classic);
    expect(LauncherIcon.fromId(null), LauncherIcon.classic);
    expect(LauncherIcon.fromId('missing'), LauncherIcon.classic);
  });

  test('LauncherIcon assets stay under app_icons', () {
    for (final icon in LauncherIcon.values) {
      expect(icon.asset, 'assets/images/app_icons/${icon.id}.png');
    }
  });

  test('LauncherIcon set stays curated without overlapping looks', () {
    expect(LauncherIcon.values.map((icon) => icon.id).toList(), [
      'classic',
      'frost',
      'midnight',
      'indigo',
      'tide',
      'graphite',
      'kitty_cheese',
      'kitty_orange',
      'kitty_black',
      'kitty_calico',
      'puppy_corgi',
      'puppy_dachshund',
      'puppy_bulldog',
      'bunny',
      'hamster',
      'otter',
    ]);
  });
}
