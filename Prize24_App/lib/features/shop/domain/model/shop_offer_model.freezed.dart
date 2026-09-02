// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_offer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopOfferModel {

 String get id; String get name; String get description; DateTime get startDate; DateTime get endDate; DateTime get createdAt;
/// Create a copy of ShopOfferModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopOfferModelCopyWith<ShopOfferModel> get copyWith => _$ShopOfferModelCopyWithImpl<ShopOfferModel>(this as ShopOfferModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopOfferModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,startDate,endDate,createdAt);

@override
String toString() {
  return 'ShopOfferModel(id: $id, name: $name, description: $description, startDate: $startDate, endDate: $endDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ShopOfferModelCopyWith<$Res>  {
  factory $ShopOfferModelCopyWith(ShopOfferModel value, $Res Function(ShopOfferModel) _then) = _$ShopOfferModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, DateTime startDate, DateTime endDate, DateTime createdAt
});




}
/// @nodoc
class _$ShopOfferModelCopyWithImpl<$Res>
    implements $ShopOfferModelCopyWith<$Res> {
  _$ShopOfferModelCopyWithImpl(this._self, this._then);

  final ShopOfferModel _self;
  final $Res Function(ShopOfferModel) _then;

/// Create a copy of ShopOfferModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? startDate = null,Object? endDate = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopOfferModel].
extension ShopOfferModelPatterns on ShopOfferModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopOfferModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopOfferModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopOfferModel value)  $default,){
final _that = this;
switch (_that) {
case _ShopOfferModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopOfferModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShopOfferModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  DateTime startDate,  DateTime endDate,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopOfferModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  DateTime startDate,  DateTime endDate,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ShopOfferModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  DateTime startDate,  DateTime endDate,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ShopOfferModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.startDate,_that.endDate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _ShopOfferModel implements ShopOfferModel {
  const _ShopOfferModel({required this.id, required this.name, required this.description, required this.startDate, required this.endDate, required this.createdAt});
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  DateTime createdAt;

/// Create a copy of ShopOfferModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopOfferModelCopyWith<_ShopOfferModel> get copyWith => __$ShopOfferModelCopyWithImpl<_ShopOfferModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopOfferModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,startDate,endDate,createdAt);

@override
String toString() {
  return 'ShopOfferModel(id: $id, name: $name, description: $description, startDate: $startDate, endDate: $endDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ShopOfferModelCopyWith<$Res> implements $ShopOfferModelCopyWith<$Res> {
  factory _$ShopOfferModelCopyWith(_ShopOfferModel value, $Res Function(_ShopOfferModel) _then) = __$ShopOfferModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, DateTime startDate, DateTime endDate, DateTime createdAt
});




}
/// @nodoc
class __$ShopOfferModelCopyWithImpl<$Res>
    implements _$ShopOfferModelCopyWith<$Res> {
  __$ShopOfferModelCopyWithImpl(this._self, this._then);

  final _ShopOfferModel _self;
  final $Res Function(_ShopOfferModel) _then;

/// Create a copy of ShopOfferModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? startDate = null,Object? endDate = null,Object? createdAt = null,}) {
  return _then(_ShopOfferModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
