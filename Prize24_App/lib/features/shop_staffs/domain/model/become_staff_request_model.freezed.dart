// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'become_staff_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BecomeStaffRequestModel {

 String get id; String get shopId; String get shopName; DateTime get requestedAt;
/// Create a copy of BecomeStaffRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BecomeStaffRequestModelCopyWith<BecomeStaffRequestModel> get copyWith => _$BecomeStaffRequestModelCopyWithImpl<BecomeStaffRequestModel>(this as BecomeStaffRequestModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BecomeStaffRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopId,shopName,requestedAt);

@override
String toString() {
  return 'BecomeStaffRequestModel(id: $id, shopId: $shopId, shopName: $shopName, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class $BecomeStaffRequestModelCopyWith<$Res>  {
  factory $BecomeStaffRequestModelCopyWith(BecomeStaffRequestModel value, $Res Function(BecomeStaffRequestModel) _then) = _$BecomeStaffRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, String shopId, String shopName, DateTime requestedAt
});




}
/// @nodoc
class _$BecomeStaffRequestModelCopyWithImpl<$Res>
    implements $BecomeStaffRequestModelCopyWith<$Res> {
  _$BecomeStaffRequestModelCopyWithImpl(this._self, this._then);

  final BecomeStaffRequestModel _self;
  final $Res Function(BecomeStaffRequestModel) _then;

/// Create a copy of BecomeStaffRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shopId = null,Object? shopName = null,Object? requestedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BecomeStaffRequestModel].
extension BecomeStaffRequestModelPatterns on BecomeStaffRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BecomeStaffRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BecomeStaffRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BecomeStaffRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _BecomeStaffRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BecomeStaffRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _BecomeStaffRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String shopId,  String shopName,  DateTime requestedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BecomeStaffRequestModel() when $default != null:
return $default(_that.id,_that.shopId,_that.shopName,_that.requestedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String shopId,  String shopName,  DateTime requestedAt)  $default,) {final _that = this;
switch (_that) {
case _BecomeStaffRequestModel():
return $default(_that.id,_that.shopId,_that.shopName,_that.requestedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String shopId,  String shopName,  DateTime requestedAt)?  $default,) {final _that = this;
switch (_that) {
case _BecomeStaffRequestModel() when $default != null:
return $default(_that.id,_that.shopId,_that.shopName,_that.requestedAt);case _:
  return null;

}
}

}

/// @nodoc


class _BecomeStaffRequestModel implements BecomeStaffRequestModel {
  const _BecomeStaffRequestModel({required this.id, required this.shopId, required this.shopName, required this.requestedAt});
  

@override final  String id;
@override final  String shopId;
@override final  String shopName;
@override final  DateTime requestedAt;

/// Create a copy of BecomeStaffRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BecomeStaffRequestModelCopyWith<_BecomeStaffRequestModel> get copyWith => __$BecomeStaffRequestModelCopyWithImpl<_BecomeStaffRequestModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BecomeStaffRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopId,shopName,requestedAt);

@override
String toString() {
  return 'BecomeStaffRequestModel(id: $id, shopId: $shopId, shopName: $shopName, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class _$BecomeStaffRequestModelCopyWith<$Res> implements $BecomeStaffRequestModelCopyWith<$Res> {
  factory _$BecomeStaffRequestModelCopyWith(_BecomeStaffRequestModel value, $Res Function(_BecomeStaffRequestModel) _then) = __$BecomeStaffRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String shopId, String shopName, DateTime requestedAt
});




}
/// @nodoc
class __$BecomeStaffRequestModelCopyWithImpl<$Res>
    implements _$BecomeStaffRequestModelCopyWith<$Res> {
  __$BecomeStaffRequestModelCopyWithImpl(this._self, this._then);

  final _BecomeStaffRequestModel _self;
  final $Res Function(_BecomeStaffRequestModel) _then;

/// Create a copy of BecomeStaffRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopId = null,Object? shopName = null,Object? requestedAt = null,}) {
  return _then(_BecomeStaffRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
