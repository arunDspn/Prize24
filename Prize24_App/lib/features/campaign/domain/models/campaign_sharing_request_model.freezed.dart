// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_sharing_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampaignSharingRequestModel {

 String get id; String get campaignId; String get campaignName; String get senderVendorId; String get senderVendorName; DateTime get requestAt;
/// Create a copy of CampaignSharingRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignSharingRequestModelCopyWith<CampaignSharingRequestModel> get copyWith => _$CampaignSharingRequestModelCopyWithImpl<CampaignSharingRequestModel>(this as CampaignSharingRequestModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignSharingRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.senderVendorId, senderVendorId) || other.senderVendorId == senderVendorId)&&(identical(other.senderVendorName, senderVendorName) || other.senderVendorName == senderVendorName)&&(identical(other.requestAt, requestAt) || other.requestAt == requestAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,campaignId,campaignName,senderVendorId,senderVendorName,requestAt);

@override
String toString() {
  return 'CampaignSharingRequestModel(id: $id, campaignId: $campaignId, campaignName: $campaignName, senderVendorId: $senderVendorId, senderVendorName: $senderVendorName, requestAt: $requestAt)';
}


}

/// @nodoc
abstract mixin class $CampaignSharingRequestModelCopyWith<$Res>  {
  factory $CampaignSharingRequestModelCopyWith(CampaignSharingRequestModel value, $Res Function(CampaignSharingRequestModel) _then) = _$CampaignSharingRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, String campaignId, String campaignName, String senderVendorId, String senderVendorName, DateTime requestAt
});




}
/// @nodoc
class _$CampaignSharingRequestModelCopyWithImpl<$Res>
    implements $CampaignSharingRequestModelCopyWith<$Res> {
  _$CampaignSharingRequestModelCopyWithImpl(this._self, this._then);

  final CampaignSharingRequestModel _self;
  final $Res Function(CampaignSharingRequestModel) _then;

/// Create a copy of CampaignSharingRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? campaignName = null,Object? senderVendorId = null,Object? senderVendorName = null,Object? requestAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,senderVendorId: null == senderVendorId ? _self.senderVendorId : senderVendorId // ignore: cast_nullable_to_non_nullable
as String,senderVendorName: null == senderVendorName ? _self.senderVendorName : senderVendorName // ignore: cast_nullable_to_non_nullable
as String,requestAt: null == requestAt ? _self.requestAt : requestAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignSharingRequestModel].
extension CampaignSharingRequestModelPatterns on CampaignSharingRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignSharingRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignSharingRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignSharingRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _CampaignSharingRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignSharingRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignSharingRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String campaignId,  String campaignName,  String senderVendorId,  String senderVendorName,  DateTime requestAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignSharingRequestModel() when $default != null:
return $default(_that.id,_that.campaignId,_that.campaignName,_that.senderVendorId,_that.senderVendorName,_that.requestAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String campaignId,  String campaignName,  String senderVendorId,  String senderVendorName,  DateTime requestAt)  $default,) {final _that = this;
switch (_that) {
case _CampaignSharingRequestModel():
return $default(_that.id,_that.campaignId,_that.campaignName,_that.senderVendorId,_that.senderVendorName,_that.requestAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String campaignId,  String campaignName,  String senderVendorId,  String senderVendorName,  DateTime requestAt)?  $default,) {final _that = this;
switch (_that) {
case _CampaignSharingRequestModel() when $default != null:
return $default(_that.id,_that.campaignId,_that.campaignName,_that.senderVendorId,_that.senderVendorName,_that.requestAt);case _:
  return null;

}
}

}

/// @nodoc


class _CampaignSharingRequestModel implements CampaignSharingRequestModel {
  const _CampaignSharingRequestModel({required this.id, required this.campaignId, required this.campaignName, required this.senderVendorId, required this.senderVendorName, required this.requestAt});
  

@override final  String id;
@override final  String campaignId;
@override final  String campaignName;
@override final  String senderVendorId;
@override final  String senderVendorName;
@override final  DateTime requestAt;

/// Create a copy of CampaignSharingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignSharingRequestModelCopyWith<_CampaignSharingRequestModel> get copyWith => __$CampaignSharingRequestModelCopyWithImpl<_CampaignSharingRequestModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignSharingRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.senderVendorId, senderVendorId) || other.senderVendorId == senderVendorId)&&(identical(other.senderVendorName, senderVendorName) || other.senderVendorName == senderVendorName)&&(identical(other.requestAt, requestAt) || other.requestAt == requestAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,campaignId,campaignName,senderVendorId,senderVendorName,requestAt);

@override
String toString() {
  return 'CampaignSharingRequestModel(id: $id, campaignId: $campaignId, campaignName: $campaignName, senderVendorId: $senderVendorId, senderVendorName: $senderVendorName, requestAt: $requestAt)';
}


}

/// @nodoc
abstract mixin class _$CampaignSharingRequestModelCopyWith<$Res> implements $CampaignSharingRequestModelCopyWith<$Res> {
  factory _$CampaignSharingRequestModelCopyWith(_CampaignSharingRequestModel value, $Res Function(_CampaignSharingRequestModel) _then) = __$CampaignSharingRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String campaignId, String campaignName, String senderVendorId, String senderVendorName, DateTime requestAt
});




}
/// @nodoc
class __$CampaignSharingRequestModelCopyWithImpl<$Res>
    implements _$CampaignSharingRequestModelCopyWith<$Res> {
  __$CampaignSharingRequestModelCopyWithImpl(this._self, this._then);

  final _CampaignSharingRequestModel _self;
  final $Res Function(_CampaignSharingRequestModel) _then;

/// Create a copy of CampaignSharingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? campaignName = null,Object? senderVendorId = null,Object? senderVendorName = null,Object? requestAt = null,}) {
  return _then(_CampaignSharingRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,senderVendorId: null == senderVendorId ? _self.senderVendorId : senderVendorId // ignore: cast_nullable_to_non_nullable
as String,senderVendorName: null == senderVendorName ? _self.senderVendorName : senderVendorName // ignore: cast_nullable_to_non_nullable
as String,requestAt: null == requestAt ? _self.requestAt : requestAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
