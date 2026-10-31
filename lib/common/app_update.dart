import 'dart:ffi';

import 'package:fl_clash/common/constant.dart';

enum LinuxInstallLayout { appImage, deb, rpm, portable }

enum UpdateApply { apk, appImageReplace, appImageLaunch, deb, rpm, dmg }

enum UpdatePhase { download, verify, install }

enum UpdateFailure { checksum, missingPackage, install }

final class UpdateFailed implements Exception {
  const UpdateFailed(this.failure, [this.detail = '']);

  final UpdateFailure failure;
  final String detail;

  @override
  String toString() => detail.isEmpty ? '$failure' : '$failure: $detail';
}

final class UpdateCancelled implements Exception {
  const UpdateCancelled();
}

enum UpdateInstallOutcome {
  scheduledRestart,
  androidInstaller,
  needsPermission,
}

final class ReleaseAsset {
  const ReleaseAsset({required this.name, required this.downloadUrl});

  final String name;
  final String downloadUrl;
}

final class UpdateCandidate {
  const UpdateCandidate({required this.asset, required this.apply});

  final ReleaseAsset asset;
  final UpdateApply apply;
}

final class UpdateHost {
  const UpdateHost({required this.preferences});

  final List<({String suffix, UpdateApply apply})> preferences;
}

bool supportsInAppUpdate({
  required bool isAndroid,
  required bool isLinux,
  required bool isMacOS,
}) {
  return isAndroid || isLinux || isMacOS;
}

bool isGitHubReleaseDownload(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null || uri.scheme != 'https' || uri.host != 'github.com') {
    return false;
  }
  return uri.path.startsWith('/$repository/releases/download/');
}

String? releaseFileVersion(String tag) {
  return RegExp(r'^v?(\d+\.\d+\.\d+)').firstMatch(tag.trim())?.group(1);
}

List<ReleaseAsset> releaseAssetsFrom(Map<String, dynamic> release) {
  final raw = release['assets'];
  if (raw is! List) {
    return const [];
  }
  final assets = <ReleaseAsset>[];
  for (final item in raw) {
    if (item is! Map) {
      continue;
    }
    final name = item['name'];
    final url = item['browser_download_url'];
    if (name is! String || url is! String || !isGitHubReleaseDownload(url)) {
      continue;
    }
    assets.add(ReleaseAsset(name: name, downloadUrl: url));
  }
  return assets;
}

bool releaseListsAssets(Map<String, dynamic> release) =>
    release['assets'] is List;

UpdateHost? updateHost({
  required String operatingSystem,
  required Abi abi,
  LinuxInstallLayout linuxLayout = LinuxInstallLayout.portable,
}) {
  switch (operatingSystem) {
    case 'android':
      final arch = switch (abi) {
        Abi.androidArm64 => 'arm64-v8a',
        Abi.androidArm => 'armeabi-v7a',
        Abi.androidX64 => 'x86_64',
        _ => null,
      };
      if (arch == null) {
        return null;
      }
      return UpdateHost(
        preferences: [(suffix: '-android-$arch.apk', apply: UpdateApply.apk)],
      );
    case 'macos':
      final arch = switch (abi) {
        Abi.macosArm64 => 'arm64',
        Abi.macosX64 => 'amd64',
        _ => null,
      };
      if (arch == null) {
        return null;
      }
      return UpdateHost(
        preferences: [
          (suffix: '-macos-$arch.dmg', apply: UpdateApply.dmg),
          if (arch == 'arm64')
            (suffix: '-macos-amd64.dmg', apply: UpdateApply.dmg),
        ],
      );
    case 'linux':
      final arch = switch (abi) {
        Abi.linuxX64 => 'amd64',
        Abi.linuxArm64 => 'arm64',
        _ => null,
      };
      if (arch == null) {
        return null;
      }
      final packaged = switch (linuxLayout) {
        LinuxInstallLayout.deb => (
          suffix: '-linux-$arch.deb',
          apply: UpdateApply.deb,
        ),
        LinuxInstallLayout.rpm => (
          suffix: '-linux-$arch.rpm',
          apply: UpdateApply.rpm,
        ),
        LinuxInstallLayout.appImage => (
          suffix: '-linux-$arch.AppImage',
          apply: UpdateApply.appImageReplace,
        ),
        LinuxInstallLayout.portable => null,
      };
      return UpdateHost(
        preferences: [
          ?packaged,
          (
            suffix: '-linux-$arch.AppImage',
            apply: linuxLayout == LinuxInstallLayout.appImage
                ? UpdateApply.appImageReplace
                : UpdateApply.appImageLaunch,
          ),
        ],
      );
    default:
      return null;
  }
}

List<UpdateCandidate> updateCandidates({
  required String tag,
  required List<ReleaseAsset> assets,
  required bool assetsKnown,
  required UpdateHost host,
}) {
  final candidates = <UpdateCandidate>[];
  final seen = <String>{};
  for (final preference in host.preferences) {
    if (preference.suffix.isEmpty || !seen.add(preference.suffix)) {
      continue;
    }
    final listed = _listedAsset(assets, preference.suffix);
    if (listed != null) {
      candidates.add(UpdateCandidate(asset: listed, apply: preference.apply));
      continue;
    }
    if (assetsKnown) {
      continue;
    }
    final version = releaseFileVersion(tag);
    if (version == null) {
      continue;
    }
    final name = 'FlClash-$version${preference.suffix}';
    candidates.add(
      UpdateCandidate(
        asset: ReleaseAsset(
          name: name,
          downloadUrl: releaseDownloadUrl(tag, name),
        ),
        apply: preference.apply,
      ),
    );
  }
  return candidates;
}

ReleaseAsset? checksumAsset({
  required String tag,
  required List<ReleaseAsset> assets,
  required bool assetsKnown,
}) {
  for (final asset in assets) {
    if (asset.name == 'SHA256SUMS') {
      return asset;
    }
  }
  if (assetsKnown) {
    return null;
  }
  return ReleaseAsset(
    name: 'SHA256SUMS',
    downloadUrl: releaseDownloadUrl(tag, 'SHA256SUMS'),
  );
}

String releaseDownloadUrl(String tag, String name) {
  return 'https://github.com/$repository/releases/download/'
      '${Uri.encodeComponent(tag)}/${Uri.encodeComponent(name)}';
}

Map<String, String> parseSha256Sums(String body) {
  final sums = <String, String>{};
  for (final raw in body.split('\n')) {
    final line = raw.trim();
    if (line.isEmpty || line.startsWith('#')) {
      continue;
    }
    final match = RegExp(r'^([0-9a-fA-F]{64})\s+\*?(.+)$').firstMatch(line);
    if (match == null) {
      continue;
    }
    var name = match.group(2)!.trim();
    if (name.startsWith('./')) {
      name = name.substring(2);
    }
    sums[name] = match.group(1)!.toLowerCase();
  }
  return sums;
}

String? macOSAppBundle(String executable) {
  final normalized = executable.replaceAll('\\', '/');
  final list = [
    for (final part in normalized.split('/'))
      if (part.isNotEmpty) part,
  ];
  final index = list.lastIndexOf('MacOS');
  if (index < 2 || list[index - 1] != 'Contents') {
    return null;
  }
  if (!list[index - 2].endsWith('.app')) {
    return null;
  }
  final root = normalized.startsWith('/') ? '/' : '';
  return '$root${list.sublist(0, index - 1).join('/')}';
}

String? chooseMountedApp(Iterable<String> paths) {
  final apps = [
    for (final path in paths)
      if (path.endsWith('.app')) path,
  ];
  for (final path in apps) {
    if (path.endsWith('/FlClash.app') || path == 'FlClash.app') {
      return path;
    }
  }
  if (apps.isEmpty) {
    return null;
  }
  return apps.first;
}

bool macUpdateNeedsAdmin({
  required bool bundleExists,
  required bool userOwnsBundle,
  required bool directoryWritable,
}) {
  if (!directoryWritable) {
    return true;
  }
  if (!bundleExists) {
    return false;
  }
  return !userOwnsBundle;
}

String shellSingleQuote(String value) => "'${value.replaceAll("'", r"'\''")}'";

String linuxRelaunchScript() => '''
#!/bin/sh
set -eu
lock=\$1
target=\$2
if command -v flock >/dev/null 2>&1; then
  while ! flock -n "\$lock" -c true; do
    sleep 0.2
  done
else
  sleep 1
fi
exec "\$target"
''';

String macOSUpdateScript({
  required bool needsAdmin,
  required String rootScript,
}) {
  final swap = needsAdmin
      ? 'osascript -e \'on run argv\' -e \'do shell script "/bin/sh " & quoted form of (item 1 of argv) with administrator privileges\' -e \'end run\' ${shellSingleQuote(rootScript)}'
      : '''
rm -rf "\$dest"
ditto "\$staged" "\$dest"
xattr -dr com.apple.quarantine "\$dest" || true
''';
  return '''
#!/bin/sh
set -eu
pid=\$1
dest=\$2
staged=\$3
while kill -0 "\$pid" 2>/dev/null; do
  sleep 0.2
done
sleep 0.5
$swap
open "\$dest"
rm -rf "\$staged"
rm -f "\$0"
''';
}

String macOSRootSwapScript({
  required String destination,
  required String stagedApp,
}) =>
    '''
#!/bin/sh
set -eu
rm -rf ${shellSingleQuote(destination)}
ditto ${shellSingleQuote(stagedApp)} ${shellSingleQuote(destination)}
xattr -dr com.apple.quarantine ${shellSingleQuote(destination)} || true
''';

List<List<String>> appImageReplaceCommands({
  required String currentPath,
  required String downloadedPath,
}) {
  return [
    ['rm', '-f', '$currentPath.old'],
    ['chmod', 'a+x', downloadedPath],
    ['mv', currentPath, '$currentPath.old'],
    ['mv', downloadedPath, currentPath],
  ];
}

List<String> packageInstallCommand(UpdateApply apply, String path) {
  return switch (apply) {
    UpdateApply.deb => [
      'env',
      'DEBIAN_FRONTEND=noninteractive',
      'dpkg',
      '-i',
      path,
    ],
    UpdateApply.rpm => ['rpm', '-U', path],
    _ => const [],
  };
}

ReleaseAsset? _listedAsset(List<ReleaseAsset> assets, String suffix) {
  for (final asset in assets) {
    if (asset.name.startsWith('FlClash-') && asset.name.endsWith(suffix)) {
      return asset;
    }
  }
  return null;
}
