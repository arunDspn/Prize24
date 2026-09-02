// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_member_vendor_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClubMemberVendorDataModel {

 int get streakTotal; int get consecutiveDays; DateTime? get lastCheckInDate; DateTime? get lastBonusDate; DateTime get joinedAt; String get userName; String get userId;
/// Create a copy of ClubMemberVendorDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClubMemberVendorDataModelCopyWith<ClubMemberVendorDataModel> get copyWith => _$ClubMemberVendorDataModelCopyWithImpl<ClubMemberVendorDataModel>(this as ClubMemberVendorDataModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClubMemberVendorDataModel&&(identical(other.streakTotal, streakTotal) || other.streakTotal == streakTotal)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastBonusDate, lastBonusDate) || other.lastBonusDate == lastBonusDate)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,streakTotal,consecutiveDays,lastCheckInDate,lastBonusDate,joinedAt,userName,userId);

@override
String toString() {
  return 'ClubMemberVendorDataModel(streakTotal: $streakTotal, consecutiveDays: $consecutiveDays, lastCheckInDate: $lastCheckInDate, lastBonusDate: $lastBonusDate, joinedAt: $joinedAt, userName: $userName, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ClubMemberVendorDataModelCopyWith<$Res>  {
  factory $ClubMemberVendorDataModelCopyWith(ClubMemberVendorDataModel value, $Res Function(ClubMemberVendorDataModel) _then) = _$ClubMemberVendorDataModelCopyWithImpl;
@useResult
$Res call({
 int streakTotal, int consecutiveDays, DateTime? lastCheckInDate, DateTime? lastBonusDate, DateTime joinedAt, String userName, String userId
});




}
/// @nodoc
class _$ClubMemberVendorDataModelCopyWithImpl<$Res>
    implements $ClubMemberVendorDataModelCopyWith<$Res> {
  _$ClubMemberVendorDataModelCopyWithImpl(this._self, this._then);

  final ClubMemberVendorDataModel _self;
  final $Res Function(ClubMemberVendorDataModel) _then;

/// Create a copy of ClubMemberVendorDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streakTotal = null,Object? consecutiveDays = null,Object? lastCheckInDate = freezed,Object? lastBonusDate = freezed,Object? joinedAt = null,Object? userName = null,Object? userId = null,}) {
  return _then(_self.copyWith(
streakTotal: null == streakTotal ? _self.streakTotal : streakTotal // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastBonusDate: freezed == lastBonusDate ? _self.lastBonusDate : lastBonusDate // ignore: cast_nullable_to_non_nullable
as DateTime?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClubMemberVendorDataModel].
extension ClubMemberVendorDataModelPatterns on ClubMemberVendorDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClubMemberVendorDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClubMemberVendorDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClubMemberVendorDataModel value)  $default,){
final _that = this;
switch (_that) {
case _ClubMemberVendorDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClubMemberVendorDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClubMemberVendorDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int streakTotal,  int consecutiveDays,  DateTime? lastCheckInDate,  DateTime? lastBonusDate,  DateTime joinedAt,  String userName,  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClubMemberVendorDataModel() when $default != null:
return $default(_that.streakTotal,_that.consecutiveDays,_that.lastCheckInDate,_that.lastBonusDate,_that.joinedAt,_that.userName,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int streakTotal,  int consecutiveDays,  DateTime? lastCheckInDate,  DateTime? lastBonusDate,  DateTime joinedAt,  String userName,  String userId)  $default,) {final _that = this;
switch (_that) {
case _ClubMemberVendorDataModel():
return $default(_that.streakTotal,_that.consecutiveDays,_that.lastCheckInDate,_that.lastBonusDate,_that.joinedAt,_that.userName,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int streakTotal,  int consecutiveDays,  DateTime? lastCheckInDate,  DateTime? lastBonusDate,  DateTime joinedAt,  String userName,  String userId)?  $default,) {final _that = this;
switch (_that) {
case _ClubMemberVendorDataModel() when $default != null:
return $default(_that.streakTotal,_that.consecutiveDays,_that.lastCheckInDate,_that.lastBonusDate,_that.joinedAt,_that.userName,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _ClubMemberVendorDataModel implements ClubMemberVendorDataModel {
  const _ClubMemberVendorDataModel({required this.streakTotal, required this.consecutiveDays, required this.lastCheckInDate, required this.lastBonusDate, required this.joinedAt, required this.userName, required this.userId});
  

@override final  int streakTotal;
@override final  int consecutiveDays;
@override final  DateTime? lastCheckInDate;
@override final  DateTime? lastBonusDate;
@override final  DateTime joinedAt;
@override final  String userName;
@override final  String userId;

/// Create a copy of ClubMemberVendorDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClubMemberVendorDataModelCopyWith<_ClubMemberVendorDataModel> get copyWith => __$ClubMemberVendorDataModelCopyWithImpl<_ClubMemberVendorDataModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClubMemberVendorDataModel&&(identical(other.streakTotal, streakTotal) || other.streakTotal == streakTotal)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastBonusDate, lastBonusDate) || other.lastBonusDate == lastBonusDate)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,streakTotal,consecutiveDays,lastCheckInDate,lastBonusDate,joinedAt,userName,userId);

@override
String toString() {
  return 'ClubMemberVendorDataModel(streakTotal: $streakTotal, consecutiveDays: $consecutiveDays, lastCheckInDate: $lastCheckInDate, lastBonusDate: $lastBonusDate, joinedAt: $joinedAt, userName: $userName, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$ClubMemberVendorDataModelCopyWith<$Res> implements $ClubMemberVendorDataModelCopyWith<$Res> {
  factory _$ClubMemberVendorDataModelCopyWith(_ClubMemberVendorDataModel value, $Res Function(_ClubMemberVendorDataModel) _then) = __$ClubMemberVendorDataModelCopyWithImpl;
@override @useResult
$Res call({
 int streakTotal, int consecutiveDays, DateTime? lastCheckInDate, DateTime? lastBonusDate, DateTime joinedAt, String userName, String userId
});




}
/// @nodoc
class __$ClubMemberVendorDataModelCopyWithImpl<$Res>
    implements _$ClubMemberVendorDataModelCopyWith<$Res> {
  __$ClubMemberVendorDataModelCopyWithImpl(this._self, this._then);

  final _ClubMemberVendorDataModel _self;
  final $Res Function(_ClubMemberVendorDataModel) _then;

/// Create a copy of ClubMemberVendorDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streakTotal = null,Object? consecutiveDays = null,Object? lastCheckInDate = freezed,Object? lastBonusDate = freezed,Object? joinedAt = null,Object? userName = null,Object? userId = null,}) {
  return _then(_ClubMemberVendorDataModel(
streakTotal: null == streakTotal ? _self.streakTotal : streakTotal // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastBonusDate: freezed == lastBonusDate ? _self.lastBonusDate : lastBonusDate // ignore: cast_nullable_to_non_nullable
as DateTime?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
