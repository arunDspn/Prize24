// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_member_user_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClubMemberUserDataModel {

 int get streakTotal; int get consecutiveDays; DateTime? get lastCheckInDate; DateTime? get lastBonusDate; DateTime? get lastGiftDate; int get giftDayCycle; String get clubName; String get clubDescription; String get clubId;
/// Create a copy of ClubMemberUserDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClubMemberUserDataModelCopyWith<ClubMemberUserDataModel> get copyWith => _$ClubMemberUserDataModelCopyWithImpl<ClubMemberUserDataModel>(this as ClubMemberUserDataModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClubMemberUserDataModel&&(identical(other.streakTotal, streakTotal) || other.streakTotal == streakTotal)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastBonusDate, lastBonusDate) || other.lastBonusDate == lastBonusDate)&&(identical(other.lastGiftDate, lastGiftDate) || other.lastGiftDate == lastGiftDate)&&(identical(other.giftDayCycle, giftDayCycle) || other.giftDayCycle == giftDayCycle)&&(identical(other.clubName, clubName) || other.clubName == clubName)&&(identical(other.clubDescription, clubDescription) || other.clubDescription == clubDescription)&&(identical(other.clubId, clubId) || other.clubId == clubId));
}


@override
int get hashCode => Object.hash(runtimeType,streakTotal,consecutiveDays,lastCheckInDate,lastBonusDate,lastGiftDate,giftDayCycle,clubName,clubDescription,clubId);

@override
String toString() {
  return 'ClubMemberUserDataModel(streakTotal: $streakTotal, consecutiveDays: $consecutiveDays, lastCheckInDate: $lastCheckInDate, lastBonusDate: $lastBonusDate, lastGiftDate: $lastGiftDate, giftDayCycle: $giftDayCycle, clubName: $clubName, clubDescription: $clubDescription, clubId: $clubId)';
}


}

/// @nodoc
abstract mixin class $ClubMemberUserDataModelCopyWith<$Res>  {
  factory $ClubMemberUserDataModelCopyWith(ClubMemberUserDataModel value, $Res Function(ClubMemberUserDataModel) _then) = _$ClubMemberUserDataModelCopyWithImpl;
@useResult
$Res call({
 int streakTotal, int consecutiveDays, DateTime? lastCheckInDate, DateTime? lastBonusDate, DateTime? lastGiftDate, int giftDayCycle, String clubName, String clubDescription, String clubId
});




}
/// @nodoc
class _$ClubMemberUserDataModelCopyWithImpl<$Res>
    implements $ClubMemberUserDataModelCopyWith<$Res> {
  _$ClubMemberUserDataModelCopyWithImpl(this._self, this._then);

  final ClubMemberUserDataModel _self;
  final $Res Function(ClubMemberUserDataModel) _then;

/// Create a copy of ClubMemberUserDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streakTotal = null,Object? consecutiveDays = null,Object? lastCheckInDate = freezed,Object? lastBonusDate = freezed,Object? lastGiftDate = freezed,Object? giftDayCycle = null,Object? clubName = null,Object? clubDescription = null,Object? clubId = null,}) {
  return _then(_self.copyWith(
streakTotal: null == streakTotal ? _self.streakTotal : streakTotal // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastBonusDate: freezed == lastBonusDate ? _self.lastBonusDate : lastBonusDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastGiftDate: freezed == lastGiftDate ? _self.lastGiftDate : lastGiftDate // ignore: cast_nullable_to_non_nullable
as DateTime?,giftDayCycle: null == giftDayCycle ? _self.giftDayCycle : giftDayCycle // ignore: cast_nullable_to_non_nullable
as int,clubName: null == clubName ? _self.clubName : clubName // ignore: cast_nullable_to_non_nullable
as String,clubDescription: null == clubDescription ? _self.clubDescription : clubDescription // ignore: cast_nullable_to_non_nullable
as String,clubId: null == clubId ? _self.clubId : clubId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClubMemberUserDataModel].
extension ClubMemberUserDataModelPatterns on ClubMemberUserDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClubMemberUserDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClubMemberUserDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClubMemberUserDataModel value)  $default,){
final _that = this;
switch (_that) {
case _ClubMemberUserDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClubMemberUserDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClubMemberUserDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int streakTotal,  int consecutiveDays,  DateTime? lastCheckInDate,  DateTime? lastBonusDate,  DateTime? lastGiftDate,  int giftDayCycle,  String clubName,  String clubDescription,  String clubId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClubMemberUserDataModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int streakTotal,  int consecutiveDays,  DateTime? lastCheckInDate,  DateTime? lastBonusDate,  DateTime? lastGiftDate,  int giftDayCycle,  String clubName,  String clubDescription,  String clubId)  $default,) {final _that = this;
switch (_that) {
case _ClubMemberUserDataModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int streakTotal,  int consecutiveDays,  DateTime? lastCheckInDate,  DateTime? lastBonusDate,  DateTime? lastGiftDate,  int giftDayCycle,  String clubName,  String clubDescription,  String clubId)?  $default,) {final _that = this;
switch (_that) {
case _ClubMemberUserDataModel() when $default != null:
return $default(_that.streakTotal,_that.consecutiveDays,_that.lastCheckInDate,_that.lastBonusDate,_that.lastGiftDate,_that.giftDayCycle,_that.clubName,_that.clubDescription,_that.clubId);case _:
  return null;

}
}

}

/// @nodoc


class _ClubMemberUserDataModel implements ClubMemberUserDataModel {
  const _ClubMemberUserDataModel({required this.streakTotal, required this.consecutiveDays, required this.lastCheckInDate, required this.lastBonusDate, required this.lastGiftDate, required this.giftDayCycle, required this.clubName, required this.clubDescription, required this.clubId});
  

@override final  int streakTotal;
@override final  int consecutiveDays;
@override final  DateTime? lastCheckInDate;
@override final  DateTime? lastBonusDate;
@override final  DateTime? lastGiftDate;
@override final  int giftDayCycle;
@override final  String clubName;
@override final  String clubDescription;
@override final  String clubId;

/// Create a copy of ClubMemberUserDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClubMemberUserDataModelCopyWith<_ClubMemberUserDataModel> get copyWith => __$ClubMemberUserDataModelCopyWithImpl<_ClubMemberUserDataModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClubMemberUserDataModel&&(identical(other.streakTotal, streakTotal) || other.streakTotal == streakTotal)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.lastBonusDate, lastBonusDate) || other.lastBonusDate == lastBonusDate)&&(identical(other.lastGiftDate, lastGiftDate) || other.lastGiftDate == lastGiftDate)&&(identical(other.giftDayCycle, giftDayCycle) || other.giftDayCycle == giftDayCycle)&&(identical(other.clubName, clubName) || other.clubName == clubName)&&(identical(other.clubDescription, clubDescription) || other.clubDescription == clubDescription)&&(identical(other.clubId, clubId) || other.clubId == clubId));
}


@override
int get hashCode => Object.hash(runtimeType,streakTotal,consecutiveDays,lastCheckInDate,lastBonusDate,lastGiftDate,giftDayCycle,clubName,clubDescription,clubId);

@override
String toString() {
  return 'ClubMemberUserDataModel(streakTotal: $streakTotal, consecutiveDays: $consecutiveDays, lastCheckInDate: $lastCheckInDate, lastBonusDate: $lastBonusDate, lastGiftDate: $lastGiftDate, giftDayCycle: $giftDayCycle, clubName: $clubName, clubDescription: $clubDescription, clubId: $clubId)';
}


}

/// @nodoc
abstract mixin class _$ClubMemberUserDataModelCopyWith<$Res> implements $ClubMemberUserDataModelCopyWith<$Res> {
  factory _$ClubMemberUserDataModelCopyWith(_ClubMemberUserDataModel value, $Res Function(_ClubMemberUserDataModel) _then) = __$ClubMemberUserDataModelCopyWithImpl;
@override @useResult
$Res call({
 int streakTotal, int consecutiveDays, DateTime? lastCheckInDate, DateTime? lastBonusDate, DateTime? lastGiftDate, int giftDayCycle, String clubName, String clubDescription, String clubId
});




}
/// @nodoc
class __$ClubMemberUserDataModelCopyWithImpl<$Res>
    implements _$ClubMemberUserDataModelCopyWith<$Res> {
  __$ClubMemberUserDataModelCopyWithImpl(this._self, this._then);

  final _ClubMemberUserDataModel _self;
  final $Res Function(_ClubMemberUserDataModel) _then;

/// Create a copy of ClubMemberUserDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streakTotal = null,Object? consecutiveDays = null,Object? lastCheckInDate = freezed,Object? lastBonusDate = freezed,Object? lastGiftDate = freezed,Object? giftDayCycle = null,Object? clubName = null,Object? clubDescription = null,Object? clubId = null,}) {
  return _then(_ClubMemberUserDataModel(
streakTotal: null == streakTotal ? _self.streakTotal : streakTotal // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastBonusDate: freezed == lastBonusDate ? _self.lastBonusDate : lastBonusDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastGiftDate: freezed == lastGiftDate ? _self.lastGiftDate : lastGiftDate // ignore: cast_nullable_to_non_nullable
as DateTime?,giftDayCycle: null == giftDayCycle ? _self.giftDayCycle : giftDayCycle // ignore: cast_nullable_to_non_nullable
as int,clubName: null == clubName ? _self.clubName : clubName // ignore: cast_nullable_to_non_nullable
as String,clubDescription: null == clubDescription ? _self.clubDescription : clubDescription // ignore: cast_nullable_to_non_nullable
as String,clubId: null == clubId ? _self.clubId : clubId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
