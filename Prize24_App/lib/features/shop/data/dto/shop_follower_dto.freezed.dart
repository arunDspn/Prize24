// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_follower_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopFollowerDto {

 String get userId; String get userName; int get cumulativeStreak;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get followedAt; String? get userPhoneNumber;@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? get lastCheckInDate; int? get lastGiftDayStreak; String? get userProfilePic;
/// Create a copy of ShopFollowerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopFollowerDtoCopyWith<ShopFollowerDto> get copyWith => _$ShopFollowerDtoCopyWithImpl<ShopFollowerDto>(this as ShopFollowerDto, _$identity);

  /// Serializes this ShopFollowerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopFollowerDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.userPhoneNumber, userPhoneNumber) || other.userPhoneNumber == userPhoneNumber)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastGiftDayStreak, lastGiftDayStreak) || other.lastGiftDayStreak == lastGiftDayStreak)&&(identical(other.userProfilePic, userProfilePic) || other.userProfilePic == userProfilePic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,cumulativeStreak,followedAt,userPhoneNumber,lastCheckInDate,lastGiftDayStreak,userProfilePic);

@override
String toString() {
  return 'ShopFollowerDto(userId: $userId, userName: $userName, cumulativeStreak: $cumulativeStreak, followedAt: $followedAt, userPhoneNumber: $userPhoneNumber, lastCheckInDate: $lastCheckInDate, lastGiftDayStreak: $lastGiftDayStreak, userProfilePic: $userProfilePic)';
}


}

/// @nodoc
abstract mixin class $ShopFollowerDtoCopyWith<$Res>  {
  factory $ShopFollowerDtoCopyWith(ShopFollowerDto value, $Res Function(ShopFollowerDto) _then) = _$ShopFollowerDtoCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, int cumulativeStreak,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp followedAt, String? userPhoneNumber,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastCheckInDate, int? lastGiftDayStreak, String? userProfilePic
});




}
/// @nodoc
class _$ShopFollowerDtoCopyWithImpl<$Res>
    implements $ShopFollowerDtoCopyWith<$Res> {
  _$ShopFollowerDtoCopyWithImpl(this._self, this._then);

  final ShopFollowerDto _self;
  final $Res Function(ShopFollowerDto) _then;

/// Create a copy of ShopFollowerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? cumulativeStreak = null,Object? followedAt = null,Object? userPhoneNumber = freezed,Object? lastCheckInDate = freezed,Object? lastGiftDayStreak = freezed,Object? userProfilePic = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,followedAt: null == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,userPhoneNumber: freezed == userPhoneNumber ? _self.userPhoneNumber : userPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,lastGiftDayStreak: freezed == lastGiftDayStreak ? _self.lastGiftDayStreak : lastGiftDayStreak // ignore: cast_nullable_to_non_nullable
as int?,userProfilePic: freezed == userProfilePic ? _self.userProfilePic : userProfilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopFollowerDto].
extension ShopFollowerDtoPatterns on ShopFollowerDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopFollowerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopFollowerDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopFollowerDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopFollowerDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopFollowerDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopFollowerDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  int cumulativeStreak, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp followedAt,  String? userPhoneNumber, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate,  int? lastGiftDayStreak,  String? userProfilePic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopFollowerDto() when $default != null:
return $default(_that.userId,_that.userName,_that.cumulativeStreak,_that.followedAt,_that.userPhoneNumber,_that.lastCheckInDate,_that.lastGiftDayStreak,_that.userProfilePic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  int cumulativeStreak, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp followedAt,  String? userPhoneNumber, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate,  int? lastGiftDayStreak,  String? userProfilePic)  $default,) {final _that = this;
switch (_that) {
case _ShopFollowerDto():
return $default(_that.userId,_that.userName,_that.cumulativeStreak,_that.followedAt,_that.userPhoneNumber,_that.lastCheckInDate,_that.lastGiftDayStreak,_that.userProfilePic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  int cumulativeStreak, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp followedAt,  String? userPhoneNumber, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate,  int? lastGiftDayStreak,  String? userProfilePic)?  $default,) {final _that = this;
switch (_that) {
case _ShopFollowerDto() when $default != null:
return $default(_that.userId,_that.userName,_that.cumulativeStreak,_that.followedAt,_that.userPhoneNumber,_that.lastCheckInDate,_that.lastGiftDayStreak,_that.userProfilePic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopFollowerDto extends ShopFollowerDto {
  const _ShopFollowerDto({required this.userId, required this.userName, required this.cumulativeStreak, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.followedAt, this.userPhoneNumber, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) this.lastCheckInDate, this.lastGiftDayStreak, this.userProfilePic}): super._();
  factory _ShopFollowerDto.fromJson(Map<String, dynamic> json) => _$ShopFollowerDtoFromJson(json);

@override final  String userId;
@override final  String userName;
@override final  int cumulativeStreak;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp followedAt;
@override final  String? userPhoneNumber;
@override@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) final  Timestamp? lastCheckInDate;
@override final  int? lastGiftDayStreak;
@override final  String? userProfilePic;

/// Create a copy of ShopFollowerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopFollowerDtoCopyWith<_ShopFollowerDto> get copyWith => __$ShopFollowerDtoCopyWithImpl<_ShopFollowerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopFollowerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopFollowerDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.userPhoneNumber, userPhoneNumber) || other.userPhoneNumber == userPhoneNumber)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastGiftDayStreak, lastGiftDayStreak) || other.lastGiftDayStreak == lastGiftDayStreak)&&(identical(other.userProfilePic, userProfilePic) || other.userProfilePic == userProfilePic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,cumulativeStreak,followedAt,userPhoneNumber,lastCheckInDate,lastGiftDayStreak,userProfilePic);

@override
String toString() {
  return 'ShopFollowerDto(userId: $userId, userName: $userName, cumulativeStreak: $cumulativeStreak, followedAt: $followedAt, userPhoneNumber: $userPhoneNumber, lastCheckInDate: $lastCheckInDate, lastGiftDayStreak: $lastGiftDayStreak, userProfilePic: $userProfilePic)';
}


}

/// @nodoc
abstract mixin class _$ShopFollowerDtoCopyWith<$Res> implements $ShopFollowerDtoCopyWith<$Res> {
  factory _$ShopFollowerDtoCopyWith(_ShopFollowerDto value, $Res Function(_ShopFollowerDto) _then) = __$ShopFollowerDtoCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, int cumulativeStreak,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp followedAt, String? userPhoneNumber,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastCheckInDate, int? lastGiftDayStreak, String? userProfilePic
});




}
/// @nodoc
class __$ShopFollowerDtoCopyWithImpl<$Res>
    implements _$ShopFollowerDtoCopyWith<$Res> {
  __$ShopFollowerDtoCopyWithImpl(this._self, this._then);

  final _ShopFollowerDto _self;
  final $Res Function(_ShopFollowerDto) _then;

/// Create a copy of ShopFollowerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? cumulativeStreak = null,Object? followedAt = null,Object? userPhoneNumber = freezed,Object? lastCheckInDate = freezed,Object? lastGiftDayStreak = freezed,Object? userProfilePic = freezed,}) {
  return _then(_ShopFollowerDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,followedAt: null == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,userPhoneNumber: freezed == userPhoneNumber ? _self.userPhoneNumber : userPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,lastGiftDayStreak: freezed == lastGiftDayStreak ? _self.lastGiftDayStreak : lastGiftDayStreak // ignore: cast_nullable_to_non_nullable
as int?,userProfilePic: freezed == userProfilePic ? _self.userProfilePic : userProfilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
