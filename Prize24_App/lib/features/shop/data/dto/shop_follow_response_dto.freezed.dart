// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_follow_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopFollowResponseDto {

 bool get success; String get message; Map<String, dynamic>? get data; String? get error;
/// Create a copy of ShopFollowResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopFollowResponseDtoCopyWith<ShopFollowResponseDto> get copyWith => _$ShopFollowResponseDtoCopyWithImpl<ShopFollowResponseDto>(this as ShopFollowResponseDto, _$identity);

  /// Serializes this ShopFollowResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopFollowResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(data),error);

@override
String toString() {
  return 'ShopFollowResponseDto(success: $success, message: $message, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class $ShopFollowResponseDtoCopyWith<$Res>  {
  factory $ShopFollowResponseDtoCopyWith(ShopFollowResponseDto value, $Res Function(ShopFollowResponseDto) _then) = _$ShopFollowResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool success, String message, Map<String, dynamic>? data, String? error
});




}
/// @nodoc
class _$ShopFollowResponseDtoCopyWithImpl<$Res>
    implements $ShopFollowResponseDtoCopyWith<$Res> {
  _$ShopFollowResponseDtoCopyWithImpl(this._self, this._then);

  final ShopFollowResponseDto _self;
  final $Res Function(ShopFollowResponseDto) _then;

/// Create a copy of ShopFollowResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopFollowResponseDto].
extension ShopFollowResponseDtoPatterns on ShopFollowResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopFollowResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopFollowResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopFollowResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopFollowResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopFollowResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopFollowResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  Map<String, dynamic>? data,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopFollowResponseDto() when $default != null:
return $default(_that.success,_that.message,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  Map<String, dynamic>? data,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ShopFollowResponseDto():
return $default(_that.success,_that.message,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  Map<String, dynamic>? data,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ShopFollowResponseDto() when $default != null:
return $default(_that.success,_that.message,_that.data,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopFollowResponseDto extends ShopFollowResponseDto {
  const _ShopFollowResponseDto({required this.success, required this.message, final  Map<String, dynamic>? data, this.error}): _data = data,super._();
  factory _ShopFollowResponseDto.fromJson(Map<String, dynamic> json) => _$ShopFollowResponseDtoFromJson(json);

@override final  bool success;
@override final  String message;
 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? error;

/// Create a copy of ShopFollowResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopFollowResponseDtoCopyWith<_ShopFollowResponseDto> get copyWith => __$ShopFollowResponseDtoCopyWithImpl<_ShopFollowResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopFollowResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopFollowResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(_data),error);

@override
String toString() {
  return 'ShopFollowResponseDto(success: $success, message: $message, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ShopFollowResponseDtoCopyWith<$Res> implements $ShopFollowResponseDtoCopyWith<$Res> {
  factory _$ShopFollowResponseDtoCopyWith(_ShopFollowResponseDto value, $Res Function(_ShopFollowResponseDto) _then) = __$ShopFollowResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, Map<String, dynamic>? data, String? error
});




}
/// @nodoc
class __$ShopFollowResponseDtoCopyWithImpl<$Res>
    implements _$ShopFollowResponseDtoCopyWith<$Res> {
  __$ShopFollowResponseDtoCopyWithImpl(this._self, this._then);

  final _ShopFollowResponseDto _self;
  final $Res Function(_ShopFollowResponseDto) _then;

/// Create a copy of ShopFollowResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_ShopFollowResponseDto(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
