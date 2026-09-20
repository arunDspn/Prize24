// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckInResponseDto {

 bool get success; String get message;// Error field
 String? get error;// Data fields
 CheckInResponseDataDto? get data;
/// Create a copy of CheckInResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckInResponseDtoCopyWith<CheckInResponseDto> get copyWith => _$CheckInResponseDtoCopyWithImpl<CheckInResponseDto>(this as CheckInResponseDto, _$identity);

  /// Serializes this CheckInResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckInResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.error, error) || other.error == error)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,error,data);

@override
String toString() {
  return 'CheckInResponseDto(success: $success, message: $message, error: $error, data: $data)';
}


}

/// @nodoc
abstract mixin class $CheckInResponseDtoCopyWith<$Res>  {
  factory $CheckInResponseDtoCopyWith(CheckInResponseDto value, $Res Function(CheckInResponseDto) _then) = _$CheckInResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool success, String message, String? error, CheckInResponseDataDto? data
});


$CheckInResponseDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class _$CheckInResponseDtoCopyWithImpl<$Res>
    implements $CheckInResponseDtoCopyWith<$Res> {
  _$CheckInResponseDtoCopyWithImpl(this._self, this._then);

  final CheckInResponseDto _self;
  final $Res Function(CheckInResponseDto) _then;

/// Create a copy of CheckInResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? error = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CheckInResponseDataDto?,
  ));
}
/// Create a copy of CheckInResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckInResponseDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CheckInResponseDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckInResponseDto].
extension CheckInResponseDtoPatterns on CheckInResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckInResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckInResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckInResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CheckInResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckInResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CheckInResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  String? error,  CheckInResponseDataDto? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckInResponseDto() when $default != null:
return $default(_that.success,_that.message,_that.error,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  String? error,  CheckInResponseDataDto? data)  $default,) {final _that = this;
switch (_that) {
case _CheckInResponseDto():
return $default(_that.success,_that.message,_that.error,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  String? error,  CheckInResponseDataDto? data)?  $default,) {final _that = this;
switch (_that) {
case _CheckInResponseDto() when $default != null:
return $default(_that.success,_that.message,_that.error,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckInResponseDto extends CheckInResponseDto {
  const _CheckInResponseDto({required this.success, required this.message, this.error, this.data}): super._();
  factory _CheckInResponseDto.fromJson(Map<String, dynamic> json) => _$CheckInResponseDtoFromJson(json);

@override final  bool success;
@override final  String message;
// Error field
@override final  String? error;
// Data fields
@override final  CheckInResponseDataDto? data;

/// Create a copy of CheckInResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInResponseDtoCopyWith<_CheckInResponseDto> get copyWith => __$CheckInResponseDtoCopyWithImpl<_CheckInResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckInResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.error, error) || other.error == error)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,error,data);

@override
String toString() {
  return 'CheckInResponseDto(success: $success, message: $message, error: $error, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CheckInResponseDtoCopyWith<$Res> implements $CheckInResponseDtoCopyWith<$Res> {
  factory _$CheckInResponseDtoCopyWith(_CheckInResponseDto value, $Res Function(_CheckInResponseDto) _then) = __$CheckInResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, String? error, CheckInResponseDataDto? data
});


@override $CheckInResponseDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class __$CheckInResponseDtoCopyWithImpl<$Res>
    implements _$CheckInResponseDtoCopyWith<$Res> {
  __$CheckInResponseDtoCopyWithImpl(this._self, this._then);

  final _CheckInResponseDto _self;
  final $Res Function(_CheckInResponseDto) _then;

/// Create a copy of CheckInResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? error = freezed,Object? data = freezed,}) {
  return _then(_CheckInResponseDto(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CheckInResponseDataDto?,
  ));
}

/// Create a copy of CheckInResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckInResponseDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CheckInResponseDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$CheckInResponseDataDto {

 int get cumulativeStreak; int get consecutiveDays; bool get bonusApplied; bool get isGiftDay; bool get isNewUser; double get cumulativeBillSum; double get milestoneCycleBillSum; int? get crossedMilestone; RewardOpportunityDto? get rewardOpportunity;
/// Create a copy of CheckInResponseDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckInResponseDataDtoCopyWith<CheckInResponseDataDto> get copyWith => _$CheckInResponseDataDtoCopyWithImpl<CheckInResponseDataDto>(this as CheckInResponseDataDto, _$identity);

  /// Serializes this CheckInResponseDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckInResponseDataDto&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.bonusApplied, bonusApplied) || other.bonusApplied == bonusApplied)&&(identical(other.isGiftDay, isGiftDay) || other.isGiftDay == isGiftDay)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.cumulativeBillSum, cumulativeBillSum) || other.cumulativeBillSum == cumulativeBillSum)&&(identical(other.milestoneCycleBillSum, milestoneCycleBillSum) || other.milestoneCycleBillSum == milestoneCycleBillSum)&&(identical(other.crossedMilestone, crossedMilestone) || other.crossedMilestone == crossedMilestone)&&(identical(other.rewardOpportunity, rewardOpportunity) || other.rewardOpportunity == rewardOpportunity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cumulativeStreak,consecutiveDays,bonusApplied,isGiftDay,isNewUser,cumulativeBillSum,milestoneCycleBillSum,crossedMilestone,rewardOpportunity);

@override
String toString() {
  return 'CheckInResponseDataDto(cumulativeStreak: $cumulativeStreak, consecutiveDays: $consecutiveDays, bonusApplied: $bonusApplied, isGiftDay: $isGiftDay, isNewUser: $isNewUser, cumulativeBillSum: $cumulativeBillSum, milestoneCycleBillSum: $milestoneCycleBillSum, crossedMilestone: $crossedMilestone, rewardOpportunity: $rewardOpportunity)';
}


}

/// @nodoc
abstract mixin class $CheckInResponseDataDtoCopyWith<$Res>  {
  factory $CheckInResponseDataDtoCopyWith(CheckInResponseDataDto value, $Res Function(CheckInResponseDataDto) _then) = _$CheckInResponseDataDtoCopyWithImpl;
@useResult
$Res call({
 int cumulativeStreak, int consecutiveDays, bool bonusApplied, bool isGiftDay, bool isNewUser, double cumulativeBillSum, double milestoneCycleBillSum, int? crossedMilestone, RewardOpportunityDto? rewardOpportunity
});


$RewardOpportunityDtoCopyWith<$Res>? get rewardOpportunity;

}
/// @nodoc
class _$CheckInResponseDataDtoCopyWithImpl<$Res>
    implements $CheckInResponseDataDtoCopyWith<$Res> {
  _$CheckInResponseDataDtoCopyWithImpl(this._self, this._then);

  final CheckInResponseDataDto _self;
  final $Res Function(CheckInResponseDataDto) _then;

/// Create a copy of CheckInResponseDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cumulativeStreak = null,Object? consecutiveDays = null,Object? bonusApplied = null,Object? isGiftDay = null,Object? isNewUser = null,Object? cumulativeBillSum = null,Object? milestoneCycleBillSum = null,Object? crossedMilestone = freezed,Object? rewardOpportunity = freezed,}) {
  return _then(_self.copyWith(
cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,bonusApplied: null == bonusApplied ? _self.bonusApplied : bonusApplied // ignore: cast_nullable_to_non_nullable
as bool,isGiftDay: null == isGiftDay ? _self.isGiftDay : isGiftDay // ignore: cast_nullable_to_non_nullable
as bool,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,cumulativeBillSum: null == cumulativeBillSum ? _self.cumulativeBillSum : cumulativeBillSum // ignore: cast_nullable_to_non_nullable
as double,milestoneCycleBillSum: null == milestoneCycleBillSum ? _self.milestoneCycleBillSum : milestoneCycleBillSum // ignore: cast_nullable_to_non_nullable
as double,crossedMilestone: freezed == crossedMilestone ? _self.crossedMilestone : crossedMilestone // ignore: cast_nullable_to_non_nullable
as int?,rewardOpportunity: freezed == rewardOpportunity ? _self.rewardOpportunity : rewardOpportunity // ignore: cast_nullable_to_non_nullable
as RewardOpportunityDto?,
  ));
}
/// Create a copy of CheckInResponseDataDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardOpportunityDtoCopyWith<$Res>? get rewardOpportunity {
    if (_self.rewardOpportunity == null) {
    return null;
  }

  return $RewardOpportunityDtoCopyWith<$Res>(_self.rewardOpportunity!, (value) {
    return _then(_self.copyWith(rewardOpportunity: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckInResponseDataDto].
extension CheckInResponseDataDtoPatterns on CheckInResponseDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckInResponseDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckInResponseDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckInResponseDataDto value)  $default,){
final _that = this;
switch (_that) {
case _CheckInResponseDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckInResponseDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _CheckInResponseDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cumulativeStreak,  int consecutiveDays,  bool bonusApplied,  bool isGiftDay,  bool isNewUser,  double cumulativeBillSum,  double milestoneCycleBillSum,  int? crossedMilestone,  RewardOpportunityDto? rewardOpportunity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckInResponseDataDto() when $default != null:
return $default(_that.cumulativeStreak,_that.consecutiveDays,_that.bonusApplied,_that.isGiftDay,_that.isNewUser,_that.cumulativeBillSum,_that.milestoneCycleBillSum,_that.crossedMilestone,_that.rewardOpportunity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cumulativeStreak,  int consecutiveDays,  bool bonusApplied,  bool isGiftDay,  bool isNewUser,  double cumulativeBillSum,  double milestoneCycleBillSum,  int? crossedMilestone,  RewardOpportunityDto? rewardOpportunity)  $default,) {final _that = this;
switch (_that) {
case _CheckInResponseDataDto():
return $default(_that.cumulativeStreak,_that.consecutiveDays,_that.bonusApplied,_that.isGiftDay,_that.isNewUser,_that.cumulativeBillSum,_that.milestoneCycleBillSum,_that.crossedMilestone,_that.rewardOpportunity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cumulativeStreak,  int consecutiveDays,  bool bonusApplied,  bool isGiftDay,  bool isNewUser,  double cumulativeBillSum,  double milestoneCycleBillSum,  int? crossedMilestone,  RewardOpportunityDto? rewardOpportunity)?  $default,) {final _that = this;
switch (_that) {
case _CheckInResponseDataDto() when $default != null:
return $default(_that.cumulativeStreak,_that.consecutiveDays,_that.bonusApplied,_that.isGiftDay,_that.isNewUser,_that.cumulativeBillSum,_that.milestoneCycleBillSum,_that.crossedMilestone,_that.rewardOpportunity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckInResponseDataDto implements CheckInResponseDataDto {
  const _CheckInResponseDataDto({required this.cumulativeStreak, required this.consecutiveDays, required this.bonusApplied, required this.isGiftDay, required this.isNewUser, this.cumulativeBillSum = 0, this.milestoneCycleBillSum = 0, this.crossedMilestone, this.rewardOpportunity});
  factory _CheckInResponseDataDto.fromJson(Map<String, dynamic> json) => _$CheckInResponseDataDtoFromJson(json);

@override final  int cumulativeStreak;
@override final  int consecutiveDays;
@override final  bool bonusApplied;
@override final  bool isGiftDay;
@override final  bool isNewUser;
@override@JsonKey() final  double cumulativeBillSum;
@override@JsonKey() final  double milestoneCycleBillSum;
@override final  int? crossedMilestone;
@override final  RewardOpportunityDto? rewardOpportunity;

/// Create a copy of CheckInResponseDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInResponseDataDtoCopyWith<_CheckInResponseDataDto> get copyWith => __$CheckInResponseDataDtoCopyWithImpl<_CheckInResponseDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckInResponseDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInResponseDataDto&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.bonusApplied, bonusApplied) || other.bonusApplied == bonusApplied)&&(identical(other.isGiftDay, isGiftDay) || other.isGiftDay == isGiftDay)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.cumulativeBillSum, cumulativeBillSum) || other.cumulativeBillSum == cumulativeBillSum)&&(identical(other.milestoneCycleBillSum, milestoneCycleBillSum) || other.milestoneCycleBillSum == milestoneCycleBillSum)&&(identical(other.crossedMilestone, crossedMilestone) || other.crossedMilestone == crossedMilestone)&&(identical(other.rewardOpportunity, rewardOpportunity) || other.rewardOpportunity == rewardOpportunity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cumulativeStreak,consecutiveDays,bonusApplied,isGiftDay,isNewUser,cumulativeBillSum,milestoneCycleBillSum,crossedMilestone,rewardOpportunity);

@override
String toString() {
  return 'CheckInResponseDataDto(cumulativeStreak: $cumulativeStreak, consecutiveDays: $consecutiveDays, bonusApplied: $bonusApplied, isGiftDay: $isGiftDay, isNewUser: $isNewUser, cumulativeBillSum: $cumulativeBillSum, milestoneCycleBillSum: $milestoneCycleBillSum, crossedMilestone: $crossedMilestone, rewardOpportunity: $rewardOpportunity)';
}


}

/// @nodoc
abstract mixin class _$CheckInResponseDataDtoCopyWith<$Res> implements $CheckInResponseDataDtoCopyWith<$Res> {
  factory _$CheckInResponseDataDtoCopyWith(_CheckInResponseDataDto value, $Res Function(_CheckInResponseDataDto) _then) = __$CheckInResponseDataDtoCopyWithImpl;
@override @useResult
$Res call({
 int cumulativeStreak, int consecutiveDays, bool bonusApplied, bool isGiftDay, bool isNewUser, double cumulativeBillSum, double milestoneCycleBillSum, int? crossedMilestone, RewardOpportunityDto? rewardOpportunity
});


@override $RewardOpportunityDtoCopyWith<$Res>? get rewardOpportunity;

}
/// @nodoc
class __$CheckInResponseDataDtoCopyWithImpl<$Res>
    implements _$CheckInResponseDataDtoCopyWith<$Res> {
  __$CheckInResponseDataDtoCopyWithImpl(this._self, this._then);

  final _CheckInResponseDataDto _self;
  final $Res Function(_CheckInResponseDataDto) _then;

/// Create a copy of CheckInResponseDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cumulativeStreak = null,Object? consecutiveDays = null,Object? bonusApplied = null,Object? isGiftDay = null,Object? isNewUser = null,Object? cumulativeBillSum = null,Object? milestoneCycleBillSum = null,Object? crossedMilestone = freezed,Object? rewardOpportunity = freezed,}) {
  return _then(_CheckInResponseDataDto(
cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,bonusApplied: null == bonusApplied ? _self.bonusApplied : bonusApplied // ignore: cast_nullable_to_non_nullable
as bool,isGiftDay: null == isGiftDay ? _self.isGiftDay : isGiftDay // ignore: cast_nullable_to_non_nullable
as bool,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,cumulativeBillSum: null == cumulativeBillSum ? _self.cumulativeBillSum : cumulativeBillSum // ignore: cast_nullable_to_non_nullable
as double,milestoneCycleBillSum: null == milestoneCycleBillSum ? _self.milestoneCycleBillSum : milestoneCycleBillSum // ignore: cast_nullable_to_non_nullable
as double,crossedMilestone: freezed == crossedMilestone ? _self.crossedMilestone : crossedMilestone // ignore: cast_nullable_to_non_nullable
as int?,rewardOpportunity: freezed == rewardOpportunity ? _self.rewardOpportunity : rewardOpportunity // ignore: cast_nullable_to_non_nullable
as RewardOpportunityDto?,
  ));
}

/// Create a copy of CheckInResponseDataDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardOpportunityDtoCopyWith<$Res>? get rewardOpportunity {
    if (_self.rewardOpportunity == null) {
    return null;
  }

  return $RewardOpportunityDtoCopyWith<$Res>(_self.rewardOpportunity!, (value) {
    return _then(_self.copyWith(rewardOpportunity: value));
  });
}
}


/// @nodoc
mixin _$RewardOpportunityDto {

 String get id; String get status; List<String> get eligibleSources; String? get selectedSource;
/// Create a copy of RewardOpportunityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardOpportunityDtoCopyWith<RewardOpportunityDto> get copyWith => _$RewardOpportunityDtoCopyWithImpl<RewardOpportunityDto>(this as RewardOpportunityDto, _$identity);

  /// Serializes this RewardOpportunityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardOpportunityDto&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.eligibleSources, eligibleSources)&&(identical(other.selectedSource, selectedSource) || other.selectedSource == selectedSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,const DeepCollectionEquality().hash(eligibleSources),selectedSource);

@override
String toString() {
  return 'RewardOpportunityDto(id: $id, status: $status, eligibleSources: $eligibleSources, selectedSource: $selectedSource)';
}


}

/// @nodoc
abstract mixin class $RewardOpportunityDtoCopyWith<$Res>  {
  factory $RewardOpportunityDtoCopyWith(RewardOpportunityDto value, $Res Function(RewardOpportunityDto) _then) = _$RewardOpportunityDtoCopyWithImpl;
@useResult
$Res call({
 String id, String status, List<String> eligibleSources, String? selectedSource
});




}
/// @nodoc
class _$RewardOpportunityDtoCopyWithImpl<$Res>
    implements $RewardOpportunityDtoCopyWith<$Res> {
  _$RewardOpportunityDtoCopyWithImpl(this._self, this._then);

  final RewardOpportunityDto _self;
  final $Res Function(RewardOpportunityDto) _then;

/// Create a copy of RewardOpportunityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? eligibleSources = null,Object? selectedSource = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eligibleSources: null == eligibleSources ? _self.eligibleSources : eligibleSources // ignore: cast_nullable_to_non_nullable
as List<String>,selectedSource: freezed == selectedSource ? _self.selectedSource : selectedSource // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardOpportunityDto].
extension RewardOpportunityDtoPatterns on RewardOpportunityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardOpportunityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardOpportunityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardOpportunityDto value)  $default,){
final _that = this;
switch (_that) {
case _RewardOpportunityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardOpportunityDto value)?  $default,){
final _that = this;
switch (_that) {
case _RewardOpportunityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status,  List<String> eligibleSources,  String? selectedSource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardOpportunityDto() when $default != null:
return $default(_that.id,_that.status,_that.eligibleSources,_that.selectedSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status,  List<String> eligibleSources,  String? selectedSource)  $default,) {final _that = this;
switch (_that) {
case _RewardOpportunityDto():
return $default(_that.id,_that.status,_that.eligibleSources,_that.selectedSource);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status,  List<String> eligibleSources,  String? selectedSource)?  $default,) {final _that = this;
switch (_that) {
case _RewardOpportunityDto() when $default != null:
return $default(_that.id,_that.status,_that.eligibleSources,_that.selectedSource);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RewardOpportunityDto extends RewardOpportunityDto {
  const _RewardOpportunityDto({required this.id, required this.status, final  List<String> eligibleSources = const <String>[], this.selectedSource}): _eligibleSources = eligibleSources,super._();
  factory _RewardOpportunityDto.fromJson(Map<String, dynamic> json) => _$RewardOpportunityDtoFromJson(json);

@override final  String id;
@override final  String status;
 final  List<String> _eligibleSources;
@override@JsonKey() List<String> get eligibleSources {
  if (_eligibleSources is EqualUnmodifiableListView) return _eligibleSources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eligibleSources);
}

@override final  String? selectedSource;

/// Create a copy of RewardOpportunityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardOpportunityDtoCopyWith<_RewardOpportunityDto> get copyWith => __$RewardOpportunityDtoCopyWithImpl<_RewardOpportunityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardOpportunityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardOpportunityDto&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._eligibleSources, _eligibleSources)&&(identical(other.selectedSource, selectedSource) || other.selectedSource == selectedSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,const DeepCollectionEquality().hash(_eligibleSources),selectedSource);

@override
String toString() {
  return 'RewardOpportunityDto(id: $id, status: $status, eligibleSources: $eligibleSources, selectedSource: $selectedSource)';
}


}

/// @nodoc
abstract mixin class _$RewardOpportunityDtoCopyWith<$Res> implements $RewardOpportunityDtoCopyWith<$Res> {
  factory _$RewardOpportunityDtoCopyWith(_RewardOpportunityDto value, $Res Function(_RewardOpportunityDto) _then) = __$RewardOpportunityDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String status, List<String> eligibleSources, String? selectedSource
});




}
/// @nodoc
class __$RewardOpportunityDtoCopyWithImpl<$Res>
    implements _$RewardOpportunityDtoCopyWith<$Res> {
  __$RewardOpportunityDtoCopyWithImpl(this._self, this._then);

  final _RewardOpportunityDto _self;
  final $Res Function(_RewardOpportunityDto) _then;

/// Create a copy of RewardOpportunityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? eligibleSources = null,Object? selectedSource = freezed,}) {
  return _then(_RewardOpportunityDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eligibleSources: null == eligibleSources ? _self._eligibleSources : eligibleSources // ignore: cast_nullable_to_non_nullable
as List<String>,selectedSource: freezed == selectedSource ? _self.selectedSource : selectedSource // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
