// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_avail_reponse_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScanAvailReponseModel {

 bool get success; ScanAvailReponseErrorModel? get error; ScanAvailResponseDataModel? get data;
/// Create a copy of ScanAvailReponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanAvailReponseModelCopyWith<ScanAvailReponseModel> get copyWith => _$ScanAvailReponseModelCopyWithImpl<ScanAvailReponseModel>(this as ScanAvailReponseModel, _$identity);

  /// Serializes this ScanAvailReponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanAvailReponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.error, error) || other.error == error)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,error,data);

@override
String toString() {
  return 'ScanAvailReponseModel(success: $success, error: $error, data: $data)';
}


}

/// @nodoc
abstract mixin class $ScanAvailReponseModelCopyWith<$Res>  {
  factory $ScanAvailReponseModelCopyWith(ScanAvailReponseModel value, $Res Function(ScanAvailReponseModel) _then) = _$ScanAvailReponseModelCopyWithImpl;
@useResult
$Res call({
 bool success, ScanAvailReponseErrorModel? error, ScanAvailResponseDataModel? data
});


$ScanAvailReponseErrorModelCopyWith<$Res>? get error;$ScanAvailResponseDataModelCopyWith<$Res>? get data;

}
/// @nodoc
class _$ScanAvailReponseModelCopyWithImpl<$Res>
    implements $ScanAvailReponseModelCopyWith<$Res> {
  _$ScanAvailReponseModelCopyWithImpl(this._self, this._then);

  final ScanAvailReponseModel _self;
  final $Res Function(ScanAvailReponseModel) _then;

/// Create a copy of ScanAvailReponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? error = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ScanAvailReponseErrorModel?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ScanAvailResponseDataModel?,
  ));
}
/// Create a copy of ScanAvailReponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanAvailReponseErrorModelCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ScanAvailReponseErrorModelCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of ScanAvailReponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanAvailResponseDataModelCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ScanAvailResponseDataModelCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScanAvailReponseModel].
extension ScanAvailReponseModelPatterns on ScanAvailReponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanAvailReponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanAvailReponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanAvailReponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ScanAvailReponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanAvailReponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ScanAvailReponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  ScanAvailReponseErrorModel? error,  ScanAvailResponseDataModel? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanAvailReponseModel() when $default != null:
return $default(_that.success,_that.error,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  ScanAvailReponseErrorModel? error,  ScanAvailResponseDataModel? data)  $default,) {final _that = this;
switch (_that) {
case _ScanAvailReponseModel():
return $default(_that.success,_that.error,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  ScanAvailReponseErrorModel? error,  ScanAvailResponseDataModel? data)?  $default,) {final _that = this;
switch (_that) {
case _ScanAvailReponseModel() when $default != null:
return $default(_that.success,_that.error,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanAvailReponseModel implements ScanAvailReponseModel {
  const _ScanAvailReponseModel({required this.success, this.error, this.data});
  factory _ScanAvailReponseModel.fromJson(Map<String, dynamic> json) => _$ScanAvailReponseModelFromJson(json);

@override final  bool success;
@override final  ScanAvailReponseErrorModel? error;
@override final  ScanAvailResponseDataModel? data;

/// Create a copy of ScanAvailReponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanAvailReponseModelCopyWith<_ScanAvailReponseModel> get copyWith => __$ScanAvailReponseModelCopyWithImpl<_ScanAvailReponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanAvailReponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanAvailReponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.error, error) || other.error == error)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,error,data);

@override
String toString() {
  return 'ScanAvailReponseModel(success: $success, error: $error, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ScanAvailReponseModelCopyWith<$Res> implements $ScanAvailReponseModelCopyWith<$Res> {
  factory _$ScanAvailReponseModelCopyWith(_ScanAvailReponseModel value, $Res Function(_ScanAvailReponseModel) _then) = __$ScanAvailReponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, ScanAvailReponseErrorModel? error, ScanAvailResponseDataModel? data
});


@override $ScanAvailReponseErrorModelCopyWith<$Res>? get error;@override $ScanAvailResponseDataModelCopyWith<$Res>? get data;

}
/// @nodoc
class __$ScanAvailReponseModelCopyWithImpl<$Res>
    implements _$ScanAvailReponseModelCopyWith<$Res> {
  __$ScanAvailReponseModelCopyWithImpl(this._self, this._then);

  final _ScanAvailReponseModel _self;
  final $Res Function(_ScanAvailReponseModel) _then;

/// Create a copy of ScanAvailReponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? error = freezed,Object? data = freezed,}) {
  return _then(_ScanAvailReponseModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ScanAvailReponseErrorModel?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ScanAvailResponseDataModel?,
  ));
}

/// Create a copy of ScanAvailReponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanAvailReponseErrorModelCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ScanAvailReponseErrorModelCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of ScanAvailReponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanAvailResponseDataModelCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ScanAvailResponseDataModelCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ScanAvailReponseErrorModel {

 String get code; String get message;
/// Create a copy of ScanAvailReponseErrorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanAvailReponseErrorModelCopyWith<ScanAvailReponseErrorModel> get copyWith => _$ScanAvailReponseErrorModelCopyWithImpl<ScanAvailReponseErrorModel>(this as ScanAvailReponseErrorModel, _$identity);

  /// Serializes this ScanAvailReponseErrorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanAvailReponseErrorModel&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ScanAvailReponseErrorModel(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ScanAvailReponseErrorModelCopyWith<$Res>  {
  factory $ScanAvailReponseErrorModelCopyWith(ScanAvailReponseErrorModel value, $Res Function(ScanAvailReponseErrorModel) _then) = _$ScanAvailReponseErrorModelCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ScanAvailReponseErrorModelCopyWithImpl<$Res>
    implements $ScanAvailReponseErrorModelCopyWith<$Res> {
  _$ScanAvailReponseErrorModelCopyWithImpl(this._self, this._then);

  final ScanAvailReponseErrorModel _self;
  final $Res Function(ScanAvailReponseErrorModel) _then;

/// Create a copy of ScanAvailReponseErrorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanAvailReponseErrorModel].
extension ScanAvailReponseErrorModelPatterns on ScanAvailReponseErrorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanAvailReponseErrorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanAvailReponseErrorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanAvailReponseErrorModel value)  $default,){
final _that = this;
switch (_that) {
case _ScanAvailReponseErrorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanAvailReponseErrorModel value)?  $default,){
final _that = this;
switch (_that) {
case _ScanAvailReponseErrorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanAvailReponseErrorModel() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message)  $default,) {final _that = this;
switch (_that) {
case _ScanAvailReponseErrorModel():
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ScanAvailReponseErrorModel() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanAvailReponseErrorModel implements ScanAvailReponseErrorModel {
  const _ScanAvailReponseErrorModel({required this.code, required this.message});
  factory _ScanAvailReponseErrorModel.fromJson(Map<String, dynamic> json) => _$ScanAvailReponseErrorModelFromJson(json);

@override final  String code;
@override final  String message;

/// Create a copy of ScanAvailReponseErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanAvailReponseErrorModelCopyWith<_ScanAvailReponseErrorModel> get copyWith => __$ScanAvailReponseErrorModelCopyWithImpl<_ScanAvailReponseErrorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanAvailReponseErrorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanAvailReponseErrorModel&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ScanAvailReponseErrorModel(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ScanAvailReponseErrorModelCopyWith<$Res> implements $ScanAvailReponseErrorModelCopyWith<$Res> {
  factory _$ScanAvailReponseErrorModelCopyWith(_ScanAvailReponseErrorModel value, $Res Function(_ScanAvailReponseErrorModel) _then) = __$ScanAvailReponseErrorModelCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$ScanAvailReponseErrorModelCopyWithImpl<$Res>
    implements _$ScanAvailReponseErrorModelCopyWith<$Res> {
  __$ScanAvailReponseErrorModelCopyWithImpl(this._self, this._then);

  final _ScanAvailReponseErrorModel _self;
  final $Res Function(_ScanAvailReponseErrorModel) _then;

/// Create a copy of ScanAvailReponseErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_ScanAvailReponseErrorModel(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ScanAvailResponseDataModel {

 bool get isRedeemable; String get giftName; String get giftDescription; String get redemptionId;
/// Create a copy of ScanAvailResponseDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanAvailResponseDataModelCopyWith<ScanAvailResponseDataModel> get copyWith => _$ScanAvailResponseDataModelCopyWithImpl<ScanAvailResponseDataModel>(this as ScanAvailResponseDataModel, _$identity);

  /// Serializes this ScanAvailResponseDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanAvailResponseDataModel&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.giftDescription, giftDescription) || other.giftDescription == giftDescription)&&(identical(other.redemptionId, redemptionId) || other.redemptionId == redemptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isRedeemable,giftName,giftDescription,redemptionId);

@override
String toString() {
  return 'ScanAvailResponseDataModel(isRedeemable: $isRedeemable, giftName: $giftName, giftDescription: $giftDescription, redemptionId: $redemptionId)';
}


}

/// @nodoc
abstract mixin class $ScanAvailResponseDataModelCopyWith<$Res>  {
  factory $ScanAvailResponseDataModelCopyWith(ScanAvailResponseDataModel value, $Res Function(ScanAvailResponseDataModel) _then) = _$ScanAvailResponseDataModelCopyWithImpl;
@useResult
$Res call({
 bool isRedeemable, String giftName, String giftDescription, String redemptionId
});




}
/// @nodoc
class _$ScanAvailResponseDataModelCopyWithImpl<$Res>
    implements $ScanAvailResponseDataModelCopyWith<$Res> {
  _$ScanAvailResponseDataModelCopyWithImpl(this._self, this._then);

  final ScanAvailResponseDataModel _self;
  final $Res Function(ScanAvailResponseDataModel) _then;

/// Create a copy of ScanAvailResponseDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isRedeemable = null,Object? giftName = null,Object? giftDescription = null,Object? redemptionId = null,}) {
  return _then(_self.copyWith(
isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,giftDescription: null == giftDescription ? _self.giftDescription : giftDescription // ignore: cast_nullable_to_non_nullable
as String,redemptionId: null == redemptionId ? _self.redemptionId : redemptionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanAvailResponseDataModel].
extension ScanAvailResponseDataModelPatterns on ScanAvailResponseDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanAvailResponseDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanAvailResponseDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanAvailResponseDataModel value)  $default,){
final _that = this;
switch (_that) {
case _ScanAvailResponseDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanAvailResponseDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _ScanAvailResponseDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isRedeemable,  String giftName,  String giftDescription,  String redemptionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanAvailResponseDataModel() when $default != null:
return $default(_that.isRedeemable,_that.giftName,_that.giftDescription,_that.redemptionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isRedeemable,  String giftName,  String giftDescription,  String redemptionId)  $default,) {final _that = this;
switch (_that) {
case _ScanAvailResponseDataModel():
return $default(_that.isRedeemable,_that.giftName,_that.giftDescription,_that.redemptionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isRedeemable,  String giftName,  String giftDescription,  String redemptionId)?  $default,) {final _that = this;
switch (_that) {
case _ScanAvailResponseDataModel() when $default != null:
return $default(_that.isRedeemable,_that.giftName,_that.giftDescription,_that.redemptionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanAvailResponseDataModel implements ScanAvailResponseDataModel {
  const _ScanAvailResponseDataModel({required this.isRedeemable, required this.giftName, required this.giftDescription, required this.redemptionId});
  factory _ScanAvailResponseDataModel.fromJson(Map<String, dynamic> json) => _$ScanAvailResponseDataModelFromJson(json);

@override final  bool isRedeemable;
@override final  String giftName;
@override final  String giftDescription;
@override final  String redemptionId;

/// Create a copy of ScanAvailResponseDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanAvailResponseDataModelCopyWith<_ScanAvailResponseDataModel> get copyWith => __$ScanAvailResponseDataModelCopyWithImpl<_ScanAvailResponseDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanAvailResponseDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanAvailResponseDataModel&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.giftDescription, giftDescription) || other.giftDescription == giftDescription)&&(identical(other.redemptionId, redemptionId) || other.redemptionId == redemptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isRedeemable,giftName,giftDescription,redemptionId);

@override
String toString() {
  return 'ScanAvailResponseDataModel(isRedeemable: $isRedeemable, giftName: $giftName, giftDescription: $giftDescription, redemptionId: $redemptionId)';
}


}

/// @nodoc
abstract mixin class _$ScanAvailResponseDataModelCopyWith<$Res> implements $ScanAvailResponseDataModelCopyWith<$Res> {
  factory _$ScanAvailResponseDataModelCopyWith(_ScanAvailResponseDataModel value, $Res Function(_ScanAvailResponseDataModel) _then) = __$ScanAvailResponseDataModelCopyWithImpl;
@override @useResult
$Res call({
 bool isRedeemable, String giftName, String giftDescription, String redemptionId
});




}
/// @nodoc
class __$ScanAvailResponseDataModelCopyWithImpl<$Res>
    implements _$ScanAvailResponseDataModelCopyWith<$Res> {
  __$ScanAvailResponseDataModelCopyWithImpl(this._self, this._then);

  final _ScanAvailResponseDataModel _self;
  final $Res Function(_ScanAvailResponseDataModel) _then;

/// Create a copy of ScanAvailResponseDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isRedeemable = null,Object? giftName = null,Object? giftDescription = null,Object? redemptionId = null,}) {
  return _then(_ScanAvailResponseDataModel(
isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,giftDescription: null == giftDescription ? _self.giftDescription : giftDescription // ignore: cast_nullable_to_non_nullable
as String,redemptionId: null == redemptionId ? _self.redemptionId : redemptionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
