// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follower_streak_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FollowerStreakLogModel {

// required String comment,
 int get consecutiveDays; int get cumulativeStreak; bool get isGiftDay; bool get bonusApplied; DateTime get timestamp;
/// Create a copy of FollowerStreakLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FollowerStreakLogModelCopyWith<FollowerStreakLogModel> get copyWith => _$FollowerStreakLogModelCopyWithImpl<FollowerStreakLogModel>(this as FollowerStreakLogModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FollowerStreakLogModel&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.isGiftDay, isGiftDay) || other.isGiftDay == isGiftDay)&&(identical(other.bonusApplied, bonusApplied) || other.bonusApplied == bonusApplied)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,consecutiveDays,cumulativeStreak,isGiftDay,bonusApplied,timestamp);

@override
String toString() {
  return 'FollowerStreakLogModel(consecutiveDays: $consecutiveDays, cumulativeStreak: $cumulativeStreak, isGiftDay: $isGiftDay, bonusApplied: $bonusApplied, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $FollowerStreakLogModelCopyWith<$Res>  {
  factory $FollowerStreakLogModelCopyWith(FollowerStreakLogModel value, $Res Function(FollowerStreakLogModel) _then) = _$FollowerStreakLogModelCopyWithImpl;
@useResult
$Res call({
 int consecutiveDays, int cumulativeStreak, bool isGiftDay, bool bonusApplied, DateTime timestamp
});




}
/// @nodoc
class _$FollowerStreakLogModelCopyWithImpl<$Res>
    implements $FollowerStreakLogModelCopyWith<$Res> {
  _$FollowerStreakLogModelCopyWithImpl(this._self, this._then);

  final FollowerStreakLogModel _self;
  final $Res Function(FollowerStreakLogModel) _then;

/// Create a copy of FollowerStreakLogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? consecutiveDays = null,Object? cumulativeStreak = null,Object? isGiftDay = null,Object? bonusApplied = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,isGiftDay: null == isGiftDay ? _self.isGiftDay : isGiftDay // ignore: cast_nullable_to_non_nullable
as bool,bonusApplied: null == bonusApplied ? _self.bonusApplied : bonusApplied // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FollowerStreakLogModel].
extension FollowerStreakLogModelPatterns on FollowerStreakLogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FollowerStreakLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FollowerStreakLogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FollowerStreakLogModel value)  $default,){
final _that = this;
switch (_that) {
case _FollowerStreakLogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FollowerStreakLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _FollowerStreakLogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int consecutiveDays,  int cumulativeStreak,  bool isGiftDay,  bool bonusApplied,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FollowerStreakLogModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int consecutiveDays,  int cumulativeStreak,  bool isGiftDay,  bool bonusApplied,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _FollowerStreakLogModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int consecutiveDays,  int cumulativeStreak,  bool isGiftDay,  bool bonusApplied,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _FollowerStreakLogModel() when $default != null:
return $default(_that.consecutiveDays,_that.cumulativeStreak,_that.isGiftDay,_that.bonusApplied,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _FollowerStreakLogModel implements FollowerStreakLogModel {
  const _FollowerStreakLogModel({required this.consecutiveDays, required this.cumulativeStreak, required this.isGiftDay, required this.bonusApplied, required this.timestamp});
  

// required String comment,
@override final  int consecutiveDays;
@override final  int cumulativeStreak;
@override final  bool isGiftDay;
@override final  bool bonusApplied;
@override final  DateTime timestamp;

/// Create a copy of FollowerStreakLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FollowerStreakLogModelCopyWith<_FollowerStreakLogModel> get copyWith => __$FollowerStreakLogModelCopyWithImpl<_FollowerStreakLogModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FollowerStreakLogModel&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.isGiftDay, isGiftDay) || other.isGiftDay == isGiftDay)&&(identical(other.bonusApplied, bonusApplied) || other.bonusApplied == bonusApplied)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,consecutiveDays,cumulativeStreak,isGiftDay,bonusApplied,timestamp);

@override
String toString() {
  return 'FollowerStreakLogModel(consecutiveDays: $consecutiveDays, cumulativeStreak: $cumulativeStreak, isGiftDay: $isGiftDay, bonusApplied: $bonusApplied, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$FollowerStreakLogModelCopyWith<$Res> implements $FollowerStreakLogModelCopyWith<$Res> {
  factory _$FollowerStreakLogModelCopyWith(_FollowerStreakLogModel value, $Res Function(_FollowerStreakLogModel) _then) = __$FollowerStreakLogModelCopyWithImpl;
@override @useResult
$Res call({
 int consecutiveDays, int cumulativeStreak, bool isGiftDay, bool bonusApplied, DateTime timestamp
});




}
/// @nodoc
class __$FollowerStreakLogModelCopyWithImpl<$Res>
    implements _$FollowerStreakLogModelCopyWith<$Res> {
  __$FollowerStreakLogModelCopyWithImpl(this._self, this._then);

  final _FollowerStreakLogModel _self;
  final $Res Function(_FollowerStreakLogModel) _then;

/// Create a copy of FollowerStreakLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? consecutiveDays = null,Object? cumulativeStreak = null,Object? isGiftDay = null,Object? bonusApplied = null,Object? timestamp = null,}) {
  return _then(_FollowerStreakLogModel(
consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,isGiftDay: null == isGiftDay ? _self.isGiftDay : isGiftDay // ignore: cast_nullable_to_non_nullable
as bool,bonusApplied: null == bonusApplied ? _self.bonusApplied : bonusApplied // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
