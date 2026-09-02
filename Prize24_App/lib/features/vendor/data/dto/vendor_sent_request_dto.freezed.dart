// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_sent_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VendorSentRequestDto {

 String get id; String get receiverId; String get receiverName; DateTime get createdAt; String get status;
/// Create a copy of VendorSentRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorSentRequestDtoCopyWith<VendorSentRequestDto> get copyWith => _$VendorSentRequestDtoCopyWithImpl<VendorSentRequestDto>(this as VendorSentRequestDto, _$identity);

  /// Serializes this VendorSentRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorSentRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,receiverId,receiverName,createdAt,status);

@override
String toString() {
  return 'VendorSentRequestDto(id: $id, receiverId: $receiverId, receiverName: $receiverName, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $VendorSentRequestDtoCopyWith<$Res>  {
  factory $VendorSentRequestDtoCopyWith(VendorSentRequestDto value, $Res Function(VendorSentRequestDto) _then) = _$VendorSentRequestDtoCopyWithImpl;
@useResult
$Res call({
 String id, String receiverId, String receiverName, DateTime createdAt, String status
});




}
/// @nodoc
class _$VendorSentRequestDtoCopyWithImpl<$Res>
    implements $VendorSentRequestDtoCopyWith<$Res> {
  _$VendorSentRequestDtoCopyWithImpl(this._self, this._then);

  final VendorSentRequestDto _self;
  final $Res Function(VendorSentRequestDto) _then;

/// Create a copy of VendorSentRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? receiverId = null,Object? receiverName = null,Object? createdAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,receiverName: null == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorSentRequestDto].
extension VendorSentRequestDtoPatterns on VendorSentRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorSentRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorSentRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorSentRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _VendorSentRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorSentRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _VendorSentRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String receiverId,  String receiverName,  DateTime createdAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorSentRequestDto() when $default != null:
return $default(_that.id,_that.receiverId,_that.receiverName,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String receiverId,  String receiverName,  DateTime createdAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _VendorSentRequestDto():
return $default(_that.id,_that.receiverId,_that.receiverName,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String receiverId,  String receiverName,  DateTime createdAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _VendorSentRequestDto() when $default != null:
return $default(_that.id,_that.receiverId,_that.receiverName,_that.createdAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VendorSentRequestDto extends VendorSentRequestDto {
  const _VendorSentRequestDto({required this.id, required this.receiverId, required this.receiverName, required this.createdAt, required this.status}): super._();
  factory _VendorSentRequestDto.fromJson(Map<String, dynamic> json) => _$VendorSentRequestDtoFromJson(json);

@override final  String id;
@override final  String receiverId;
@override final  String receiverName;
@override final  DateTime createdAt;
@override final  String status;

/// Create a copy of VendorSentRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorSentRequestDtoCopyWith<_VendorSentRequestDto> get copyWith => __$VendorSentRequestDtoCopyWithImpl<_VendorSentRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VendorSentRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorSentRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,receiverId,receiverName,createdAt,status);

@override
String toString() {
  return 'VendorSentRequestDto(id: $id, receiverId: $receiverId, receiverName: $receiverName, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$VendorSentRequestDtoCopyWith<$Res> implements $VendorSentRequestDtoCopyWith<$Res> {
  factory _$VendorSentRequestDtoCopyWith(_VendorSentRequestDto value, $Res Function(_VendorSentRequestDto) _then) = __$VendorSentRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String receiverId, String receiverName, DateTime createdAt, String status
});




}
/// @nodoc
class __$VendorSentRequestDtoCopyWithImpl<$Res>
    implements _$VendorSentRequestDtoCopyWith<$Res> {
  __$VendorSentRequestDtoCopyWithImpl(this._self, this._then);

  final _VendorSentRequestDto _self;
  final $Res Function(_VendorSentRequestDto) _then;

/// Create a copy of VendorSentRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? receiverId = null,Object? receiverName = null,Object? createdAt = null,Object? status = null,}) {
  return _then(_VendorSentRequestDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,receiverName: null == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
