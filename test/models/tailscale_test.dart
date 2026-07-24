import 'dart:convert';

import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('TailscaleProxy.toOutboundJson', () {
    test('emits only name and type when optionals are empty', () {
      const proxy = TailscaleProxy(name: 'ts-node');
      final json = proxy.toOutboundJson();
      expect(json, {'name': 'ts-node', 'type': 'tailscale'});
    });

    test('trims name and type value matches core parser', () {
      const proxy = TailscaleProxy(name: '  ts-node  ');
      final json = proxy.toOutboundJson();
      expect(json['name'], 'ts-node');
      expect(json['type'], tailscaleProxyType);
    });

    test('emits kebab-case keys for populated fields', () {
      const proxy = TailscaleProxy(
        name: 'ts-node',
        authKey: 'tskey-auth-abc',
        hostname: 'my-host',
        controlUrl: 'https://controlplane.example.com',
        stateDir: 'tailscale-state',
        ephemeral: true,
        udp: true,
        acceptRoutes: true,
      );
      final json = proxy.toOutboundJson();
      expect(json['auth-key'], 'tskey-auth-abc');
      expect(json['hostname'], 'my-host');
      expect(json['control-url'], 'https://controlplane.example.com');
      expect(json['state-dir'], 'tailscale-state');
      expect(json['ephemeral'], true);
      expect(json['udp'], true);
      expect(json['accept-routes'], true);
    });

    test('omits false boolean flags', () {
      const proxy = TailscaleProxy(name: 'ts-node');
      final json = proxy.toOutboundJson();
      expect(json.containsKey('ephemeral'), isFalse);
      expect(json.containsKey('udp'), isFalse);
      expect(json.containsKey('accept-routes'), isFalse);
      expect(json.containsKey('exit-node'), isFalse);
      expect(json.containsKey('exit-node-allow-lan-access'), isFalse);
    });

    test('includes exit-node-allow-lan-access only when exit-node is set', () {
      const proxy = TailscaleProxy(
        name: 'ts-node',
        exitNode: '100.64.0.1',
        exitNodeAllowLanAccess: true,
      );
      final json = proxy.toOutboundJson();
      expect(json['exit-node'], '100.64.0.1');
      expect(json['exit-node-allow-lan-access'], true);
    });

    test('exit-node-allow-lan-access defaults to false alongside exit-node', () {
      const proxy = TailscaleProxy(name: 'ts-node', exitNode: '100.64.0.1');
      final json = proxy.toOutboundJson();
      expect(json['exit-node'], '100.64.0.1');
      expect(json['exit-node-allow-lan-access'], false);
    });
  });

  group('TailscaleProxy validation and serialization', () {
    test('isValid requires a non-empty trimmed name', () {
      expect(const TailscaleProxy(name: '').isValid, isFalse);
      expect(const TailscaleProxy(name: '   ').isValid, isFalse);
      expect(const TailscaleProxy(name: 'ts-node').isValid, isTrue);
    });

    test('round-trips through json for persistence', () {
      const proxy = TailscaleProxy(
        name: 'ts-node',
        authKey: 'tskey-auth-abc',
        exitNode: '100.64.0.1',
        ephemeral: true,
      );
      final restored = TailscaleProxy.fromJson(
        jsonDecode(jsonEncode(proxy.toJson())) as Map<String, Object?>,
      );
      expect(restored, proxy);
    });
  });

  group('TailscaleProxyListExt.mergeInto', () {
    test('adds tailscale proxies to a config without a proxies list', () {
      final config = <String, dynamic>{'mode': 'rule'};
      const proxies = [TailscaleProxy(name: 'ts-node')];
      final result = proxies.mergeInto(config);
      expect(result['proxies'], [
        {'name': 'ts-node', 'type': 'tailscale'},
      ]);
      expect(result['mode'], 'rule');
    });

    test('appends while preserving existing proxies', () {
      final config = <String, dynamic>{
        'proxies': [
          {'name': 'ss-node', 'type': 'ss'},
        ],
      };
      const proxies = [TailscaleProxy(name: 'ts-node')];
      final result = proxies.mergeInto(config);
      final resultProxies = result['proxies'] as List;
      expect(resultProxies.length, 2);
      expect(resultProxies.first, {'name': 'ss-node', 'type': 'ss'});
      expect(resultProxies.last, {'name': 'ts-node', 'type': 'tailscale'});
    });

    test('replaces an existing proxy with the same name', () {
      final config = <String, dynamic>{
        'proxies': [
          {'name': 'ts-node', 'type': 'ss'},
        ],
      };
      const proxies = [TailscaleProxy(name: 'ts-node', authKey: 'new-key')];
      final result = proxies.mergeInto(config);
      final resultProxies = result['proxies'] as List;
      expect(resultProxies.length, 1);
      expect(resultProxies.first, {
        'name': 'ts-node',
        'type': 'tailscale',
        'auth-key': 'new-key',
      });
    });

    test('skips invalid nodes', () {
      final config = <String, dynamic>{};
      const proxies = [
        TailscaleProxy(name: ''),
        TailscaleProxy(name: 'ts-node'),
      ];
      final result = proxies.mergeInto(config);
      expect((result['proxies'] as List).length, 1);
    });

    test('returns config unchanged when there are no valid nodes', () {
      final config = <String, dynamic>{
        'proxies': [
          {'name': 'ss-node', 'type': 'ss'},
        ],
      };
      const proxies = [TailscaleProxy(name: '')];
      final result = proxies.mergeInto(config);
      expect(result['proxies'], [
        {'name': 'ss-node', 'type': 'ss'},
      ]);
    });

    test('does not mutate the input config', () {
      final config = <String, dynamic>{
        'proxies': [
          {'name': 'ss-node', 'type': 'ss'},
        ],
      };
      const proxies = [TailscaleProxy(name: 'ts-node')];
      proxies.mergeInto(config);
      expect((config['proxies'] as List).length, 1);
    });
  });
}
