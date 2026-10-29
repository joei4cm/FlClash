import 'dart:convert';
import 'dart:math';

import 'package:fl_clash/common/clash_identifiers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/tailscale.freezed.dart';

part 'generated/tailscale.g.dart';

const tailscaleProxyType = 'tailscale';

const defaultTailscaleProps = TailscaleProps();

const _authKeyFormatVersion = 'v1';
const _authKeyNonceLength = 16;
const _authKeyObfuscationMask = <int>[
  0x5a,
  0xc3,
  0x19,
  0xe8,
  0x47,
  0x91,
  0x2d,
  0x76,
  0xb0,
  0x0f,
  0xdc,
  0x63,
  0xa5,
  0x3e,
  0x88,
  0xf1,
];

// Accidental plain-text disclosure only — not a security boundary.
String _encodeTailscaleAuthKey(String authKey) {
  if (authKey.isEmpty) {
    return '';
  }
  final random = Random.secure();
  final nonce = List<int>.generate(
    _authKeyNonceLength,
    (_) => random.nextInt(256),
    growable: false,
  );
  final keyBytes = utf8.encode(authKey);
  final obfuscated = List<int>.generate(
    keyBytes.length,
    (index) =>
        keyBytes[index] ^
        nonce[index % nonce.length] ^
        _authKeyObfuscationMask[index % _authKeyObfuscationMask.length],
    growable: false,
  );
  return [
    _authKeyFormatVersion,
    base64UrlEncode(nonce),
    base64UrlEncode(obfuscated),
  ].join('.');
}

String _decodeTailscaleAuthKey(String? value) {
  if (value == null || value.isEmpty) {
    return '';
  }
  final parts = value.split('.');
  if (parts.length != 3 || parts[0] != _authKeyFormatVersion) {
    return value;
  }
  try {
    final nonce = base64Url.decode(parts[1]);
    final obfuscated = base64Url.decode(parts[2]);
    if (nonce.length != _authKeyNonceLength) {
      return '';
    }
    final keyBytes = List<int>.generate(
      obfuscated.length,
      (index) =>
          obfuscated[index] ^
          nonce[index % nonce.length] ^
          _authKeyObfuscationMask[index % _authKeyObfuscationMask.length],
      growable: false,
    );
    return utf8.decode(keyBytes);
  } on FormatException {
    return '';
  }
}

@freezed
abstract class TailscaleProps with _$TailscaleProps {
  const factory TailscaleProps({
    @Default(false) bool enable,
    @Default(false) bool bypassTraffic,
    @Default([]) List<TailscaleProxy> proxies,
  }) = _TailscaleProps;

  factory TailscaleProps.fromJson(Map<String, Object?> json) =>
      _$TailscalePropsFromJson(json);

  factory TailscaleProps.safeFromJson(Map<String, Object?>? json) {
    if (json == null) {
      return defaultTailscaleProps;
    }
    try {
      return TailscaleProps.fromJson(json);
    } catch (_) {
      return defaultTailscaleProps;
    }
  }
}

const tailscaleBypassDomains = <String>[
  'tailscale.com',
  'tailscale.io',
  'ts.net',
];

/// DIRECT rules are not enough: fake-ip answers controlplane.tailscale.com
/// from 198.18.0.0/16 and `tailscale up` hangs in the TLS handshake.
/// `+.` matches the domain and its subdomains.
const tailscaleFakeIpFilters = <String>[
  '+.tailscale.com',
  '+.tailscale.io',
  '+.ts.net',
];

const tailscaleBypassRules = <String>[
  'IP-CIDR,100.64.0.0/10,DIRECT,no-resolve',
  'IP-CIDR6,fd7a:115c:a1e0::/48,DIRECT,no-resolve',
  'PROCESS-NAME,tailscaled,DIRECT',
  'PROCESS-NAME,tailscaled.exe,DIRECT',
  'PROCESS-NAME,tailscale,DIRECT',
  'PROCESS-NAME,tailscale.exe,DIRECT',
  'DOMAIN-SUFFIX,tailscale.com,DIRECT',
  'DOMAIN-SUFFIX,tailscale.io,DIRECT',
  'DOMAIN-SUFFIX,ts.net,DIRECT',
];

/// Builds a Clash rule CSV cell. Returns null when [dest] or [target] would
/// split or corrupt the rule string.
String? buildTailscaleRouteRule(String dest, String target) {
  final value = dest.trim();
  final routeTarget = target.trim();
  if (!isSafeClashField(value) || !isSafeClashField(routeTarget)) {
    return null;
  }
  final isV6 = value.contains(':');
  if (value.contains('/')) {
    final type = isV6 ? 'IP-CIDR6' : 'IP-CIDR';
    return '$type,$value,$routeTarget,no-resolve';
  }
  final isV4 = RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(value);
  if (isV4) {
    return 'IP-CIDR,$value/32,$routeTarget,no-resolve';
  }
  if (isV6) {
    return 'IP-CIDR6,$value/128,$routeTarget,no-resolve';
  }
  return 'DOMAIN-SUFFIX,$value,$routeTarget';
}

extension TailscalePropsExt on TailscaleProps {
  List<TailscaleProxy> get activeProxies =>
      enable ? proxies : const <TailscaleProxy>[];

  List<String> buildInjectedRules() {
    final rules = <String>[];
    if (enable) {
      for (final proxy in proxies.where((item) => item.isValid)) {
        for (final dest in proxy.routes) {
          if (dest.trim().isEmpty) {
            continue;
          }
          final rule = buildTailscaleRouteRule(dest, proxy.name.trim());
          if (rule != null) {
            rules.add(rule);
          }
        }
      }
    }
    if (bypassTraffic) {
      rules.addAll(tailscaleBypassRules);
    }
    return rules;
  }

  List<String> buildFakeIpFilters() =>
      bypassTraffic ? tailscaleFakeIpFilters : const <String>[];
}

@Freezed(toStringOverride: false)
abstract class TailscaleProxy with _$TailscaleProxy {
  const TailscaleProxy._();

  const factory TailscaleProxy({
    required String name,
    @JsonKey(fromJson: _decodeTailscaleAuthKey, toJson: _encodeTailscaleAuthKey)
    @Default('')
    String authKey,
    @Default('') String hostname,
    @Default('') String controlUrl,
    @Default('') String stateDir,
    @Default(false) bool ephemeral,
    @Default(false) bool udp,
    @Default(false) bool acceptRoutes,
    @Default('') String exitNode,
    @Default(false) bool exitNodeAllowLanAccess,
    @Default([]) List<String> routes,
  }) = _TailscaleProxy;

  factory TailscaleProxy.fromJson(Map<String, Object?> json) =>
      _$TailscaleProxyFromJson(json);

  @override
  String toString() =>
      'TailscaleProxy(name: $name, authKey: ***, hostname: $hostname, '
      'controlUrl: $controlUrl, stateDir: $stateDir, ephemeral: $ephemeral, '
      'udp: $udp, acceptRoutes: $acceptRoutes, exitNode: $exitNode, '
      'exitNodeAllowLanAccess: $exitNodeAllowLanAccess, routes: $routes)';
}

extension TailscaleProxyExt on TailscaleProxy {
  /// Name must be a single Clash CSV/YAML field; commas and controls are out.
  bool get isValid => isSafeClashField(name);

  Map<String, dynamic> toOutboundJson() {
    final map = <String, dynamic>{
      'name': name.trim(),
      'type': tailscaleProxyType,
    };
    if (authKey.trim().isNotEmpty) {
      map['auth-key'] = authKey.trim();
    }
    final host = hostname.trim();
    if (host.isNotEmpty && isSafeClashField(host)) {
      map['hostname'] = host;
    }
    final control = controlUrl.trim();
    if (control.isNotEmpty && isSafeTailscaleControlUrl(control)) {
      map['control-url'] = control;
    }
    final dir = stateDir.trim();
    if (dir.isNotEmpty && isSafeTailscaleStateDir(dir)) {
      map['state-dir'] = dir;
    }
    if (ephemeral) {
      map['ephemeral'] = true;
    }
    if (udp) {
      map['udp'] = true;
    }
    if (acceptRoutes) {
      map['accept-routes'] = true;
    }
    final node = exitNode.trim();
    if (node.isNotEmpty && isSafeClashField(node)) {
      map['exit-node'] = node;
      map['exit-node-allow-lan-access'] = exitNodeAllowLanAccess;
    }
    return map;
  }
}

extension TailscaleProxyListExt on List<TailscaleProxy> {
  Map<String, dynamic> mergeInto(Map<String, dynamic> rawConfig) {
    final validProxies = where((item) => item.isValid).toList();
    if (validProxies.isEmpty) {
      return Map<String, dynamic>.from(rawConfig);
    }
    final nextConfig = Map<String, dynamic>.from(rawConfig);
    final existing = <dynamic>[...?(nextConfig['proxies'] as List?)];
    final tailscaleNames = validProxies.map((item) => item.name.trim()).toSet();
    existing.removeWhere((item) {
      return item is Map && tailscaleNames.contains(item['name']);
    });
    existing.addAll(validProxies.map((item) => item.toOutboundJson()));
    nextConfig['proxies'] = existing;
    return nextConfig;
  }
}
