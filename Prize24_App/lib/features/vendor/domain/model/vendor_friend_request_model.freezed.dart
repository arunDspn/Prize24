// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_friend_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorFriendRequestModel {

 String get id; String get vendorId; String get vendorName; DateTime get createdAt;
/// Create a copy of VendorFriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorFriendRequestModelCopyWith<VendorFriendRequestModel> get copyWith => _$VendorFriendRequestModelCopyWithImpl<VendorFriendRequestModel>(this as VendorFriendRequestModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorFriendRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendorId,vendorName,createdAt);

@override
String toString() {
  return 'VendorFriendRequestModel(id: $id, vendorId: $vendorId, vendorName: $vendorName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $VendorFriendRequestModelCopyWith<$Res>  {
  factory $VendorFriendRequestModelCopyWith(VendorFriendRequestModel value, $Res Function(VendorFriendRequestModel) _then) = _$VendorFriendRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, String vendorId, String vendorName, DateTime createdAt
});




}
/// @nodoc
class _$VendorFriendRequestModelCopyWithImpl<$Res>
    implements $VendorFriendRequestModelCopyWith<$Res> {
  _$VendorFriendRequestModelCopyWithImpl(this._self, this._then);

  final VendorFriendRequestModel _self;
  final $Res Function(VendorFriendRequestModel) _then;

/// Create a copy of VendorFriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vendorId = null,Object? vendorName = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorFriendRequestModel].
extension VendorFriendRequestModelPatterns on VendorFriendRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorFriendRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorFriendRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorFriendRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _VendorFriendRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorFriendRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _VendorFriendRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String vendorId,  String vendorName,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorFriendRequestModel() when $default != null:
return $default(_that.id,_that.vendorId,_that.vendorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String vendorId,  String vendorName,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _VendorFriendRequestModel():
return $default(_that.id,_that.vendorId,_that.vendorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String vendorId,  String vendorName,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _VendorFriendRequestModel() when $default != null:
return $default(_that.id,_that.vendorId,_that.vendorName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _VendorFriendRequestModel implements VendorFriendRequestModel {
  const _VendorFriendRequestModel({required this.id, required this.vendorId, required this.vendorName, required this.createdAt});
  

@override final  String id;
@override final  String vendorId;
@override final  String vendorName;
@override final  DateTime createdAt;

/// Create a copy of VendorFriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorFriendRequestModelCopyWith<_VendorFriendRequestModel> get copyWith => __$VendorFriendRequestModelCopyWithImpl<_VendorFriendRequestModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorFriendRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendorId,vendorName,createdAt);

@override
String toString() {
  return 'VendorFriendRequestModel(id: $id, vendorId: $vendorId, vendorName: $vendorName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$VendorFriendRequestModelCopyWith<$Res> implements $VendorFriendRequestModelCopyWith<$Res> {
  factory _$VendorFriendRequestModelCopyWith(_VendorFriendRequestModel value, $Res Function(_VendorFriendRequestModel) _then) = __$VendorFriendRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String vendorId, String vendorName, DateTime createdAt
});




}
/// @nodoc
class __$VendorFriendRequestModelCopyWithImpl<$Res>
    implements _$VendorFriendRequestModelCopyWith<$Res> {
  __$VendorFriendRequestModelCopyWithImpl(this._self, this._then);

  final _VendorFriendRequestModel _self;
  final $Res Function(_VendorFriendRequestModel) _then;

/// Create a copy of VendorFriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vendorId = null,Object? vendorName = null,Object? createdAt = null,}) {
  return _then(_VendorFriendRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
