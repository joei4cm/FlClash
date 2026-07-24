// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tailscale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TailscaleProxy _$TailscaleProxyFromJson(Map<String, dynamic> json) =>
    _TailscaleProxy(
      name: json['name'] as String,
      authKey: json['authKey'] as String? ?? '',
      hostname: json['hostname'] as String? ?? '',
      controlUrl: json['controlUrl'] as String? ?? '',
      stateDir: json['stateDir'] as String? ?? '',
      ephemeral: json['ephemeral'] as bool? ?? false,
      udp: json['udp'] as bool? ?? false,
      acceptRoutes: json['acceptRoutes'] as bool? ?? false,
      exitNode: json['exitNode'] as String? ?? '',
      exitNodeAllowLanAccess: json['exitNodeAllowLanAccess'] as bool? ?? false,
    );

Map<String, dynamic> _$TailscaleProxyToJson(_TailscaleProxy instance) =>
    <String, dynamic>{
      'name': instance.name,
      'authKey': instance.authKey,
      'hostname': instance.hostname,
      'controlUrl': instance.controlUrl,
      'stateDir': instance.stateDir,
      'ephemeral': instance.ephemeral,
      'udp': instance.udp,
      'acceptRoutes': instance.acceptRoutes,
      'exitNode': instance.exitNode,
      'exitNodeAllowLanAccess': instance.exitNodeAllowLanAccess,
    };
