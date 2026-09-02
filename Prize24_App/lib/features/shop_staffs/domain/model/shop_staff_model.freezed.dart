// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_staff_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopStaffModel {

 String get staffId; String get staffName; DateTime get addedAt; String? get staffPhone;
/// Create a copy of ShopStaffModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopStaffModelCopyWith<ShopStaffModel> get copyWith => _$ShopStaffModelCopyWithImpl<ShopStaffModel>(this as ShopStaffModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopStaffModel&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt)&&(identical(other.staffPhone, staffPhone) || other.staffPhone == staffPhone));
}


@override
int get hashCode => Object.hash(runtimeType,staffId,staffName,addedAt,staffPhone);

@override
String toString() {
  return 'ShopStaffModel(staffId: $staffId, staffName: $staffName, addedAt: $addedAt, staffPhone: $staffPhone)';
}


}

/// @nodoc
abstract mixin class $ShopStaffModelCopyWith<$Res>  {
  factory $ShopStaffModelCopyWith(ShopStaffModel value, $Res Function(ShopStaffModel) _then) = _$ShopStaffModelCopyWithImpl;
@useResult
$Res call({
 String staffId, String staffName, DateTime addedAt, String? staffPhone
});




}
/// @nodoc
class _$ShopStaffModelCopyWithImpl<$Res>
    implements $ShopStaffModelCopyWith<$Res> {
  _$ShopStaffModelCopyWithImpl(this._self, this._then);

  final ShopStaffModel _self;
  final $Res Function(ShopStaffModel) _then;

/// Create a copy of ShopStaffModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? staffId = null,Object? staffName = null,Object? addedAt = null,Object? staffPhone = freezed,}) {
  return _then(_self.copyWith(
staffId: null == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as String,staffName: null == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,staffPhone: freezed == staffPhone ? _self.staffPhone : staffPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopStaffModel].
extension ShopStaffModelPatterns on ShopStaffModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopStaffModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopStaffModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopStaffModel value)  $default,){
final _that = this;
switch (_that) {
case _ShopStaffModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopStaffModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShopStaffModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String staffId,  String staffName,  DateTime addedAt,  String? staffPhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopStaffModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String staffId,  String staffName,  DateTime addedAt,  String? staffPhone)  $default,) {final _that = this;
switch (_that) {
case _ShopStaffModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String staffId,  String staffName,  DateTime addedAt,  String? staffPhone)?  $default,) {final _that = this;
switch (_that) {
case _ShopStaffModel() when $default != null:
return $default(_that.staffId,_that.staffName,_that.addedAt,_that.staffPhone);case _:
  return null;

}
}

}

/// @nodoc


class _ShopStaffModel implements ShopStaffModel {
  const _ShopStaffModel({required this.staffId, required this.staffName, required this.addedAt, this.staffPhone});
  

@override final  String staffId;
@override final  String staffName;
@override final  DateTime addedAt;
@override final  String? staffPhone;

/// Create a copy of ShopStaffModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopStaffModelCopyWith<_ShopStaffModel> get copyWith => __$ShopStaffModelCopyWithImpl<_ShopStaffModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopStaffModel&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt)&&(identical(other.staffPhone, staffPhone) || other.staffPhone == staffPhone));
}


@override
int get hashCode => Object.hash(runtimeType,staffId,staffName,addedAt,staffPhone);

@override
String toString() {
  return 'ShopStaffModel(staffId: $staffId, staffName: $staffName, addedAt: $addedAt, staffPhone: $staffPhone)';
}


}

/// @nodoc
abstract mixin class _$ShopStaffModelCopyWith<$Res> implements $ShopStaffModelCopyWith<$Res> {
  factory _$ShopStaffModelCopyWith(_ShopStaffModel value, $Res Function(_ShopStaffModel) _then) = __$ShopStaffModelCopyWithImpl;
@override @useResult
$Res call({
 String staffId, String staffName, DateTime addedAt, String? staffPhone
});




}
/// @nodoc
class __$ShopStaffModelCopyWithImpl<$Res>
    implements _$ShopStaffModelCopyWith<$Res> {
  __$ShopStaffModelCopyWithImpl(this._self, this._then);

  final _ShopStaffModel _self;
  final $Res Function(_ShopStaffModel) _then;

/// Create a copy of ShopStaffModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? staffId = null,Object? staffName = null,Object? addedAt = null,Object? staffPhone = freezed,}) {
  return _then(_ShopStaffModel(
staffId: null == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as String,staffName: null == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,staffPhone: freezed == staffPhone ? _self.staffPhone : staffPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
