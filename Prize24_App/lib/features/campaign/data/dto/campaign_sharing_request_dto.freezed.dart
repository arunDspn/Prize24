// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_sharing_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CampaignSharingRequestDto {

 String get campaignId; String get campaignName;@JsonKey(name: 'ownerVendorId') String get senderVendorId;@JsonKey(name: 'ownerVendorName') String get senderVendorName;@JsonKey(name: 'requestedAt', fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get requestAt; String get id;
/// Create a copy of CampaignSharingRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignSharingRequestDtoCopyWith<CampaignSharingRequestDto> get copyWith => _$CampaignSharingRequestDtoCopyWithImpl<CampaignSharingRequestDto>(this as CampaignSharingRequestDto, _$identity);

  /// Serializes this CampaignSharingRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignSharingRequestDto&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.senderVendorId, senderVendorId) || other.senderVendorId == senderVendorId)&&(identical(other.senderVendorName, senderVendorName) || other.senderVendorName == senderVendorName)&&(identical(other.requestAt, requestAt) || other.requestAt == requestAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,campaignId,campaignName,senderVendorId,senderVendorName,requestAt,id);

@override
String toString() {
  return 'CampaignSharingRequestDto(campaignId: $campaignId, campaignName: $campaignName, senderVendorId: $senderVendorId, senderVendorName: $senderVendorName, requestAt: $requestAt, id: $id)';
}


}

/// @nodoc
abstract mixin class $CampaignSharingRequestDtoCopyWith<$Res>  {
  factory $CampaignSharingRequestDtoCopyWith(CampaignSharingRequestDto value, $Res Function(CampaignSharingRequestDto) _then) = _$CampaignSharingRequestDtoCopyWithImpl;
@useResult
$Res call({
 String campaignId, String campaignName,@JsonKey(name: 'ownerVendorId') String senderVendorId,@JsonKey(name: 'ownerVendorName') String senderVendorName,@JsonKey(name: 'requestedAt', fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp requestAt, String id
});




}
/// @nodoc
class _$CampaignSharingRequestDtoCopyWithImpl<$Res>
    implements $CampaignSharingRequestDtoCopyWith<$Res> {
  _$CampaignSharingRequestDtoCopyWithImpl(this._self, this._then);

  final CampaignSharingRequestDto _self;
  final $Res Function(CampaignSharingRequestDto) _then;

/// Create a copy of CampaignSharingRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? campaignId = null,Object? campaignName = null,Object? senderVendorId = null,Object? senderVendorName = null,Object? requestAt = null,Object? id = null,}) {
  return _then(_self.copyWith(
campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,senderVendorId: null == senderVendorId ? _self.senderVendorId : senderVendorId // ignore: cast_nullable_to_non_nullable
as String,senderVendorName: null == senderVendorName ? _self.senderVendorName : senderVendorName // ignore: cast_nullable_to_non_nullable
as String,requestAt: null == requestAt ? _self.requestAt : requestAt // ignore: cast_nullable_to_non_nullable
as Timestamp,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignSharingRequestDto].
extension CampaignSharingRequestDtoPatterns on CampaignSharingRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignSharingRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignSharingRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignSharingRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CampaignSharingRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignSharingRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignSharingRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String campaignId,  String campaignName, @JsonKey(name: 'ownerVendorId')  String senderVendorId, @JsonKey(name: 'ownerVendorName')  String senderVendorName, @JsonKey(name: 'requestedAt', fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp requestAt,  String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignSharingRequestDto() when $default != null:
return $default(_that.campaignId,_that.campaignName,_that.senderVendorId,_that.senderVendorName,_that.requestAt,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String campaignId,  String campaignName, @JsonKey(name: 'ownerVendorId')  String senderVendorId, @JsonKey(name: 'ownerVendorName')  String senderVendorName, @JsonKey(name: 'requestedAt', fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp requestAt,  String id)  $default,) {final _that = this;
switch (_that) {
case _CampaignSharingRequestDto():
return $default(_that.campaignId,_that.campaignName,_that.senderVendorId,_that.senderVendorName,_that.requestAt,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String campaignId,  String campaignName, @JsonKey(name: 'ownerVendorId')  String senderVendorId, @JsonKey(name: 'ownerVendorName')  String senderVendorName, @JsonKey(name: 'requestedAt', fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp requestAt,  String id)?  $default,) {final _that = this;
switch (_that) {
case _CampaignSharingRequestDto() when $default != null:
return $default(_that.campaignId,_that.campaignName,_that.senderVendorId,_that.senderVendorName,_that.requestAt,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignSharingRequestDto extends CampaignSharingRequestDto {
  const _CampaignSharingRequestDto({required this.campaignId, required this.campaignName, @JsonKey(name: 'ownerVendorId') required this.senderVendorId, @JsonKey(name: 'ownerVendorName') required this.senderVendorName, @JsonKey(name: 'requestedAt', fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.requestAt, this.id = ''}): super._();
  factory _CampaignSharingRequestDto.fromJson(Map<String, dynamic> json) => _$CampaignSharingRequestDtoFromJson(json);

@override final  String campaignId;
@override final  String campaignName;
@override@JsonKey(name: 'ownerVendorId') final  String senderVendorId;
@override@JsonKey(name: 'ownerVendorName') final  String senderVendorName;
@override@JsonKey(name: 'requestedAt', fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp requestAt;
@override@JsonKey() final  String id;

/// Create a copy of CampaignSharingRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignSharingRequestDtoCopyWith<_CampaignSharingRequestDto> get copyWith => __$CampaignSharingRequestDtoCopyWithImpl<_CampaignSharingRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignSharingRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignSharingRequestDto&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.senderVendorId, senderVendorId) || other.senderVendorId == senderVendorId)&&(identical(other.senderVendorName, senderVendorName) || other.senderVendorName == senderVendorName)&&(identical(other.requestAt, requestAt) || other.requestAt == requestAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,campaignId,campaignName,senderVendorId,senderVendorName,requestAt,id);

@override
String toString() {
  return 'CampaignSharingRequestDto(campaignId: $campaignId, campaignName: $campaignName, senderVendorId: $senderVendorId, senderVendorName: $senderVendorName, requestAt: $requestAt, id: $id)';
}


}

/// @nodoc
abstract mixin class _$CampaignSharingRequestDtoCopyWith<$Res> implements $CampaignSharingRequestDtoCopyWith<$Res> {
  factory _$CampaignSharingRequestDtoCopyWith(_CampaignSharingRequestDto value, $Res Function(_CampaignSharingRequestDto) _then) = __$CampaignSharingRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String campaignId, String campaignName,@JsonKey(name: 'ownerVendorId') String senderVendorId,@JsonKey(name: 'ownerVendorName') String senderVendorName,@JsonKey(name: 'requestedAt', fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp requestAt, String id
});




}
/// @nodoc
class __$CampaignSharingRequestDtoCopyWithImpl<$Res>
    implements _$CampaignSharingRequestDtoCopyWith<$Res> {
  __$CampaignSharingRequestDtoCopyWithImpl(this._self, this._then);

  final _CampaignSharingRequestDto _self;
  final $Res Function(_CampaignSharingRequestDto) _then;

/// Create a copy of CampaignSharingRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? campaignId = null,Object? campaignName = null,Object? senderVendorId = null,Object? senderVendorName = null,Object? requestAt = null,Object? id = null,}) {
  return _then(_CampaignSharingRequestDto(
campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,senderVendorId: null == senderVendorId ? _self.senderVendorId : senderVendorId // ignore: cast_nullable_to_non_nullable
as String,senderVendorName: null == senderVendorName ? _self.senderVendorName : senderVendorName // ignore: cast_nullable_to_non_nullable
as String,requestAt: null == requestAt ? _self.requestAt : requestAt // ignore: cast_nullable_to_non_nullable
as Timestamp,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
