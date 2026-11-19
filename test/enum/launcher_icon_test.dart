import 'package:fl_clash/enum/enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LauncherIcon.fromId maps known ids and falls back', () {
    expect(LauncherIcon.fromId('tide'), LauncherIcon.tide);
    expect(LauncherIcon.fromId('mascot_fox'), LauncherIcon.mascotFox);
    expect(LauncherIcon.fromId('kitty_orange'), LauncherIcon.kittyOrange);
    expect(LauncherIcon.fromId('puppy_shiba'), LauncherIcon.puppyShiba);
    expect(LauncherIcon.fromId('kitty_cheese'), LauncherIcon.kittyCheese);
    expect(LauncherIcon.fromId('puppy_corgi'), LauncherIcon.puppyCorgi);
    expect(LauncherIcon.fromId('red_panda'), LauncherIcon.redPanda);
    expect(LauncherIcon.fromId(null), LauncherIcon.classic);
    expect(LauncherIcon.fromId('missing'), LauncherIcon.classic);
  });

  test('LauncherIcon assets stay under app_icons', () {
    for (final icon in LauncherIcon.values) {
      expect(icon.asset, 'assets/images/app_icons/${icon.id}.png');
    }
  });
}
