// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'become_staff_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BecomeStaffRequestDto {

 String get shopId; String get shopName;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get requestedAt;/// Request Id
 String get id;
/// Create a copy of BecomeStaffRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BecomeStaffRequestDtoCopyWith<BecomeStaffRequestDto> get copyWith => _$BecomeStaffRequestDtoCopyWithImpl<BecomeStaffRequestDto>(this as BecomeStaffRequestDto, _$identity);

  /// Serializes this BecomeStaffRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BecomeStaffRequestDto&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,requestedAt,id);

@override
String toString() {
  return 'BecomeStaffRequestDto(shopId: $shopId, shopName: $shopName, requestedAt: $requestedAt, id: $id)';
}


}

/// @nodoc
abstract mixin class $BecomeStaffRequestDtoCopyWith<$Res>  {
  factory $BecomeStaffRequestDtoCopyWith(BecomeStaffRequestDto value, $Res Function(BecomeStaffRequestDto) _then) = _$BecomeStaffRequestDtoCopyWithImpl;
@useResult
$Res call({
 String shopId, String shopName,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp requestedAt, String id
});




}
/// @nodoc
class _$BecomeStaffRequestDtoCopyWithImpl<$Res>
    implements $BecomeStaffRequestDtoCopyWith<$Res> {
  _$BecomeStaffRequestDtoCopyWithImpl(this._self, this._then);

  final BecomeStaffRequestDto _self;
  final $Res Function(BecomeStaffRequestDto) _then;

/// Create a copy of BecomeStaffRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? shopName = null,Object? requestedAt = null,Object? id = null,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BecomeStaffRequestDto].
extension BecomeStaffRequestDtoPatterns on BecomeStaffRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BecomeStaffRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BecomeStaffRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BecomeStaffRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _BecomeStaffRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BecomeStaffRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _BecomeStaffRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  String shopName, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp requestedAt,  String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BecomeStaffRequestDto() when $default != null:
return $default(_that.shopId,_that.shopName,_that.requestedAt,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  String shopName, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp requestedAt,  String id)  $default,) {final _that = this;
switch (_that) {
case _BecomeStaffRequestDto():
return $default(_that.shopId,_that.shopName,_that.requestedAt,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  String shopName, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp requestedAt,  String id)?  $default,) {final _that = this;
switch (_that) {
case _BecomeStaffRequestDto() when $default != null:
return $default(_that.shopId,_that.shopName,_that.requestedAt,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BecomeStaffRequestDto extends BecomeStaffRequestDto {
  const _BecomeStaffRequestDto({required this.shopId, required this.shopName, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.requestedAt, this.id = ''}): super._();
  factory _BecomeStaffRequestDto.fromJson(Map<String, dynamic> json) => _$BecomeStaffRequestDtoFromJson(json);

@override final  String shopId;
@override final  String shopName;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp requestedAt;
/// Request Id
@override@JsonKey() final  String id;

/// Create a copy of BecomeStaffRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BecomeStaffRequestDtoCopyWith<_BecomeStaffRequestDto> get copyWith => __$BecomeStaffRequestDtoCopyWithImpl<_BecomeStaffRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BecomeStaffRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BecomeStaffRequestDto&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,requestedAt,id);

@override
String toString() {
  return 'BecomeStaffRequestDto(shopId: $shopId, shopName: $shopName, requestedAt: $requestedAt, id: $id)';
}


}

/// @nodoc
abstract mixin class _$BecomeStaffRequestDtoCopyWith<$Res> implements $BecomeStaffRequestDtoCopyWith<$Res> {
  factory _$BecomeStaffRequestDtoCopyWith(_BecomeStaffRequestDto value, $Res Function(_BecomeStaffRequestDto) _then) = __$BecomeStaffRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String shopId, String shopName,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp requestedAt, String id
});




}
/// @nodoc
class __$BecomeStaffRequestDtoCopyWithImpl<$Res>
    implements _$BecomeStaffRequestDtoCopyWith<$Res> {
  __$BecomeStaffRequestDtoCopyWithImpl(this._self, this._then);

  final _BecomeStaffRequestDto _self;
  final $Res Function(_BecomeStaffRequestDto) _then;

/// Create a copy of BecomeStaffRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? shopName = null,Object? requestedAt = null,Object? id = null,}) {
  return _then(_BecomeStaffRequestDto(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
