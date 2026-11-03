import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fl_clash/common/app_update.dart';
import 'package:fl_clash/common/constant.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

typedef ProcessRunner =
    Future<ProcessResult> Function(String executable, List<String> arguments);

typedef DetachedStarter =
    Future<void> Function(String executable, List<String> arguments);

typedef CommandElevator = Future<bool> Function(List<String> command);

class AppUpdateInstaller {
  AppUpdateInstaller({
    Dio? dio,
    ProcessRunner? runProcess,
    DetachedStarter? startDetached,
    this.elevate,
    this.installApk,
    this.lockFilePath,
    this.portableDirectory,
    this.appImagePath,
    this.executablePath,
    this.workspace,
  }) : dio = dio ?? createUpdateDio(),
       runProcess = runProcess ?? Process.run,
       startDetached = startDetached ?? startDetachedProcess;

  final Dio dio;
  final ProcessRunner runProcess;
  final DetachedStarter startDetached;
  final CommandElevator? elevate;
  final Future<bool> Function(String path)? installApk;
  final Future<String> Function()? lockFilePath;
  final Future<String> Function()? portableDirectory;
  final String? appImagePath;
  final String? executablePath;
  final Directory? workspace;

  final CancelToken _cancelToken = CancelToken();

  void cancel() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  Future<UpdateInstallOutcome> install({
    required Map<String, dynamic> release,
    required UpdateHost host,
    void Function(UpdatePhase phase, double? fraction)? onProgress,
  }) async {
    final tag = release['tag_name'];
    if (tag is! String || tag.isEmpty) {
      throw const UpdateFailed(UpdateFailure.missingPackage);
    }
    final assets = releaseAssetsFrom(release);
    final known = releaseListsAssets(release);
    final candidates = updateCandidates(
      tag: tag,
      assets: assets,
      assetsKnown: known,
      host: host,
    );
    if (candidates.isEmpty) {
      throw const UpdateFailed(UpdateFailure.missingPackage);
    }
    final directory =
        workspace ??
        await (await getTemporaryDirectory()).createTemp('flclash-update-');
    var keepWorkspace = false;
    UpdateApply? applied;
    try {
      final downloaded = await _downloadCandidate(
        candidates,
        directory,
        onProgress,
      );
      _throwIfCancelled();
      onProgress?.call(UpdatePhase.verify, null);
      await _verify(
        file: downloaded.file,
        name: downloaded.candidate.asset.name,
        tag: tag,
        assets: assets,
        assetsKnown: known,
      );
      _throwIfCancelled();
      onProgress?.call(UpdatePhase.install, null);
      applied = downloaded.candidate.apply;
      final outcome = await _apply(
        file: downloaded.file,
        apply: downloaded.candidate.apply,
        directory: directory,
      );
      keepWorkspace =
          workspace == null &&
          (outcome == UpdateInstallOutcome.androidInstaller ||
              (outcome == UpdateInstallOutcome.scheduledRestart &&
                  _keepsDownloadedPackage(applied)));
      return outcome;
    } on DioException catch (error) {
      if (CancelToken.isCancel(error)) {
        throw const UpdateCancelled();
      }
      throw UpdateFailed(UpdateFailure.install, error.message ?? '');
    } finally {
      if (!keepWorkspace && workspace == null && directory.existsSync()) {
        await directory.delete(recursive: true);
      }
    }
  }

  Future<({UpdateCandidate candidate, File file})> _downloadCandidate(
    List<UpdateCandidate> candidates,
    Directory directory,
    void Function(UpdatePhase phase, double? fraction)? onProgress,
  ) async {
    for (final candidate in candidates) {
      final name = candidate.asset.name;
      if (!isSafeReleaseAssetName(name)) {
        continue;
      }
      final file = File(p.join(directory.path, p.basename(name)));
      final resolved = p.normalize(file.absolute.path);
      if (!p.isWithin(directory.absolute.path, resolved) &&
          resolved != p.normalize(directory.absolute.path)) {
        continue;
      }
      try {
        onProgress?.call(UpdatePhase.download, null);
        await _downloadToFile(
          candidate.asset.downloadUrl,
          file,
          onProgress: onProgress,
        );
        return (candidate: candidate, file: file);
      } on DioException catch (error) {
        if (CancelToken.isCancel(error)) {
          rethrow;
        }
        if (error.response?.statusCode == 404) {
          continue;
        }
        rethrow;
      }
    }
    throw const UpdateFailed(UpdateFailure.missingPackage);
  }

  Future<void> _downloadToFile(
    String url,
    File file, {
    void Function(UpdatePhase phase, double? fraction)? onProgress,
  }) async {
    final response = await _getAllowed(
      url,
      options: Options(
        responseType: ResponseType.stream,
        receiveTimeout: const Duration(minutes: 15),
        validateStatus: (status) => status != null && status < 400,
      ),
    );
    _throwIfCancelled();
    final body = response.data;
    if (body is! ResponseBody) {
      throw const UpdateFailed(UpdateFailure.install);
    }
    final sink = file.openWrite();
    try {
      var received = 0;
      final total = contentLengthOf(response.headers);
      await for (final chunk in body.stream) {
        _throwIfCancelled();
        sink.add(chunk);
        received += chunk.length;
        onProgress?.call(
          UpdatePhase.download,
          total != null && total > 0 ? received / total : null,
        );
      }
    } finally {
      await sink.close();
    }
  }

  Future<void> _verify({
    required File file,
    required String name,
    required String tag,
    required List<ReleaseAsset> assets,
    required bool assetsKnown,
  }) async {
    final checksum = checksumAsset(
      tag: tag,
      assets: assets,
      assetsKnown: assetsKnown,
    );
    if (checksum == null) {
      throw const UpdateFailed(UpdateFailure.checksum);
    }
    final response = await _getAllowed(
      checksum.downloadUrl,
      options: Options(
        responseType: ResponseType.plain,
        // Keep verify shorter than the package download; a hung sums fetch
        // previously left the progress dialog on "Checking the download".
        receiveTimeout: const Duration(minutes: 2),
        sendTimeout: const Duration(seconds: 30),
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    _throwIfCancelled();
    if (response.statusCode == 404) {
      throw const UpdateFailed(UpdateFailure.checksum);
    }
    final sums = parseSha256Sums('${response.data ?? ''}');
    final expected = sums[name];
    if (expected == null) {
      throw const UpdateFailed(UpdateFailure.checksum);
    }
    await verifyFileHash(file, expected);
  }

  /// Follow redirects only onto the GitHub download CDN allowlist.
  Future<Response<T>> _getAllowed<T>(
    String url, {
    required Options options,
  }) async {
    var current = url;
    for (var hop = 0; hop < 8; hop++) {
      _throwIfCancelled();
      final uri = Uri.tryParse(current);
      if (uri == null ||
          uri.scheme != 'https' ||
          !isAllowedUpdateDownloadHost(uri.host)) {
        throw const UpdateFailed(UpdateFailure.install);
      }
      if (hop == 0 && !isGitHubReleaseDownload(current)) {
        throw const UpdateFailed(UpdateFailure.install);
      }
      final response = await dio.getUri<T>(
        uri,
        cancelToken: _cancelToken,
        options: options.copyWith(followRedirects: false, maxRedirects: 0),
      );
      final status = response.statusCode ?? 0;
      if (status >= 300 && status < 400) {
        final location = response.headers.value('location');
        if (location == null || location.isEmpty) {
          throw const UpdateFailed(UpdateFailure.install);
        }
        current = uri.resolve(location).toString();
        continue;
      }
      return response;
    }
    throw const UpdateFailed(UpdateFailure.install);
  }

  @visibleForTesting
  Future<UpdateInstallOutcome> applyDownloaded({
    required File file,
    required UpdateApply apply,
    required Directory directory,
  }) {
    return _apply(file: file, apply: apply, directory: directory);
  }

  @visibleForTesting
  Future<void> verifyFileHash(File file, String expected) async {
    _throwIfCancelled();
    // Hash off the UI isolate so a large installer does not freeze the
    // progress dialog on the verify step.
    final digest = await Isolate.run(() => _sha256File(file.path));
    _throwIfCancelled();
    if (digest != expected) {
      throw const UpdateFailed(UpdateFailure.checksum);
    }
  }

  void _throwIfCancelled() {
    if (_cancelToken.isCancelled) {
      throw const UpdateCancelled();
    }
  }

  Future<UpdateInstallOutcome> _apply({
    required File file,
    required UpdateApply apply,
    required Directory directory,
  }) async {
    _throwIfCancelled();
    switch (apply) {
      case UpdateApply.apk:
        final install = installApk;
        if (install == null) {
          throw const UpdateFailed(UpdateFailure.install);
        }
        final accepted = await install(file.path);
        return accepted
            ? UpdateInstallOutcome.androidInstaller
            : UpdateInstallOutcome.needsPermission;
      case UpdateApply.appImageReplace:
        await _replaceAppImage(file);
        await _scheduleLinuxRelaunch(_appImage);
        return UpdateInstallOutcome.scheduledRestart;
      case UpdateApply.appImageLaunch:
        final destination = await _stagePortableAppImage(file);
        await _scheduleLinuxRelaunch(destination);
        return UpdateInstallOutcome.scheduledRestart;
      case UpdateApply.deb:
      case UpdateApply.rpm:
        final elevateCommand = elevate;
        if (elevateCommand == null) {
          throw const UpdateFailed(UpdateFailure.install);
        }
        final installed = await elevateCommand(
          packageInstallCommand(apply, file.path),
        );
        if (!installed) {
          throw const UpdateFailed(UpdateFailure.install);
        }
        await _scheduleLinuxRelaunch(_executable);
        return UpdateInstallOutcome.scheduledRestart;
      case UpdateApply.dmg:
        await _scheduleMacSwap(file, directory);
        return UpdateInstallOutcome.scheduledRestart;
      case UpdateApply.windowsSetup:
      case UpdateApply.windowsZip:
        await _scheduleWindowsUpdate(file, directory, apply);
        return UpdateInstallOutcome.scheduledRestart;
    }
  }

  Future<void> _scheduleWindowsUpdate(
    File package,
    Directory directory,
    UpdateApply apply,
  ) async {
    _throwIfCancelled();
    final installDir = p.dirname(_executable);
    final script = File(p.join(directory.path, 'flclash-update.ps1'));
    await script.writeAsString(windowsUpdateScript());
    await startDetached(_powerShell, [
      '-NoProfile',
      '-ExecutionPolicy',
      'Bypass',
      '-File',
      script.path,
      '-ProcessId',
      '$pid',
      '-Package',
      package.path,
      '-InstallDir',
      installDir,
      '-Mode',
      apply == UpdateApply.windowsSetup ? 'setup' : 'zip',
      '-Workspace',
      directory.path,
    ]);
  }

  Future<void> _replaceAppImage(File downloaded) async {
    final current = _appImage;
    final commands = appImageReplaceCommands(
      currentPath: current,
      downloadedPath: downloaded.path,
    );
    for (var index = 0; index < commands.length; index++) {
      final result = await _run(commands[index][0], commands[index].sublist(1));
      if (result.exitCode == 0) {
        continue;
      }
      if (index == commands.length - 1) {
        await _run('mv', ['$current.old', current]);
      }
      throw UpdateFailed(
        UpdateFailure.install,
        result.stderr.toString().trim(),
      );
    }
  }

  Future<String> _stagePortableAppImage(File downloaded) async {
    final directory = portableDirectory == null
        ? _fallbackPortableDirectory()
        : await portableDirectory!.call();
    await Directory(directory).create(recursive: true);
    final destination = p.join(directory, p.basename(downloaded.path));
    final result = await _run('chmod', ['a+x', downloaded.path]);
    if (result.exitCode != 0) {
      throw UpdateFailed(UpdateFailure.install, result.stderr.toString());
    }
    if (downloaded.path != destination) {
      final moved = await _run('mv', [downloaded.path, destination]);
      if (moved.exitCode != 0) {
        throw UpdateFailed(UpdateFailure.install, moved.stderr.toString());
      }
    }
    return destination;
  }

  Future<void> _scheduleLinuxRelaunch(String target) async {
    _throwIfCancelled();
    final lock = lockFilePath;
    if (lock == null) {
      throw const UpdateFailed(UpdateFailure.install);
    }
    final script = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}flclash-relaunch-$pid.sh',
    );
    await script.writeAsString(linuxRelaunchScript());
    final chmod = await _run('chmod', ['700', script.path]);
    if (chmod.exitCode != 0) {
      throw UpdateFailed(UpdateFailure.install, chmod.stderr.toString());
    }
    await startDetached('/bin/sh', [script.path, await lock(), target]);
  }

  Future<void> _scheduleMacSwap(File dmg, Directory directory) async {
    _throwIfCancelled();
    final bundle = macOSAppBundle(_executable);
    if (bundle == null) {
      throw const UpdateFailed(UpdateFailure.install);
    }
    final mount = Directory(p.join(directory.path, 'mnt'))..createSync();
    final attached = await _run('hdiutil', [
      'attach',
      '-nobrowse',
      '-readonly',
      '-mountpoint',
      mount.path,
      dmg.path,
    ]);
    if (attached.exitCode != 0) {
      throw UpdateFailed(UpdateFailure.install, attached.stderr.toString());
    }
    try {
      final names = mount.listSync().map((entity) => entity.path).toList();
      final source = chooseMountedApp(names);
      if (source == null) {
        throw const UpdateFailed(UpdateFailure.install);
      }
      final staged = p.join(directory.path, 'FlClash.app');
      final copied = await _run('ditto', [source, staged]);
      if (copied.exitCode != 0) {
        throw UpdateFailed(UpdateFailure.install, copied.stderr.toString());
      }
      final needsAdmin = macUpdateNeedsAdmin(
        bundleExists: Directory(bundle).existsSync(),
        userOwnsBundle: await _userOwns(bundle),
        directoryWritable: await _directoryWritable(p.dirname(bundle)),
      );
      final rootScript = File(p.join(directory.path, 'swap-root.sh'));
      await rootScript.writeAsString(
        macOSRootSwapScript(destination: bundle, stagedApp: staged),
      );
      await _run('chmod', ['700', rootScript.path]);
      final script = File(p.join(directory.path, 'swap.sh'));
      await script.writeAsString(
        macOSUpdateScript(needsAdmin: needsAdmin, rootScript: rootScript.path),
      );
      final chmod = await _run('chmod', ['700', script.path]);
      if (chmod.exitCode != 0) {
        throw UpdateFailed(UpdateFailure.install, chmod.stderr.toString());
      }
      _throwIfCancelled();
      await startDetached('/bin/sh', [script.path, '$pid', bundle, staged]);
    } finally {
      await _run('hdiutil', ['detach', mount.path]);
    }
  }

  Future<bool> _userOwns(String bundle) async {
    final stat = await _run('stat', ['-f', '%u', bundle]);
    final id = await _run('id', ['-u']);
    if (stat.exitCode != 0 || id.exitCode != 0) {
      return false;
    }
    return stat.stdout.toString().trim() == id.stdout.toString().trim();
  }

  Future<bool> _directoryWritable(String directory) async {
    final probe = File(p.join(directory, '.flclash-update-$pid'));
    try {
      await probe.writeAsString('ok');
      await probe.delete();
      return true;
    } on FileSystemException {
      return false;
    }
  }

  String _fallbackPortableDirectory() {
    final home = Platform.environment['HOME'];
    if (home == null || home.isEmpty) {
      return Directory.systemTemp.path;
    }
    final downloads = Directory(p.join(home, 'Downloads'));
    if (downloads.existsSync()) {
      return downloads.path;
    }
    return home;
  }

  String get _executable => executablePath ?? Platform.resolvedExecutable;

  String get _powerShell {
    final root = Platform.environment['SystemRoot'];
    if (root != null && root.isNotEmpty) {
      return p.join(
        root,
        'System32',
        'WindowsPowerShell',
        'v1.0',
        'powershell.exe',
      );
    }
    return 'powershell.exe';
  }

  String get _appImage {
    final path = appImagePath ?? Platform.environment['APPIMAGE'];
    if (path == null || path.isEmpty) {
      throw const UpdateFailed(UpdateFailure.install);
    }
    return path;
  }

  Future<ProcessResult> _run(String executable, List<String> arguments) {
    return runProcess(executable, arguments);
  }
}

/// Update traffic never inherits the app-wide optional TLS bypass or the
/// mixed-port proxy — a disabled cert check would otherwise MITM installers.
Dio createUpdateDio({String? userAgent}) {
  final dio = Dio(
    BaseOptions(
      headers: {'User-Agent': userAgent ?? browserUa},
      followRedirects: false,
      maxRedirects: 0,
    ),
  );
  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient();
      client.badCertificateCallback = (_, _, _) => false;
      client.findProxy = (_) => 'DIRECT';
      return client;
    },
  );
  return dio;
}

@visibleForTesting
int? contentLengthOf(Headers headers) {
  final raw = headers.value(Headers.contentLengthHeader);
  return raw == null ? null : int.tryParse(raw);
}

Future<String> _sha256File(String path) async {
  final digest = await sha256.bind(File(path).openRead()).first;
  return digest.toString();
}

Future<void> startDetachedProcess(String executable, List<String> arguments) {
  return Process.start(
    executable,
    arguments,
    mode: ProcessStartMode.detached,
  ).then((_) {});
}

Future<LinuxInstallLayout> detectLinuxInstallLayout({
  required bool appImage,
  required String executable,
  ProcessRunner runProcess = Process.run,
}) async {
  if (appImage) {
    return LinuxInstallLayout.appImage;
  }
  if (await _commandOwns(runProcess, 'dpkg', ['-S', executable])) {
    return LinuxInstallLayout.deb;
  }
  if (await _commandOwns(runProcess, 'rpm', ['-qf', executable])) {
    return LinuxInstallLayout.rpm;
  }
  return LinuxInstallLayout.portable;
}

bool windowsSetupInstalled(String executable) {
  return File(p.join(p.dirname(executable), 'unins000.exe')).existsSync();
}

bool _keepsDownloadedPackage(UpdateApply? apply) {
  return apply == UpdateApply.dmg ||
      apply == UpdateApply.windowsSetup ||
      apply == UpdateApply.windowsZip;
}

Future<UpdateHost?> currentUpdateHost({
  String? operatingSystem,
  Abi? abi,
  bool? appImage,
  String? executable,
  ProcessRunner? runProcess,
}) async {
  final os = operatingSystem ?? Platform.operatingSystem;
  final executablePath = executable ?? Platform.resolvedExecutable;
  final layout = os == 'linux'
      ? await detectLinuxInstallLayout(
          appImage: appImage ?? Platform.environment.containsKey('APPIMAGE'),
          executable: executablePath,
          runProcess: runProcess ?? Process.run,
        )
      : LinuxInstallLayout.portable;
  final windowsLayout = os == 'windows' && windowsSetupInstalled(executablePath)
      ? WindowsInstallLayout.setup
      : WindowsInstallLayout.portable;
  return updateHost(
    operatingSystem: os,
    abi: abi ?? Abi.current(),
    linuxLayout: layout,
    windowsLayout: windowsLayout,
  );
}

Future<bool> _commandOwns(
  ProcessRunner runProcess,
  String executable,
  List<String> arguments,
) async {
  try {
    final result = await runProcess(executable, arguments);
    return result.exitCode == 0;
  } on ProcessException {
    return false;
  }
}
