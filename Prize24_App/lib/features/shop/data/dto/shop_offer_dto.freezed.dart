// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_offer_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopOfferDto {

@JsonKey(name: 'offerId') String get id; String get name; String get description;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get startDate;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get endDate;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get createdAt;
/// Create a copy of ShopOfferDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopOfferDtoCopyWith<ShopOfferDto> get copyWith => _$ShopOfferDtoCopyWithImpl<ShopOfferDto>(this as ShopOfferDto, _$identity);

  /// Serializes this ShopOfferDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopOfferDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,startDate,endDate,createdAt);

@override
String toString() {
  return 'ShopOfferDto(id: $id, name: $name, description: $description, startDate: $startDate, endDate: $endDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ShopOfferDtoCopyWith<$Res>  {
  factory $ShopOfferDtoCopyWith(ShopOfferDto value, $Res Function(ShopOfferDto) _then) = _$ShopOfferDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'offerId') String id, String name, String description,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp startDate,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp endDate,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp createdAt
});




}
/// @nodoc
class _$ShopOfferDtoCopyWithImpl<$Res>
    implements $ShopOfferDtoCopyWith<$Res> {
  _$ShopOfferDtoCopyWithImpl(this._self, this._then);

  final ShopOfferDto _self;
  final $Res Function(ShopOfferDto) _then;

/// Create a copy of ShopOfferDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? startDate = null,Object? endDate = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as Timestamp,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as Timestamp,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopOfferDto].
extension ShopOfferDtoPatterns on ShopOfferDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopOfferDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopOfferDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopOfferDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopOfferDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopOfferDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopOfferDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'offerId')  String id,  String name,  String description, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp startDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp endDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopOfferDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.startDate,_that.endDate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'offerId')  String id,  String name,  String description, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp startDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp endDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp createdAt)  $default,) {final _that = this;
switch (_that) {
case _ShopOfferDto():
return $default(_that.id,_that.name,_that.description,_that.startDate,_that.endDate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'offerId')  String id,  String name,  String description, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp startDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp endDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ShopOfferDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.startDate,_that.endDate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopOfferDto extends ShopOfferDto {
  const _ShopOfferDto({@JsonKey(name: 'offerId') required this.id, required this.name, required this.description, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.startDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.endDate, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.createdAt}): super._();
  factory _ShopOfferDto.fromJson(Map<String, dynamic> json) => _$ShopOfferDtoFromJson(json);

@override@JsonKey(name: 'offerId') final  String id;
@override final  String name;
@override final  String description;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp startDate;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp endDate;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp createdAt;

/// Create a copy of ShopOfferDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopOfferDtoCopyWith<_ShopOfferDto> get copyWith => __$ShopOfferDtoCopyWithImpl<_ShopOfferDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopOfferDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopOfferDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,startDate,endDate,createdAt);

@override
String toString() {
  return 'ShopOfferDto(id: $id, name: $name, description: $description, startDate: $startDate, endDate: $endDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ShopOfferDtoCopyWith<$Res> implements $ShopOfferDtoCopyWith<$Res> {
  factory _$ShopOfferDtoCopyWith(_ShopOfferDto value, $Res Function(_ShopOfferDto) _then) = __$ShopOfferDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'offerId') String id, String name, String description,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp startDate,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp endDate,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp createdAt
});




}
/// @nodoc
class __$ShopOfferDtoCopyWithImpl<$Res>
    implements _$ShopOfferDtoCopyWith<$Res> {
  __$ShopOfferDtoCopyWithImpl(this._self, this._then);

  final _ShopOfferDto _self;
  final $Res Function(_ShopOfferDto) _then;

/// Create a copy of ShopOfferDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? startDate = null,Object? endDate = null,Object? createdAt = null,}) {
  return _then(_ShopOfferDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as Timestamp,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as Timestamp,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
