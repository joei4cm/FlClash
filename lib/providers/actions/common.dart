part of '../action.dart';

@Riverpod(keepAlive: true)
class CommonAction extends _$CommonAction {
  CoreController get _core => ref.read(coreHandlerProvider);
  bool _isUpdatingTraffic = false;

  @override
  void build() {}

  void toggleRunning() {
    final running = !ref.read(isStartProvider);
    unawaited(
      globalState.safeRun(
        () => ref
            .read(setupActionProvider.notifier)
            .setRunning(
              running,
              initialize: running && !ref.read(initProvider),
            ),
      ),
    );
  }

  void updateSpeedStatistics() {
    ref
        .read(appSettingProvider.notifier)
        .update((state) => state.copyWith(showTrayTitle: !state.showTrayTitle));
  }

  void updateMonochromeTrayIcon() {
    ref
        .read(appSettingProvider.notifier)
        .update(
          (state) =>
              state.copyWith(monochromeTrayIcon: !state.monochromeTrayIcon),
        );
  }

  void updateMode() {
    ref.read(patchClashConfigProvider.notifier).update((state) {
      final index = Mode.values.indexWhere((item) => item == state.mode);
      if (index == -1) return state;
      final nextIndex = index + 1 > Mode.values.length - 1 ? 0 : index + 1;
      return state.copyWith(mode: Mode.values[nextIndex]);
    });
  }

  Future<void> updateTraffic() async {
    if (_isUpdatingTraffic) {
      return;
    }
    _isUpdatingTraffic = true;
    try {
      final onlyStatisticsProxy = ref.read(
        appSettingProvider.select((state) => state.onlyStatisticsProxy),
      );
      final [traffic, totalTraffic] = await Future.wait([
        _readTraffic(() => _core.getTraffic(onlyStatisticsProxy)),
        _readTraffic(() => _core.getTotalTraffic(onlyStatisticsProxy)),
      ]);
      if (traffic != null) {
        ref.read(trafficsProvider.notifier).addTraffic(traffic);
      }
      if (totalTraffic != null) {
        ref.read(totalTrafficProvider.notifier).value = totalTraffic;
      }
    } finally {
      _isUpdatingTraffic = false;
    }
  }

  Future<Traffic?> _readTraffic(Future<Traffic> Function() request) async {
    try {
      return await request();
    } catch (error) {
      commonPrint.log(
        'updateTraffic error: $error',
        logLevel: coreFailureLogLevel(error),
      );
      return null;
    }
  }

  Future<bool> autoCheckUpdate() async {
    if (!ref.read(appSettingProvider).autoCheckUpdate) return false;
    final Map<String, dynamic>? res;
    try {
      res = await request.checkForUpdate();
    } catch (error) {
      commonPrint.log(
        'checkForUpdate failed: ${compactError(error)}',
        logLevel: LogLevel.warning,
      );
      return false;
    }
    await checkUpdateResultHandle(data: res);
    return res != null;
  }

  TextSpan _releaseSpan(BuildContext context, String tagName, String? body) {
    final version = parseReleaseChangelog(body);
    return TextSpan(
      text: '$tagName \n',
      style: AppTextStyle.title2.of(context),
      children: version == null
          ? [
              TextSpan(text: '\n', style: AppTextStyle.subheadline.of(context)),
              for (final submit in parseReleaseBody(body))
                TextSpan(
                  text: '- $submit \n',
                  style: AppTextStyle.subheadline.of(context),
                ),
            ]
          : _changelogSpans(context, version),
    );
  }

  List<TextSpan> _changelogSpans(
    BuildContext context,
    ChangelogVersion version,
  ) {
    return [
      for (final group in version.visibleGroups) ...[
        TextSpan(
          text:
              '\n${changelogGroupTitle(currentAppLocalizations, group.type)}\n',
          style: AppTextStyle.subheadline
              .of(context, emphasized: true)
              .copyWith(
                color: group.type == ChangelogType.breaking
                    ? context.colorScheme.error
                    : context.colorScheme.primary,
              ),
        ),
        for (final entry in group.entries)
          TextSpan(
            text: '• ${entry.text}\n',
            style: AppTextStyle.subheadline.of(context),
          ),
      ],
    ];
  }

  Future<void> checkUpdateResultHandle({
    Map<String, dynamic>? data,
    bool isUser = false,
  }) async {
    if (data != null) {
      final context = globalState.navigatorKey.currentContext!;
      final inAppUpdate = supportsInAppUpdate(
        isAndroid: system.isAndroid,
        isLinux: system.isLinux,
        isMacOS: system.isMacOS,
        isWindows: system.isWindows,
      );
      final res = await dialogs.showMessage(
        title: currentAppLocalizations.discoverNewVersion,
        message: _releaseSpan(
          context,
          data['tag_name'] as String,
          data['body'] as String?,
        ),
        confirmText: inAppUpdate
            ? currentAppLocalizations.update
            : currentAppLocalizations.goDownload,
        cancelText: isUser ? null : currentAppLocalizations.noLongerRemind,
      );
      if (res == true) {
        if (inAppUpdate) {
          unawaited(
            globalState.safeRun(
              () => _installInApp(data),
              silence: false,
              title: currentAppLocalizations.discoverNewVersion,
            ),
          );
        } else {
          unawaited(_openReleasePage());
        }
      } else if (!isUser && res == false) {
        ref
            .read(appSettingProvider.notifier)
            .update((state) => state.copyWith(autoCheckUpdate: false));
      }
    } else if (isUser) {
      unawaited(
        dialogs.showAlert(
          title: currentAppLocalizations.checkUpdate,
          message: TextSpan(text: currentAppLocalizations.checkUpdateError),
        ),
      );
    }
  }

  Future<void> _openReleasePage() {
    return launchUrl(
      Uri.parse('https://github.com/$repository/releases/latest'),
    );
  }

  Future<void> _installInApp(Map<String, dynamic> data) async {
    final host = await currentUpdateHost();
    if (host == null) {
      await _openReleasePage();
      return;
    }
    final localizations = currentAppLocalizations;
    final progress = ValueNotifier<double?>(null);
    final title = ValueNotifier(localizations.updateDownload);
    final installer = AppUpdateInstaller(
      elevate: system.isLinux ? linuxElevation.elevate : null,
      installApk: system.isAndroid ? app!.installApk : null,
      lockFilePath: () => appPath.lockFilePath,
      portableDirectory: () => appPath.downloadDirPath,
    );
    BuildContext? dialogContext;
    final shown = Completer<void>();
    void closeDialog() {
      final context = dialogContext;
      if (context != null && context.mounted) {
        Navigator.of(context).pop();
      }
    }

    final dialog = dialogs.showCommonDialog<void>(
      dismissible: false,
      child: Builder(
        builder: (context) {
          dialogContext ??= context;
          if (!shown.isCompleted) {
            shown.complete();
          }
          return ValueListenableBuilder<String>(
            valueListenable: title,
            builder: (context, titleText, _) {
              return ValueListenableBuilder<double?>(
                valueListenable: progress,
                builder: (context, fraction, _) {
                  return CommonDialog(
                    title: titleText,
                    actions: [
                      TextButton(
                        onPressed: () {
                          installer.cancel();
                          Navigator.of(context).pop();
                        },
                        child: Text(context.appLocalizations.cancel),
                      ),
                    ],
                    child: LinearProgressIndicator(value: fraction),
                  );
                },
              );
            },
          );
        },
      ),
    );
    try {
      await shown.future;
      final outcome = await installer.install(
        release: data,
        host: host,
        onProgress: (phase, fraction) {
          progress.value = fraction;
          title.value = switch (phase) {
            UpdatePhase.download => localizations.updateDownload,
            UpdatePhase.verify => localizations.updateVerify,
            UpdatePhase.install => localizations.updateInstall,
          };
        },
      );
      closeDialog();
      await dialog;
      switch (outcome) {
        case UpdateInstallOutcome.needsPermission:
          await dialogs.showAlert(
            title: localizations.discoverNewVersion,
            message: TextSpan(text: localizations.updateInstallPermission),
          );
        case UpdateInstallOutcome.androidInstaller:
          break;
        case UpdateInstallOutcome.scheduledRestart:
          await ref.read(systemActionProvider.notifier).handleExit();
      }
    } on UpdateCancelled {
      closeDialog();
      await dialog;
    } on UpdateFailed catch (error) {
      closeDialog();
      await dialog;
      throw MessageException(switch (error.failure) {
        UpdateFailure.checksum => localizations.updateChecksumMismatch,
        UpdateFailure.missingPackage => localizations.updatePackageMissing,
        UpdateFailure.install => localizations.updateInstallFailed,
      });
    } catch (error) {
      closeDialog();
      await dialog;
      rethrow;
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        progress.dispose();
        title.dispose();
      });
    }
  }
}
