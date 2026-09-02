// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_staff_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopStaffDto {

 String? get staffId; String get staffName;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get addedAt; String? get staffPhone;
/// Create a copy of ShopStaffDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopStaffDtoCopyWith<ShopStaffDto> get copyWith => _$ShopStaffDtoCopyWithImpl<ShopStaffDto>(this as ShopStaffDto, _$identity);

  /// Serializes this ShopStaffDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopStaffDto&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt)&&(identical(other.staffPhone, staffPhone) || other.staffPhone == staffPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staffId,staffName,addedAt,staffPhone);

@override
String toString() {
  return 'ShopStaffDto(staffId: $staffId, staffName: $staffName, addedAt: $addedAt, staffPhone: $staffPhone)';
}


}

/// @nodoc
abstract mixin class $ShopStaffDtoCopyWith<$Res>  {
  factory $ShopStaffDtoCopyWith(ShopStaffDto value, $Res Function(ShopStaffDto) _then) = _$ShopStaffDtoCopyWithImpl;
@useResult
$Res call({
 String? staffId, String staffName,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp addedAt, String? staffPhone
});




}
/// @nodoc
class _$ShopStaffDtoCopyWithImpl<$Res>
    implements $ShopStaffDtoCopyWith<$Res> {
  _$ShopStaffDtoCopyWithImpl(this._self, this._then);

  final ShopStaffDto _self;
  final $Res Function(ShopStaffDto) _then;

/// Create a copy of ShopStaffDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? staffId = freezed,Object? staffName = null,Object? addedAt = null,Object? staffPhone = freezed,}) {
  return _then(_self.copyWith(
staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as String?,staffName: null == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,staffPhone: freezed == staffPhone ? _self.staffPhone : staffPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopStaffDto].
extension ShopStaffDtoPatterns on ShopStaffDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopStaffDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopStaffDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopStaffDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopStaffDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopStaffDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopStaffDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? staffId,  String staffName, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp addedAt,  String? staffPhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopStaffDto() when $default != null:
return $default(_that.staffId,_that.staffName,_that.addedAt,_that.staffPhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? staffId,  String staffName, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp addedAt,  String? staffPhone)  $default,) {final _that = this;
switch (_that) {
case _ShopStaffDto():
return $default(_that.staffId,_that.staffName,_that.addedAt,_that.staffPhone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? staffId,  String staffName, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp addedAt,  String? staffPhone)?  $default,) {final _that = this;
switch (_that) {
case _ShopStaffDto() when $default != null:
return $default(_that.staffId,_that.staffName,_that.addedAt,_that.staffPhone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopStaffDto extends ShopStaffDto {
  const _ShopStaffDto({this.staffId, required this.staffName, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.addedAt, this.staffPhone}): super._();
  factory _ShopStaffDto.fromJson(Map<String, dynamic> json) => _$ShopStaffDtoFromJson(json);

@override final  String? staffId;
@override final  String staffName;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp addedAt;
@override final  String? staffPhone;

/// Create a copy of ShopStaffDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopStaffDtoCopyWith<_ShopStaffDto> get copyWith => __$ShopStaffDtoCopyWithImpl<_ShopStaffDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopStaffDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopStaffDto&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt)&&(identical(other.staffPhone, staffPhone) || other.staffPhone == staffPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staffId,staffName,addedAt,staffPhone);

@override
String toString() {
  return 'ShopStaffDto(staffId: $staffId, staffName: $staffName, addedAt: $addedAt, staffPhone: $staffPhone)';
}


}

/// @nodoc
abstract mixin class _$ShopStaffDtoCopyWith<$Res> implements $ShopStaffDtoCopyWith<$Res> {
  factory _$ShopStaffDtoCopyWith(_ShopStaffDto value, $Res Function(_ShopStaffDto) _then) = __$ShopStaffDtoCopyWithImpl;
@override @useResult
$Res call({
 String? staffId, String staffName,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp addedAt, String? staffPhone
});




}
/// @nodoc
class __$ShopStaffDtoCopyWithImpl<$Res>
    implements _$ShopStaffDtoCopyWith<$Res> {
  __$ShopStaffDtoCopyWithImpl(this._self, this._then);

  final _ShopStaffDto _self;
  final $Res Function(_ShopStaffDto) _then;

/// Create a copy of ShopStaffDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? staffId = freezed,Object? staffName = null,Object? addedAt = null,Object? staffPhone = freezed,}) {
  return _then(_ShopStaffDto(
staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as String?,staffName: null == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,staffPhone: freezed == staffPhone ? _self.staffPhone : staffPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
