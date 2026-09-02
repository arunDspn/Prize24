// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follower_streak_log_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FollowerStreakLogDto {

// required String comment,
 int get consecutiveDays; int get cumulativeStreak; bool get isGiftDay;// bonusApplied true (boolean)
 bool get bonusApplied;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get timestamp;
/// Create a copy of FollowerStreakLogDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FollowerStreakLogDtoCopyWith<FollowerStreakLogDto> get copyWith => _$FollowerStreakLogDtoCopyWithImpl<FollowerStreakLogDto>(this as FollowerStreakLogDto, _$identity);

  /// Serializes this FollowerStreakLogDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FollowerStreakLogDto&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.isGiftDay, isGiftDay) || other.isGiftDay == isGiftDay)&&(identical(other.bonusApplied, bonusApplied) || other.bonusApplied == bonusApplied)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,consecutiveDays,cumulativeStreak,isGiftDay,bonusApplied,timestamp);

@override
String toString() {
  return 'FollowerStreakLogDto(consecutiveDays: $consecutiveDays, cumulativeStreak: $cumulativeStreak, isGiftDay: $isGiftDay, bonusApplied: $bonusApplied, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $FollowerStreakLogDtoCopyWith<$Res>  {
  factory $FollowerStreakLogDtoCopyWith(FollowerStreakLogDto value, $Res Function(FollowerStreakLogDto) _then) = _$FollowerStreakLogDtoCopyWithImpl;
@useResult
$Res call({
 int consecutiveDays, int cumulativeStreak, bool isGiftDay, bool bonusApplied,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp timestamp
});




}
/// @nodoc
class _$FollowerStreakLogDtoCopyWithImpl<$Res>
    implements $FollowerStreakLogDtoCopyWith<$Res> {
  _$FollowerStreakLogDtoCopyWithImpl(this._self, this._then);

  final FollowerStreakLogDto _self;
  final $Res Function(FollowerStreakLogDto) _then;

/// Create a copy of FollowerStreakLogDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? consecutiveDays = null,Object? cumulativeStreak = null,Object? isGiftDay = null,Object? bonusApplied = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,isGiftDay: null == isGiftDay ? _self.isGiftDay : isGiftDay // ignore: cast_nullable_to_non_nullable
as bool,bonusApplied: null == bonusApplied ? _self.bonusApplied : bonusApplied // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// Adds pattern-matching-related methods to [FollowerStreakLogDto].
extension FollowerStreakLogDtoPatterns on FollowerStreakLogDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FollowerStreakLogDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FollowerStreakLogDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FollowerStreakLogDto value)  $default,){
final _that = this;
switch (_that) {
case _FollowerStreakLogDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FollowerStreakLogDto value)?  $default,){
final _that = this;
switch (_that) {
case _FollowerStreakLogDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int consecutiveDays,  int cumulativeStreak,  bool isGiftDay,  bool bonusApplied, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FollowerStreakLogDto() when $default != null:
return $default(_that.consecutiveDays,_that.cumulativeStreak,_that.isGiftDay,_that.bonusApplied,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int consecutiveDays,  int cumulativeStreak,  bool isGiftDay,  bool bonusApplied, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp timestamp)  $default,) {final _that = this;
switch (_that) {
case _FollowerStreakLogDto():
return $default(_that.consecutiveDays,_that.cumulativeStreak,_that.isGiftDay,_that.bonusApplied,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int consecutiveDays,  int cumulativeStreak,  bool isGiftDay,  bool bonusApplied, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp timestamp)?  $default,) {final _that = this;
switch (_that) {
case _FollowerStreakLogDto() when $default != null:
return $default(_that.consecutiveDays,_that.cumulativeStreak,_that.isGiftDay,_that.bonusApplied,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FollowerStreakLogDto extends FollowerStreakLogDto {
  const _FollowerStreakLogDto({required this.consecutiveDays, required this.cumulativeStreak, required this.isGiftDay, required this.bonusApplied, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.timestamp}): super._();
  factory _FollowerStreakLogDto.fromJson(Map<String, dynamic> json) => _$FollowerStreakLogDtoFromJson(json);

// required String comment,
@override final  int consecutiveDays;
@override final  int cumulativeStreak;
@override final  bool isGiftDay;
// bonusApplied true (boolean)
@override final  bool bonusApplied;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp timestamp;

/// Create a copy of FollowerStreakLogDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FollowerStreakLogDtoCopyWith<_FollowerStreakLogDto> get copyWith => __$FollowerStreakLogDtoCopyWithImpl<_FollowerStreakLogDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FollowerStreakLogDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FollowerStreakLogDto&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.isGiftDay, isGiftDay) || other.isGiftDay == isGiftDay)&&(identical(other.bonusApplied, bonusApplied) || other.bonusApplied == bonusApplied)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,consecutiveDays,cumulativeStreak,isGiftDay,bonusApplied,timestamp);

@override
String toString() {
  return 'FollowerStreakLogDto(consecutiveDays: $consecutiveDays, cumulativeStreak: $cumulativeStreak, isGiftDay: $isGiftDay, bonusApplied: $bonusApplied, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$FollowerStreakLogDtoCopyWith<$Res> implements $FollowerStreakLogDtoCopyWith<$Res> {
  factory _$FollowerStreakLogDtoCopyWith(_FollowerStreakLogDto value, $Res Function(_FollowerStreakLogDto) _then) = __$FollowerStreakLogDtoCopyWithImpl;
@override @useResult
$Res call({
 int consecutiveDays, int cumulativeStreak, bool isGiftDay, bool bonusApplied,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp timestamp
});




}
/// @nodoc
class __$FollowerStreakLogDtoCopyWithImpl<$Res>
    implements _$FollowerStreakLogDtoCopyWith<$Res> {
  __$FollowerStreakLogDtoCopyWithImpl(this._self, this._then);

  final _FollowerStreakLogDto _self;
  final $Res Function(_FollowerStreakLogDto) _then;

/// Create a copy of FollowerStreakLogDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? consecutiveDays = null,Object? cumulativeStreak = null,Object? isGiftDay = null,Object? bonusApplied = null,Object? timestamp = null,}) {
  return _then(_FollowerStreakLogDto(
consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,isGiftDay: null == isGiftDay ? _self.isGiftDay : isGiftDay // ignore: cast_nullable_to_non_nullable
as bool,bonusApplied: null == bonusApplied ? _self.bonusApplied : bonusApplied // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
