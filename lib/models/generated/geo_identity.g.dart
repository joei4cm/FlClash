// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../geo_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeoIdentityProps _$GeoIdentityPropsFromJson(Map<String, dynamic> json) =>
    _GeoIdentityProps(
      enable: json['enable'] as bool? ?? false,
      useUsAcceptLanguage: json['useUsAcceptLanguage'] as bool? ?? true,
      captureMode:
          $enumDecodeNullable(
            _$GeoIdentityCaptureModeEnumMap,
            json['captureMode'],
          ) ??
          GeoIdentityCaptureMode.auto,
      previousOsTimezone: json['previousOsTimezone'] as String?,
      appliedOsTimezone: json['appliedOsTimezone'] as String?,
    );

Map<String, dynamic> _$GeoIdentityPropsToJson(_GeoIdentityProps instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'useUsAcceptLanguage': instance.useUsAcceptLanguage,
      'captureMode': _$GeoIdentityCaptureModeEnumMap[instance.captureMode]!,
      'previousOsTimezone': instance.previousOsTimezone,
      'appliedOsTimezone': instance.appliedOsTimezone,
    };

const _$GeoIdentityCaptureModeEnumMap = {
  GeoIdentityCaptureMode.auto: 'auto',
  GeoIdentityCaptureMode.tun: 'tun',
  GeoIdentityCaptureMode.systemProxy: 'systemProxy',
  GeoIdentityCaptureMode.both: 'both',
};
