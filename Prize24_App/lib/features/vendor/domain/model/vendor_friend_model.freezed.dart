// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_friend_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorFriendModel {

 String get id; String get userId; String get vendorName;
/// Create a copy of VendorFriendModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorFriendModelCopyWith<VendorFriendModel> get copyWith => _$VendorFriendModelCopyWithImpl<VendorFriendModel>(this as VendorFriendModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorFriendModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,vendorName);

@override
String toString() {
  return 'VendorFriendModel(id: $id, userId: $userId, vendorName: $vendorName)';
}


}

/// @nodoc
abstract mixin class $VendorFriendModelCopyWith<$Res>  {
  factory $VendorFriendModelCopyWith(VendorFriendModel value, $Res Function(VendorFriendModel) _then) = _$VendorFriendModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String vendorName
});




}
/// @nodoc
class _$VendorFriendModelCopyWithImpl<$Res>
    implements $VendorFriendModelCopyWith<$Res> {
  _$VendorFriendModelCopyWithImpl(this._self, this._then);

  final VendorFriendModel _self;
  final $Res Function(VendorFriendModel) _then;

/// Create a copy of VendorFriendModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? vendorName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorFriendModel].
extension VendorFriendModelPatterns on VendorFriendModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorFriendModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorFriendModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorFriendModel value)  $default,){
final _that = this;
switch (_that) {
case _VendorFriendModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorFriendModel value)?  $default,){
final _that = this;
switch (_that) {
case _VendorFriendModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String vendorName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorFriendModel() when $default != null:
return $default(_that.id,_that.userId,_that.vendorName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String vendorName)  $default,) {final _that = this;
switch (_that) {
case _VendorFriendModel():
return $default(_that.id,_that.userId,_that.vendorName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String vendorName)?  $default,) {final _that = this;
switch (_that) {
case _VendorFriendModel() when $default != null:
return $default(_that.id,_that.userId,_that.vendorName);case _:
  return null;

}
}

}

/// @nodoc


class _VendorFriendModel implements VendorFriendModel {
  const _VendorFriendModel({required this.id, required this.userId, required this.vendorName});
  

@override final  String id;
@override final  String userId;
@override final  String vendorName;

/// Create a copy of VendorFriendModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorFriendModelCopyWith<_VendorFriendModel> get copyWith => __$VendorFriendModelCopyWithImpl<_VendorFriendModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorFriendModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,vendorName);

@override
String toString() {
  return 'VendorFriendModel(id: $id, userId: $userId, vendorName: $vendorName)';
}


}

/// @nodoc
abstract mixin class _$VendorFriendModelCopyWith<$Res> implements $VendorFriendModelCopyWith<$Res> {
  factory _$VendorFriendModelCopyWith(_VendorFriendModel value, $Res Function(_VendorFriendModel) _then) = __$VendorFriendModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String vendorName
});




}
/// @nodoc
class __$VendorFriendModelCopyWithImpl<$Res>
    implements _$VendorFriendModelCopyWith<$Res> {
  __$VendorFriendModelCopyWithImpl(this._self, this._then);

  final _VendorFriendModel _self;
  final $Res Function(_VendorFriendModel) _then;

/// Create a copy of VendorFriendModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? vendorName = null,}) {
  return _then(_VendorFriendModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
