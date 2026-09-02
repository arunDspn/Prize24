// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_campaign_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShareCampaignRequestModel {

 String get id; String get campaignId; String get campaignName; String get ownerVendorId; String get ownerVendorName; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ShareCampaignRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareCampaignRequestModelCopyWith<ShareCampaignRequestModel> get copyWith => _$ShareCampaignRequestModelCopyWithImpl<ShareCampaignRequestModel>(this as ShareCampaignRequestModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareCampaignRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.ownerVendorId, ownerVendorId) || other.ownerVendorId == ownerVendorId)&&(identical(other.ownerVendorName, ownerVendorName) || other.ownerVendorName == ownerVendorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,campaignId,campaignName,ownerVendorId,ownerVendorName,createdAt,updatedAt);

@override
String toString() {
  return 'ShareCampaignRequestModel(id: $id, campaignId: $campaignId, campaignName: $campaignName, ownerVendorId: $ownerVendorId, ownerVendorName: $ownerVendorName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ShareCampaignRequestModelCopyWith<$Res>  {
  factory $ShareCampaignRequestModelCopyWith(ShareCampaignRequestModel value, $Res Function(ShareCampaignRequestModel) _then) = _$ShareCampaignRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, String campaignId, String campaignName, String ownerVendorId, String ownerVendorName, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ShareCampaignRequestModelCopyWithImpl<$Res>
    implements $ShareCampaignRequestModelCopyWith<$Res> {
  _$ShareCampaignRequestModelCopyWithImpl(this._self, this._then);

  final ShareCampaignRequestModel _self;
  final $Res Function(ShareCampaignRequestModel) _then;

/// Create a copy of ShareCampaignRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? campaignName = null,Object? ownerVendorId = null,Object? ownerVendorName = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,ownerVendorId: null == ownerVendorId ? _self.ownerVendorId : ownerVendorId // ignore: cast_nullable_to_non_nullable
as String,ownerVendorName: null == ownerVendorName ? _self.ownerVendorName : ownerVendorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ShareCampaignRequestModel].
extension ShareCampaignRequestModelPatterns on ShareCampaignRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShareCampaignRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShareCampaignRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShareCampaignRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _ShareCampaignRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShareCampaignRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShareCampaignRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String campaignId,  String campaignName,  String ownerVendorId,  String ownerVendorName,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShareCampaignRequestModel() when $default != null:
return $default(_that.id,_that.campaignId,_that.campaignName,_that.ownerVendorId,_that.ownerVendorName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String campaignId,  String campaignName,  String ownerVendorId,  String ownerVendorName,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ShareCampaignRequestModel():
return $default(_that.id,_that.campaignId,_that.campaignName,_that.ownerVendorId,_that.ownerVendorName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String campaignId,  String campaignName,  String ownerVendorId,  String ownerVendorName,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ShareCampaignRequestModel() when $default != null:
return $default(_that.id,_that.campaignId,_that.campaignName,_that.ownerVendorId,_that.ownerVendorName,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ShareCampaignRequestModel implements ShareCampaignRequestModel {
  const _ShareCampaignRequestModel({required this.id, required this.campaignId, required this.campaignName, required this.ownerVendorId, required this.ownerVendorName, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String campaignId;
@override final  String campaignName;
@override final  String ownerVendorId;
@override final  String ownerVendorName;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ShareCampaignRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareCampaignRequestModelCopyWith<_ShareCampaignRequestModel> get copyWith => __$ShareCampaignRequestModelCopyWithImpl<_ShareCampaignRequestModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareCampaignRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.ownerVendorId, ownerVendorId) || other.ownerVendorId == ownerVendorId)&&(identical(other.ownerVendorName, ownerVendorName) || other.ownerVendorName == ownerVendorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,campaignId,campaignName,ownerVendorId,ownerVendorName,createdAt,updatedAt);

@override
String toString() {
  return 'ShareCampaignRequestModel(id: $id, campaignId: $campaignId, campaignName: $campaignName, ownerVendorId: $ownerVendorId, ownerVendorName: $ownerVendorName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ShareCampaignRequestModelCopyWith<$Res> implements $ShareCampaignRequestModelCopyWith<$Res> {
  factory _$ShareCampaignRequestModelCopyWith(_ShareCampaignRequestModel value, $Res Function(_ShareCampaignRequestModel) _then) = __$ShareCampaignRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String campaignId, String campaignName, String ownerVendorId, String ownerVendorName, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ShareCampaignRequestModelCopyWithImpl<$Res>
    implements _$ShareCampaignRequestModelCopyWith<$Res> {
  __$ShareCampaignRequestModelCopyWithImpl(this._self, this._then);

  final _ShareCampaignRequestModel _self;
  final $Res Function(_ShareCampaignRequestModel) _then;

/// Create a copy of ShareCampaignRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? campaignName = null,Object? ownerVendorId = null,Object? ownerVendorName = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ShareCampaignRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,ownerVendorId: null == ownerVendorId ? _self.ownerVendorId : ownerVendorId // ignore: cast_nullable_to_non_nullable
as String,ownerVendorName: null == ownerVendorName ? _self.ownerVendorName : ownerVendorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
