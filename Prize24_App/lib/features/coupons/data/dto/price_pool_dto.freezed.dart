// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_pool_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PricePoolDto {

 String get prizeName; String get prizeDescription;
/// Create a copy of PricePoolDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricePoolDtoCopyWith<PricePoolDto> get copyWith => _$PricePoolDtoCopyWithImpl<PricePoolDto>(this as PricePoolDto, _$identity);

  /// Serializes this PricePoolDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricePoolDto&&(identical(other.prizeName, prizeName) || other.prizeName == prizeName)&&(identical(other.prizeDescription, prizeDescription) || other.prizeDescription == prizeDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prizeName,prizeDescription);

@override
String toString() {
  return 'PricePoolDto(prizeName: $prizeName, prizeDescription: $prizeDescription)';
}


}

/// @nodoc
abstract mixin class $PricePoolDtoCopyWith<$Res>  {
  factory $PricePoolDtoCopyWith(PricePoolDto value, $Res Function(PricePoolDto) _then) = _$PricePoolDtoCopyWithImpl;
@useResult
$Res call({
 String prizeName, String prizeDescription
});




}
/// @nodoc
class _$PricePoolDtoCopyWithImpl<$Res>
    implements $PricePoolDtoCopyWith<$Res> {
  _$PricePoolDtoCopyWithImpl(this._self, this._then);

  final PricePoolDto _self;
  final $Res Function(PricePoolDto) _then;

/// Create a copy of PricePoolDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prizeName = null,Object? prizeDescription = null,}) {
  return _then(_self.copyWith(
prizeName: null == prizeName ? _self.prizeName : prizeName // ignore: cast_nullable_to_non_nullable
as String,prizeDescription: null == prizeDescription ? _self.prizeDescription : prizeDescription // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PricePoolDto].
extension PricePoolDtoPatterns on PricePoolDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricePoolDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricePoolDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricePoolDto value)  $default,){
final _that = this;
switch (_that) {
case _PricePoolDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricePoolDto value)?  $default,){
final _that = this;
switch (_that) {
case _PricePoolDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String prizeName,  String prizeDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricePoolDto() when $default != null:
return $default(_that.prizeName,_that.prizeDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String prizeName,  String prizeDescription)  $default,) {final _that = this;
switch (_that) {
case _PricePoolDto():
return $default(_that.prizeName,_that.prizeDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String prizeName,  String prizeDescription)?  $default,) {final _that = this;
switch (_that) {
case _PricePoolDto() when $default != null:
return $default(_that.prizeName,_that.prizeDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricePoolDto implements PricePoolDto {
  const _PricePoolDto({required this.prizeName, required this.prizeDescription});
  factory _PricePoolDto.fromJson(Map<String, dynamic> json) => _$PricePoolDtoFromJson(json);

@override final  String prizeName;
@override final  String prizeDescription;

/// Create a copy of PricePoolDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricePoolDtoCopyWith<_PricePoolDto> get copyWith => __$PricePoolDtoCopyWithImpl<_PricePoolDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PricePoolDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricePoolDto&&(identical(other.prizeName, prizeName) || other.prizeName == prizeName)&&(identical(other.prizeDescription, prizeDescription) || other.prizeDescription == prizeDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prizeName,prizeDescription);

@override
String toString() {
  return 'PricePoolDto(prizeName: $prizeName, prizeDescription: $prizeDescription)';
}


}

/// @nodoc
abstract mixin class _$PricePoolDtoCopyWith<$Res> implements $PricePoolDtoCopyWith<$Res> {
  factory _$PricePoolDtoCopyWith(_PricePoolDto value, $Res Function(_PricePoolDto) _then) = __$PricePoolDtoCopyWithImpl;
@override @useResult
$Res call({
 String prizeName, String prizeDescription
});




}
/// @nodoc
class __$PricePoolDtoCopyWithImpl<$Res>
    implements _$PricePoolDtoCopyWith<$Res> {
  __$PricePoolDtoCopyWithImpl(this._self, this._then);

  final _PricePoolDto _self;
  final $Res Function(_PricePoolDto) _then;

/// Create a copy of PricePoolDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prizeName = null,Object? prizeDescription = null,}) {
  return _then(_PricePoolDto(
prizeName: null == prizeName ? _self.prizeName : prizeName // ignore: cast_nullable_to_non_nullable
as String,prizeDescription: null == prizeDescription ? _self.prizeDescription : prizeDescription // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
