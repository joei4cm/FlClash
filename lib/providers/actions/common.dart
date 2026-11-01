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
    final localizations = currentAppLocalizations;
    final running = globalState.packageInfo.version;
    final secondary = AppTextStyle.subheadline
        .of(context)
        .copyWith(color: context.colorScheme.onSurfaceVariant);
    return TextSpan(
      children: [
        TextSpan(
          text: '${localizations.updateRunningVersion(running)}\n',
          style: secondary,
        ),
        TextSpan(text: '$tagName\n', style: AppTextStyle.title2.of(context)),
        if (version == null) ...[
          TextSpan(text: '\n', style: AppTextStyle.subheadline.of(context)),
          for (final submit in parseReleaseBody(body))
            TextSpan(text: '- $submit\n', style: secondary),
        ] else
          ..._changelogSpans(context, version),
      ],
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
      final choice = await _showUpdatePrompt(
        tagName: data['tag_name'] as String,
        body: data['body'] as String?,
        isUser: isUser,
      );
      switch (choice) {
        case UpdatePromptResult.install:
          final inAppUpdate = supportsInAppUpdate(
            isAndroid: system.isAndroid,
            isLinux: system.isLinux,
            isMacOS: system.isMacOS,
            isWindows: system.isWindows,
          );
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
        case UpdatePromptResult.mute:
          ref
              .read(appSettingProvider.notifier)
              .update((state) => state.copyWith(autoCheckUpdate: false));
        case UpdatePromptResult.dismiss:
        case null:
          break;
      }
    } else if (isUser) {
      dialogs.showNotifier(
        currentAppLocalizations.checkUpdateError,
        level: MessageLevel.success,
      );
    }
  }

  /// Auto checks offer Cancel / Don't remind / Install so "later" does not
  /// mute reminders. Manual checks keep Cancel / Install.
  Future<UpdatePromptResult?> _showUpdatePrompt({
    required String tagName,
    required String? body,
    required bool isUser,
  }) {
    final inAppUpdate = supportsInAppUpdate(
      isAndroid: system.isAndroid,
      isLinux: system.isLinux,
      isMacOS: system.isMacOS,
      isWindows: system.isWindows,
    );
    return dialogs.showCommonDialog<UpdatePromptResult>(
      child: Builder(
        builder: (context) {
          final localizations = context.appLocalizations;
          return CommonDialog(
            title: localizations.discoverNewVersion,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(UpdatePromptResult.dismiss);
                },
                child: Text(localizations.cancel),
              ),
              if (!isUser)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(UpdatePromptResult.mute);
                  },
                  child: Text(localizations.noLongerRemind),
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(UpdatePromptResult.install);
                },
                child: Text(
                  inAppUpdate
                      ? localizations.installUpdate
                      : localizations.goDownload,
                ),
              ),
            ],
            child: SelectableText.rich(
              TextSpan(children: [_releaseSpan(context, tagName, body)]),
              style: const TextStyle(overflow: TextOverflow.visible),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openReleasePage() {
    return launchUrl(
      Uri.parse('https://github.com/$repository/releases/latest'),
    );
  }

  Future<void> _installInApp(Map<String, dynamic> data) async {
    final localizations = currentAppLocalizations;
    final host = await currentUpdateHost();
    if (host == null) {
      await dialogs.showAlert(
        title: localizations.discoverNewVersion,
        message: TextSpan(text: localizations.updateOpenDownloadPage),
      );
      await _openReleasePage();
      return;
    }
    final progress = ValueNotifier<double?>(null);
    final title = ValueNotifier(localizations.updateDownload);
    final phase = ValueNotifier(UpdatePhase.download);
    final releaseTag = data['tag_name'] as String? ?? '';
    final installer = AppUpdateInstaller(
      elevate: system.isLinux ? linuxElevation.elevate : null,
      installApk: system.isAndroid ? app!.installApk : null,
      lockFilePath: () => appPath.lockFilePath,
      portableDirectory: () => appPath.downloadDirPath,
    );
    var cancelled = false;
    var dialogOpen = true;
    BuildContext? dialogContext;
    final shown = Completer<void>();
    // One pop only: the cancel button used to pop and UpdateCancelled then
    // popped again, which removed the page under the dialog (black screen).
    void closeDialog() {
      if (!dialogOpen) {
        return;
      }
      dialogOpen = false;
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
          final colorScheme = context.colorScheme;
          final secondaryStyle = AppTextStyle.subheadline
              .of(context)
              .copyWith(color: colorScheme.onSurfaceVariant);
          return ValueListenableBuilder<String>(
            valueListenable: title,
            builder: (context, titleText, _) {
              return ValueListenableBuilder<UpdatePhase>(
                valueListenable: phase,
                builder: (context, currentPhase, _) {
                  return ValueListenableBuilder<double?>(
                    valueListenable: progress,
                    builder: (context, fraction, _) {
                      final canCancel = currentPhase != UpdatePhase.install;
                      return CommonDialog(
                        title: titleText,
                        actions: [
                          if (canCancel)
                            TextButton(
                              onPressed: () {
                                cancelled = true;
                                installer.cancel();
                                closeDialog();
                              },
                              child: Text(context.appLocalizations.cancel),
                            ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LinearProgressIndicator(value: fraction),
                            if (fraction != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                '${(fraction * 100).round()}%',
                                style: secondaryStyle,
                              ),
                            ],
                            if (releaseTag.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(releaseTag, style: secondaryStyle),
                            ],
                            if (currentPhase == UpdatePhase.install) ...[
                              const SizedBox(height: 8),
                              Text(
                                system.isAndroid
                                    ? localizations.updateOpensInstaller
                                    : localizations.updateWillRestart,
                                style: secondaryStyle,
                              ),
                            ],
                          ],
                        ),
                      );
                    },
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
        onProgress: (nextPhase, fraction) {
          phase.value = nextPhase;
          progress.value = fraction;
          title.value = switch (nextPhase) {
            UpdatePhase.download => localizations.updateDownload,
            UpdatePhase.verify => localizations.updateVerify,
            UpdatePhase.install => localizations.updateInstall,
          };
        },
      );
      closeDialog();
      await dialog;
      if (cancelled) {
        return;
      }
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
        phase.dispose();
      });
    }
  }
}
