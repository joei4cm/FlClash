import 'dart:ffi';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:fl_clash/common/app_update.dart';
import 'package:fl_clash/common/app_update_installer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const assets = [
    'FlClash-0.9.8-android-arm64-v8a.apk',
    'FlClash-0.9.8-android-armeabi-v7a.apk',
    'FlClash-0.9.8-android-x86_64.apk',
    'FlClash-0.9.8-linux-amd64.AppImage',
    'FlClash-0.9.8-linux-amd64.deb',
    'FlClash-0.9.8-linux-amd64.rpm',
    'FlClash-0.9.8-linux-arm64.AppImage',
    'FlClash-0.9.8-macos-arm64.dmg',
    'FlClash-0.9.8-macos-amd64.dmg',
    'SHA256SUMS',
  ];

  List<ReleaseAsset> listed() {
    return [
      for (final name in assets)
        if (name != 'SHA256SUMS')
          ReleaseAsset(
            name: name,
            downloadUrl:
                'https://github.com/joei4cm/FlClash/releases/download/v0.9.8_8784e8/$name',
          ),
    ];
  }

  UpdateCandidate only(UpdateHost host) {
    final candidates = updateCandidates(
      tag: 'v0.9.8_8784e8',
      assets: listed(),
      assetsKnown: true,
      host: host,
    );
    expect(candidates, hasLength(1));
    return candidates.single;
  }

  test('picks the package for this device', () {
    expect(
      only(
        updateHost(operatingSystem: 'android', abi: Abi.androidArm64)!,
      ).asset.name,
      'FlClash-0.9.8-android-arm64-v8a.apk',
    );
    expect(
      only(
        updateHost(operatingSystem: 'android', abi: Abi.androidArm)!,
      ).asset.name,
      'FlClash-0.9.8-android-armeabi-v7a.apk',
    );
    expect(
      only(
        updateHost(
          operatingSystem: 'linux',
          abi: Abi.linuxArm64,
          linuxLayout: LinuxInstallLayout.appImage,
        )!,
      ).apply,
      UpdateApply.appImageReplace,
    );
    final deb = updateCandidates(
      tag: 'v0.9.8_8784e8',
      assets: listed(),
      assetsKnown: true,
      host: updateHost(
        operatingSystem: 'linux',
        abi: Abi.linuxX64,
        linuxLayout: LinuxInstallLayout.deb,
      )!,
    );
    expect(deb.map((candidate) => candidate.apply), [
      UpdateApply.deb,
      UpdateApply.appImageLaunch,
    ]);
    final rpm = updateCandidates(
      tag: 'v0.9.8_8784e8',
      assets: listed(),
      assetsKnown: true,
      host: updateHost(
        operatingSystem: 'linux',
        abi: Abi.linuxX64,
        linuxLayout: LinuxInstallLayout.rpm,
      )!,
    );
    expect(rpm.first.apply, UpdateApply.rpm);
    expect(
      only(updateHost(operatingSystem: 'macos', abi: Abi.macosX64)!).asset.name,
      'FlClash-0.9.8-macos-amd64.dmg',
    );
    expect(updateHost(operatingSystem: 'windows', abi: Abi.windowsX64), isNull);
  });

  test(
    'a deb install falls back to an AppImage when the package is absent',
    () {
      final host = updateHost(
        operatingSystem: 'linux',
        abi: Abi.linuxX64,
        linuxLayout: LinuxInstallLayout.deb,
      )!;
      final candidates = updateCandidates(
        tag: 'v0.9.8_8784e8',
        assets: listed()
            .where((asset) => !asset.name.endsWith('.deb'))
            .toList(),
        assetsKnown: true,
        host: host,
      );
      expect(candidates.single.apply, UpdateApply.appImageLaunch);
      expect(candidates.single.asset.name, endsWith('.AppImage'));
    },
  );

  test('Apple Silicon uses the Intel disk image when arm64 is missing', () {
    final host = updateHost(operatingSystem: 'macos', abi: Abi.macosArm64)!;
    final candidates = updateCandidates(
      tag: 'v0.9.8_8784e8',
      assets: listed()
          .where((asset) => !asset.name.endsWith('macos-arm64.dmg'))
          .toList(),
      assetsKnown: true,
      host: host,
    );
    expect(candidates.single.asset.name, endsWith('macos-amd64.dmg'));
  });

  test('an unknown asset list builds the stable download url', () {
    final host = updateHost(operatingSystem: 'android', abi: Abi.androidX64)!;
    final candidates = updateCandidates(
      tag: 'v0.9.8_8784e8',
      assets: const [],
      assetsKnown: false,
      host: host,
    );
    expect(
      candidates.single.asset.downloadUrl,
      'https://github.com/joei4cm/FlClash/releases/download/'
      'v0.9.8_8784e8/FlClash-0.9.8-android-x86_64.apk',
    );
    expect(releaseFileVersion('v0.9.8-pre.1_abcdef'), '0.9.8');
  });

  test('drops download urls that are not this repository release', () {
    final release = {
      'assets': [
        {
          'name': 'FlClash-0.9.8-android-arm64-v8a.apk',
          'browser_download_url': 'https://example.com/FlClash.apk',
        },
      ],
    };
    expect(releaseAssetsFrom(release), isEmpty);
    expect(releaseListsAssets(release), isTrue);
  });

  test('reads the published checksum names', () {
    final hash = 'ab' * 32;
    final body = '$hash  ./FlClash-0.9.8-linux-amd64.deb\n';
    expect(parseSha256Sums(body)['FlClash-0.9.8-linux-amd64.deb'], hash);
  });

  test('finds the macOS bundle and decides when an admin copy is required', () {
    expect(
      macOSAppBundle('/Applications/FlClash.app/Contents/MacOS/FlClash'),
      '/Applications/FlClash.app',
    );
    expect(macOSAppBundle('/usr/bin/FlClash'), isNull);
    expect(
      chooseMountedApp(['/mnt/Applications', '/mnt/FlClash.app']),
      '/mnt/FlClash.app',
    );
    expect(
      macUpdateNeedsAdmin(
        bundleExists: true,
        userOwnsBundle: false,
        directoryWritable: true,
      ),
      isTrue,
    );
    expect(
      macUpdateNeedsAdmin(
        bundleExists: true,
        userOwnsBundle: true,
        directoryWritable: true,
      ),
      isFalse,
    );
  });

  test(
    'the relaunch script waits until the running process drops its lock',
    () {
      expect(linuxRelaunchScript(), contains('flock'));
      final script = macOSUpdateScript(
        needsAdmin: true,
        rootScript: '/tmp/swap root.sh',
      );
      expect(script, contains('quoted form of'));
      expect(script, contains("'/tmp/swap root.sh'"));
      expect(
        macOSRootSwapScript(
          destination: "/Applications/FlClash's.app",
          stagedApp: '/tmp/FlClash.app',
        ),
        contains(r"'/Applications/FlClash'\''s.app'"),
      );
    },
  );

  test('linux package detection follows the running binary', () async {
    Future<ProcessResult> run(String executable, List<String> arguments) async {
      final owns = executable == 'dpkg' && arguments.last == '/usr/bin/FlClash';
      return ProcessResult(0, owns ? 0 : 1, '', '');
    }

    expect(
      await detectLinuxInstallLayout(
        appImage: true,
        executable: '/usr/bin/FlClash',
        runProcess: run,
      ),
      LinuxInstallLayout.appImage,
    );
    expect(
      await detectLinuxInstallLayout(
        appImage: false,
        executable: '/usr/bin/FlClash',
        runProcess: run,
      ),
      LinuxInstallLayout.deb,
    );
    expect(
      await detectLinuxInstallLayout(
        appImage: false,
        executable: '/opt/FlClash',
        runProcess: run,
      ),
      LinuxInstallLayout.portable,
    );
  });

  test('a file hash must match the published checksum', () async {
    final file = File('${Directory.systemTemp.path}/flclash-update-hash-test');
    await file.writeAsString('payload');
    addTearDown(file.delete);
    final installer = AppUpdateInstaller();
    await installer.verifyFileHash(
      file,
      sha256.convert(file.readAsBytesSync()).toString(),
    );
    await expectLater(
      installer.verifyFileHash(file, '0' * 64),
      throwsA(
        isA<UpdateFailed>().having(
          (error) => error.failure,
          'failure',
          UpdateFailure.checksum,
        ),
      ),
    );
  });

  test(
    'an AppImage is replaced and relaunched after this process exits',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'flclash-update-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final current = File('${directory.path}/FlClash.AppImage')
        ..writeAsStringSync('old');
      final downloaded = File('${directory.path}/new.AppImage')
        ..writeAsStringSync('new');
      List<String>? relaunch;
      final installer = AppUpdateInstaller(
        appImagePath: current.path,
        lockFilePath: () async => '${directory.path}/FlClash.lock',
        runProcess: (executable, arguments) async {
          if (executable == 'rm' && arguments.last == '${current.path}.old') {
            final backup = File(arguments.last);
            if (backup.existsSync()) {
              backup.deleteSync();
            }
          } else if (executable == 'mv') {
            await File(arguments[0]).rename(arguments[1]);
          }
          return ProcessResult(0, 0, '', '');
        },
        startDetached: (executable, arguments) async {
          relaunch = [executable, ...arguments];
        },
      );

      final outcome = await installer.applyDownloaded(
        file: downloaded,
        apply: UpdateApply.appImageReplace,
        directory: directory,
      );

      expect(outcome, UpdateInstallOutcome.scheduledRestart);
      expect(current.readAsStringSync(), 'new');
      expect(File('${current.path}.old').readAsStringSync(), 'old');
      expect(relaunch, isNotNull);
      expect(relaunch!.first, '/bin/sh');
      expect(relaunch!.last, current.path);
      expect(File(relaunch![1]).readAsStringSync(), contains('flock'));
    },
  );
}
