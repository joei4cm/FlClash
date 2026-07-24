// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tailscale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TailscaleProxy {

 String get name; String get authKey; String get hostname; String get controlUrl; String get stateDir; bool get ephemeral; bool get udp; bool get acceptRoutes; String get exitNode; bool get exitNodeAllowLanAccess;
/// Create a copy of TailscaleProxy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TailscaleProxyCopyWith<TailscaleProxy> get copyWith => _$TailscaleProxyCopyWithImpl<TailscaleProxy>(this as TailscaleProxy, _$identity);

  /// Serializes this TailscaleProxy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TailscaleProxy&&(identical(other.name, name) || other.name == name)&&(identical(other.authKey, authKey) || other.authKey == authKey)&&(identical(other.hostname, hostname) || other.hostname == hostname)&&(identical(other.controlUrl, controlUrl) || other.controlUrl == controlUrl)&&(identical(other.stateDir, stateDir) || other.stateDir == stateDir)&&(identical(other.ephemeral, ephemeral) || other.ephemeral == ephemeral)&&(identical(other.udp, udp) || other.udp == udp)&&(identical(other.acceptRoutes, acceptRoutes) || other.acceptRoutes == acceptRoutes)&&(identical(other.exitNode, exitNode) || other.exitNode == exitNode)&&(identical(other.exitNodeAllowLanAccess, exitNodeAllowLanAccess) || other.exitNodeAllowLanAccess == exitNodeAllowLanAccess));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,authKey,hostname,controlUrl,stateDir,ephemeral,udp,acceptRoutes,exitNode,exitNodeAllowLanAccess);

@override
String toString() {
  return 'TailscaleProxy(name: $name, authKey: $authKey, hostname: $hostname, controlUrl: $controlUrl, stateDir: $stateDir, ephemeral: $ephemeral, udp: $udp, acceptRoutes: $acceptRoutes, exitNode: $exitNode, exitNodeAllowLanAccess: $exitNodeAllowLanAccess)';
}


}

/// @nodoc
abstract mixin class $TailscaleProxyCopyWith<$Res>  {
  factory $TailscaleProxyCopyWith(TailscaleProxy value, $Res Function(TailscaleProxy) _then) = _$TailscaleProxyCopyWithImpl;
@useResult
$Res call({
 String name, String authKey, String hostname, String controlUrl, String stateDir, bool ephemeral, bool udp, bool acceptRoutes, String exitNode, bool exitNodeAllowLanAccess
});




}
/// @nodoc
class _$TailscaleProxyCopyWithImpl<$Res>
    implements $TailscaleProxyCopyWith<$Res> {
  _$TailscaleProxyCopyWithImpl(this._self, this._then);

  final TailscaleProxy _self;
  final $Res Function(TailscaleProxy) _then;

/// Create a copy of TailscaleProxy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? authKey = null,Object? hostname = null,Object? controlUrl = null,Object? stateDir = null,Object? ephemeral = null,Object? udp = null,Object? acceptRoutes = null,Object? exitNode = null,Object? exitNodeAllowLanAccess = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,authKey: null == authKey ? _self.authKey : authKey // ignore: cast_nullable_to_non_nullable
as String,hostname: null == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String,controlUrl: null == controlUrl ? _self.controlUrl : controlUrl // ignore: cast_nullable_to_non_nullable
as String,stateDir: null == stateDir ? _self.stateDir : stateDir // ignore: cast_nullable_to_non_nullable
as String,ephemeral: null == ephemeral ? _self.ephemeral : ephemeral // ignore: cast_nullable_to_non_nullable
as bool,udp: null == udp ? _self.udp : udp // ignore: cast_nullable_to_non_nullable
as bool,acceptRoutes: null == acceptRoutes ? _self.acceptRoutes : acceptRoutes // ignore: cast_nullable_to_non_nullable
as bool,exitNode: null == exitNode ? _self.exitNode : exitNode // ignore: cast_nullable_to_non_nullable
as String,exitNodeAllowLanAccess: null == exitNodeAllowLanAccess ? _self.exitNodeAllowLanAccess : exitNodeAllowLanAccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TailscaleProxy].
extension TailscaleProxyPatterns on TailscaleProxy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TailscaleProxy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TailscaleProxy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TailscaleProxy value)  $default,){
final _that = this;
switch (_that) {
case _TailscaleProxy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TailscaleProxy value)?  $default,){
final _that = this;
switch (_that) {
case _TailscaleProxy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String authKey,  String hostname,  String controlUrl,  String stateDir,  bool ephemeral,  bool udp,  bool acceptRoutes,  String exitNode,  bool exitNodeAllowLanAccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TailscaleProxy() when $default != null:
return $default(_that.name,_that.authKey,_that.hostname,_that.controlUrl,_that.stateDir,_that.ephemeral,_that.udp,_that.acceptRoutes,_that.exitNode,_that.exitNodeAllowLanAccess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String authKey,  String hostname,  String controlUrl,  String stateDir,  bool ephemeral,  bool udp,  bool acceptRoutes,  String exitNode,  bool exitNodeAllowLanAccess)  $default,) {final _that = this;
switch (_that) {
case _TailscaleProxy():
return $default(_that.name,_that.authKey,_that.hostname,_that.controlUrl,_that.stateDir,_that.ephemeral,_that.udp,_that.acceptRoutes,_that.exitNode,_that.exitNodeAllowLanAccess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String authKey,  String hostname,  String controlUrl,  String stateDir,  bool ephemeral,  bool udp,  bool acceptRoutes,  String exitNode,  bool exitNodeAllowLanAccess)?  $default,) {final _that = this;
switch (_that) {
case _TailscaleProxy() when $default != null:
return $default(_that.name,_that.authKey,_that.hostname,_that.controlUrl,_that.stateDir,_that.ephemeral,_that.udp,_that.acceptRoutes,_that.exitNode,_that.exitNodeAllowLanAccess);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TailscaleProxy implements TailscaleProxy {
  const _TailscaleProxy({required this.name, this.authKey = '', this.hostname = '', this.controlUrl = '', this.stateDir = '', this.ephemeral = false, this.udp = false, this.acceptRoutes = false, this.exitNode = '', this.exitNodeAllowLanAccess = false});
  factory _TailscaleProxy.fromJson(Map<String, dynamic> json) => _$TailscaleProxyFromJson(json);

@override final  String name;
@override@JsonKey() final  String authKey;
@override@JsonKey() final  String hostname;
@override@JsonKey() final  String controlUrl;
@override@JsonKey() final  String stateDir;
@override@JsonKey() final  bool ephemeral;
@override@JsonKey() final  bool udp;
@override@JsonKey() final  bool acceptRoutes;
@override@JsonKey() final  String exitNode;
@override@JsonKey() final  bool exitNodeAllowLanAccess;

/// Create a copy of TailscaleProxy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TailscaleProxyCopyWith<_TailscaleProxy> get copyWith => __$TailscaleProxyCopyWithImpl<_TailscaleProxy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TailscaleProxyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TailscaleProxy&&(identical(other.name, name) || other.name == name)&&(identical(other.authKey, authKey) || other.authKey == authKey)&&(identical(other.hostname, hostname) || other.hostname == hostname)&&(identical(other.controlUrl, controlUrl) || other.controlUrl == controlUrl)&&(identical(other.stateDir, stateDir) || other.stateDir == stateDir)&&(identical(other.ephemeral, ephemeral) || other.ephemeral == ephemeral)&&(identical(other.udp, udp) || other.udp == udp)&&(identical(other.acceptRoutes, acceptRoutes) || other.acceptRoutes == acceptRoutes)&&(identical(other.exitNode, exitNode) || other.exitNode == exitNode)&&(identical(other.exitNodeAllowLanAccess, exitNodeAllowLanAccess) || other.exitNodeAllowLanAccess == exitNodeAllowLanAccess));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,authKey,hostname,controlUrl,stateDir,ephemeral,udp,acceptRoutes,exitNode,exitNodeAllowLanAccess);

@override
String toString() {
  return 'TailscaleProxy(name: $name, authKey: $authKey, hostname: $hostname, controlUrl: $controlUrl, stateDir: $stateDir, ephemeral: $ephemeral, udp: $udp, acceptRoutes: $acceptRoutes, exitNode: $exitNode, exitNodeAllowLanAccess: $exitNodeAllowLanAccess)';
}


}

/// @nodoc
abstract mixin class _$TailscaleProxyCopyWith<$Res> implements $TailscaleProxyCopyWith<$Res> {
  factory _$TailscaleProxyCopyWith(_TailscaleProxy value, $Res Function(_TailscaleProxy) _then) = __$TailscaleProxyCopyWithImpl;
@override @useResult
$Res call({
 String name, String authKey, String hostname, String controlUrl, String stateDir, bool ephemeral, bool udp, bool acceptRoutes, String exitNode, bool exitNodeAllowLanAccess
});




}
/// @nodoc
class __$TailscaleProxyCopyWithImpl<$Res>
    implements _$TailscaleProxyCopyWith<$Res> {
  __$TailscaleProxyCopyWithImpl(this._self, this._then);

  final _TailscaleProxy _self;
  final $Res Function(_TailscaleProxy) _then;

/// Create a copy of TailscaleProxy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? authKey = null,Object? hostname = null,Object? controlUrl = null,Object? stateDir = null,Object? ephemeral = null,Object? udp = null,Object? acceptRoutes = null,Object? exitNode = null,Object? exitNodeAllowLanAccess = null,}) {
  return _then(_TailscaleProxy(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,authKey: null == authKey ? _self.authKey : authKey // ignore: cast_nullable_to_non_nullable
as String,hostname: null == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String,controlUrl: null == controlUrl ? _self.controlUrl : controlUrl // ignore: cast_nullable_to_non_nullable
as String,stateDir: null == stateDir ? _self.stateDir : stateDir // ignore: cast_nullable_to_non_nullable
as String,ephemeral: null == ephemeral ? _self.ephemeral : ephemeral // ignore: cast_nullable_to_non_nullable
as bool,udp: null == udp ? _self.udp : udp // ignore: cast_nullable_to_non_nullable
as bool,acceptRoutes: null == acceptRoutes ? _self.acceptRoutes : acceptRoutes // ignore: cast_nullable_to_non_nullable
as bool,exitNode: null == exitNode ? _self.exitNode : exitNode // ignore: cast_nullable_to_non_nullable
as String,exitNodeAllowLanAccess: null == exitNodeAllowLanAccess ? _self.exitNodeAllowLanAccess : exitNodeAllowLanAccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
