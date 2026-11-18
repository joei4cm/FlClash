import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'build_cache.dart';
import 'fingerprint.dart';
import 'options.dart';
import 'target.dart';
import 'util.dart';

final _log = Logger('tui_builder');

/// Compiles the desktop `flclash-tui` AOT binary next to Core under libclash/.
class TuiBuilder {
  TuiBuilder({
    required this.rootDir,
    required this.config,
    required this.cache,
    required this.notice,
  });

  final String rootDir;
  final BuildConfig config;
  final BuildCache cache;
  final BuildNotice notice;

  static const binaryName = 'flclash-tui';

  Future<BuildExecution> build(Target target) async {
    final outDir = p.join(rootDir, config.outputDir, target.platformDir);
    ensureDir(outDir);
    final outFile = p.join(outDir, '$binaryName${target.executableExtension}');

    return cache.run(
      key: '${target.platformDir}-${target.goarch}-tui',
      fingerprint: () async => _fingerprint(target),
      primaryOutput: outFile,
      notice: notice,
      build: () async {
        final stagingDir = Directory(
          p.join(outDir, '.staging-tui-${target.goarch}-$pid'),
        );
        final staged = p.join(
          stagingDir.path,
          '$binaryName${target.executableExtension}',
        );
        try {
          ensureDir(stagingDir.path);
          _log.info('Compiling desktop TUI: $target');
          await runCommandStream('dart', [
            'compile',
            'exe',
            'tool/tui.dart',
            '-o',
            staged,
          ], workingDirectory: rootDir);
          replaceFile(staged, outFile);
          if (!Platform.isWindows) {
            runCommand('chmod', ['+x', outFile]);
          }
          _log.info('Built: $outFile');
          return [outFile];
        } finally {
          if (stagingDir.existsSync()) {
            stagingDir.deleteSync(recursive: true);
          }
        }
      },
    );
  }

  Fingerprint _fingerprint(Target target) {
    final builder = FingerprintBuilder(rootDir: rootDir)
      ..addValue('kind', 'flclash-tui')
      ..addValue('goos', target.goos)
      ..addValue('goarch', target.goarch)
      ..addValue('dart', Platform.version)
      ..addFiles(
        collectFiles(
          p.join(rootDir, 'tool', 'tui'),
          include: (relative) => relative.endsWith('.dart'),
        ),
      )
      ..addFile(p.join(rootDir, 'tool', 'tui.dart'));
    return builder.finishWithInputs();
  }
}
