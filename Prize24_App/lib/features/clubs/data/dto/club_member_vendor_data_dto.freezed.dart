// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_member_vendor_data_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClubMemberVendorDataDto {

 int get streakTotal; int get consecutiveDays;@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? get lastCheckInDate;@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? get lastBonusDate;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get joinedAt; String get userName; String get userId;
/// Create a copy of ClubMemberVendorDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClubMemberVendorDataDtoCopyWith<ClubMemberVendorDataDto> get copyWith => _$ClubMemberVendorDataDtoCopyWithImpl<ClubMemberVendorDataDto>(this as ClubMemberVendorDataDto, _$identity);

  /// Serializes this ClubMemberVendorDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClubMemberVendorDataDto&&(identical(other.streakTotal, streakTotal) || other.streakTotal == streakTotal)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastBonusDate, lastBonusDate) || other.lastBonusDate == lastBonusDate)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streakTotal,consecutiveDays,lastCheckInDate,lastBonusDate,joinedAt,userName,userId);

@override
String toString() {
  return 'ClubMemberVendorDataDto(streakTotal: $streakTotal, consecutiveDays: $consecutiveDays, lastCheckInDate: $lastCheckInDate, lastBonusDate: $lastBonusDate, joinedAt: $joinedAt, userName: $userName, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ClubMemberVendorDataDtoCopyWith<$Res>  {
  factory $ClubMemberVendorDataDtoCopyWith(ClubMemberVendorDataDto value, $Res Function(ClubMemberVendorDataDto) _then) = _$ClubMemberVendorDataDtoCopyWithImpl;
@useResult
$Res call({
 int streakTotal, int consecutiveDays,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastCheckInDate,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastBonusDate,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp joinedAt, String userName, String userId
});




}
/// @nodoc
class _$ClubMemberVendorDataDtoCopyWithImpl<$Res>
    implements $ClubMemberVendorDataDtoCopyWith<$Res> {
  _$ClubMemberVendorDataDtoCopyWithImpl(this._self, this._then);

  final ClubMemberVendorDataDto _self;
  final $Res Function(ClubMemberVendorDataDto) _then;

/// Create a copy of ClubMemberVendorDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streakTotal = null,Object? consecutiveDays = null,Object? lastCheckInDate = freezed,Object? lastBonusDate = freezed,Object? joinedAt = null,Object? userName = null,Object? userId = null,}) {
  return _then(_self.copyWith(
streakTotal: null == streakTotal ? _self.streakTotal : streakTotal // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,lastBonusDate: freezed == lastBonusDate ? _self.lastBonusDate : lastBonusDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClubMemberVendorDataDto].
extension ClubMemberVendorDataDtoPatterns on ClubMemberVendorDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClubMemberVendorDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClubMemberVendorDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClubMemberVendorDataDto value)  $default,){
final _that = this;
switch (_that) {
case _ClubMemberVendorDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClubMemberVendorDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _ClubMemberVendorDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int streakTotal,  int consecutiveDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastBonusDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp joinedAt,  String userName,  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClubMemberVendorDataDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int streakTotal,  int consecutiveDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastBonusDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp joinedAt,  String userName,  String userId)  $default,) {final _that = this;
switch (_that) {
case _ClubMemberVendorDataDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int streakTotal,  int consecutiveDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastBonusDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp joinedAt,  String userName,  String userId)?  $default,) {final _that = this;
switch (_that) {
case _ClubMemberVendorDataDto() when $default != null:
return $default(_that.streakTotal,_that.consecutiveDays,_that.lastCheckInDate,_that.lastBonusDate,_that.joinedAt,_that.userName,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClubMemberVendorDataDto extends ClubMemberVendorDataDto {
  const _ClubMemberVendorDataDto({required this.streakTotal, required this.consecutiveDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) required this.lastCheckInDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) required this.lastBonusDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.joinedAt, required this.userName, required this.userId}): super._();
  factory _ClubMemberVendorDataDto.fromJson(Map<String, dynamic> json) => _$ClubMemberVendorDataDtoFromJson(json);

@override final  int streakTotal;
@override final  int consecutiveDays;
@override@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) final  Timestamp? lastCheckInDate;
@override@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) final  Timestamp? lastBonusDate;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp joinedAt;
@override final  String userName;
@override final  String userId;

/// Create a copy of ClubMemberVendorDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClubMemberVendorDataDtoCopyWith<_ClubMemberVendorDataDto> get copyWith => __$ClubMemberVendorDataDtoCopyWithImpl<_ClubMemberVendorDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClubMemberVendorDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClubMemberVendorDataDto&&(identical(other.streakTotal, streakTotal) || other.streakTotal == streakTotal)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastBonusDate, lastBonusDate) || other.lastBonusDate == lastBonusDate)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streakTotal,consecutiveDays,lastCheckInDate,lastBonusDate,joinedAt,userName,userId);

@override
String toString() {
  return 'ClubMemberVendorDataDto(streakTotal: $streakTotal, consecutiveDays: $consecutiveDays, lastCheckInDate: $lastCheckInDate, lastBonusDate: $lastBonusDate, joinedAt: $joinedAt, userName: $userName, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$ClubMemberVendorDataDtoCopyWith<$Res> implements $ClubMemberVendorDataDtoCopyWith<$Res> {
  factory _$ClubMemberVendorDataDtoCopyWith(_ClubMemberVendorDataDto value, $Res Function(_ClubMemberVendorDataDto) _then) = __$ClubMemberVendorDataDtoCopyWithImpl;
@override @useResult
$Res call({
 int streakTotal, int consecutiveDays,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastCheckInDate,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastBonusDate,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp joinedAt, String userName, String userId
});




}
/// @nodoc
class __$ClubMemberVendorDataDtoCopyWithImpl<$Res>
    implements _$ClubMemberVendorDataDtoCopyWith<$Res> {
  __$ClubMemberVendorDataDtoCopyWithImpl(this._self, this._then);

  final _ClubMemberVendorDataDto _self;
  final $Res Function(_ClubMemberVendorDataDto) _then;

/// Create a copy of ClubMemberVendorDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streakTotal = null,Object? consecutiveDays = null,Object? lastCheckInDate = freezed,Object? lastBonusDate = freezed,Object? joinedAt = null,Object? userName = null,Object? userId = null,}) {
  return _then(_ClubMemberVendorDataDto(
streakTotal: null == streakTotal ? _self.streakTotal : streakTotal // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,lastBonusDate: freezed == lastBonusDate ? _self.lastBonusDate : lastBonusDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
