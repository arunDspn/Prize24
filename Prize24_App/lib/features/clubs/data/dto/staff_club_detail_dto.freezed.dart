// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_club_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StaffClubDetailDto {

 String get id; String get name; String get description;@JsonKey(name: 'giftDay') int get giftDayCycle;@JsonKey(name: 'campaignId') String get campaignId;
/// Create a copy of StaffClubDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffClubDetailDtoCopyWith<StaffClubDetailDto> get copyWith => _$StaffClubDetailDtoCopyWithImpl<StaffClubDetailDto>(this as StaffClubDetailDto, _$identity);

  /// Serializes this StaffClubDetailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffClubDetailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDayCycle, giftDayCycle) || other.giftDayCycle == giftDayCycle)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,giftDayCycle,campaignId);

@override
String toString() {
  return 'StaffClubDetailDto(id: $id, name: $name, description: $description, giftDayCycle: $giftDayCycle, campaignId: $campaignId)';
}


}

/// @nodoc
abstract mixin class $StaffClubDetailDtoCopyWith<$Res>  {
  factory $StaffClubDetailDtoCopyWith(StaffClubDetailDto value, $Res Function(StaffClubDetailDto) _then) = _$StaffClubDetailDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description,@JsonKey(name: 'giftDay') int giftDayCycle,@JsonKey(name: 'campaignId') String campaignId
});




}
/// @nodoc
class _$StaffClubDetailDtoCopyWithImpl<$Res>
    implements $StaffClubDetailDtoCopyWith<$Res> {
  _$StaffClubDetailDtoCopyWithImpl(this._self, this._then);

  final StaffClubDetailDto _self;
  final $Res Function(StaffClubDetailDto) _then;

/// Create a copy of StaffClubDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? giftDayCycle = null,Object? campaignId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDayCycle: null == giftDayCycle ? _self.giftDayCycle : giftDayCycle // ignore: cast_nullable_to_non_nullable
as int,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffClubDetailDto].
extension StaffClubDetailDtoPatterns on StaffClubDetailDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffClubDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffClubDetailDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffClubDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _StaffClubDetailDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffClubDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _StaffClubDetailDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description, @JsonKey(name: 'giftDay')  int giftDayCycle, @JsonKey(name: 'campaignId')  String campaignId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffClubDetailDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.giftDayCycle,_that.campaignId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description, @JsonKey(name: 'giftDay')  int giftDayCycle, @JsonKey(name: 'campaignId')  String campaignId)  $default,) {final _that = this;
switch (_that) {
case _StaffClubDetailDto():
return $default(_that.id,_that.name,_that.description,_that.giftDayCycle,_that.campaignId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description, @JsonKey(name: 'giftDay')  int giftDayCycle, @JsonKey(name: 'campaignId')  String campaignId)?  $default,) {final _that = this;
switch (_that) {
case _StaffClubDetailDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.giftDayCycle,_that.campaignId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StaffClubDetailDto extends StaffClubDetailDto {
  const _StaffClubDetailDto({this.id = '', required this.name, required this.description, @JsonKey(name: 'giftDay') required this.giftDayCycle, @JsonKey(name: 'campaignId') required this.campaignId}): super._();
  factory _StaffClubDetailDto.fromJson(Map<String, dynamic> json) => _$StaffClubDetailDtoFromJson(json);

@override@JsonKey() final  String id;
@override final  String name;
@override final  String description;
@override@JsonKey(name: 'giftDay') final  int giftDayCycle;
@override@JsonKey(name: 'campaignId') final  String campaignId;

/// Create a copy of StaffClubDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffClubDetailDtoCopyWith<_StaffClubDetailDto> get copyWith => __$StaffClubDetailDtoCopyWithImpl<_StaffClubDetailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffClubDetailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffClubDetailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDayCycle, giftDayCycle) || other.giftDayCycle == giftDayCycle)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,giftDayCycle,campaignId);

@override
String toString() {
  return 'StaffClubDetailDto(id: $id, name: $name, description: $description, giftDayCycle: $giftDayCycle, campaignId: $campaignId)';
}


}

/// @nodoc
abstract mixin class _$StaffClubDetailDtoCopyWith<$Res> implements $StaffClubDetailDtoCopyWith<$Res> {
  factory _$StaffClubDetailDtoCopyWith(_StaffClubDetailDto value, $Res Function(_StaffClubDetailDto) _then) = __$StaffClubDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description,@JsonKey(name: 'giftDay') int giftDayCycle,@JsonKey(name: 'campaignId') String campaignId
});




}
/// @nodoc
class __$StaffClubDetailDtoCopyWithImpl<$Res>
    implements _$StaffClubDetailDtoCopyWith<$Res> {
  __$StaffClubDetailDtoCopyWithImpl(this._self, this._then);

  final _StaffClubDetailDto _self;
  final $Res Function(_StaffClubDetailDto) _then;

/// Create a copy of StaffClubDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? giftDayCycle = null,Object? campaignId = null,}) {
  return _then(_StaffClubDetailDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDayCycle: null == giftDayCycle ? _self.giftDayCycle : giftDayCycle // ignore: cast_nullable_to_non_nullable
as int,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
