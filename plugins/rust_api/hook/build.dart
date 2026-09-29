import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:flutter_rust_bridge_hooks/flutter_rust_bridge_hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (input.userDefines['build_assets'] == false) {
      stdout.writeln('Skipping the Rust build: user-define build_assets=false');
      return;
    }
    await FlutterRustBridgeNativeAssetsBuilder(
      cratePath: 'rust',
      extraCargoEnvironmentVariables: _bindgenEnvironment(input),
    ).run(input: input, output: output);
  });
}

// rquickjs runs bindgen on Android, which must load the NDK's libclang; Linux
// NDKs before r26 keep it under lib64, later ones and every macOS NDK under lib.
// Flutter may hand an SDK NDK that lacks libclang (e.g. 27.x on CI) while the
// workflow installs r28c — search env roots and ANDROID_HOME/ndk/* for one that
// actually ships libclang.
Map<String, String> _bindgenEnvironment(BuildInput input) {
  if (!input.config.buildCodeAssets ||
      input.config.code.targetOS != OS.android) {
    return const {};
  }
  final compiler = input.config.code.cCompiler?.compiler;
  if (compiler != null) {
    final fromFlutter = _libclangDir(File.fromUri(compiler).parent.parent);
    if (fromFlutter != null) {
      return {'LIBCLANG_PATH': fromFlutter};
    }
  }
  for (final key in const [
    'ANDROID_NDK_HOME',
    'ANDROID_NDK_ROOT',
    'ANDROID_NDK',
    'ANDROID_NDK_LATEST_HOME',
  ]) {
    final ndkRoot = Platform.environment[key];
    if (ndkRoot == null || ndkRoot.isEmpty) {
      continue;
    }
    final fromEnv = _libclangDirFromNdkRoot(ndkRoot);
    if (fromEnv != null) {
      stdout.writeln(
        'Using LIBCLANG_PATH from $key (Flutter NDK lacked libclang)',
      );
      return {'LIBCLANG_PATH': fromEnv};
    }
  }
  final androidHome = Platform.environment['ANDROID_HOME'];
  if (androidHome != null && androidHome.isNotEmpty) {
    final ndkDir = Directory('$androidHome${Platform.pathSeparator}ndk');
    if (ndkDir.existsSync()) {
      final versions = ndkDir.listSync().whereType<Directory>().toList()
        ..sort((a, b) => b.path.compareTo(a.path));
      for (final version in versions) {
        final found = _libclangDirFromNdkRoot(version.path);
        if (found != null) {
          stdout.writeln(
            'Using LIBCLANG_PATH from ${version.path} '
            '(Flutter NDK lacked libclang)',
          );
          return {'LIBCLANG_PATH': found};
        }
      }
    }
  }
  final hint = compiler != null
      ? File.fromUri(compiler).parent.parent.path
      : '(no cCompiler from Flutter)';
  throw StateError(
    'No libclang under $hint (lib or lib64), and no Android NDK with '
    'libclang was found via ANDROID_NDK_* / ANDROID_HOME; cannot run '
    'bindgen for rquickjs',
  );
}

String? _libclangDirFromNdkRoot(String ndkRoot) {
  final prebuilt = Directory(
    '$ndkRoot${Platform.pathSeparator}toolchains'
    '${Platform.pathSeparator}llvm'
    '${Platform.pathSeparator}prebuilt',
  );
  if (!prebuilt.existsSync()) {
    return null;
  }
  for (final host in prebuilt.listSync().whereType<Directory>()) {
    final found = _libclangDir(host);
    if (found != null) {
      return found;
    }
  }
  return null;
}

String? _libclangDir(Directory llvmRoot) {
  for (final name in const ['lib', 'lib64']) {
    final directory = Directory(
      '${llvmRoot.path}${Platform.pathSeparator}$name',
    );
    if (directory.existsSync() && directory.listSync().any(_isLibclang)) {
      return directory.path;
    }
  }
  return null;
}

bool _isLibclang(FileSystemEntity entity) {
  return entity.path.split(Platform.pathSeparator).last.startsWith('libclang.');
}
