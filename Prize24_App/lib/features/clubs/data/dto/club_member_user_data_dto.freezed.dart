// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_member_user_data_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClubMemberUserDataDto {

 int get streakTotal; int get consecutiveDays;@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? get lastCheckInDate;@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? get lastBonusDate;@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? get lastGiftDate; int get giftDayCycle; String get clubName; String get clubDescription; String? get clubId;
/// Create a copy of ClubMemberUserDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClubMemberUserDataDtoCopyWith<ClubMemberUserDataDto> get copyWith => _$ClubMemberUserDataDtoCopyWithImpl<ClubMemberUserDataDto>(this as ClubMemberUserDataDto, _$identity);

  /// Serializes this ClubMemberUserDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClubMemberUserDataDto&&(identical(other.streakTotal, streakTotal) || other.streakTotal == streakTotal)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastBonusDate, lastBonusDate) || other.lastBonusDate == lastBonusDate)&&(identical(other.lastGiftDate, lastGiftDate) || other.lastGiftDate == lastGiftDate)&&(identical(other.giftDayCycle, giftDayCycle) || other.giftDayCycle == giftDayCycle)&&(identical(other.clubName, clubName) || other.clubName == clubName)&&(identical(other.clubDescription, clubDescription) || other.clubDescription == clubDescription)&&(identical(other.clubId, clubId) || other.clubId == clubId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streakTotal,consecutiveDays,lastCheckInDate,lastBonusDate,lastGiftDate,giftDayCycle,clubName,clubDescription,clubId);

@override
String toString() {
  return 'ClubMemberUserDataDto(streakTotal: $streakTotal, consecutiveDays: $consecutiveDays, lastCheckInDate: $lastCheckInDate, lastBonusDate: $lastBonusDate, lastGiftDate: $lastGiftDate, giftDayCycle: $giftDayCycle, clubName: $clubName, clubDescription: $clubDescription, clubId: $clubId)';
}


}

/// @nodoc
abstract mixin class $ClubMemberUserDataDtoCopyWith<$Res>  {
  factory $ClubMemberUserDataDtoCopyWith(ClubMemberUserDataDto value, $Res Function(ClubMemberUserDataDto) _then) = _$ClubMemberUserDataDtoCopyWithImpl;
@useResult
$Res call({
 int streakTotal, int consecutiveDays,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastCheckInDate,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastBonusDate,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastGiftDate, int giftDayCycle, String clubName, String clubDescription, String? clubId
});




}
/// @nodoc
class _$ClubMemberUserDataDtoCopyWithImpl<$Res>
    implements $ClubMemberUserDataDtoCopyWith<$Res> {
  _$ClubMemberUserDataDtoCopyWithImpl(this._self, this._then);

  final ClubMemberUserDataDto _self;
  final $Res Function(ClubMemberUserDataDto) _then;

/// Create a copy of ClubMemberUserDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streakTotal = null,Object? consecutiveDays = null,Object? lastCheckInDate = freezed,Object? lastBonusDate = freezed,Object? lastGiftDate = freezed,Object? giftDayCycle = null,Object? clubName = null,Object? clubDescription = null,Object? clubId = freezed,}) {
  return _then(_self.copyWith(
streakTotal: null == streakTotal ? _self.streakTotal : streakTotal // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,lastBonusDate: freezed == lastBonusDate ? _self.lastBonusDate : lastBonusDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,lastGiftDate: freezed == lastGiftDate ? _self.lastGiftDate : lastGiftDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,giftDayCycle: null == giftDayCycle ? _self.giftDayCycle : giftDayCycle // ignore: cast_nullable_to_non_nullable
as int,clubName: null == clubName ? _self.clubName : clubName // ignore: cast_nullable_to_non_nullable
as String,clubDescription: null == clubDescription ? _self.clubDescription : clubDescription // ignore: cast_nullable_to_non_nullable
as String,clubId: freezed == clubId ? _self.clubId : clubId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClubMemberUserDataDto].
extension ClubMemberUserDataDtoPatterns on ClubMemberUserDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClubMemberUserDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClubMemberUserDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClubMemberUserDataDto value)  $default,){
final _that = this;
switch (_that) {
case _ClubMemberUserDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClubMemberUserDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _ClubMemberUserDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int streakTotal,  int consecutiveDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastBonusDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastGiftDate,  int giftDayCycle,  String clubName,  String clubDescription,  String? clubId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClubMemberUserDataDto() when $default != null:
return $default(_that.streakTotal,_that.consecutiveDays,_that.lastCheckInDate,_that.lastBonusDate,_that.lastGiftDate,_that.giftDayCycle,_that.clubName,_that.clubDescription,_that.clubId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int streakTotal,  int consecutiveDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastBonusDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastGiftDate,  int giftDayCycle,  String clubName,  String clubDescription,  String? clubId)  $default,) {final _that = this;
switch (_that) {
case _ClubMemberUserDataDto():
return $default(_that.streakTotal,_that.consecutiveDays,_that.lastCheckInDate,_that.lastBonusDate,_that.lastGiftDate,_that.giftDayCycle,_that.clubName,_that.clubDescription,_that.clubId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int streakTotal,  int consecutiveDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastCheckInDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastBonusDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? lastGiftDate,  int giftDayCycle,  String clubName,  String clubDescription,  String? clubId)?  $default,) {final _that = this;
switch (_that) {
case _ClubMemberUserDataDto() when $default != null:
return $default(_that.streakTotal,_that.consecutiveDays,_that.lastCheckInDate,_that.lastBonusDate,_that.lastGiftDate,_that.giftDayCycle,_that.clubName,_that.clubDescription,_that.clubId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClubMemberUserDataDto extends ClubMemberUserDataDto {
  const _ClubMemberUserDataDto({required this.streakTotal, required this.consecutiveDays, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) required this.lastCheckInDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) required this.lastBonusDate, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) required this.lastGiftDate, required this.giftDayCycle, required this.clubName, required this.clubDescription, this.clubId}): super._();
  factory _ClubMemberUserDataDto.fromJson(Map<String, dynamic> json) => _$ClubMemberUserDataDtoFromJson(json);

@override final  int streakTotal;
@override final  int consecutiveDays;
@override@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) final  Timestamp? lastCheckInDate;
@override@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) final  Timestamp? lastBonusDate;
@override@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) final  Timestamp? lastGiftDate;
@override final  int giftDayCycle;
@override final  String clubName;
@override final  String clubDescription;
@override final  String? clubId;

/// Create a copy of ClubMemberUserDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClubMemberUserDataDtoCopyWith<_ClubMemberUserDataDto> get copyWith => __$ClubMemberUserDataDtoCopyWithImpl<_ClubMemberUserDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClubMemberUserDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClubMemberUserDataDto&&(identical(other.streakTotal, streakTotal) || other.streakTotal == streakTotal)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastBonusDate, lastBonusDate) || other.lastBonusDate == lastBonusDate)&&(identical(other.lastGiftDate, lastGiftDate) || other.lastGiftDate == lastGiftDate)&&(identical(other.giftDayCycle, giftDayCycle) || other.giftDayCycle == giftDayCycle)&&(identical(other.clubName, clubName) || other.clubName == clubName)&&(identical(other.clubDescription, clubDescription) || other.clubDescription == clubDescription)&&(identical(other.clubId, clubId) || other.clubId == clubId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streakTotal,consecutiveDays,lastCheckInDate,lastBonusDate,lastGiftDate,giftDayCycle,clubName,clubDescription,clubId);

@override
String toString() {
  return 'ClubMemberUserDataDto(streakTotal: $streakTotal, consecutiveDays: $consecutiveDays, lastCheckInDate: $lastCheckInDate, lastBonusDate: $lastBonusDate, lastGiftDate: $lastGiftDate, giftDayCycle: $giftDayCycle, clubName: $clubName, clubDescription: $clubDescription, clubId: $clubId)';
}


}

/// @nodoc
abstract mixin class _$ClubMemberUserDataDtoCopyWith<$Res> implements $ClubMemberUserDataDtoCopyWith<$Res> {
  factory _$ClubMemberUserDataDtoCopyWith(_ClubMemberUserDataDto value, $Res Function(_ClubMemberUserDataDto) _then) = __$ClubMemberUserDataDtoCopyWithImpl;
@override @useResult
$Res call({
 int streakTotal, int consecutiveDays,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastCheckInDate,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastBonusDate,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? lastGiftDate, int giftDayCycle, String clubName, String clubDescription, String? clubId
});




}
/// @nodoc
class __$ClubMemberUserDataDtoCopyWithImpl<$Res>
    implements _$ClubMemberUserDataDtoCopyWith<$Res> {
  __$ClubMemberUserDataDtoCopyWithImpl(this._self, this._then);

  final _ClubMemberUserDataDto _self;
  final $Res Function(_ClubMemberUserDataDto) _then;

/// Create a copy of ClubMemberUserDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streakTotal = null,Object? consecutiveDays = null,Object? lastCheckInDate = freezed,Object? lastBonusDate = freezed,Object? lastGiftDate = freezed,Object? giftDayCycle = null,Object? clubName = null,Object? clubDescription = null,Object? clubId = freezed,}) {
  return _then(_ClubMemberUserDataDto(
streakTotal: null == streakTotal ? _self.streakTotal : streakTotal // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,lastBonusDate: freezed == lastBonusDate ? _self.lastBonusDate : lastBonusDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,lastGiftDate: freezed == lastGiftDate ? _self.lastGiftDate : lastGiftDate // ignore: cast_nullable_to_non_nullable
as Timestamp?,giftDayCycle: null == giftDayCycle ? _self.giftDayCycle : giftDayCycle // ignore: cast_nullable_to_non_nullable
as int,clubName: null == clubName ? _self.clubName : clubName // ignore: cast_nullable_to_non_nullable
as String,clubDescription: null == clubDescription ? _self.clubDescription : clubDescription // ignore: cast_nullable_to_non_nullable
as String,clubId: freezed == clubId ? _self.clubId : clubId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
