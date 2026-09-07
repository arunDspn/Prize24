// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_follower_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopFollowerModel {

 String get userId; String get userName; int get cumulativeStreak; DateTime get followedAt; String? get userPhoneNumber; DateTime? get lastCheckInDate; int? get lastGiftDayStreak; String? get userProfilePic;
/// Create a copy of ShopFollowerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopFollowerModelCopyWith<ShopFollowerModel> get copyWith => _$ShopFollowerModelCopyWithImpl<ShopFollowerModel>(this as ShopFollowerModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopFollowerModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.userPhoneNumber, userPhoneNumber) || other.userPhoneNumber == userPhoneNumber)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastGiftDayStreak, lastGiftDayStreak) || other.lastGiftDayStreak == lastGiftDayStreak)&&(identical(other.userProfilePic, userProfilePic) || other.userProfilePic == userProfilePic));
}


@override
int get hashCode => Object.hash(runtimeType,userId,userName,cumulativeStreak,followedAt,userPhoneNumber,lastCheckInDate,lastGiftDayStreak,userProfilePic);

@override
String toString() {
  return 'ShopFollowerModel(userId: $userId, userName: $userName, cumulativeStreak: $cumulativeStreak, followedAt: $followedAt, userPhoneNumber: $userPhoneNumber, lastCheckInDate: $lastCheckInDate, lastGiftDayStreak: $lastGiftDayStreak, userProfilePic: $userProfilePic)';
}


}

/// @nodoc
abstract mixin class $ShopFollowerModelCopyWith<$Res>  {
  factory $ShopFollowerModelCopyWith(ShopFollowerModel value, $Res Function(ShopFollowerModel) _then) = _$ShopFollowerModelCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, int cumulativeStreak, DateTime followedAt, String? userPhoneNumber, DateTime? lastCheckInDate, int? lastGiftDayStreak, String? userProfilePic
});




}
/// @nodoc
class _$ShopFollowerModelCopyWithImpl<$Res>
    implements $ShopFollowerModelCopyWith<$Res> {
  _$ShopFollowerModelCopyWithImpl(this._self, this._then);

  final ShopFollowerModel _self;
  final $Res Function(ShopFollowerModel) _then;

/// Create a copy of ShopFollowerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? cumulativeStreak = null,Object? followedAt = null,Object? userPhoneNumber = freezed,Object? lastCheckInDate = freezed,Object? lastGiftDayStreak = freezed,Object? userProfilePic = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,followedAt: null == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userPhoneNumber: freezed == userPhoneNumber ? _self.userPhoneNumber : userPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastGiftDayStreak: freezed == lastGiftDayStreak ? _self.lastGiftDayStreak : lastGiftDayStreak // ignore: cast_nullable_to_non_nullable
as int?,userProfilePic: freezed == userProfilePic ? _self.userProfilePic : userProfilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopFollowerModel].
extension ShopFollowerModelPatterns on ShopFollowerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopFollowerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopFollowerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopFollowerModel value)  $default,){
final _that = this;
switch (_that) {
case _ShopFollowerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopFollowerModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShopFollowerModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  int cumulativeStreak,  DateTime followedAt,  String? userPhoneNumber,  DateTime? lastCheckInDate,  int? lastGiftDayStreak,  String? userProfilePic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopFollowerModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  int cumulativeStreak,  DateTime followedAt,  String? userPhoneNumber,  DateTime? lastCheckInDate,  int? lastGiftDayStreak,  String? userProfilePic)  $default,) {final _that = this;
switch (_that) {
case _ShopFollowerModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  int cumulativeStreak,  DateTime followedAt,  String? userPhoneNumber,  DateTime? lastCheckInDate,  int? lastGiftDayStreak,  String? userProfilePic)?  $default,) {final _that = this;
switch (_that) {
case _ShopFollowerModel() when $default != null:
return $default(_that.userId,_that.userName,_that.cumulativeStreak,_that.followedAt,_that.userPhoneNumber,_that.lastCheckInDate,_that.lastGiftDayStreak,_that.userProfilePic);case _:
  return null;

}
}

}

/// @nodoc


class _ShopFollowerModel implements ShopFollowerModel {
  const _ShopFollowerModel({required this.userId, required this.userName, required this.cumulativeStreak, required this.followedAt, this.userPhoneNumber, this.lastCheckInDate, this.lastGiftDayStreak, this.userProfilePic});
  

@override final  String userId;
@override final  String userName;
@override final  int cumulativeStreak;
@override final  DateTime followedAt;
@override final  String? userPhoneNumber;
@override final  DateTime? lastCheckInDate;
@override final  int? lastGiftDayStreak;
@override final  String? userProfilePic;

/// Create a copy of ShopFollowerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopFollowerModelCopyWith<_ShopFollowerModel> get copyWith => __$ShopFollowerModelCopyWithImpl<_ShopFollowerModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopFollowerModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.userPhoneNumber, userPhoneNumber) || other.userPhoneNumber == userPhoneNumber)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastGiftDayStreak, lastGiftDayStreak) || other.lastGiftDayStreak == lastGiftDayStreak)&&(identical(other.userProfilePic, userProfilePic) || other.userProfilePic == userProfilePic));
}


@override
int get hashCode => Object.hash(runtimeType,userId,userName,cumulativeStreak,followedAt,userPhoneNumber,lastCheckInDate,lastGiftDayStreak,userProfilePic);

@override
String toString() {
  return 'ShopFollowerModel(userId: $userId, userName: $userName, cumulativeStreak: $cumulativeStreak, followedAt: $followedAt, userPhoneNumber: $userPhoneNumber, lastCheckInDate: $lastCheckInDate, lastGiftDayStreak: $lastGiftDayStreak, userProfilePic: $userProfilePic)';
}


}

/// @nodoc
abstract mixin class _$ShopFollowerModelCopyWith<$Res> implements $ShopFollowerModelCopyWith<$Res> {
  factory _$ShopFollowerModelCopyWith(_ShopFollowerModel value, $Res Function(_ShopFollowerModel) _then) = __$ShopFollowerModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, int cumulativeStreak, DateTime followedAt, String? userPhoneNumber, DateTime? lastCheckInDate, int? lastGiftDayStreak, String? userProfilePic
});




}
/// @nodoc
class __$ShopFollowerModelCopyWithImpl<$Res>
    implements _$ShopFollowerModelCopyWith<$Res> {
  __$ShopFollowerModelCopyWithImpl(this._self, this._then);

  final _ShopFollowerModel _self;
  final $Res Function(_ShopFollowerModel) _then;

/// Create a copy of ShopFollowerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? cumulativeStreak = null,Object? followedAt = null,Object? userPhoneNumber = freezed,Object? lastCheckInDate = freezed,Object? lastGiftDayStreak = freezed,Object? userProfilePic = freezed,}) {
  return _then(_ShopFollowerModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,followedAt: null == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userPhoneNumber: freezed == userPhoneNumber ? _self.userPhoneNumber : userPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastGiftDayStreak: freezed == lastGiftDayStreak ? _self.lastGiftDayStreak : lastGiftDayStreak // ignore: cast_nullable_to_non_nullable
as int?,userProfilePic: freezed == userProfilePic ? _self.userProfilePic : userProfilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
