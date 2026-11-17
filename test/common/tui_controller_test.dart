import 'dart:io';

import 'package:fl_clash/common/tui_controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/clash_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('tui-controller-');
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('publish writes endpoint json and read returns it', () async {
    await TuiControllerEndpoint.publish(
      address: '127.0.0.1:9090',
      secret: 's3cret',
      homeDir: tempDir.path,
    );
    final endpoint = await TuiControllerEndpoint.read(homeDir: tempDir.path);
    expect(endpoint?.url, 'http://127.0.0.1:9090');
    expect(endpoint?.secret, 's3cret');
  });

  test('syncFromPatch publishes when controller is open with secret', () async {
    final patch = const PatchClashConfig().copyWith(
      externalController: ExternalControllerStatus.open,
      secret: 'token',
    );
    await TuiControllerEndpoint.syncFromPatch(patch, homeDir: tempDir.path);
    final endpoint = await TuiControllerEndpoint.read(homeDir: tempDir.path);
    expect(endpoint?.secret, 'token');
    expect(endpoint?.url, 'http://127.0.0.1:9090');
  });

  test('syncFromPatch clears when controller is closed', () async {
    await TuiControllerEndpoint.publish(
      address: '127.0.0.1:9090',
      secret: 'token',
      homeDir: tempDir.path,
    );
    await TuiControllerEndpoint.syncFromPatch(
      const PatchClashConfig(),
      homeDir: tempDir.path,
    );
    expect(await TuiControllerEndpoint.read(homeDir: tempDir.path), isNull);
  });

  test('syncFromPatch is a no-op on non-desktop', () async {
    final patch = const PatchClashConfig().copyWith(
      externalController: ExternalControllerStatus.open,
      secret: 'token',
    );
    await TuiControllerEndpoint.syncFromPatch(
      patch,
      homeDir: tempDir.path,
      isDesktop: false,
    );
    expect(await TuiControllerEndpoint.read(homeDir: tempDir.path), isNull);
  });
}
