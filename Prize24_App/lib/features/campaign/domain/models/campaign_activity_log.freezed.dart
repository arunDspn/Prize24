// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_activity_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampaignActivityLogPayload {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignActivityLogPayload);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CampaignActivityLogPayload()';
}


}

/// @nodoc
class $CampaignActivityLogPayloadCopyWith<$Res>  {
$CampaignActivityLogPayloadCopyWith(CampaignActivityLogPayload _, $Res Function(CampaignActivityLogPayload) __);
}


/// Adds pattern-matching-related methods to [CampaignActivityLogPayload].
extension CampaignActivityLogPayloadPatterns on CampaignActivityLogPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CampaignGiftAvailSuccessPayload value)?  giftAvailSuccess,TResult Function( CampaignGiftAvailFailedPayload value)?  giftAvailFailed,TResult Function( CampaignGiftRedemptionSuccessPayload value)?  giftRedemptionSuccess,TResult Function( CampaignGiftRedemptionFailedPayload value)?  giftRedemptionFailed,TResult Function( UnknownCampaignPayload value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CampaignGiftAvailSuccessPayload() when giftAvailSuccess != null:
return giftAvailSuccess(_that);case CampaignGiftAvailFailedPayload() when giftAvailFailed != null:
return giftAvailFailed(_that);case CampaignGiftRedemptionSuccessPayload() when giftRedemptionSuccess != null:
return giftRedemptionSuccess(_that);case CampaignGiftRedemptionFailedPayload() when giftRedemptionFailed != null:
return giftRedemptionFailed(_that);case UnknownCampaignPayload() when unknown != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CampaignGiftAvailSuccessPayload value)  giftAvailSuccess,required TResult Function( CampaignGiftAvailFailedPayload value)  giftAvailFailed,required TResult Function( CampaignGiftRedemptionSuccessPayload value)  giftRedemptionSuccess,required TResult Function( CampaignGiftRedemptionFailedPayload value)  giftRedemptionFailed,required TResult Function( UnknownCampaignPayload value)  unknown,}){
final _that = this;
switch (_that) {
case CampaignGiftAvailSuccessPayload():
return giftAvailSuccess(_that);case CampaignGiftAvailFailedPayload():
return giftAvailFailed(_that);case CampaignGiftRedemptionSuccessPayload():
return giftRedemptionSuccess(_that);case CampaignGiftRedemptionFailedPayload():
return giftRedemptionFailed(_that);case UnknownCampaignPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CampaignGiftAvailSuccessPayload value)?  giftAvailSuccess,TResult? Function( CampaignGiftAvailFailedPayload value)?  giftAvailFailed,TResult? Function( CampaignGiftRedemptionSuccessPayload value)?  giftRedemptionSuccess,TResult? Function( CampaignGiftRedemptionFailedPayload value)?  giftRedemptionFailed,TResult? Function( UnknownCampaignPayload value)?  unknown,}){
final _that = this;
switch (_that) {
case CampaignGiftAvailSuccessPayload() when giftAvailSuccess != null:
return giftAvailSuccess(_that);case CampaignGiftAvailFailedPayload() when giftAvailFailed != null:
return giftAvailFailed(_that);case CampaignGiftRedemptionSuccessPayload() when giftRedemptionSuccess != null:
return giftRedemptionSuccess(_that);case CampaignGiftRedemptionFailedPayload() when giftRedemptionFailed != null:
return giftRedemptionFailed(_that);case UnknownCampaignPayload() when unknown != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String customerId,  String giftId,  String giftName,  String redemptionId,  bool isRedeemable,  String? payloadId,  double luckFactor,  double randomNumber,  int remainingGifts,  int remainingParticipants,  bool availedViaStreak,  String? streakShopId)?  giftAvailSuccess,TResult Function( String customerId,  String? failureReason,  double? luckFactor,  double? randomNumber,  int? remainingGifts,  int? remainingParticipants,  bool availedViaStreak,  String? streakShopId)?  giftAvailFailed,TResult Function( String customerId,  String userGiftId,  String giftId,  String giftName,  String redemptionId,  String redemptionMethod,  String? shopId)?  giftRedemptionSuccess,TResult Function( String? customerId,  String? userGiftId,  String? giftId,  String? giftName,  String? redemptionId,  String? failureReason,  String redemptionMethod,  String? shopId)?  giftRedemptionFailed,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CampaignGiftAvailSuccessPayload() when giftAvailSuccess != null:
return giftAvailSuccess(_that.customerId,_that.giftId,_that.giftName,_that.redemptionId,_that.isRedeemable,_that.payloadId,_that.luckFactor,_that.randomNumber,_that.remainingGifts,_that.remainingParticipants,_that.availedViaStreak,_that.streakShopId);case CampaignGiftAvailFailedPayload() when giftAvailFailed != null:
return giftAvailFailed(_that.customerId,_that.failureReason,_that.luckFactor,_that.randomNumber,_that.remainingGifts,_that.remainingParticipants,_that.availedViaStreak,_that.streakShopId);case CampaignGiftRedemptionSuccessPayload() when giftRedemptionSuccess != null:
return giftRedemptionSuccess(_that.customerId,_that.userGiftId,_that.giftId,_that.giftName,_that.redemptionId,_that.redemptionMethod,_that.shopId);case CampaignGiftRedemptionFailedPayload() when giftRedemptionFailed != null:
return giftRedemptionFailed(_that.customerId,_that.userGiftId,_that.giftId,_that.giftName,_that.redemptionId,_that.failureReason,_that.redemptionMethod,_that.shopId);case UnknownCampaignPayload() when unknown != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String customerId,  String giftId,  String giftName,  String redemptionId,  bool isRedeemable,  String? payloadId,  double luckFactor,  double randomNumber,  int remainingGifts,  int remainingParticipants,  bool availedViaStreak,  String? streakShopId)  giftAvailSuccess,required TResult Function( String customerId,  String? failureReason,  double? luckFactor,  double? randomNumber,  int? remainingGifts,  int? remainingParticipants,  bool availedViaStreak,  String? streakShopId)  giftAvailFailed,required TResult Function( String customerId,  String userGiftId,  String giftId,  String giftName,  String redemptionId,  String redemptionMethod,  String? shopId)  giftRedemptionSuccess,required TResult Function( String? customerId,  String? userGiftId,  String? giftId,  String? giftName,  String? redemptionId,  String? failureReason,  String redemptionMethod,  String? shopId)  giftRedemptionFailed,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case CampaignGiftAvailSuccessPayload():
return giftAvailSuccess(_that.customerId,_that.giftId,_that.giftName,_that.redemptionId,_that.isRedeemable,_that.payloadId,_that.luckFactor,_that.randomNumber,_that.remainingGifts,_that.remainingParticipants,_that.availedViaStreak,_that.streakShopId);case CampaignGiftAvailFailedPayload():
return giftAvailFailed(_that.customerId,_that.failureReason,_that.luckFactor,_that.randomNumber,_that.remainingGifts,_that.remainingParticipants,_that.availedViaStreak,_that.streakShopId);case CampaignGiftRedemptionSuccessPayload():
return giftRedemptionSuccess(_that.customerId,_that.userGiftId,_that.giftId,_that.giftName,_that.redemptionId,_that.redemptionMethod,_that.shopId);case CampaignGiftRedemptionFailedPayload():
return giftRedemptionFailed(_that.customerId,_that.userGiftId,_that.giftId,_that.giftName,_that.redemptionId,_that.failureReason,_that.redemptionMethod,_that.shopId);case UnknownCampaignPayload():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String customerId,  String giftId,  String giftName,  String redemptionId,  bool isRedeemable,  String? payloadId,  double luckFactor,  double randomNumber,  int remainingGifts,  int remainingParticipants,  bool availedViaStreak,  String? streakShopId)?  giftAvailSuccess,TResult? Function( String customerId,  String? failureReason,  double? luckFactor,  double? randomNumber,  int? remainingGifts,  int? remainingParticipants,  bool availedViaStreak,  String? streakShopId)?  giftAvailFailed,TResult? Function( String customerId,  String userGiftId,  String giftId,  String giftName,  String redemptionId,  String redemptionMethod,  String? shopId)?  giftRedemptionSuccess,TResult? Function( String? customerId,  String? userGiftId,  String? giftId,  String? giftName,  String? redemptionId,  String? failureReason,  String redemptionMethod,  String? shopId)?  giftRedemptionFailed,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case CampaignGiftAvailSuccessPayload() when giftAvailSuccess != null:
return giftAvailSuccess(_that.customerId,_that.giftId,_that.giftName,_that.redemptionId,_that.isRedeemable,_that.payloadId,_that.luckFactor,_that.randomNumber,_that.remainingGifts,_that.remainingParticipants,_that.availedViaStreak,_that.streakShopId);case CampaignGiftAvailFailedPayload() when giftAvailFailed != null:
return giftAvailFailed(_that.customerId,_that.failureReason,_that.luckFactor,_that.randomNumber,_that.remainingGifts,_that.remainingParticipants,_that.availedViaStreak,_that.streakShopId);case CampaignGiftRedemptionSuccessPayload() when giftRedemptionSuccess != null:
return giftRedemptionSuccess(_that.customerId,_that.userGiftId,_that.giftId,_that.giftName,_that.redemptionId,_that.redemptionMethod,_that.shopId);case CampaignGiftRedemptionFailedPayload() when giftRedemptionFailed != null:
return giftRedemptionFailed(_that.customerId,_that.userGiftId,_that.giftId,_that.giftName,_that.redemptionId,_that.failureReason,_that.redemptionMethod,_that.shopId);case UnknownCampaignPayload() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc


class CampaignGiftAvailSuccessPayload extends CampaignActivityLogPayload {
  const CampaignGiftAvailSuccessPayload({required this.customerId, required this.giftId, required this.giftName, required this.redemptionId, required this.isRedeemable, this.payloadId, required this.luckFactor, required this.randomNumber, required this.remainingGifts, required this.remainingParticipants, required this.availedViaStreak, this.streakShopId}): super._();
  

 final  String customerId;
 final  String giftId;
 final  String giftName;
 final  String redemptionId;
 final  bool isRedeemable;
 final  String? payloadId;
 final  double luckFactor;
 final  double randomNumber;
 final  int remainingGifts;
 final  int remainingParticipants;
 final  bool availedViaStreak;
 final  String? streakShopId;

/// Create a copy of CampaignActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignGiftAvailSuccessPayloadCopyWith<CampaignGiftAvailSuccessPayload> get copyWith => _$CampaignGiftAvailSuccessPayloadCopyWithImpl<CampaignGiftAvailSuccessPayload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignGiftAvailSuccessPayload&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.redemptionId, redemptionId) || other.redemptionId == redemptionId)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.payloadId, payloadId) || other.payloadId == payloadId)&&(identical(other.luckFactor, luckFactor) || other.luckFactor == luckFactor)&&(identical(other.randomNumber, randomNumber) || other.randomNumber == randomNumber)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.remainingParticipants, remainingParticipants) || other.remainingParticipants == remainingParticipants)&&(identical(other.availedViaStreak, availedViaStreak) || other.availedViaStreak == availedViaStreak)&&(identical(other.streakShopId, streakShopId) || other.streakShopId == streakShopId));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,giftId,giftName,redemptionId,isRedeemable,payloadId,luckFactor,randomNumber,remainingGifts,remainingParticipants,availedViaStreak,streakShopId);

@override
String toString() {
  return 'CampaignActivityLogPayload.giftAvailSuccess(customerId: $customerId, giftId: $giftId, giftName: $giftName, redemptionId: $redemptionId, isRedeemable: $isRedeemable, payloadId: $payloadId, luckFactor: $luckFactor, randomNumber: $randomNumber, remainingGifts: $remainingGifts, remainingParticipants: $remainingParticipants, availedViaStreak: $availedViaStreak, streakShopId: $streakShopId)';
}


}

/// @nodoc
abstract mixin class $CampaignGiftAvailSuccessPayloadCopyWith<$Res> implements $CampaignActivityLogPayloadCopyWith<$Res> {
  factory $CampaignGiftAvailSuccessPayloadCopyWith(CampaignGiftAvailSuccessPayload value, $Res Function(CampaignGiftAvailSuccessPayload) _then) = _$CampaignGiftAvailSuccessPayloadCopyWithImpl;
@useResult
$Res call({
 String customerId, String giftId, String giftName, String redemptionId, bool isRedeemable, String? payloadId, double luckFactor, double randomNumber, int remainingGifts, int remainingParticipants, bool availedViaStreak, String? streakShopId
});




}
/// @nodoc
class _$CampaignGiftAvailSuccessPayloadCopyWithImpl<$Res>
    implements $CampaignGiftAvailSuccessPayloadCopyWith<$Res> {
  _$CampaignGiftAvailSuccessPayloadCopyWithImpl(this._self, this._then);

  final CampaignGiftAvailSuccessPayload _self;
  final $Res Function(CampaignGiftAvailSuccessPayload) _then;

/// Create a copy of CampaignActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? giftId = null,Object? giftName = null,Object? redemptionId = null,Object? isRedeemable = null,Object? payloadId = freezed,Object? luckFactor = null,Object? randomNumber = null,Object? remainingGifts = null,Object? remainingParticipants = null,Object? availedViaStreak = null,Object? streakShopId = freezed,}) {
  return _then(CampaignGiftAvailSuccessPayload(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,giftId: null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,redemptionId: null == redemptionId ? _self.redemptionId : redemptionId // ignore: cast_nullable_to_non_nullable
as String,isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,payloadId: freezed == payloadId ? _self.payloadId : payloadId // ignore: cast_nullable_to_non_nullable
as String?,luckFactor: null == luckFactor ? _self.luckFactor : luckFactor // ignore: cast_nullable_to_non_nullable
as double,randomNumber: null == randomNumber ? _self.randomNumber : randomNumber // ignore: cast_nullable_to_non_nullable
as double,remainingGifts: null == remainingGifts ? _self.remainingGifts : remainingGifts // ignore: cast_nullable_to_non_nullable
as int,remainingParticipants: null == remainingParticipants ? _self.remainingParticipants : remainingParticipants // ignore: cast_nullable_to_non_nullable
as int,availedViaStreak: null == availedViaStreak ? _self.availedViaStreak : availedViaStreak // ignore: cast_nullable_to_non_nullable
as bool,streakShopId: freezed == streakShopId ? _self.streakShopId : streakShopId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CampaignGiftAvailFailedPayload extends CampaignActivityLogPayload {
  const CampaignGiftAvailFailedPayload({required this.customerId, this.failureReason, this.luckFactor, this.randomNumber, this.remainingGifts, this.remainingParticipants, required this.availedViaStreak, this.streakShopId}): super._();
  

 final  String customerId;
 final  String? failureReason;
 final  double? luckFactor;
 final  double? randomNumber;
 final  int? remainingGifts;
 final  int? remainingParticipants;
 final  bool availedViaStreak;
 final  String? streakShopId;

/// Create a copy of CampaignActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignGiftAvailFailedPayloadCopyWith<CampaignGiftAvailFailedPayload> get copyWith => _$CampaignGiftAvailFailedPayloadCopyWithImpl<CampaignGiftAvailFailedPayload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignGiftAvailFailedPayload&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.luckFactor, luckFactor) || other.luckFactor == luckFactor)&&(identical(other.randomNumber, randomNumber) || other.randomNumber == randomNumber)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.remainingParticipants, remainingParticipants) || other.remainingParticipants == remainingParticipants)&&(identical(other.availedViaStreak, availedViaStreak) || other.availedViaStreak == availedViaStreak)&&(identical(other.streakShopId, streakShopId) || other.streakShopId == streakShopId));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,failureReason,luckFactor,randomNumber,remainingGifts,remainingParticipants,availedViaStreak,streakShopId);

@override
String toString() {
  return 'CampaignActivityLogPayload.giftAvailFailed(customerId: $customerId, failureReason: $failureReason, luckFactor: $luckFactor, randomNumber: $randomNumber, remainingGifts: $remainingGifts, remainingParticipants: $remainingParticipants, availedViaStreak: $availedViaStreak, streakShopId: $streakShopId)';
}


}

/// @nodoc
abstract mixin class $CampaignGiftAvailFailedPayloadCopyWith<$Res> implements $CampaignActivityLogPayloadCopyWith<$Res> {
  factory $CampaignGiftAvailFailedPayloadCopyWith(CampaignGiftAvailFailedPayload value, $Res Function(CampaignGiftAvailFailedPayload) _then) = _$CampaignGiftAvailFailedPayloadCopyWithImpl;
@useResult
$Res call({
 String customerId, String? failureReason, double? luckFactor, double? randomNumber, int? remainingGifts, int? remainingParticipants, bool availedViaStreak, String? streakShopId
});




}
/// @nodoc
class _$CampaignGiftAvailFailedPayloadCopyWithImpl<$Res>
    implements $CampaignGiftAvailFailedPayloadCopyWith<$Res> {
  _$CampaignGiftAvailFailedPayloadCopyWithImpl(this._self, this._then);

  final CampaignGiftAvailFailedPayload _self;
  final $Res Function(CampaignGiftAvailFailedPayload) _then;

/// Create a copy of CampaignActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? failureReason = freezed,Object? luckFactor = freezed,Object? randomNumber = freezed,Object? remainingGifts = freezed,Object? remainingParticipants = freezed,Object? availedViaStreak = null,Object? streakShopId = freezed,}) {
  return _then(CampaignGiftAvailFailedPayload(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,luckFactor: freezed == luckFactor ? _self.luckFactor : luckFactor // ignore: cast_nullable_to_non_nullable
as double?,randomNumber: freezed == randomNumber ? _self.randomNumber : randomNumber // ignore: cast_nullable_to_non_nullable
as double?,remainingGifts: freezed == remainingGifts ? _self.remainingGifts : remainingGifts // ignore: cast_nullable_to_non_nullable
as int?,remainingParticipants: freezed == remainingParticipants ? _self.remainingParticipants : remainingParticipants // ignore: cast_nullable_to_non_nullable
as int?,availedViaStreak: null == availedViaStreak ? _self.availedViaStreak : availedViaStreak // ignore: cast_nullable_to_non_nullable
as bool,streakShopId: freezed == streakShopId ? _self.streakShopId : streakShopId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CampaignGiftRedemptionSuccessPayload extends CampaignActivityLogPayload {
  const CampaignGiftRedemptionSuccessPayload({required this.customerId, required this.userGiftId, required this.giftId, required this.giftName, required this.redemptionId, required this.redemptionMethod, this.shopId}): super._();
  

 final  String customerId;
 final  String userGiftId;
 final  String giftId;
 final  String giftName;
 final  String redemptionId;
/// `owner_scan` | `shared_vendor_scan` | `staff_scan`
 final  String redemptionMethod;
 final  String? shopId;

/// Create a copy of CampaignActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignGiftRedemptionSuccessPayloadCopyWith<CampaignGiftRedemptionSuccessPayload> get copyWith => _$CampaignGiftRedemptionSuccessPayloadCopyWithImpl<CampaignGiftRedemptionSuccessPayload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignGiftRedemptionSuccessPayload&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.userGiftId, userGiftId) || other.userGiftId == userGiftId)&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.redemptionId, redemptionId) || other.redemptionId == redemptionId)&&(identical(other.redemptionMethod, redemptionMethod) || other.redemptionMethod == redemptionMethod)&&(identical(other.shopId, shopId) || other.shopId == shopId));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,userGiftId,giftId,giftName,redemptionId,redemptionMethod,shopId);

@override
String toString() {
  return 'CampaignActivityLogPayload.giftRedemptionSuccess(customerId: $customerId, userGiftId: $userGiftId, giftId: $giftId, giftName: $giftName, redemptionId: $redemptionId, redemptionMethod: $redemptionMethod, shopId: $shopId)';
}


}

/// @nodoc
abstract mixin class $CampaignGiftRedemptionSuccessPayloadCopyWith<$Res> implements $CampaignActivityLogPayloadCopyWith<$Res> {
  factory $CampaignGiftRedemptionSuccessPayloadCopyWith(CampaignGiftRedemptionSuccessPayload value, $Res Function(CampaignGiftRedemptionSuccessPayload) _then) = _$CampaignGiftRedemptionSuccessPayloadCopyWithImpl;
@useResult
$Res call({
 String customerId, String userGiftId, String giftId, String giftName, String redemptionId, String redemptionMethod, String? shopId
});




}
/// @nodoc
class _$CampaignGiftRedemptionSuccessPayloadCopyWithImpl<$Res>
    implements $CampaignGiftRedemptionSuccessPayloadCopyWith<$Res> {
  _$CampaignGiftRedemptionSuccessPayloadCopyWithImpl(this._self, this._then);

  final CampaignGiftRedemptionSuccessPayload _self;
  final $Res Function(CampaignGiftRedemptionSuccessPayload) _then;

/// Create a copy of CampaignActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? userGiftId = null,Object? giftId = null,Object? giftName = null,Object? redemptionId = null,Object? redemptionMethod = null,Object? shopId = freezed,}) {
  return _then(CampaignGiftRedemptionSuccessPayload(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,userGiftId: null == userGiftId ? _self.userGiftId : userGiftId // ignore: cast_nullable_to_non_nullable
as String,giftId: null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,redemptionId: null == redemptionId ? _self.redemptionId : redemptionId // ignore: cast_nullable_to_non_nullable
as String,redemptionMethod: null == redemptionMethod ? _self.redemptionMethod : redemptionMethod // ignore: cast_nullable_to_non_nullable
as String,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CampaignGiftRedemptionFailedPayload extends CampaignActivityLogPayload {
  const CampaignGiftRedemptionFailedPayload({this.customerId, this.userGiftId, this.giftId, this.giftName, this.redemptionId, this.failureReason, required this.redemptionMethod, this.shopId}): super._();
  

 final  String? customerId;
 final  String? userGiftId;
 final  String? giftId;
 final  String? giftName;
 final  String? redemptionId;
 final  String? failureReason;
/// `owner_scan` | `shared_vendor_scan` | `staff_scan`
 final  String redemptionMethod;
 final  String? shopId;

/// Create a copy of CampaignActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignGiftRedemptionFailedPayloadCopyWith<CampaignGiftRedemptionFailedPayload> get copyWith => _$CampaignGiftRedemptionFailedPayloadCopyWithImpl<CampaignGiftRedemptionFailedPayload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignGiftRedemptionFailedPayload&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.userGiftId, userGiftId) || other.userGiftId == userGiftId)&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.redemptionId, redemptionId) || other.redemptionId == redemptionId)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.redemptionMethod, redemptionMethod) || other.redemptionMethod == redemptionMethod)&&(identical(other.shopId, shopId) || other.shopId == shopId));
}


@override
int get hashCode => Object.hash(runtimeType,customerId,userGiftId,giftId,giftName,redemptionId,failureReason,redemptionMethod,shopId);

@override
String toString() {
  return 'CampaignActivityLogPayload.giftRedemptionFailed(customerId: $customerId, userGiftId: $userGiftId, giftId: $giftId, giftName: $giftName, redemptionId: $redemptionId, failureReason: $failureReason, redemptionMethod: $redemptionMethod, shopId: $shopId)';
}


}

/// @nodoc
abstract mixin class $CampaignGiftRedemptionFailedPayloadCopyWith<$Res> implements $CampaignActivityLogPayloadCopyWith<$Res> {
  factory $CampaignGiftRedemptionFailedPayloadCopyWith(CampaignGiftRedemptionFailedPayload value, $Res Function(CampaignGiftRedemptionFailedPayload) _then) = _$CampaignGiftRedemptionFailedPayloadCopyWithImpl;
@useResult
$Res call({
 String? customerId, String? userGiftId, String? giftId, String? giftName, String? redemptionId, String? failureReason, String redemptionMethod, String? shopId
});




}
/// @nodoc
class _$CampaignGiftRedemptionFailedPayloadCopyWithImpl<$Res>
    implements $CampaignGiftRedemptionFailedPayloadCopyWith<$Res> {
  _$CampaignGiftRedemptionFailedPayloadCopyWithImpl(this._self, this._then);

  final CampaignGiftRedemptionFailedPayload _self;
  final $Res Function(CampaignGiftRedemptionFailedPayload) _then;

/// Create a copy of CampaignActivityLogPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerId = freezed,Object? userGiftId = freezed,Object? giftId = freezed,Object? giftName = freezed,Object? redemptionId = freezed,Object? failureReason = freezed,Object? redemptionMethod = null,Object? shopId = freezed,}) {
  return _then(CampaignGiftRedemptionFailedPayload(
customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,userGiftId: freezed == userGiftId ? _self.userGiftId : userGiftId // ignore: cast_nullable_to_non_nullable
as String?,giftId: freezed == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String?,giftName: freezed == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String?,redemptionId: freezed == redemptionId ? _self.redemptionId : redemptionId // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,redemptionMethod: null == redemptionMethod ? _self.redemptionMethod : redemptionMethod // ignore: cast_nullable_to_non_nullable
as String,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UnknownCampaignPayload extends CampaignActivityLogPayload {
  const UnknownCampaignPayload(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownCampaignPayload);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CampaignActivityLogPayload.unknown()';
}


}




// dart format on
