// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffShopModel {

/// Shop ID
 String get id;/// Shop Name
 String get shopName;/// Associated Club ID (if any)
 String? get associatedCampaignId;
/// Create a copy of StaffShopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffShopModelCopyWith<StaffShopModel> get copyWith => _$StaffShopModelCopyWithImpl<StaffShopModel>(this as StaffShopModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.associatedCampaignId, associatedCampaignId) || other.associatedCampaignId == associatedCampaignId));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopName,associatedCampaignId);

@override
String toString() {
  return 'StaffShopModel(id: $id, shopName: $shopName, associatedCampaignId: $associatedCampaignId)';
}


}

/// @nodoc
abstract mixin class $StaffShopModelCopyWith<$Res>  {
  factory $StaffShopModelCopyWith(StaffShopModel value, $Res Function(StaffShopModel) _then) = _$StaffShopModelCopyWithImpl;
@useResult
$Res call({
 String id, String shopName, String? associatedCampaignId
});




}
/// @nodoc
class _$StaffShopModelCopyWithImpl<$Res>
    implements $StaffShopModelCopyWith<$Res> {
  _$StaffShopModelCopyWithImpl(this._self, this._then);

  final StaffShopModel _self;
  final $Res Function(StaffShopModel) _then;

/// Create a copy of StaffShopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shopName = null,Object? associatedCampaignId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,associatedCampaignId: freezed == associatedCampaignId ? _self.associatedCampaignId : associatedCampaignId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffShopModel].
extension StaffShopModelPatterns on StaffShopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffShopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffShopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffShopModel value)  $default,){
final _that = this;
switch (_that) {
case _StaffShopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffShopModel value)?  $default,){
final _that = this;
switch (_that) {
case _StaffShopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String shopName,  String? associatedCampaignId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffShopModel() when $default != null:
return $default(_that.id,_that.shopName,_that.associatedCampaignId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String shopName,  String? associatedCampaignId)  $default,) {final _that = this;
switch (_that) {
case _StaffShopModel():
return $default(_that.id,_that.shopName,_that.associatedCampaignId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String shopName,  String? associatedCampaignId)?  $default,) {final _that = this;
switch (_that) {
case _StaffShopModel() when $default != null:
return $default(_that.id,_that.shopName,_that.associatedCampaignId);case _:
  return null;

}
}

}

/// @nodoc


class _StaffShopModel implements StaffShopModel {
  const _StaffShopModel({required this.id, required this.shopName, this.associatedCampaignId});
  

/// Shop ID
@override final  String id;
/// Shop Name
@override final  String shopName;
/// Associated Club ID (if any)
@override final  String? associatedCampaignId;

/// Create a copy of StaffShopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffShopModelCopyWith<_StaffShopModel> get copyWith => __$StaffShopModelCopyWithImpl<_StaffShopModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.associatedCampaignId, associatedCampaignId) || other.associatedCampaignId == associatedCampaignId));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopName,associatedCampaignId);

@override
String toString() {
  return 'StaffShopModel(id: $id, shopName: $shopName, associatedCampaignId: $associatedCampaignId)';
}


}

/// @nodoc
abstract mixin class _$StaffShopModelCopyWith<$Res> implements $StaffShopModelCopyWith<$Res> {
  factory _$StaffShopModelCopyWith(_StaffShopModel value, $Res Function(_StaffShopModel) _then) = __$StaffShopModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String shopName, String? associatedCampaignId
});




}
/// @nodoc
class __$StaffShopModelCopyWithImpl<$Res>
    implements _$StaffShopModelCopyWith<$Res> {
  __$StaffShopModelCopyWithImpl(this._self, this._then);

  final _StaffShopModel _self;
  final $Res Function(_StaffShopModel) _then;

/// Create a copy of StaffShopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopName = null,Object? associatedCampaignId = freezed,}) {
  return _then(_StaffShopModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,associatedCampaignId: freezed == associatedCampaignId ? _self.associatedCampaignId : associatedCampaignId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
