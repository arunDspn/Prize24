// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopModel {

 String? get id; String get shopName; String get shopPhone; String get shopAddress;/// Vendor ID == User ID
 String get shopOwnerId;@JsonKey(defaultValue: '') String? get shopDescription; String? get shopEmail;// required String shopLocation,
 ShopStatus get shopStatus;// Streak Data
 int get giftCycleDay; int get bonusIncrementValue; int get bonusIncrementDaysRequired; int get totalFollowers; String? get associatedCampaignId; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopModelCopyWith<ShopModel> get copyWith => _$ShopModelCopyWithImpl<ShopModel>(this as ShopModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopOwnerId, shopOwnerId) || other.shopOwnerId == shopOwnerId)&&(identical(other.shopDescription, shopDescription) || other.shopDescription == shopDescription)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopStatus, shopStatus) || other.shopStatus == shopStatus)&&(identical(other.giftCycleDay, giftCycleDay) || other.giftCycleDay == giftCycleDay)&&(identical(other.bonusIncrementValue, bonusIncrementValue) || other.bonusIncrementValue == bonusIncrementValue)&&(identical(other.bonusIncrementDaysRequired, bonusIncrementDaysRequired) || other.bonusIncrementDaysRequired == bonusIncrementDaysRequired)&&(identical(other.totalFollowers, totalFollowers) || other.totalFollowers == totalFollowers)&&(identical(other.associatedCampaignId, associatedCampaignId) || other.associatedCampaignId == associatedCampaignId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopName,shopPhone,shopAddress,shopOwnerId,shopDescription,shopEmail,shopStatus,giftCycleDay,bonusIncrementValue,bonusIncrementDaysRequired,totalFollowers,associatedCampaignId,createdAt,updatedAt);

@override
String toString() {
  return 'ShopModel(id: $id, shopName: $shopName, shopPhone: $shopPhone, shopAddress: $shopAddress, shopOwnerId: $shopOwnerId, shopDescription: $shopDescription, shopEmail: $shopEmail, shopStatus: $shopStatus, giftCycleDay: $giftCycleDay, bonusIncrementValue: $bonusIncrementValue, bonusIncrementDaysRequired: $bonusIncrementDaysRequired, totalFollowers: $totalFollowers, associatedCampaignId: $associatedCampaignId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ShopModelCopyWith<$Res>  {
  factory $ShopModelCopyWith(ShopModel value, $Res Function(ShopModel) _then) = _$ShopModelCopyWithImpl;
@useResult
$Res call({
 String? id, String shopName, String shopPhone, String shopAddress, String shopOwnerId,@JsonKey(defaultValue: '') String? shopDescription, String? shopEmail, ShopStatus shopStatus, int giftCycleDay, int bonusIncrementValue, int bonusIncrementDaysRequired, int totalFollowers, String? associatedCampaignId, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ShopModelCopyWithImpl<$Res>
    implements $ShopModelCopyWith<$Res> {
  _$ShopModelCopyWithImpl(this._self, this._then);

  final ShopModel _self;
  final $Res Function(ShopModel) _then;

/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? shopName = null,Object? shopPhone = null,Object? shopAddress = null,Object? shopOwnerId = null,Object? shopDescription = freezed,Object? shopEmail = freezed,Object? shopStatus = null,Object? giftCycleDay = null,Object? bonusIncrementValue = null,Object? bonusIncrementDaysRequired = null,Object? totalFollowers = null,Object? associatedCampaignId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopPhone: null == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopOwnerId: null == shopOwnerId ? _self.shopOwnerId : shopOwnerId // ignore: cast_nullable_to_non_nullable
as String,shopDescription: freezed == shopDescription ? _self.shopDescription : shopDescription // ignore: cast_nullable_to_non_nullable
as String?,shopEmail: freezed == shopEmail ? _self.shopEmail : shopEmail // ignore: cast_nullable_to_non_nullable
as String?,shopStatus: null == shopStatus ? _self.shopStatus : shopStatus // ignore: cast_nullable_to_non_nullable
as ShopStatus,giftCycleDay: null == giftCycleDay ? _self.giftCycleDay : giftCycleDay // ignore: cast_nullable_to_non_nullable
as int,bonusIncrementValue: null == bonusIncrementValue ? _self.bonusIncrementValue : bonusIncrementValue // ignore: cast_nullable_to_non_nullable
as int,bonusIncrementDaysRequired: null == bonusIncrementDaysRequired ? _self.bonusIncrementDaysRequired : bonusIncrementDaysRequired // ignore: cast_nullable_to_non_nullable
as int,totalFollowers: null == totalFollowers ? _self.totalFollowers : totalFollowers // ignore: cast_nullable_to_non_nullable
as int,associatedCampaignId: freezed == associatedCampaignId ? _self.associatedCampaignId : associatedCampaignId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopModel].
extension ShopModelPatterns on ShopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopModel value)  $default,){
final _that = this;
switch (_that) {
case _ShopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String shopName,  String shopPhone,  String shopAddress,  String shopOwnerId, @JsonKey(defaultValue: '')  String? shopDescription,  String? shopEmail,  ShopStatus shopStatus,  int giftCycleDay,  int bonusIncrementValue,  int bonusIncrementDaysRequired,  int totalFollowers,  String? associatedCampaignId,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
return $default(_that.id,_that.shopName,_that.shopPhone,_that.shopAddress,_that.shopOwnerId,_that.shopDescription,_that.shopEmail,_that.shopStatus,_that.giftCycleDay,_that.bonusIncrementValue,_that.bonusIncrementDaysRequired,_that.totalFollowers,_that.associatedCampaignId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String shopName,  String shopPhone,  String shopAddress,  String shopOwnerId, @JsonKey(defaultValue: '')  String? shopDescription,  String? shopEmail,  ShopStatus shopStatus,  int giftCycleDay,  int bonusIncrementValue,  int bonusIncrementDaysRequired,  int totalFollowers,  String? associatedCampaignId,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ShopModel():
return $default(_that.id,_that.shopName,_that.shopPhone,_that.shopAddress,_that.shopOwnerId,_that.shopDescription,_that.shopEmail,_that.shopStatus,_that.giftCycleDay,_that.bonusIncrementValue,_that.bonusIncrementDaysRequired,_that.totalFollowers,_that.associatedCampaignId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String shopName,  String shopPhone,  String shopAddress,  String shopOwnerId, @JsonKey(defaultValue: '')  String? shopDescription,  String? shopEmail,  ShopStatus shopStatus,  int giftCycleDay,  int bonusIncrementValue,  int bonusIncrementDaysRequired,  int totalFollowers,  String? associatedCampaignId,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
return $default(_that.id,_that.shopName,_that.shopPhone,_that.shopAddress,_that.shopOwnerId,_that.shopDescription,_that.shopEmail,_that.shopStatus,_that.giftCycleDay,_that.bonusIncrementValue,_that.bonusIncrementDaysRequired,_that.totalFollowers,_that.associatedCampaignId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ShopModel extends ShopModel {
  const _ShopModel({required this.id, required this.shopName, required this.shopPhone, required this.shopAddress, required this.shopOwnerId, @JsonKey(defaultValue: '') this.shopDescription, this.shopEmail, this.shopStatus = ShopStatus.active, required this.giftCycleDay, required this.bonusIncrementValue, required this.bonusIncrementDaysRequired, required this.totalFollowers, this.associatedCampaignId, this.createdAt, this.updatedAt}): super._();
  

@override final  String? id;
@override final  String shopName;
@override final  String shopPhone;
@override final  String shopAddress;
/// Vendor ID == User ID
@override final  String shopOwnerId;
@override@JsonKey(defaultValue: '') final  String? shopDescription;
@override final  String? shopEmail;
// required String shopLocation,
@override@JsonKey() final  ShopStatus shopStatus;
// Streak Data
@override final  int giftCycleDay;
@override final  int bonusIncrementValue;
@override final  int bonusIncrementDaysRequired;
@override final  int totalFollowers;
@override final  String? associatedCampaignId;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopModelCopyWith<_ShopModel> get copyWith => __$ShopModelCopyWithImpl<_ShopModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopOwnerId, shopOwnerId) || other.shopOwnerId == shopOwnerId)&&(identical(other.shopDescription, shopDescription) || other.shopDescription == shopDescription)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopStatus, shopStatus) || other.shopStatus == shopStatus)&&(identical(other.giftCycleDay, giftCycleDay) || other.giftCycleDay == giftCycleDay)&&(identical(other.bonusIncrementValue, bonusIncrementValue) || other.bonusIncrementValue == bonusIncrementValue)&&(identical(other.bonusIncrementDaysRequired, bonusIncrementDaysRequired) || other.bonusIncrementDaysRequired == bonusIncrementDaysRequired)&&(identical(other.totalFollowers, totalFollowers) || other.totalFollowers == totalFollowers)&&(identical(other.associatedCampaignId, associatedCampaignId) || other.associatedCampaignId == associatedCampaignId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopName,shopPhone,shopAddress,shopOwnerId,shopDescription,shopEmail,shopStatus,giftCycleDay,bonusIncrementValue,bonusIncrementDaysRequired,totalFollowers,associatedCampaignId,createdAt,updatedAt);

@override
String toString() {
  return 'ShopModel(id: $id, shopName: $shopName, shopPhone: $shopPhone, shopAddress: $shopAddress, shopOwnerId: $shopOwnerId, shopDescription: $shopDescription, shopEmail: $shopEmail, shopStatus: $shopStatus, giftCycleDay: $giftCycleDay, bonusIncrementValue: $bonusIncrementValue, bonusIncrementDaysRequired: $bonusIncrementDaysRequired, totalFollowers: $totalFollowers, associatedCampaignId: $associatedCampaignId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ShopModelCopyWith<$Res> implements $ShopModelCopyWith<$Res> {
  factory _$ShopModelCopyWith(_ShopModel value, $Res Function(_ShopModel) _then) = __$ShopModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String shopName, String shopPhone, String shopAddress, String shopOwnerId,@JsonKey(defaultValue: '') String? shopDescription, String? shopEmail, ShopStatus shopStatus, int giftCycleDay, int bonusIncrementValue, int bonusIncrementDaysRequired, int totalFollowers, String? associatedCampaignId, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ShopModelCopyWithImpl<$Res>
    implements _$ShopModelCopyWith<$Res> {
  __$ShopModelCopyWithImpl(this._self, this._then);

  final _ShopModel _self;
  final $Res Function(_ShopModel) _then;

/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? shopName = null,Object? shopPhone = null,Object? shopAddress = null,Object? shopOwnerId = null,Object? shopDescription = freezed,Object? shopEmail = freezed,Object? shopStatus = null,Object? giftCycleDay = null,Object? bonusIncrementValue = null,Object? bonusIncrementDaysRequired = null,Object? totalFollowers = null,Object? associatedCampaignId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ShopModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopPhone: null == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopOwnerId: null == shopOwnerId ? _self.shopOwnerId : shopOwnerId // ignore: cast_nullable_to_non_nullable
as String,shopDescription: freezed == shopDescription ? _self.shopDescription : shopDescription // ignore: cast_nullable_to_non_nullable
as String?,shopEmail: freezed == shopEmail ? _self.shopEmail : shopEmail // ignore: cast_nullable_to_non_nullable
as String?,shopStatus: null == shopStatus ? _self.shopStatus : shopStatus // ignore: cast_nullable_to_non_nullable
as ShopStatus,giftCycleDay: null == giftCycleDay ? _self.giftCycleDay : giftCycleDay // ignore: cast_nullable_to_non_nullable
as int,bonusIncrementValue: null == bonusIncrementValue ? _self.bonusIncrementValue : bonusIncrementValue // ignore: cast_nullable_to_non_nullable
as int,bonusIncrementDaysRequired: null == bonusIncrementDaysRequired ? _self.bonusIncrementDaysRequired : bonusIncrementDaysRequired // ignore: cast_nullable_to_non_nullable
as int,totalFollowers: null == totalFollowers ? _self.totalFollowers : totalFollowers // ignore: cast_nullable_to_non_nullable
as int,associatedCampaignId: freezed == associatedCampaignId ? _self.associatedCampaignId : associatedCampaignId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
