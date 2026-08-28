import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

File _resolveSource(String relativePath) {
  final direct = File(relativePath);
  if (direct.existsSync()) {
    return direct;
  }
  final inPlugin = File('plugins/wifi_ssid/$relativePath');
  if (inPlugin.existsSync()) {
    return inPlugin;
  }
  return direct;
}

void main() {
  late String pluginSource;

  setUpAll(() {
    pluginSource = _resolveSource(
      'macos/wifi_ssid/Sources/wifi_ssid/WifiSsidPlugin.swift',
    ).readAsStringSync();
  });

  test('macOS reads the SSID off the platform thread', () {
    expect(pluginSource, contains('ssidQueue.async {'));
    expect(pluginSource, contains('DispatchQueue.main.async {'));
    expect(
      pluginSource,
      isNot(contains('result(wifiClient.interface()?.ssid())')),
      reason: 'CoreWLAN reaches wifid over XPC and can stall the window',
    );
  });

  test('macOS skips CoreWLAN without the location permission', () {
    expect(
      pluginSource,
      contains(
        'guard mapAuthStatus(locationManager.authorizationStatus) == .granted',
      ),
    );
  });
}
