// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_shop_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StaffShopDto {

 String get shopName;// Shop ID
 String? get id; String? get associatedCampaignId;
/// Create a copy of StaffShopDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffShopDtoCopyWith<StaffShopDto> get copyWith => _$StaffShopDtoCopyWithImpl<StaffShopDto>(this as StaffShopDto, _$identity);

  /// Serializes this StaffShopDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffShopDto&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.id, id) || other.id == id)&&(identical(other.associatedCampaignId, associatedCampaignId) || other.associatedCampaignId == associatedCampaignId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopName,id,associatedCampaignId);

@override
String toString() {
  return 'StaffShopDto(shopName: $shopName, id: $id, associatedCampaignId: $associatedCampaignId)';
}


}

/// @nodoc
abstract mixin class $StaffShopDtoCopyWith<$Res>  {
  factory $StaffShopDtoCopyWith(StaffShopDto value, $Res Function(StaffShopDto) _then) = _$StaffShopDtoCopyWithImpl;
@useResult
$Res call({
 String shopName, String? id, String? associatedCampaignId
});




}
/// @nodoc
class _$StaffShopDtoCopyWithImpl<$Res>
    implements $StaffShopDtoCopyWith<$Res> {
  _$StaffShopDtoCopyWithImpl(this._self, this._then);

  final StaffShopDto _self;
  final $Res Function(StaffShopDto) _then;

/// Create a copy of StaffShopDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopName = null,Object? id = freezed,Object? associatedCampaignId = freezed,}) {
  return _then(_self.copyWith(
shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,associatedCampaignId: freezed == associatedCampaignId ? _self.associatedCampaignId : associatedCampaignId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffShopDto].
extension StaffShopDtoPatterns on StaffShopDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffShopDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffShopDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffShopDto value)  $default,){
final _that = this;
switch (_that) {
case _StaffShopDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffShopDto value)?  $default,){
final _that = this;
switch (_that) {
case _StaffShopDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopName,  String? id,  String? associatedCampaignId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffShopDto() when $default != null:
return $default(_that.shopName,_that.id,_that.associatedCampaignId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopName,  String? id,  String? associatedCampaignId)  $default,) {final _that = this;
switch (_that) {
case _StaffShopDto():
return $default(_that.shopName,_that.id,_that.associatedCampaignId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopName,  String? id,  String? associatedCampaignId)?  $default,) {final _that = this;
switch (_that) {
case _StaffShopDto() when $default != null:
return $default(_that.shopName,_that.id,_that.associatedCampaignId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StaffShopDto extends StaffShopDto {
  const _StaffShopDto({required this.shopName, this.id, this.associatedCampaignId}): super._();
  factory _StaffShopDto.fromJson(Map<String, dynamic> json) => _$StaffShopDtoFromJson(json);

@override final  String shopName;
// Shop ID
@override final  String? id;
@override final  String? associatedCampaignId;

/// Create a copy of StaffShopDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffShopDtoCopyWith<_StaffShopDto> get copyWith => __$StaffShopDtoCopyWithImpl<_StaffShopDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffShopDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffShopDto&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.id, id) || other.id == id)&&(identical(other.associatedCampaignId, associatedCampaignId) || other.associatedCampaignId == associatedCampaignId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopName,id,associatedCampaignId);

@override
String toString() {
  return 'StaffShopDto(shopName: $shopName, id: $id, associatedCampaignId: $associatedCampaignId)';
}


}

/// @nodoc
abstract mixin class _$StaffShopDtoCopyWith<$Res> implements $StaffShopDtoCopyWith<$Res> {
  factory _$StaffShopDtoCopyWith(_StaffShopDto value, $Res Function(_StaffShopDto) _then) = __$StaffShopDtoCopyWithImpl;
@override @useResult
$Res call({
 String shopName, String? id, String? associatedCampaignId
});




}
/// @nodoc
class __$StaffShopDtoCopyWithImpl<$Res>
    implements _$StaffShopDtoCopyWith<$Res> {
  __$StaffShopDtoCopyWithImpl(this._self, this._then);

  final _StaffShopDto _self;
  final $Res Function(_StaffShopDto) _then;

/// Create a copy of StaffShopDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopName = null,Object? id = freezed,Object? associatedCampaignId = freezed,}) {
  return _then(_StaffShopDto(
shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,associatedCampaignId: freezed == associatedCampaignId ? _self.associatedCampaignId : associatedCampaignId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
