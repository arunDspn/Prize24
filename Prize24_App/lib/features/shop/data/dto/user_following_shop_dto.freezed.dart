// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_following_shop_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserFollowingShopDto {

 String get shopId; String get shopName; String get shopAddress;@JsonKey(name: 'shopPhone') String get shopPhoneNumber; bool get notificationEnabled; int get consecutiveDays; int get cumulativeStreak; bool get isGiftAvailable;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get followedAt; int? get giftCycleDays;@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? get lastCheckInDate;
/// Create a copy of UserFollowingShopDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFollowingShopDtoCopyWith<UserFollowingShopDto> get copyWith => _$UserFollowingShopDtoCopyWithImpl<UserFollowingShopDto>(this as UserFollowingShopDto, _$identity);

  /// Serializes this UserFollowingShopDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFollowingShopDto&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopPhoneNumber, shopPhoneNumber) || other.shopPhoneNumber == shopPhoneNumber)&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.isGiftAvailable, isGiftAvailable) || other.isGiftAvailable == isGiftAvailable)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.giftCycleDays, giftCycleDays) || other.giftCycleDays == giftCycleDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,shopAddress,shopPhoneNumber,notificationEnabled,consecutiveDays,cumulativeStreak,isGiftAvailable,followedAt,giftCycleDays,lastCheckInDate);

@override
String toString() {
  return 'UserFollowingShopDto(shopId: $shopId, shopName: $shopName, shopAddress: $shopAddress, shopPhoneNumber: $shopPhoneNumber, notificationEnabled: $notificationEnabled, consecutiveDays: $consecutiveDays, cumulativeStreak: $cumulativeStreak, isGiftAvailable: $isGiftAvailable, followedAt: $followedAt, giftCycleDays: $giftCycleDays, lastCheckInDate: $lastCheckInDate)';
}


}

/// @nodoc
abstract mixin class $UserFollowingShopDtoCopyWith<$Res>  {
  factory $UserFollowingShopDtoCopyWith(UserFollowingShopDto value, $Res Function(UserFollowingShopDto) _then) = _$UserFollowingShopDtoCopyWithImpl;
@useResult
$Res call({
 String shopId, String shopName, String shopAddress,@JsonKey(name: 'shopPhone') String shopPhoneNumber, bool notificationEnabled, int consecutiveDays, int cumulativeStreak, bool isGiftAvailable,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp followedAt, int? giftCycleDays,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastCheckInDate
});




}
/// @nodoc
class _$UserFollowingShopDtoCopyWithImpl<$Res>
    implements $UserFollowingShopDtoCopyWith<$Res> {
  _$UserFollowingShopDtoCopyWithImpl(this._self, this._then);

  final UserFollowingShopDto _self;
  final $Res Function(UserFollowingShopDto) _then;

/// Create a copy of UserFollowingShopDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? shopName = null,Object? shopAddress = null,Object? shopPhoneNumber = null,Object? notificationEnabled = null,Object? consecutiveDays = null,Object? cumulativeStreak = null,Object? isGiftAvailable = null,Object? followedAt = null,Object? giftCycleDays = freezed,Object? lastCheckInDate = freezed,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopPhoneNumber: null == shopPhoneNumber ? _self.shopPhoneNumber : shopPhoneNumber // ignore: cast_nullable_to_non_nullable
as String,notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,isGiftAvailable: null == isGiftAvailable ? _self.isGiftAvailable : isGiftAvailable // ignore: cast_nullable_to_non_nullable
as bool,followedAt: null == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,giftCycleDays: freezed == giftCycleDays ? _self.giftCycleDays : giftCycleDays // ignore: cast_nullable_to_non_nullable
as int?,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserFollowingShopDto].
extension UserFollowingShopDtoPatterns on UserFollowingShopDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFollowingShopDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFollowingShopDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFollowingShopDto value)  $default,){
final _that = this;
switch (_that) {
case _UserFollowingShopDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFollowingShopDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserFollowingShopDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  String shopName,  String shopAddress, @JsonKey(name: 'shopPhone')  String shopPhoneNumber,  bool notificationEnabled,  int consecutiveDays,  int cumulativeStreak,  bool isGiftAvailable, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp followedAt,  int? giftCycleDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFollowingShopDto() when $default != null:
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.shopPhoneNumber,_that.notificationEnabled,_that.consecutiveDays,_that.cumulativeStreak,_that.isGiftAvailable,_that.followedAt,_that.giftCycleDays,_that.lastCheckInDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  String shopName,  String shopAddress, @JsonKey(name: 'shopPhone')  String shopPhoneNumber,  bool notificationEnabled,  int consecutiveDays,  int cumulativeStreak,  bool isGiftAvailable, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp followedAt,  int? giftCycleDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate)  $default,) {final _that = this;
switch (_that) {
case _UserFollowingShopDto():
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.shopPhoneNumber,_that.notificationEnabled,_that.consecutiveDays,_that.cumulativeStreak,_that.isGiftAvailable,_that.followedAt,_that.giftCycleDays,_that.lastCheckInDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  String shopName,  String shopAddress, @JsonKey(name: 'shopPhone')  String shopPhoneNumber,  bool notificationEnabled,  int consecutiveDays,  int cumulativeStreak,  bool isGiftAvailable, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp followedAt,  int? giftCycleDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate)?  $default,) {final _that = this;
switch (_that) {
case _UserFollowingShopDto() when $default != null:
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.shopPhoneNumber,_that.notificationEnabled,_that.consecutiveDays,_that.cumulativeStreak,_that.isGiftAvailable,_that.followedAt,_that.giftCycleDays,_that.lastCheckInDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserFollowingShopDto extends UserFollowingShopDto {
  const _UserFollowingShopDto({required this.shopId, required this.shopName, required this.shopAddress, @JsonKey(name: 'shopPhone') required this.shopPhoneNumber, required this.notificationEnabled, required this.consecutiveDays, required this.cumulativeStreak, this.isGiftAvailable = false, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.followedAt, this.giftCycleDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) this.lastCheckInDate}): super._();
  factory _UserFollowingShopDto.fromJson(Map<String, dynamic> json) => _$UserFollowingShopDtoFromJson(json);

@override final  String shopId;
@override final  String shopName;
@override final  String shopAddress;
@override@JsonKey(name: 'shopPhone') final  String shopPhoneNumber;
@override final  bool notificationEnabled;
@override final  int consecutiveDays;
@override final  int cumulativeStreak;
@override@JsonKey() final  bool isGiftAvailable;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp followedAt;
@override final  int? giftCycleDays;
@override@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) final  Timestamp? lastCheckInDate;

/// Create a copy of UserFollowingShopDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFollowingShopDtoCopyWith<_UserFollowingShopDto> get copyWith => __$UserFollowingShopDtoCopyWithImpl<_UserFollowingShopDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserFollowingShopDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFollowingShopDto&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopPhoneNumber, shopPhoneNumber) || other.shopPhoneNumber == shopPhoneNumber)&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.isGiftAvailable, isGiftAvailable) || other.isGiftAvailable == isGiftAvailable)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.giftCycleDays, giftCycleDays) || other.giftCycleDays == giftCycleDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,shopAddress,shopPhoneNumber,notificationEnabled,consecutiveDays,cumulativeStreak,isGiftAvailable,followedAt,giftCycleDays,lastCheckInDate);

@override
String toString() {
  return 'UserFollowingShopDto(shopId: $shopId, shopName: $shopName, shopAddress: $shopAddress, shopPhoneNumber: $shopPhoneNumber, notificationEnabled: $notificationEnabled, consecutiveDays: $consecutiveDays, cumulativeStreak: $cumulativeStreak, isGiftAvailable: $isGiftAvailable, followedAt: $followedAt, giftCycleDays: $giftCycleDays, lastCheckInDate: $lastCheckInDate)';
}


}

/// @nodoc
abstract mixin class _$UserFollowingShopDtoCopyWith<$Res> implements $UserFollowingShopDtoCopyWith<$Res> {
  factory _$UserFollowingShopDtoCopyWith(_UserFollowingShopDto value, $Res Function(_UserFollowingShopDto) _then) = __$UserFollowingShopDtoCopyWithImpl;
@override @useResult
$Res call({
 String shopId, String shopName, String shopAddress,@JsonKey(name: 'shopPhone') String shopPhoneNumber, bool notificationEnabled, int consecutiveDays, int cumulativeStreak, bool isGiftAvailable,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp followedAt, int? giftCycleDays,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastCheckInDate
});




}
/// @nodoc
class __$UserFollowingShopDtoCopyWithImpl<$Res>
    implements _$UserFollowingShopDtoCopyWith<$Res> {
  __$UserFollowingShopDtoCopyWithImpl(this._self, this._then);

  final _UserFollowingShopDto _self;
  final $Res Function(_UserFollowingShopDto) _then;

/// Create a copy of UserFollowingShopDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? shopName = null,Object? shopAddress = null,Object? shopPhoneNumber = null,Object? notificationEnabled = null,Object? consecutiveDays = null,Object? cumulativeStreak = null,Object? isGiftAvailable = null,Object? followedAt = null,Object? giftCycleDays = freezed,Object? lastCheckInDate = freezed,}) {
  return _then(_UserFollowingShopDto(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopPhoneNumber: null == shopPhoneNumber ? _self.shopPhoneNumber : shopPhoneNumber // ignore: cast_nullable_to_non_nullable
as String,notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,isGiftAvailable: null == isGiftAvailable ? _self.isGiftAvailable : isGiftAvailable // ignore: cast_nullable_to_non_nullable
as bool,followedAt: null == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,giftCycleDays: freezed == giftCycleDays ? _self.giftCycleDays : giftCycleDays // ignore: cast_nullable_to_non_nullable
as int?,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,
  ));
}


}

// dart format on
