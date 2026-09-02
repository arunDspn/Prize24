// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_following_shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserFollowingShopModel {

 String get shopId; String get shopName; String get shopAddress; String get shopPhoneNumber; bool get notificationEnabled; int get consecutiveDays; int get cumulativeStreak; DateTime get followedAt; int get giftCycleDays; bool get isGiftAvailable; DateTime? get lastCheckInDate;
/// Create a copy of UserFollowingShopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFollowingShopModelCopyWith<UserFollowingShopModel> get copyWith => _$UserFollowingShopModelCopyWithImpl<UserFollowingShopModel>(this as UserFollowingShopModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFollowingShopModel&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopPhoneNumber, shopPhoneNumber) || other.shopPhoneNumber == shopPhoneNumber)&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.giftCycleDays, giftCycleDays) || other.giftCycleDays == giftCycleDays)&&(identical(other.isGiftAvailable, isGiftAvailable) || other.isGiftAvailable == isGiftAvailable)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,shopAddress,shopPhoneNumber,notificationEnabled,consecutiveDays,cumulativeStreak,followedAt,giftCycleDays,isGiftAvailable,lastCheckInDate);

@override
String toString() {
  return 'UserFollowingShopModel(shopId: $shopId, shopName: $shopName, shopAddress: $shopAddress, shopPhoneNumber: $shopPhoneNumber, notificationEnabled: $notificationEnabled, consecutiveDays: $consecutiveDays, cumulativeStreak: $cumulativeStreak, followedAt: $followedAt, giftCycleDays: $giftCycleDays, isGiftAvailable: $isGiftAvailable, lastCheckInDate: $lastCheckInDate)';
}


}

/// @nodoc
abstract mixin class $UserFollowingShopModelCopyWith<$Res>  {
  factory $UserFollowingShopModelCopyWith(UserFollowingShopModel value, $Res Function(UserFollowingShopModel) _then) = _$UserFollowingShopModelCopyWithImpl;
@useResult
$Res call({
 String shopId, String shopName, String shopAddress, String shopPhoneNumber, bool notificationEnabled, int consecutiveDays, int cumulativeStreak, DateTime followedAt, int giftCycleDays, bool isGiftAvailable, DateTime? lastCheckInDate
});




}
/// @nodoc
class _$UserFollowingShopModelCopyWithImpl<$Res>
    implements $UserFollowingShopModelCopyWith<$Res> {
  _$UserFollowingShopModelCopyWithImpl(this._self, this._then);

  final UserFollowingShopModel _self;
  final $Res Function(UserFollowingShopModel) _then;

/// Create a copy of UserFollowingShopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? shopName = null,Object? shopAddress = null,Object? shopPhoneNumber = null,Object? notificationEnabled = null,Object? consecutiveDays = null,Object? cumulativeStreak = null,Object? followedAt = null,Object? giftCycleDays = null,Object? isGiftAvailable = null,Object? lastCheckInDate = freezed,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopPhoneNumber: null == shopPhoneNumber ? _self.shopPhoneNumber : shopPhoneNumber // ignore: cast_nullable_to_non_nullable
as String,notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,followedAt: null == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as DateTime,giftCycleDays: null == giftCycleDays ? _self.giftCycleDays : giftCycleDays // ignore: cast_nullable_to_non_nullable
as int,isGiftAvailable: null == isGiftAvailable ? _self.isGiftAvailable : isGiftAvailable // ignore: cast_nullable_to_non_nullable
as bool,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserFollowingShopModel].
extension UserFollowingShopModelPatterns on UserFollowingShopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFollowingShopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFollowingShopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFollowingShopModel value)  $default,){
final _that = this;
switch (_that) {
case _UserFollowingShopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFollowingShopModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserFollowingShopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  String shopName,  String shopAddress,  String shopPhoneNumber,  bool notificationEnabled,  int consecutiveDays,  int cumulativeStreak,  DateTime followedAt,  int giftCycleDays,  bool isGiftAvailable,  DateTime? lastCheckInDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFollowingShopModel() when $default != null:
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.shopPhoneNumber,_that.notificationEnabled,_that.consecutiveDays,_that.cumulativeStreak,_that.followedAt,_that.giftCycleDays,_that.isGiftAvailable,_that.lastCheckInDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  String shopName,  String shopAddress,  String shopPhoneNumber,  bool notificationEnabled,  int consecutiveDays,  int cumulativeStreak,  DateTime followedAt,  int giftCycleDays,  bool isGiftAvailable,  DateTime? lastCheckInDate)  $default,) {final _that = this;
switch (_that) {
case _UserFollowingShopModel():
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.shopPhoneNumber,_that.notificationEnabled,_that.consecutiveDays,_that.cumulativeStreak,_that.followedAt,_that.giftCycleDays,_that.isGiftAvailable,_that.lastCheckInDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  String shopName,  String shopAddress,  String shopPhoneNumber,  bool notificationEnabled,  int consecutiveDays,  int cumulativeStreak,  DateTime followedAt,  int giftCycleDays,  bool isGiftAvailable,  DateTime? lastCheckInDate)?  $default,) {final _that = this;
switch (_that) {
case _UserFollowingShopModel() when $default != null:
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.shopPhoneNumber,_that.notificationEnabled,_that.consecutiveDays,_that.cumulativeStreak,_that.followedAt,_that.giftCycleDays,_that.isGiftAvailable,_that.lastCheckInDate);case _:
  return null;

}
}

}

/// @nodoc


class _UserFollowingShopModel implements UserFollowingShopModel {
  const _UserFollowingShopModel({required this.shopId, required this.shopName, required this.shopAddress, required this.shopPhoneNumber, required this.notificationEnabled, required this.consecutiveDays, required this.cumulativeStreak, required this.followedAt, required this.giftCycleDays, required this.isGiftAvailable, this.lastCheckInDate});
  

@override final  String shopId;
@override final  String shopName;
@override final  String shopAddress;
@override final  String shopPhoneNumber;
@override final  bool notificationEnabled;
@override final  int consecutiveDays;
@override final  int cumulativeStreak;
@override final  DateTime followedAt;
@override final  int giftCycleDays;
@override final  bool isGiftAvailable;
@override final  DateTime? lastCheckInDate;

/// Create a copy of UserFollowingShopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFollowingShopModelCopyWith<_UserFollowingShopModel> get copyWith => __$UserFollowingShopModelCopyWithImpl<_UserFollowingShopModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFollowingShopModel&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopPhoneNumber, shopPhoneNumber) || other.shopPhoneNumber == shopPhoneNumber)&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.giftCycleDays, giftCycleDays) || other.giftCycleDays == giftCycleDays)&&(identical(other.isGiftAvailable, isGiftAvailable) || other.isGiftAvailable == isGiftAvailable)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,shopAddress,shopPhoneNumber,notificationEnabled,consecutiveDays,cumulativeStreak,followedAt,giftCycleDays,isGiftAvailable,lastCheckInDate);

@override
String toString() {
  return 'UserFollowingShopModel(shopId: $shopId, shopName: $shopName, shopAddress: $shopAddress, shopPhoneNumber: $shopPhoneNumber, notificationEnabled: $notificationEnabled, consecutiveDays: $consecutiveDays, cumulativeStreak: $cumulativeStreak, followedAt: $followedAt, giftCycleDays: $giftCycleDays, isGiftAvailable: $isGiftAvailable, lastCheckInDate: $lastCheckInDate)';
}


}

/// @nodoc
abstract mixin class _$UserFollowingShopModelCopyWith<$Res> implements $UserFollowingShopModelCopyWith<$Res> {
  factory _$UserFollowingShopModelCopyWith(_UserFollowingShopModel value, $Res Function(_UserFollowingShopModel) _then) = __$UserFollowingShopModelCopyWithImpl;
@override @useResult
$Res call({
 String shopId, String shopName, String shopAddress, String shopPhoneNumber, bool notificationEnabled, int consecutiveDays, int cumulativeStreak, DateTime followedAt, int giftCycleDays, bool isGiftAvailable, DateTime? lastCheckInDate
});




}
/// @nodoc
class __$UserFollowingShopModelCopyWithImpl<$Res>
    implements _$UserFollowingShopModelCopyWith<$Res> {
  __$UserFollowingShopModelCopyWithImpl(this._self, this._then);

  final _UserFollowingShopModel _self;
  final $Res Function(_UserFollowingShopModel) _then;

/// Create a copy of UserFollowingShopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? shopName = null,Object? shopAddress = null,Object? shopPhoneNumber = null,Object? notificationEnabled = null,Object? consecutiveDays = null,Object? cumulativeStreak = null,Object? followedAt = null,Object? giftCycleDays = null,Object? isGiftAvailable = null,Object? lastCheckInDate = freezed,}) {
  return _then(_UserFollowingShopModel(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopPhoneNumber: null == shopPhoneNumber ? _self.shopPhoneNumber : shopPhoneNumber // ignore: cast_nullable_to_non_nullable
as String,notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,followedAt: null == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as DateTime,giftCycleDays: null == giftCycleDays ? _self.giftCycleDays : giftCycleDays // ignore: cast_nullable_to_non_nullable
as int,isGiftAvailable: null == isGiftAvailable ? _self.isGiftAvailable : isGiftAvailable // ignore: cast_nullable_to_non_nullable
as bool,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
