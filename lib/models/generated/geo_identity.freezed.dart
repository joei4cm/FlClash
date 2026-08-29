// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../geo_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeoIdentityProps {

/// When true, FlClash treats geo identity as an active concern: prefer a US
/// Accept-Language on network probes and surface capture-mode guidance.
 bool get enable;/// Send `Accept-Language: en-US,en;q=0.9` on FuckClaude network probes so
/// the server-side estimate is not polluted by a Chinese Accept-Language.
 bool get useUsAcceptLanguage;/// Previous OS timezone id saved before an align action (for Restore).
 String? get previousOsTimezone;/// Last OS timezone FlClash successfully applied.
 String? get appliedOsTimezone;
/// Create a copy of GeoIdentityProps
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeoIdentityPropsCopyWith<GeoIdentityProps> get copyWith => _$GeoIdentityPropsCopyWithImpl<GeoIdentityProps>(this as GeoIdentityProps, _$identity);

  /// Serializes this GeoIdentityProps to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoIdentityProps&&(identical(other.enable, enable) || other.enable == enable)&&(identical(other.useUsAcceptLanguage, useUsAcceptLanguage) || other.useUsAcceptLanguage == useUsAcceptLanguage)&&(identical(other.previousOsTimezone, previousOsTimezone) || other.previousOsTimezone == previousOsTimezone)&&(identical(other.appliedOsTimezone, appliedOsTimezone) || other.appliedOsTimezone == appliedOsTimezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enable,useUsAcceptLanguage,previousOsTimezone,appliedOsTimezone);

@override
String toString() {
  return 'GeoIdentityProps(enable: $enable, useUsAcceptLanguage: $useUsAcceptLanguage, previousOsTimezone: $previousOsTimezone, appliedOsTimezone: $appliedOsTimezone)';
}


}

/// @nodoc
abstract mixin class $GeoIdentityPropsCopyWith<$Res>  {
  factory $GeoIdentityPropsCopyWith(GeoIdentityProps value, $Res Function(GeoIdentityProps) _then) = _$GeoIdentityPropsCopyWithImpl;
@useResult
$Res call({
 bool enable, bool useUsAcceptLanguage, String? previousOsTimezone, String? appliedOsTimezone
});




}
/// @nodoc
class _$GeoIdentityPropsCopyWithImpl<$Res>
    implements $GeoIdentityPropsCopyWith<$Res> {
  _$GeoIdentityPropsCopyWithImpl(this._self, this._then);

  final GeoIdentityProps _self;
  final $Res Function(GeoIdentityProps) _then;

/// Create a copy of GeoIdentityProps
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enable = null,Object? useUsAcceptLanguage = null,Object? previousOsTimezone = freezed,Object? appliedOsTimezone = freezed,}) {
  return _then(_self.copyWith(
enable: null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,useUsAcceptLanguage: null == useUsAcceptLanguage ? _self.useUsAcceptLanguage : useUsAcceptLanguage // ignore: cast_nullable_to_non_nullable
as bool,previousOsTimezone: freezed == previousOsTimezone ? _self.previousOsTimezone : previousOsTimezone // ignore: cast_nullable_to_non_nullable
as String?,appliedOsTimezone: freezed == appliedOsTimezone ? _self.appliedOsTimezone : appliedOsTimezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GeoIdentityProps].
extension GeoIdentityPropsPatterns on GeoIdentityProps {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeoIdentityProps value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeoIdentityProps() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeoIdentityProps value)  $default,){
final _that = this;
switch (_that) {
case _GeoIdentityProps():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeoIdentityProps value)?  $default,){
final _that = this;
switch (_that) {
case _GeoIdentityProps() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enable,  bool useUsAcceptLanguage,  String? previousOsTimezone,  String? appliedOsTimezone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeoIdentityProps() when $default != null:
return $default(_that.enable,_that.useUsAcceptLanguage,_that.previousOsTimezone,_that.appliedOsTimezone);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enable,  bool useUsAcceptLanguage,  String? previousOsTimezone,  String? appliedOsTimezone)  $default,) {final _that = this;
switch (_that) {
case _GeoIdentityProps():
return $default(_that.enable,_that.useUsAcceptLanguage,_that.previousOsTimezone,_that.appliedOsTimezone);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enable,  bool useUsAcceptLanguage,  String? previousOsTimezone,  String? appliedOsTimezone)?  $default,) {final _that = this;
switch (_that) {
case _GeoIdentityProps() when $default != null:
return $default(_that.enable,_that.useUsAcceptLanguage,_that.previousOsTimezone,_that.appliedOsTimezone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeoIdentityProps implements GeoIdentityProps {
  const _GeoIdentityProps({this.enable = false, this.useUsAcceptLanguage = true, this.previousOsTimezone, this.appliedOsTimezone});
  factory _GeoIdentityProps.fromJson(Map<String, dynamic> json) => _$GeoIdentityPropsFromJson(json);

/// When true, FlClash treats geo identity as an active concern: prefer a US
/// Accept-Language on network probes and surface capture-mode guidance.
@override@JsonKey() final  bool enable;
/// Send `Accept-Language: en-US,en;q=0.9` on FuckClaude network probes so
/// the server-side estimate is not polluted by a Chinese Accept-Language.
@override@JsonKey() final  bool useUsAcceptLanguage;
/// Previous OS timezone id saved before an align action (for Restore).
@override final  String? previousOsTimezone;
/// Last OS timezone FlClash successfully applied.
@override final  String? appliedOsTimezone;

/// Create a copy of GeoIdentityProps
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeoIdentityPropsCopyWith<_GeoIdentityProps> get copyWith => __$GeoIdentityPropsCopyWithImpl<_GeoIdentityProps>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeoIdentityPropsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeoIdentityProps&&(identical(other.enable, enable) || other.enable == enable)&&(identical(other.useUsAcceptLanguage, useUsAcceptLanguage) || other.useUsAcceptLanguage == useUsAcceptLanguage)&&(identical(other.previousOsTimezone, previousOsTimezone) || other.previousOsTimezone == previousOsTimezone)&&(identical(other.appliedOsTimezone, appliedOsTimezone) || other.appliedOsTimezone == appliedOsTimezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enable,useUsAcceptLanguage,previousOsTimezone,appliedOsTimezone);

@override
String toString() {
  return 'GeoIdentityProps(enable: $enable, useUsAcceptLanguage: $useUsAcceptLanguage, previousOsTimezone: $previousOsTimezone, appliedOsTimezone: $appliedOsTimezone)';
}


}

/// @nodoc
abstract mixin class _$GeoIdentityPropsCopyWith<$Res> implements $GeoIdentityPropsCopyWith<$Res> {
  factory _$GeoIdentityPropsCopyWith(_GeoIdentityProps value, $Res Function(_GeoIdentityProps) _then) = __$GeoIdentityPropsCopyWithImpl;
@override @useResult
$Res call({
 bool enable, bool useUsAcceptLanguage, String? previousOsTimezone, String? appliedOsTimezone
});




}
/// @nodoc
class __$GeoIdentityPropsCopyWithImpl<$Res>
    implements _$GeoIdentityPropsCopyWith<$Res> {
  __$GeoIdentityPropsCopyWithImpl(this._self, this._then);

  final _GeoIdentityProps _self;
  final $Res Function(_GeoIdentityProps) _then;

/// Create a copy of GeoIdentityProps
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enable = null,Object? useUsAcceptLanguage = null,Object? previousOsTimezone = freezed,Object? appliedOsTimezone = freezed,}) {
  return _then(_GeoIdentityProps(
enable: null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,useUsAcceptLanguage: null == useUsAcceptLanguage ? _self.useUsAcceptLanguage : useUsAcceptLanguage // ignore: cast_nullable_to_non_nullable
as bool,previousOsTimezone: freezed == previousOsTimezone ? _self.previousOsTimezone : previousOsTimezone // ignore: cast_nullable_to_non_nullable
as String?,appliedOsTimezone: freezed == appliedOsTimezone ? _self.appliedOsTimezone : appliedOsTimezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
