// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../geo_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeoIdentityProps _$GeoIdentityPropsFromJson(Map<String, dynamic> json) =>
    _GeoIdentityProps(
      enable: json['enable'] as bool? ?? false,
      useUsAcceptLanguage: json['useUsAcceptLanguage'] as bool? ?? true,
    );

Map<String, dynamic> _$GeoIdentityPropsToJson(_GeoIdentityProps instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'useUsAcceptLanguage': instance.useUsAcceptLanguage,
    };
