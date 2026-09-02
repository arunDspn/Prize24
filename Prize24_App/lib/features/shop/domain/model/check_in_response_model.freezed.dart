// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckInResponseModel {

 bool get success; String get message;// Error field
 String? get error;// Data fields
 CheckInRepsponseDataModel? get data;
/// Create a copy of CheckInResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckInResponseModelCopyWith<CheckInResponseModel> get copyWith => _$CheckInResponseModelCopyWithImpl<CheckInResponseModel>(this as CheckInResponseModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckInResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.error, error) || other.error == error)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,success,message,error,data);

@override
String toString() {
  return 'CheckInResponseModel(success: $success, message: $message, error: $error, data: $data)';
}


}

/// @nodoc
abstract mixin class $CheckInResponseModelCopyWith<$Res>  {
  factory $CheckInResponseModelCopyWith(CheckInResponseModel value, $Res Function(CheckInResponseModel) _then) = _$CheckInResponseModelCopyWithImpl;
@useResult
$Res call({
 bool success, String message, String? error, CheckInRepsponseDataModel? data
});


$CheckInRepsponseDataModelCopyWith<$Res>? get data;

}
/// @nodoc
class _$CheckInResponseModelCopyWithImpl<$Res>
    implements $CheckInResponseModelCopyWith<$Res> {
  _$CheckInResponseModelCopyWithImpl(this._self, this._then);

  final CheckInResponseModel _self;
  final $Res Function(CheckInResponseModel) _then;

/// Create a copy of CheckInResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? error = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CheckInRepsponseDataModel?,
  ));
}
/// Create a copy of CheckInResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckInRepsponseDataModelCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CheckInRepsponseDataModelCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckInResponseModel].
extension CheckInResponseModelPatterns on CheckInResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckInResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckInResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckInResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CheckInResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckInResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CheckInResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  String? error,  CheckInRepsponseDataModel? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckInResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  String? error,  CheckInRepsponseDataModel? data)  $default,) {final _that = this;
switch (_that) {
case _CheckInResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  String? error,  CheckInRepsponseDataModel? data)?  $default,) {final _that = this;
switch (_that) {
case _CheckInResponseModel() when $default != null:
return $default(_that.success,_that.message,_that.error,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _CheckInResponseModel implements CheckInResponseModel {
  const _CheckInResponseModel({required this.success, required this.message, this.error, this.data});
  

@override final  bool success;
@override final  String message;
// Error field
@override final  String? error;
// Data fields
@override final  CheckInRepsponseDataModel? data;

/// Create a copy of CheckInResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInResponseModelCopyWith<_CheckInResponseModel> get copyWith => __$CheckInResponseModelCopyWithImpl<_CheckInResponseModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.error, error) || other.error == error)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,success,message,error,data);

@override
String toString() {
  return 'CheckInResponseModel(success: $success, message: $message, error: $error, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CheckInResponseModelCopyWith<$Res> implements $CheckInResponseModelCopyWith<$Res> {
  factory _$CheckInResponseModelCopyWith(_CheckInResponseModel value, $Res Function(_CheckInResponseModel) _then) = __$CheckInResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, String? error, CheckInRepsponseDataModel? data
});


@override $CheckInRepsponseDataModelCopyWith<$Res>? get data;

}
/// @nodoc
class __$CheckInResponseModelCopyWithImpl<$Res>
    implements _$CheckInResponseModelCopyWith<$Res> {
  __$CheckInResponseModelCopyWithImpl(this._self, this._then);

  final _CheckInResponseModel _self;
  final $Res Function(_CheckInResponseModel) _then;

/// Create a copy of CheckInResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? error = freezed,Object? data = freezed,}) {
  return _then(_CheckInResponseModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CheckInRepsponseDataModel?,
  ));
}

/// Create a copy of CheckInResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckInRepsponseDataModelCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CheckInRepsponseDataModelCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$CheckInRepsponseDataModel {

 int get cumulativeStreak; int get consecutiveDays; bool get bonusApplied; bool get isGiftDay; bool get isNewUser;
/// Create a copy of CheckInRepsponseDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckInRepsponseDataModelCopyWith<CheckInRepsponseDataModel> get copyWith => _$CheckInRepsponseDataModelCopyWithImpl<CheckInRepsponseDataModel>(this as CheckInRepsponseDataModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckInRepsponseDataModel&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.bonusApplied, bonusApplied) || other.bonusApplied == bonusApplied)&&(identical(other.isGiftDay, isGiftDay) || other.isGiftDay == isGiftDay)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser));
}


@override
int get hashCode => Object.hash(runtimeType,cumulativeStreak,consecutiveDays,bonusApplied,isGiftDay,isNewUser);

@override
String toString() {
  return 'CheckInRepsponseDataModel(cumulativeStreak: $cumulativeStreak, consecutiveDays: $consecutiveDays, bonusApplied: $bonusApplied, isGiftDay: $isGiftDay, isNewUser: $isNewUser)';
}


}

/// @nodoc
abstract mixin class $CheckInRepsponseDataModelCopyWith<$Res>  {
  factory $CheckInRepsponseDataModelCopyWith(CheckInRepsponseDataModel value, $Res Function(CheckInRepsponseDataModel) _then) = _$CheckInRepsponseDataModelCopyWithImpl;
@useResult
$Res call({
 int cumulativeStreak, int consecutiveDays, bool bonusApplied, bool isGiftDay, bool isNewUser
});




}
/// @nodoc
class _$CheckInRepsponseDataModelCopyWithImpl<$Res>
    implements $CheckInRepsponseDataModelCopyWith<$Res> {
  _$CheckInRepsponseDataModelCopyWithImpl(this._self, this._then);

  final CheckInRepsponseDataModel _self;
  final $Res Function(CheckInRepsponseDataModel) _then;

/// Create a copy of CheckInRepsponseDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cumulativeStreak = null,Object? consecutiveDays = null,Object? bonusApplied = null,Object? isGiftDay = null,Object? isNewUser = null,}) {
  return _then(_self.copyWith(
cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,bonusApplied: null == bonusApplied ? _self.bonusApplied : bonusApplied // ignore: cast_nullable_to_non_nullable
as bool,isGiftDay: null == isGiftDay ? _self.isGiftDay : isGiftDay // ignore: cast_nullable_to_non_nullable
as bool,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckInRepsponseDataModel].
extension CheckInRepsponseDataModelPatterns on CheckInRepsponseDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckInRepsponseDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckInRepsponseDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckInRepsponseDataModel value)  $default,){
final _that = this;
switch (_that) {
case _CheckInRepsponseDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckInRepsponseDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _CheckInRepsponseDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cumulativeStreak,  int consecutiveDays,  bool bonusApplied,  bool isGiftDay,  bool isNewUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckInRepsponseDataModel() when $default != null:
return $default(_that.cumulativeStreak,_that.consecutiveDays,_that.bonusApplied,_that.isGiftDay,_that.isNewUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cumulativeStreak,  int consecutiveDays,  bool bonusApplied,  bool isGiftDay,  bool isNewUser)  $default,) {final _that = this;
switch (_that) {
case _CheckInRepsponseDataModel():
return $default(_that.cumulativeStreak,_that.consecutiveDays,_that.bonusApplied,_that.isGiftDay,_that.isNewUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cumulativeStreak,  int consecutiveDays,  bool bonusApplied,  bool isGiftDay,  bool isNewUser)?  $default,) {final _that = this;
switch (_that) {
case _CheckInRepsponseDataModel() when $default != null:
return $default(_that.cumulativeStreak,_that.consecutiveDays,_that.bonusApplied,_that.isGiftDay,_that.isNewUser);case _:
  return null;

}
}

}

/// @nodoc


class _CheckInRepsponseDataModel implements CheckInRepsponseDataModel {
  const _CheckInRepsponseDataModel({required this.cumulativeStreak, required this.consecutiveDays, required this.bonusApplied, required this.isGiftDay, required this.isNewUser});
  

@override final  int cumulativeStreak;
@override final  int consecutiveDays;
@override final  bool bonusApplied;
@override final  bool isGiftDay;
@override final  bool isNewUser;

/// Create a copy of CheckInRepsponseDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInRepsponseDataModelCopyWith<_CheckInRepsponseDataModel> get copyWith => __$CheckInRepsponseDataModelCopyWithImpl<_CheckInRepsponseDataModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInRepsponseDataModel&&(identical(other.cumulativeStreak, cumulativeStreak) || other.cumulativeStreak == cumulativeStreak)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.bonusApplied, bonusApplied) || other.bonusApplied == bonusApplied)&&(identical(other.isGiftDay, isGiftDay) || other.isGiftDay == isGiftDay)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser));
}


@override
int get hashCode => Object.hash(runtimeType,cumulativeStreak,consecutiveDays,bonusApplied,isGiftDay,isNewUser);

@override
String toString() {
  return 'CheckInRepsponseDataModel(cumulativeStreak: $cumulativeStreak, consecutiveDays: $consecutiveDays, bonusApplied: $bonusApplied, isGiftDay: $isGiftDay, isNewUser: $isNewUser)';
}


}

/// @nodoc
abstract mixin class _$CheckInRepsponseDataModelCopyWith<$Res> implements $CheckInRepsponseDataModelCopyWith<$Res> {
  factory _$CheckInRepsponseDataModelCopyWith(_CheckInRepsponseDataModel value, $Res Function(_CheckInRepsponseDataModel) _then) = __$CheckInRepsponseDataModelCopyWithImpl;
@override @useResult
$Res call({
 int cumulativeStreak, int consecutiveDays, bool bonusApplied, bool isGiftDay, bool isNewUser
});




}
/// @nodoc
class __$CheckInRepsponseDataModelCopyWithImpl<$Res>
    implements _$CheckInRepsponseDataModelCopyWith<$Res> {
  __$CheckInRepsponseDataModelCopyWithImpl(this._self, this._then);

  final _CheckInRepsponseDataModel _self;
  final $Res Function(_CheckInRepsponseDataModel) _then;

/// Create a copy of CheckInRepsponseDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cumulativeStreak = null,Object? consecutiveDays = null,Object? bonusApplied = null,Object? isGiftDay = null,Object? isNewUser = null,}) {
  return _then(_CheckInRepsponseDataModel(
cumulativeStreak: null == cumulativeStreak ? _self.cumulativeStreak : cumulativeStreak // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,bonusApplied: null == bonusApplied ? _self.bonusApplied : bonusApplied // ignore: cast_nullable_to_non_nullable
as bool,isGiftDay: null == isGiftDay ? _self.isGiftDay : isGiftDay // ignore: cast_nullable_to_non_nullable
as bool,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
