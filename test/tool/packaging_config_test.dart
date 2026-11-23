import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('Linux packaging teardown', () {
    for (final format in ['deb', 'rpm']) {
      test('$format removes the Helper unit only on a real uninstall', () {
        final config =
            loadYaml(
                  File(
                    'linux/packaging/$format/make_config.yaml',
                  ).readAsStringSync(),
                )
                as YamlMap;
        final scripts = (config['postuninstall_scripts'] as YamlList)
            .cast<String>();

        expect(scripts.first, contains('exit 0'));
        expect(
          scripts,
          contains('rm -f /etc/systemd/system/flclash-helper.service'),
        );
        expect(
          scripts.any((script) => script.contains('systemctl daemon-reload')),
          isTrue,
        );
      });
    }
  });

  test('rpm keeps the Core bytes the Helper was built against', () {
    final config =
        loadYaml(
              File('linux/packaging/rpm/make_config.yaml').readAsStringSync(),
            )
            as YamlMap;
    final macros = (config['spec_macros'] as YamlList).cast<String>();

    expect(macros, contains('%global debug_package %{nil}'));
    expect(macros, contains('%global __os_install_post %{nil}'));
  });

  test('flclash-tui PATH symlinks match each format install root', () {
    final deb =
        loadYaml(
              File('linux/packaging/deb/make_config.yaml').readAsStringSync(),
            )
            as YamlMap;
    final rpm =
        loadYaml(
              File('linux/packaging/rpm/make_config.yaml').readAsStringSync(),
            )
            as YamlMap;

    expect(
      (deb['postinstall_scripts'] as YamlList).cast<String>(),
      contains('ln -sfn /opt/FlClash/flclash-tui /usr/bin/flclash-tui'),
    );
    expect(
      (rpm['postinstall_scripts'] as YamlList).cast<String>(),
      contains(
        'ln -sfn %{_datadir}/%{name}/flclash-tui %{_bindir}/flclash-tui',
      ),
    );
    for (final format in ['deb', 'rpm']) {
      final config =
          loadYaml(
                File(
                  'linux/packaging/$format/make_config.yaml',
                ).readAsStringSync(),
              )
              as YamlMap;
      expect(
        (config['postuninstall_scripts'] as YamlList).cast<String>(),
        contains('rm -f /usr/bin/flclash-tui'),
      );
    }
  });
}
