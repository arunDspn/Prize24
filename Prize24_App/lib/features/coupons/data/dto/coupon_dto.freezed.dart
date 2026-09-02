// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupon_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CouponDto {

 String get couponName; String get storeName; String get description; String get couponCode; DateTime get drawDateTime; DateTime get expiryDate;// required String imageUrl,
 List<PricePoolDto> get prizePools; String get shopId; String? get id;
/// Create a copy of CouponDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponDtoCopyWith<CouponDto> get copyWith => _$CouponDtoCopyWithImpl<CouponDto>(this as CouponDto, _$identity);

  /// Serializes this CouponDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CouponDto&&(identical(other.couponName, couponName) || other.couponName == couponName)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.description, description) || other.description == description)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.drawDateTime, drawDateTime) || other.drawDateTime == drawDateTime)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&const DeepCollectionEquality().equals(other.prizePools, prizePools)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponName,storeName,description,couponCode,drawDateTime,expiryDate,const DeepCollectionEquality().hash(prizePools),shopId,id);

@override
String toString() {
  return 'CouponDto(couponName: $couponName, storeName: $storeName, description: $description, couponCode: $couponCode, drawDateTime: $drawDateTime, expiryDate: $expiryDate, prizePools: $prizePools, shopId: $shopId, id: $id)';
}


}

/// @nodoc
abstract mixin class $CouponDtoCopyWith<$Res>  {
  factory $CouponDtoCopyWith(CouponDto value, $Res Function(CouponDto) _then) = _$CouponDtoCopyWithImpl;
@useResult
$Res call({
 String couponName, String storeName, String description, String couponCode, DateTime drawDateTime, DateTime expiryDate, List<PricePoolDto> prizePools, String shopId, String? id
});




}
/// @nodoc
class _$CouponDtoCopyWithImpl<$Res>
    implements $CouponDtoCopyWith<$Res> {
  _$CouponDtoCopyWithImpl(this._self, this._then);

  final CouponDto _self;
  final $Res Function(CouponDto) _then;

/// Create a copy of CouponDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? couponName = null,Object? storeName = null,Object? description = null,Object? couponCode = null,Object? drawDateTime = null,Object? expiryDate = null,Object? prizePools = null,Object? shopId = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
couponName: null == couponName ? _self.couponName : couponName // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,couponCode: null == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String,drawDateTime: null == drawDateTime ? _self.drawDateTime : drawDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,prizePools: null == prizePools ? _self.prizePools : prizePools // ignore: cast_nullable_to_non_nullable
as List<PricePoolDto>,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CouponDto].
extension CouponDtoPatterns on CouponDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CouponDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CouponDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CouponDto value)  $default,){
final _that = this;
switch (_that) {
case _CouponDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CouponDto value)?  $default,){
final _that = this;
switch (_that) {
case _CouponDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String couponName,  String storeName,  String description,  String couponCode,  DateTime drawDateTime,  DateTime expiryDate,  List<PricePoolDto> prizePools,  String shopId,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CouponDto() when $default != null:
return $default(_that.couponName,_that.storeName,_that.description,_that.couponCode,_that.drawDateTime,_that.expiryDate,_that.prizePools,_that.shopId,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String couponName,  String storeName,  String description,  String couponCode,  DateTime drawDateTime,  DateTime expiryDate,  List<PricePoolDto> prizePools,  String shopId,  String? id)  $default,) {final _that = this;
switch (_that) {
case _CouponDto():
return $default(_that.couponName,_that.storeName,_that.description,_that.couponCode,_that.drawDateTime,_that.expiryDate,_that.prizePools,_that.shopId,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String couponName,  String storeName,  String description,  String couponCode,  DateTime drawDateTime,  DateTime expiryDate,  List<PricePoolDto> prizePools,  String shopId,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _CouponDto() when $default != null:
return $default(_that.couponName,_that.storeName,_that.description,_that.couponCode,_that.drawDateTime,_that.expiryDate,_that.prizePools,_that.shopId,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CouponDto implements CouponDto {
  const _CouponDto({required this.couponName, required this.storeName, required this.description, required this.couponCode, required this.drawDateTime, required this.expiryDate, required final  List<PricePoolDto> prizePools, required this.shopId, this.id}): _prizePools = prizePools;
  factory _CouponDto.fromJson(Map<String, dynamic> json) => _$CouponDtoFromJson(json);

@override final  String couponName;
@override final  String storeName;
@override final  String description;
@override final  String couponCode;
@override final  DateTime drawDateTime;
@override final  DateTime expiryDate;
// required String imageUrl,
 final  List<PricePoolDto> _prizePools;
// required String imageUrl,
@override List<PricePoolDto> get prizePools {
  if (_prizePools is EqualUnmodifiableListView) return _prizePools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prizePools);
}

@override final  String shopId;
@override final  String? id;

/// Create a copy of CouponDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponDtoCopyWith<_CouponDto> get copyWith => __$CouponDtoCopyWithImpl<_CouponDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CouponDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CouponDto&&(identical(other.couponName, couponName) || other.couponName == couponName)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.description, description) || other.description == description)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.drawDateTime, drawDateTime) || other.drawDateTime == drawDateTime)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&const DeepCollectionEquality().equals(other._prizePools, _prizePools)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponName,storeName,description,couponCode,drawDateTime,expiryDate,const DeepCollectionEquality().hash(_prizePools),shopId,id);

@override
String toString() {
  return 'CouponDto(couponName: $couponName, storeName: $storeName, description: $description, couponCode: $couponCode, drawDateTime: $drawDateTime, expiryDate: $expiryDate, prizePools: $prizePools, shopId: $shopId, id: $id)';
}


}

/// @nodoc
abstract mixin class _$CouponDtoCopyWith<$Res> implements $CouponDtoCopyWith<$Res> {
  factory _$CouponDtoCopyWith(_CouponDto value, $Res Function(_CouponDto) _then) = __$CouponDtoCopyWithImpl;
@override @useResult
$Res call({
 String couponName, String storeName, String description, String couponCode, DateTime drawDateTime, DateTime expiryDate, List<PricePoolDto> prizePools, String shopId, String? id
});




}
/// @nodoc
class __$CouponDtoCopyWithImpl<$Res>
    implements _$CouponDtoCopyWith<$Res> {
  __$CouponDtoCopyWithImpl(this._self, this._then);

  final _CouponDto _self;
  final $Res Function(_CouponDto) _then;

/// Create a copy of CouponDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? couponName = null,Object? storeName = null,Object? description = null,Object? couponCode = null,Object? drawDateTime = null,Object? expiryDate = null,Object? prizePools = null,Object? shopId = null,Object? id = freezed,}) {
  return _then(_CouponDto(
couponName: null == couponName ? _self.couponName : couponName // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,couponCode: null == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String,drawDateTime: null == drawDateTime ? _self.drawDateTime : drawDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,prizePools: null == prizePools ? _self._prizePools : prizePools // ignore: cast_nullable_to_non_nullable
as List<PricePoolDto>,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
