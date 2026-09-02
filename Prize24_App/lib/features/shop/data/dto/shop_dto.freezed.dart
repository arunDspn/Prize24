// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopDto {

 String get shopName; String get shopPhone; String get shopAddress;// required String shopCategory,
/// The ID of the vendor that owns the shop.
 String get shopOwnerId; String get shopStatus;@JsonKey(includeIfNull: false) String? get shopId; String? get shopDescription;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt; String? get shopEmail;// Streak Data
 int get giftCycleDay; int get bonusIncrementValue; int get bonusIncrementDaysRequired; int get totalFollowers; String? get associatedCampaignId;
/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopDtoCopyWith<ShopDto> get copyWith => _$ShopDtoCopyWithImpl<ShopDto>(this as ShopDto, _$identity);

  /// Serializes this ShopDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopDto&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopOwnerId, shopOwnerId) || other.shopOwnerId == shopOwnerId)&&(identical(other.shopStatus, shopStatus) || other.shopStatus == shopStatus)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopDescription, shopDescription) || other.shopDescription == shopDescription)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.giftCycleDay, giftCycleDay) || other.giftCycleDay == giftCycleDay)&&(identical(other.bonusIncrementValue, bonusIncrementValue) || other.bonusIncrementValue == bonusIncrementValue)&&(identical(other.bonusIncrementDaysRequired, bonusIncrementDaysRequired) || other.bonusIncrementDaysRequired == bonusIncrementDaysRequired)&&(identical(other.totalFollowers, totalFollowers) || other.totalFollowers == totalFollowers)&&(identical(other.associatedCampaignId, associatedCampaignId) || other.associatedCampaignId == associatedCampaignId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopName,shopPhone,shopAddress,shopOwnerId,shopStatus,shopId,shopDescription,createdAt,updatedAt,shopEmail,giftCycleDay,bonusIncrementValue,bonusIncrementDaysRequired,totalFollowers,associatedCampaignId);

@override
String toString() {
  return 'ShopDto(shopName: $shopName, shopPhone: $shopPhone, shopAddress: $shopAddress, shopOwnerId: $shopOwnerId, shopStatus: $shopStatus, shopId: $shopId, shopDescription: $shopDescription, createdAt: $createdAt, updatedAt: $updatedAt, shopEmail: $shopEmail, giftCycleDay: $giftCycleDay, bonusIncrementValue: $bonusIncrementValue, bonusIncrementDaysRequired: $bonusIncrementDaysRequired, totalFollowers: $totalFollowers, associatedCampaignId: $associatedCampaignId)';
}


}

/// @nodoc
abstract mixin class $ShopDtoCopyWith<$Res>  {
  factory $ShopDtoCopyWith(ShopDto value, $Res Function(ShopDto) _then) = _$ShopDtoCopyWithImpl;
@useResult
$Res call({
 String shopName, String shopPhone, String shopAddress, String shopOwnerId, String shopStatus,@JsonKey(includeIfNull: false) String? shopId, String? shopDescription,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, String? shopEmail, int giftCycleDay, int bonusIncrementValue, int bonusIncrementDaysRequired, int totalFollowers, String? associatedCampaignId
});




}
/// @nodoc
class _$ShopDtoCopyWithImpl<$Res>
    implements $ShopDtoCopyWith<$Res> {
  _$ShopDtoCopyWithImpl(this._self, this._then);

  final ShopDto _self;
  final $Res Function(ShopDto) _then;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopName = null,Object? shopPhone = null,Object? shopAddress = null,Object? shopOwnerId = null,Object? shopStatus = null,Object? shopId = freezed,Object? shopDescription = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? shopEmail = freezed,Object? giftCycleDay = null,Object? bonusIncrementValue = null,Object? bonusIncrementDaysRequired = null,Object? totalFollowers = null,Object? associatedCampaignId = freezed,}) {
  return _then(_self.copyWith(
shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopPhone: null == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopOwnerId: null == shopOwnerId ? _self.shopOwnerId : shopOwnerId // ignore: cast_nullable_to_non_nullable
as String,shopStatus: null == shopStatus ? _self.shopStatus : shopStatus // ignore: cast_nullable_to_non_nullable
as String,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,shopDescription: freezed == shopDescription ? _self.shopDescription : shopDescription // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,shopEmail: freezed == shopEmail ? _self.shopEmail : shopEmail // ignore: cast_nullable_to_non_nullable
as String?,giftCycleDay: null == giftCycleDay ? _self.giftCycleDay : giftCycleDay // ignore: cast_nullable_to_non_nullable
as int,bonusIncrementValue: null == bonusIncrementValue ? _self.bonusIncrementValue : bonusIncrementValue // ignore: cast_nullable_to_non_nullable
as int,bonusIncrementDaysRequired: null == bonusIncrementDaysRequired ? _self.bonusIncrementDaysRequired : bonusIncrementDaysRequired // ignore: cast_nullable_to_non_nullable
as int,totalFollowers: null == totalFollowers ? _self.totalFollowers : totalFollowers // ignore: cast_nullable_to_non_nullable
as int,associatedCampaignId: freezed == associatedCampaignId ? _self.associatedCampaignId : associatedCampaignId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopDto].
extension ShopDtoPatterns on ShopDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopName,  String shopPhone,  String shopAddress,  String shopOwnerId,  String shopStatus, @JsonKey(includeIfNull: false)  String? shopId,  String? shopDescription, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt,  String? shopEmail,  int giftCycleDay,  int bonusIncrementValue,  int bonusIncrementDaysRequired,  int totalFollowers,  String? associatedCampaignId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that.shopName,_that.shopPhone,_that.shopAddress,_that.shopOwnerId,_that.shopStatus,_that.shopId,_that.shopDescription,_that.createdAt,_that.updatedAt,_that.shopEmail,_that.giftCycleDay,_that.bonusIncrementValue,_that.bonusIncrementDaysRequired,_that.totalFollowers,_that.associatedCampaignId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopName,  String shopPhone,  String shopAddress,  String shopOwnerId,  String shopStatus, @JsonKey(includeIfNull: false)  String? shopId,  String? shopDescription, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt,  String? shopEmail,  int giftCycleDay,  int bonusIncrementValue,  int bonusIncrementDaysRequired,  int totalFollowers,  String? associatedCampaignId)  $default,) {final _that = this;
switch (_that) {
case _ShopDto():
return $default(_that.shopName,_that.shopPhone,_that.shopAddress,_that.shopOwnerId,_that.shopStatus,_that.shopId,_that.shopDescription,_that.createdAt,_that.updatedAt,_that.shopEmail,_that.giftCycleDay,_that.bonusIncrementValue,_that.bonusIncrementDaysRequired,_that.totalFollowers,_that.associatedCampaignId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopName,  String shopPhone,  String shopAddress,  String shopOwnerId,  String shopStatus, @JsonKey(includeIfNull: false)  String? shopId,  String? shopDescription, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt,  String? shopEmail,  int giftCycleDay,  int bonusIncrementValue,  int bonusIncrementDaysRequired,  int totalFollowers,  String? associatedCampaignId)?  $default,) {final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that.shopName,_that.shopPhone,_that.shopAddress,_that.shopOwnerId,_that.shopStatus,_that.shopId,_that.shopDescription,_that.createdAt,_that.updatedAt,_that.shopEmail,_that.giftCycleDay,_that.bonusIncrementValue,_that.bonusIncrementDaysRequired,_that.totalFollowers,_that.associatedCampaignId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopDto extends ShopDto {
  const _ShopDto({required this.shopName, required this.shopPhone, required this.shopAddress, required this.shopOwnerId, this.shopStatus = 'active', @JsonKey(includeIfNull: false) this.shopId, this.shopDescription, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt, this.shopEmail, required this.giftCycleDay, required this.bonusIncrementValue, required this.bonusIncrementDaysRequired, this.totalFollowers = 0, this.associatedCampaignId}): super._();
  factory _ShopDto.fromJson(Map<String, dynamic> json) => _$ShopDtoFromJson(json);

@override final  String shopName;
@override final  String shopPhone;
@override final  String shopAddress;
// required String shopCategory,
/// The ID of the vendor that owns the shop.
@override final  String shopOwnerId;
@override@JsonKey() final  String shopStatus;
@override@JsonKey(includeIfNull: false) final  String? shopId;
@override final  String? shopDescription;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;
@override final  String? shopEmail;
// Streak Data
@override final  int giftCycleDay;
@override final  int bonusIncrementValue;
@override final  int bonusIncrementDaysRequired;
@override@JsonKey() final  int totalFollowers;
@override final  String? associatedCampaignId;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopDtoCopyWith<_ShopDto> get copyWith => __$ShopDtoCopyWithImpl<_ShopDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopDto&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopOwnerId, shopOwnerId) || other.shopOwnerId == shopOwnerId)&&(identical(other.shopStatus, shopStatus) || other.shopStatus == shopStatus)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopDescription, shopDescription) || other.shopDescription == shopDescription)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.giftCycleDay, giftCycleDay) || other.giftCycleDay == giftCycleDay)&&(identical(other.bonusIncrementValue, bonusIncrementValue) || other.bonusIncrementValue == bonusIncrementValue)&&(identical(other.bonusIncrementDaysRequired, bonusIncrementDaysRequired) || other.bonusIncrementDaysRequired == bonusIncrementDaysRequired)&&(identical(other.totalFollowers, totalFollowers) || other.totalFollowers == totalFollowers)&&(identical(other.associatedCampaignId, associatedCampaignId) || other.associatedCampaignId == associatedCampaignId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopName,shopPhone,shopAddress,shopOwnerId,shopStatus,shopId,shopDescription,createdAt,updatedAt,shopEmail,giftCycleDay,bonusIncrementValue,bonusIncrementDaysRequired,totalFollowers,associatedCampaignId);

@override
String toString() {
  return 'ShopDto(shopName: $shopName, shopPhone: $shopPhone, shopAddress: $shopAddress, shopOwnerId: $shopOwnerId, shopStatus: $shopStatus, shopId: $shopId, shopDescription: $shopDescription, createdAt: $createdAt, updatedAt: $updatedAt, shopEmail: $shopEmail, giftCycleDay: $giftCycleDay, bonusIncrementValue: $bonusIncrementValue, bonusIncrementDaysRequired: $bonusIncrementDaysRequired, totalFollowers: $totalFollowers, associatedCampaignId: $associatedCampaignId)';
}


}

/// @nodoc
abstract mixin class _$ShopDtoCopyWith<$Res> implements $ShopDtoCopyWith<$Res> {
  factory _$ShopDtoCopyWith(_ShopDto value, $Res Function(_ShopDto) _then) = __$ShopDtoCopyWithImpl;
@override @useResult
$Res call({
 String shopName, String shopPhone, String shopAddress, String shopOwnerId, String shopStatus,@JsonKey(includeIfNull: false) String? shopId, String? shopDescription,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, String? shopEmail, int giftCycleDay, int bonusIncrementValue, int bonusIncrementDaysRequired, int totalFollowers, String? associatedCampaignId
});




}
/// @nodoc
class __$ShopDtoCopyWithImpl<$Res>
    implements _$ShopDtoCopyWith<$Res> {
  __$ShopDtoCopyWithImpl(this._self, this._then);

  final _ShopDto _self;
  final $Res Function(_ShopDto) _then;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopName = null,Object? shopPhone = null,Object? shopAddress = null,Object? shopOwnerId = null,Object? shopStatus = null,Object? shopId = freezed,Object? shopDescription = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? shopEmail = freezed,Object? giftCycleDay = null,Object? bonusIncrementValue = null,Object? bonusIncrementDaysRequired = null,Object? totalFollowers = null,Object? associatedCampaignId = freezed,}) {
  return _then(_ShopDto(
shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopPhone: null == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopOwnerId: null == shopOwnerId ? _self.shopOwnerId : shopOwnerId // ignore: cast_nullable_to_non_nullable
as String,shopStatus: null == shopStatus ? _self.shopStatus : shopStatus // ignore: cast_nullable_to_non_nullable
as String,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,shopDescription: freezed == shopDescription ? _self.shopDescription : shopDescription // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,shopEmail: freezed == shopEmail ? _self.shopEmail : shopEmail // ignore: cast_nullable_to_non_nullable
as String?,giftCycleDay: null == giftCycleDay ? _self.giftCycleDay : giftCycleDay // ignore: cast_nullable_to_non_nullable
as int,bonusIncrementValue: null == bonusIncrementValue ? _self.bonusIncrementValue : bonusIncrementValue // ignore: cast_nullable_to_non_nullable
as int,bonusIncrementDaysRequired: null == bonusIncrementDaysRequired ? _self.bonusIncrementDaysRequired : bonusIncrementDaysRequired // ignore: cast_nullable_to_non_nullable
as int,totalFollowers: null == totalFollowers ? _self.totalFollowers : totalFollowers // ignore: cast_nullable_to_non_nullable
as int,associatedCampaignId: freezed == associatedCampaignId ? _self.associatedCampaignId : associatedCampaignId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
