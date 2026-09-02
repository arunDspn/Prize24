// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_metadata_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionMetadata {

 int get maxShops; int get maxCampaigns; int get maxUsers;
/// Create a copy of SubscriptionMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionMetadataCopyWith<SubscriptionMetadata> get copyWith => _$SubscriptionMetadataCopyWithImpl<SubscriptionMetadata>(this as SubscriptionMetadata, _$identity);

  /// Serializes this SubscriptionMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionMetadata&&(identical(other.maxShops, maxShops) || other.maxShops == maxShops)&&(identical(other.maxCampaigns, maxCampaigns) || other.maxCampaigns == maxCampaigns)&&(identical(other.maxUsers, maxUsers) || other.maxUsers == maxUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxShops,maxCampaigns,maxUsers);

@override
String toString() {
  return 'SubscriptionMetadata(maxShops: $maxShops, maxCampaigns: $maxCampaigns, maxUsers: $maxUsers)';
}


}

/// @nodoc
abstract mixin class $SubscriptionMetadataCopyWith<$Res>  {
  factory $SubscriptionMetadataCopyWith(SubscriptionMetadata value, $Res Function(SubscriptionMetadata) _then) = _$SubscriptionMetadataCopyWithImpl;
@useResult
$Res call({
 int maxShops, int maxCampaigns, int maxUsers
});




}
/// @nodoc
class _$SubscriptionMetadataCopyWithImpl<$Res>
    implements $SubscriptionMetadataCopyWith<$Res> {
  _$SubscriptionMetadataCopyWithImpl(this._self, this._then);

  final SubscriptionMetadata _self;
  final $Res Function(SubscriptionMetadata) _then;

/// Create a copy of SubscriptionMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxShops = null,Object? maxCampaigns = null,Object? maxUsers = null,}) {
  return _then(_self.copyWith(
maxShops: null == maxShops ? _self.maxShops : maxShops // ignore: cast_nullable_to_non_nullable
as int,maxCampaigns: null == maxCampaigns ? _self.maxCampaigns : maxCampaigns // ignore: cast_nullable_to_non_nullable
as int,maxUsers: null == maxUsers ? _self.maxUsers : maxUsers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionMetadata].
extension SubscriptionMetadataPatterns on SubscriptionMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionMetadata value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxShops,  int maxCampaigns,  int maxUsers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionMetadata() when $default != null:
return $default(_that.maxShops,_that.maxCampaigns,_that.maxUsers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxShops,  int maxCampaigns,  int maxUsers)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionMetadata():
return $default(_that.maxShops,_that.maxCampaigns,_that.maxUsers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxShops,  int maxCampaigns,  int maxUsers)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionMetadata() when $default != null:
return $default(_that.maxShops,_that.maxCampaigns,_that.maxUsers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionMetadata implements SubscriptionMetadata {
  const _SubscriptionMetadata({required this.maxShops, required this.maxCampaigns, required this.maxUsers});
  factory _SubscriptionMetadata.fromJson(Map<String, dynamic> json) => _$SubscriptionMetadataFromJson(json);

@override final  int maxShops;
@override final  int maxCampaigns;
@override final  int maxUsers;

/// Create a copy of SubscriptionMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionMetadataCopyWith<_SubscriptionMetadata> get copyWith => __$SubscriptionMetadataCopyWithImpl<_SubscriptionMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionMetadata&&(identical(other.maxShops, maxShops) || other.maxShops == maxShops)&&(identical(other.maxCampaigns, maxCampaigns) || other.maxCampaigns == maxCampaigns)&&(identical(other.maxUsers, maxUsers) || other.maxUsers == maxUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxShops,maxCampaigns,maxUsers);

@override
String toString() {
  return 'SubscriptionMetadata(maxShops: $maxShops, maxCampaigns: $maxCampaigns, maxUsers: $maxUsers)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionMetadataCopyWith<$Res> implements $SubscriptionMetadataCopyWith<$Res> {
  factory _$SubscriptionMetadataCopyWith(_SubscriptionMetadata value, $Res Function(_SubscriptionMetadata) _then) = __$SubscriptionMetadataCopyWithImpl;
@override @useResult
$Res call({
 int maxShops, int maxCampaigns, int maxUsers
});




}
/// @nodoc
class __$SubscriptionMetadataCopyWithImpl<$Res>
    implements _$SubscriptionMetadataCopyWith<$Res> {
  __$SubscriptionMetadataCopyWithImpl(this._self, this._then);

  final _SubscriptionMetadata _self;
  final $Res Function(_SubscriptionMetadata) _then;

/// Create a copy of SubscriptionMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxShops = null,Object? maxCampaigns = null,Object? maxUsers = null,}) {
  return _then(_SubscriptionMetadata(
maxShops: null == maxShops ? _self.maxShops : maxShops // ignore: cast_nullable_to_non_nullable
as int,maxCampaigns: null == maxCampaigns ? _self.maxCampaigns : maxCampaigns // ignore: cast_nullable_to_non_nullable
as int,maxUsers: null == maxUsers ? _self.maxUsers : maxUsers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
