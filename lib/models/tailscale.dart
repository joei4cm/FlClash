import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/tailscale.freezed.dart';

part 'generated/tailscale.g.dart';

/// The outbound `type` value understood by the mihomo core for Tailscale nodes.
const tailscaleProxyType = 'tailscale';

/// A user authored Tailscale outbound node.
///
/// The mihomo core (built with the `with_gvisor` tag and without
/// `no_tailscale`) already supports a `tailscale` outbound. FlClash only ever
/// received proxies from imported subscription YAML, so there was no way to add
/// a Tailscale node from the app. This model captures the fields the core
/// understands and can serialize them into a proxy map that is merged into the
/// generated config through [toOutboundJson].
@freezed
abstract class TailscaleProxy with _$TailscaleProxy {
  const factory TailscaleProxy({
    required String name,
    @Default('') String authKey,
    @Default('') String hostname,
    @Default('') String controlUrl,
    @Default('') String stateDir,
    @Default(false) bool ephemeral,
    @Default(false) bool udp,
    @Default(false) bool acceptRoutes,
    @Default('') String exitNode,
    @Default(false) bool exitNodeAllowLanAccess,
  }) = _TailscaleProxy;

  factory TailscaleProxy.fromJson(Map<String, Object?> json) =>
      _$TailscaleProxyFromJson(json);
}

extension TailscaleProxyExt on TailscaleProxy {
  /// Whether the node has the minimum data required to build a valid outbound.
  bool get isValid => name.trim().isNotEmpty;

  /// Builds the mihomo `proxies` entry for this node.
  ///
  /// Only non empty optional values are emitted so the core keeps its own
  /// defaults for anything left blank. Keys use the kebab-case names the core
  /// parser expects (see `adapter/outbound/tailscale.go`).
  Map<String, dynamic> toOutboundJson() {
    final map = <String, dynamic>{
      'name': name.trim(),
      'type': tailscaleProxyType,
    };
    if (authKey.trim().isNotEmpty) {
      map['auth-key'] = authKey.trim();
    }
    if (hostname.trim().isNotEmpty) {
      map['hostname'] = hostname.trim();
    }
    if (controlUrl.trim().isNotEmpty) {
      map['control-url'] = controlUrl.trim();
    }
    if (stateDir.trim().isNotEmpty) {
      map['state-dir'] = stateDir.trim();
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
    if (exitNode.trim().isNotEmpty) {
      map['exit-node'] = exitNode.trim();
      map['exit-node-allow-lan-access'] = exitNodeAllowLanAccess;
    }
    return map;
  }
}

extension TailscaleProxyListExt on List<TailscaleProxy> {
  /// Merges the valid Tailscale nodes in this list into a raw clash config
  /// [rawConfig]'s `proxies` list.
  ///
  /// Nodes are matched by `name`; an existing proxy with the same name is
  /// replaced so the app authored value always wins. The input map is not
  /// mutated. Returns a new config map ready to be serialized to YAML.
  Map<String, dynamic> mergeInto(Map<String, dynamic> rawConfig) {
    final validProxies = where((item) => item.isValid).toList();
    if (validProxies.isEmpty) {
      return Map<String, dynamic>.from(rawConfig);
    }
    final nextConfig = Map<String, dynamic>.from(rawConfig);
    final existing = <dynamic>[
      ...?(nextConfig['proxies'] as List?),
    ];
    final tailscaleNames = validProxies.map((item) => item.name.trim()).toSet();
    existing.removeWhere((item) {
      return item is Map && tailscaleNames.contains(item['name']);
    });
    existing.addAll(validProxies.map((item) => item.toOutboundJson()));
    nextConfig['proxies'] = existing;
    return nextConfig;
  }
}
