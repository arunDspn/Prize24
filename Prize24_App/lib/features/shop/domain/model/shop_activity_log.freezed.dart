// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_activity_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopActivityLogPayload {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopActivityLogPayload);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopActivityLogPayload()';
}


}

/// @nodoc
class $ShopActivityLogPayloadCopyWith<$Res>  {
$ShopActivityLogPayloadCopyWith(ShopActivityLogPayload _, $Res Function(ShopActivityLogPayload) __);
}


/// Adds pattern-matching-related methods to [ShopActivityLogPayload].
extension ShopActivityLogPayloadPatterns on ShopActivityLogPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ShopGiftAvailTriggeredPayload value)?  giftAvailTriggered,TResult Function( ShopCheckInSuccessPayload value)?  checkInSuccess,TResult Function( ShopCheckInFailedPayload value)?  checkInFailed,TResult Function( ShopFollowerAddedPayload value)?  followerAdded,TResult Function( UnknownShopPayload value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ShopGiftAvailTriggeredPayload() when giftAvailTriggered != null:
return giftAvailTriggered(_that);case ShopCheckInSuccessPayload() when checkInSuccess != null:
return checkInSuccess(_that);case ShopCheckInFailedPayload() when checkInFailed != null:
return checkInFailed(_that);case ShopFollowerAddedPayload() when followerAdded != null:
return followerAdded(_that);case UnknownShopPayload() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ShopGiftAvailTriggeredPayload value)  giftAvailTriggered,required TResult Function( ShopCheckInSuccessPayload value)  checkInSuccess,required TResult Function( ShopCheckInFailedPayload value)  checkInFailed,required TResult Function( ShopFollowerAddedPayload value)  followerAdded,required TResult Function( UnknownShopPayload value)  unknown,}){
final _that = this;
switch (_that) {
case ShopGiftAvailTriggeredPayload():
return giftAvailTriggered(_that);case ShopCheckInSuccessPayload():
return checkInSuccess(_that);case ShopCheckInFailedPayload():
return checkInFailed(_that);case ShopFollowerAddedPayload():
return followerAdded(_that);case UnknownShopPayload():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ShopGiftAvailTriggeredPayload value)?  giftAvailTriggered,TResult? Function( ShopCheckInSuccessPayload value)?  checkInSuccess,TResult? Function( ShopCheckInFailedPayload value)?  checkInFailed,TResult? Function( ShopFollowerAddedPayload value)?  followerAdded,TResult? Function( UnknownShopPayload value)?  unknown,}){
final _that = this;
switch (_that) {
case ShopGiftAvailTriggeredPayload() when giftAvailTriggered != null:
return giftAvailTriggered(_that);case ShopCheckInSuccessPayload() when checkInSuccess != null:
return checkInSuccess(_that);case ShopCheckInFailedPayload() when checkInFailed != null:
return checkInFailed(_that);case ShopFollowerAddedPayload() when followerAdded != null:
return followerAdded(_that);case UnknownShopPayload() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String customerId,  String campaignId,  String availStatus,  bool triggeredByStreak,  int? streakValue,  int? giftCycleDay,  String? giftId,  String? giftName,  String? shopId,  String? failureReason,  double? luckFactor,  double? randomNumber)?  giftAvailTriggered,TResult Function( String customerId,  String shopId,  int cumulativeStreak,  int consecutiveDays,  bool bonusApplied,  bool isGiftDay,  bool wasAutoFollowed,  int previousStreak,  String billNumber,  double billAmount,  double cycleBillSum,  double previousCycleBillSum,  double cumulativeBillSum,  int? bonusValue,  String? campaignId)?  checkInSuccess,TResult Function( String customerId,  String shopId,  String? failureReason)?  checkInFailed,TResult Function( String customerId,  String shopId,  String addedMethod,  int initialStreak)?  followerAdded,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ShopGiftAvailTriggeredPayload() when giftAvailTriggered != null:
return giftAvailTriggered(_that.customerId,_that.campaignId,_that.availStatus,_that.triggeredByStreak,_that.streakValue,_that.giftCycleDay,_that.giftId,_that.giftName,_that.shopId,_that.failureReason,_that.luckFactor,_that.randomNumber);case ShopCheckInSuccessPayload() when checkInSuccess != null:
return checkInSuccess(_that.customerId,_that.shopId,_that.cumulativeStreak,_that.consecutiveDays,_that.bonusApplied,_that.isGiftDay,_that.wasAutoFollowed,_that.previousStreak,_that.billNumber,_that.billAmount,_that.cycleBillSum,_that.previousCycleBillSum,_that.cumulativeBillSum,_that.bonusValue,_that.campaignId);case ShopCheckInFailedPayload() when checkInFailed != null:
return checkInFailed(_that.customerId,_that.shopId,_that.failureReason);case ShopFollowerAddedPayload() when followerAdded != null:
return followerAdded(_that.customerId,_that.shopId,_that.addedMethod,_that.initialStreak);case UnknownShopPayload() when unknown != null:
return unknown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String customerId,  String campaignId,  String availStatus,  bool triggeredByStreak,  int? streakValue,  int? giftCycleDay,  String? giftId,  String? giftName,  String? shopId,  String? failureReason,  double? luckFactor,  double? randomNumber)  giftAvailTriggered,required TResult Function( String customerId,  String shopId,  int cumulativeStreak,  int consecutiveDays,  bool bonusApplied,  bool isGiftDay,  bool wasAutoFollowed,  int previousStreak,  String billNumber,  double billAmount,  double cycleBillSum,  double previousCycleBillSum,  double cumulativeBillSum,  int? bonusValue,  String? campaignId)  checkInSuccess,required TResult Function( String customerId,  String shopId,  String? failureReason)  checkInFailed,required TResult Function( String customerId,  String shopId,  String addedMethod,  int initialStreak)  followerAdded,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case ShopGiftAvailTriggeredPayload():
return giftAvailTriggered(_that.customerId,_that.campaignId,_that.availStatus,_that.triggeredByStreak,_that.streakValue,_that.giftCycleDay,_that.giftId,_that.giftName,_that.shopId,_that.failureReason,_that.luckFactor,_that.randomNumber);case ShopCheckInSuccessPayload():
return checkInSuccess(_that.customerId,_that.shopId,_that.cumulativeStreak,_that.consecutiveDays,_that.bonusApplied,_that.isGiftDay,_that.wasAutoFollowed,_that.previousStreak,_that.billNumber,_that.billAmount,_that.cycleBillSum,_that.previousCycleBillSum,_that.cumulativeBillSum,_that.bonusValue,_that.campaignId);case ShopCheckInFailedPayload():
return checkInFailed(_that.customerId,_that.shopId,_that.failureReason);case ShopFollowerAddedPayload():
return followerAdded(_that.customerId,_that.shopId,_that.addedMethod,_that.initialStreak);case UnknownShopPayload():
return unknown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String customerId,  String campaignId,  String availStatus,  bool triggeredByStreak,  int? streakValue,  int? giftCycleDay,  String? giftId,  String? giftName,  String? shopId,  String? failureReason,  double? luckFactor,  double? randomNumber)?  giftAvailTriggered,TResult? Function( String customerId,  String shopId,  int cumulativeStreak,  int consecutiveDays,  bool bonusApplied,  bool isGiftDay,  bool wasAutoFollowed,  int previousStreak,  String billNumber,  double billAmount,  double cycleBillSum,  double previousCycleBillSum,  double cumulativeBillSum,  int? bonusValue,  String? campaignId)?  checkInSuccess,TResult? Function( String customerId,  String shopId,  String? failureReason)?  checkInFailed,TResult? Function( String customerId,  String shopId,  String addedMethod,  int initialStreak)?  followerAdded,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case ShopGiftAvailTriggeredPayload() when giftAvailTriggered != null:
return giftAvailTriggered(_that.customerId,_that.campaignId,_that.availStatus,_that.triggeredByStreak,_that.streakValue,_that.giftCycleDay,_that.giftId,_that.giftName,_that.shopId,_that.failureReason,_that.luckFactor,_that.randomNumber);case ShopCheckInSuccessPayload() when checkInSuccess != null:
return checkInSuccess(_that.customerId,_that.shopId,_that.cumulativeStreak,_that.consecutiveDays,_that.bonusApplied,_that.isGiftDay,_that.wasAutoFollowed,_that.previousStreak,_that.billNumber,_that.billAmount,_that.cycleBillSum,_that.previousCycleBillSum,_that.cumulativeBillSum,_that.bonusValue,_that.campaignId);case ShopCheckInFailedPayload() when checkInFailed != null:
return checkInFailed(_that.customerId,_that.shopId,_that.failureReason);case ShopFollowerAddedPayload() when followerAdded != null:
return followerAdded(_that.customerId,_that.shopId,_that.addedMethod,_that.initialStreak);case UnknownShopPayload() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc


class ShopGiftAvailTriggeredPayload extends ShopActivityLogPayload {
  const ShopGiftAvailTriggeredPayload({required this.customerId, required this.campaignId, required this.availStatus, required this.triggeredByStreak, this.streakValue, this.giftCycleDay, this.giftId, this.giftName, this.shopId, this.failureReason, this.luckFactor, this.randomNumber}): super._();
  

 final  String customerId;
 final  String campaignId;
/// `success` | `failed`
 final  String availStatus;
 final  bool triggeredByStreak;
 final  int? streakValue;
 final  int? giftCycleDay;
 final  String? giftId;
 final  String? giftName;
 final  String? shopId;
 final  String? failureReason;
 final  double? luckFactor;
 final  double? randomNumber;

/// Create a copy of ShopActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopGiftAvailTriggeredPayloadCopyWith<ShopGiftAvailTriggeredPayload> get copyWith => _$ShopGiftAvailTriggeredPayloadCopyWithImpl<ShopGiftAvailTriggeredPayload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopGiftAvailTriggeredPayload&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.availStatus, availStatus) || other.availStatus == availStatus)&&(identical(other.triggeredByStreak, triggeredByStreak) || other.triggeredByStreak == triggeredByStreak)&&(identical(other.streakValue, streakValue) || other.streakValue == streakValue)&&(identical(other.giftCycleDay, giftCycleDay) || other.giftCycleDay == giftCycleDay)&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.luckFactor, luckFactor) || other.luckFactor == luckFactor)&&(identical(other.randomNumber, randomNumber) || other.randomNumber == randomNumber));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,campaignId,availStatus,triggeredByStreak,streakValue,giftCycleDay,giftId,giftName,shopId,failureReason,luckFactor,randomNumber);

@override
String toString() {
  return 'ShopActivityLogPayload.giftAvailTriggered(customerId: $customerId, campaignId: $campaignId, availStatus: $availStatus, triggeredByStreak: $triggeredByStreak, streakValue: $streakValue, giftCycleDay: $giftCycleDay, giftId: $giftId, giftName: $giftName, shopId: $shopId, failureReason: $failureReason, luckFactor: $luckFactor, randomNumber: $randomNumber)';
}


}

/// @nodoc
abstract mixin class $ShopGiftAvailTriggeredPayloadCopyWith<$Res> implements $ShopActivityLogPayloadCopyWith<$Res> {
  factory $ShopGiftAvailTriggeredPayloadCopyWith(ShopGiftAvailTriggeredPayload value, $Res Function(ShopGiftAvailTriggeredPayload) _then) = _$ShopGiftAvailTriggeredPayloadCopyWithImpl;
@useResult
$Res call({
 String customerId, String campaignId, String availStatus, bool triggeredByStreak, int? streakValue, int? giftCycleDay, String? giftId, String? giftName, String? shopId, String? failureReason, double? luckFactor, double? randomNumber
});




}
/// @nodoc
class _$ShopGiftAvailTriggeredPayloadCopyWithImpl<$Res>
    implements $ShopGiftAvailTriggeredPayloadCopyWith<$Res> {
  _$ShopGiftAvailTriggeredPayloadCopyWithImpl(this._self, this._then);

  final ShopGiftAvailTriggeredPayload _self;
  final $Res Function(ShopGiftAvailTriggeredPayload) _then;

/// Create a copy of ShopActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? campaignId = null,Object? availStatus = null,Object? triggeredByStreak = null,Object? streakValue = freezed,Object? giftCycleDay = freezed,Object? giftId = freezed,Object? giftName = freezed,Object? shopId = freezed,Object? failureReason = freezed,Object? luckFactor = freezed,Object? randomNumber = freezed,}) {
  return _then(ShopGiftAvailTriggeredPayload(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,availStatus: null == availStatus ? _self.availStatus : availStatus // ignore: cast_nullable_to_non_nullable
as String,triggeredByStreak: null == triggeredByStreak ? _self.triggeredByStreak : triggeredByStreak // ignore: cast_nullable_to_non_nullable
as bool,streakValue: freezed == streakValue ? _self.streakValue : streakValue // ignore: cast_nullable_to_non_nullable
as int?,giftCycleDay: freezed == giftCycleDay ? _self.giftCycleDay : giftCycleDay // ignore: cast_nullable_to_non_nullable
as int?,giftId: freezed == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String?,giftName: freezed == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String?,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,luckFactor: freezed == luckFactor ? _self.luckFactor : luckFactor // ignore: cast_nullable_to_non_nullable
as double?,randomNumber: freezed == randomNumber ? _self.randomNumber : randomNumber // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc


class ShopCheckInSuccessPayload extends ShopActivityLogPayload {
  const ShopCheckInSuccessPayload({required this.customerId, required this.shopId, required this.cumulativeStreak, required this.consecutiveDays, required this.bonusApplied, required this.isGiftDay, required this.wasAutoFollowed, required this.previousStreak, required this.billNumber, required this.billAmount, required this.cycleBillSum, required this.previousCycleBillSum, required this.cumulativeBillSum, this.bonusValue, this.campaignId}): super._();
  

 final  String customerId;
 final  String shopId;
 final  int cumulativeStreak;
 final  int consecutiveDays;
 final  bool bonusApplied;
 final  bool isGiftDay;
 final  bool wasAutoFollowed;
 final  int previousStreak;
 final  String billNumber;
 final  double billAmount;
 final  double cycleBillSum;
 final  double previousCycleBillSum;
 final  double cumulativeBillSum;
 final  int? bonusValue;
 final  String? campaignId;

/// Create a copy of ShopActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopCheckInSuccessPayloadCopyWith<ShopCheckInSuccessPayload> get copyWith => _$ShopCheckInSuccessPayloadCopyWithImpl<ShopCheckInSuccessPayload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopCheckInSuccessPayload&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.bonusApplied, bonusApplied) || other.bonusApplied == bonusApplied)&&(identical(other.isGiftDay, isGiftDay) || other.isGiftDay == isGiftDay)&&(identical(other.wasAutoFollowed, wasAutoFollowed) || other.wasAutoFollowed == wasAutoFollowed)&&(identical(other.previousStreak, previousStreak) || other.previousStreak == previousStreak)&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber)&&(identical(other.billAmount, billAmount) || other.billAmount == billAmount)&&(identical(other.cycleBillSum, cycleBillSum) || other.cycleBillSum == cycleBillSum)&&(identical(other.previousCycleBillSum, previousCycleBillSum) || other.previousCycleBillSum == previousCycleBillSum)&&(identical(other.cumulativeBillSum, cumulativeBillSum) || other.cumulativeBillSum == cumulativeBillSum)&&(identical(other.bonusValue, bonusValue) || other.bonusValue == bonusValue)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,shopId,cumulativeStreak,consecutiveDays,bonusApplied,isGiftDay,wasAutoFollowed,previousStreak,billNumber,billAmount,cycleBillSum,previousCycleBillSum,cumulativeBillSum,bonusValue,campaignId);

@override
String toString() {
  return 'ShopActivityLogPayload.checkInSuccess(customerId: $customerId, shopId: $shopId, cumulativeStreak: $cumulativeStreak, consecutiveDays: $consecutiveDays, bonusApplied: $bonusApplied, isGiftDay: $isGiftDay, wasAutoFollowed: $wasAutoFollowed, previousStreak: $previousStreak, billNumber: $billNumber, billAmount: $billAmount, cycleBillSum: $cycleBillSum, previousCycleBillSum: $previousCycleBillSum, cumulativeBillSum: $cumulativeBillSum, bonusValue: $bonusValue, campaignId: $campaignId)';
}


}

/// @nodoc
abstract mixin class $ShopCheckInSuccessPayloadCopyWith<$Res> implements $ShopActivityLogPayloadCopyWith<$Res> {
  factory $ShopCheckInSuccessPayloadCopyWith(ShopCheckInSuccessPayload value, $Res Function(ShopCheckInSuccessPayload) _then) = _$ShopCheckInSuccessPayloadCopyWithImpl;
@useResult
$Res call({
 String customerId, String shopId, int cumulativeStreak, int consecutiveDays, bool bonusApplied, bool isGiftDay, bool wasAutoFollowed, int previousStreak, String billNumber, double billAmount, double cycleBillSum, double previousCycleBillSum, double cumulativeBillSum, int? bonusValue, String? campaignId
});




}
/// @nodoc
class _$ShopCheckInSuccessPayloadCopyWithImpl<$Res>
    implements $ShopCheckInSuccessPayloadCopyWith<$Res> {
  _$ShopCheckInSuccessPayloadCopyWithImpl(this._self, this._then);

  final ShopCheckInSuccessPayload _self;
  final $Res Function(ShopCheckInSuccessPayload) _then;

/// Create a copy of ShopActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? shopId = null,Object? cumulativeStreak = null,Object? consecutiveDays = null,Object? bonusApplied = null,Object? isGiftDay = null,Object? wasAutoFollowed = null,Object? previousStreak = null,Object? billNumber = null,Object? billAmount = null,Object? cycleBillSum = null,Object? previousCycleBillSum = null,Object? cumulativeBillSum = null,Object? bonusValue = freezed,Object? campaignId = freezed,}) {
  return _then(ShopCheckInSuccessPayload(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,bonusApplied: null == bonusApplied ? _self.bonusApplied : bonusApplied // ignore: cast_nullable_to_non_nullable
as bool,isGiftDay: null == isGiftDay ? _self.isGiftDay : isGiftDay // ignore: cast_nullable_to_non_nullable
as bool,wasAutoFollowed: null == wasAutoFollowed ? _self.wasAutoFollowed : wasAutoFollowed // ignore: cast_nullable_to_non_nullable
as bool,previousStreak: null == previousStreak ? _self.previousStreak : previousStreak // ignore: cast_nullable_to_non_nullable
as int,billNumber: null == billNumber ? _self.billNumber : billNumber // ignore: cast_nullable_to_non_nullable
as String,billAmount: null == billAmount ? _self.billAmount : billAmount // ignore: cast_nullable_to_non_nullable
as double,cycleBillSum: null == cycleBillSum ? _self.cycleBillSum : cycleBillSum // ignore: cast_nullable_to_non_nullable
as double,previousCycleBillSum: null == previousCycleBillSum ? _self.previousCycleBillSum : previousCycleBillSum // ignore: cast_nullable_to_non_nullable
as double,cumulativeBillSum: null == cumulativeBillSum ? _self.cumulativeBillSum : cumulativeBillSum // ignore: cast_nullable_to_non_nullable
as double,bonusValue: freezed == bonusValue ? _self.bonusValue : bonusValue // ignore: cast_nullable_to_non_nullable
as int?,campaignId: freezed == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ShopCheckInFailedPayload extends ShopActivityLogPayload {
  const ShopCheckInFailedPayload({required this.customerId, required this.shopId, this.failureReason}): super._();
  

 final  String customerId;
 final  String shopId;
 final  String? failureReason;

/// Create a copy of ShopActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopCheckInFailedPayloadCopyWith<ShopCheckInFailedPayload> get copyWith => _$ShopCheckInFailedPayloadCopyWithImpl<ShopCheckInFailedPayload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopCheckInFailedPayload&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,shopId,failureReason);

@override
String toString() {
  return 'ShopActivityLogPayload.checkInFailed(customerId: $customerId, shopId: $shopId, failureReason: $failureReason)';
}


}

/// @nodoc
abstract mixin class $ShopCheckInFailedPayloadCopyWith<$Res> implements $ShopActivityLogPayloadCopyWith<$Res> {
  factory $ShopCheckInFailedPayloadCopyWith(ShopCheckInFailedPayload value, $Res Function(ShopCheckInFailedPayload) _then) = _$ShopCheckInFailedPayloadCopyWithImpl;
@useResult
$Res call({
 String customerId, String shopId, String? failureReason
});




}
/// @nodoc
class _$ShopCheckInFailedPayloadCopyWithImpl<$Res>
    implements $ShopCheckInFailedPayloadCopyWith<$Res> {
  _$ShopCheckInFailedPayloadCopyWithImpl(this._self, this._then);

  final ShopCheckInFailedPayload _self;
  final $Res Function(ShopCheckInFailedPayload) _then;

/// Create a copy of ShopActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? shopId = null,Object? failureReason = freezed,}) {
  return _then(ShopCheckInFailedPayload(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ShopFollowerAddedPayload extends ShopActivityLogPayload {
  const ShopFollowerAddedPayload({required this.customerId, required this.shopId, required this.addedMethod, required this.initialStreak}): super._();
  

 final  String customerId;
 final  String shopId;
/// e.g. `auto_check_in`
 final  String addedMethod;
 final  int initialStreak;

/// Create a copy of ShopActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopFollowerAddedPayloadCopyWith<ShopFollowerAddedPayload> get copyWith => _$ShopFollowerAddedPayloadCopyWithImpl<ShopFollowerAddedPayload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopFollowerAddedPayload&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.addedMethod, addedMethod) || other.addedMethod == addedMethod)&&(identical(other.initialStreak, initialStreak) || other.initialStreak == initialStreak));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,shopId,addedMethod,initialStreak);

@override
String toString() {
  return 'ShopActivityLogPayload.followerAdded(customerId: $customerId, shopId: $shopId, addedMethod: $addedMethod, initialStreak: $initialStreak)';
}


}

/// @nodoc
abstract mixin class $ShopFollowerAddedPayloadCopyWith<$Res> implements $ShopActivityLogPayloadCopyWith<$Res> {
  factory $ShopFollowerAddedPayloadCopyWith(ShopFollowerAddedPayload value, $Res Function(ShopFollowerAddedPayload) _then) = _$ShopFollowerAddedPayloadCopyWithImpl;
@useResult
$Res call({
 String customerId, String shopId, String addedMethod, int initialStreak
});




}
/// @nodoc
class _$ShopFollowerAddedPayloadCopyWithImpl<$Res>
    implements $ShopFollowerAddedPayloadCopyWith<$Res> {
  _$ShopFollowerAddedPayloadCopyWithImpl(this._self, this._then);

  final ShopFollowerAddedPayload _self;
  final $Res Function(ShopFollowerAddedPayload) _then;

/// Create a copy of ShopActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? shopId = null,Object? addedMethod = null,Object? initialStreak = null,}) {
  return _then(ShopFollowerAddedPayload(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,addedMethod: null == addedMethod ? _self.addedMethod : addedMethod // ignore: cast_nullable_to_non_nullable
as String,initialStreak: null == initialStreak ? _self.initialStreak : initialStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class UnknownShopPayload extends ShopActivityLogPayload {
  const UnknownShopPayload(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownShopPayload);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopActivityLogPayload.unknown()';
}


}




// dart format on
