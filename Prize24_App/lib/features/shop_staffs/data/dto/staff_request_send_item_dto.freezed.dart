// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_request_send_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StaffRequestSendItemDto {

 String? get id; String get receiverName; String get shopId; String get receiverId;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get requestedAt;@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? get respondedAt; String get status;
/// Create a copy of StaffRequestSendItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffRequestSendItemDtoCopyWith<StaffRequestSendItemDto> get copyWith => _$StaffRequestSendItemDtoCopyWithImpl<StaffRequestSendItemDto>(this as StaffRequestSendItemDto, _$identity);

  /// Serializes this StaffRequestSendItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffRequestSendItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,receiverName,shopId,receiverId,requestedAt,respondedAt,status);

@override
String toString() {
  return 'StaffRequestSendItemDto(id: $id, receiverName: $receiverName, shopId: $shopId, receiverId: $receiverId, requestedAt: $requestedAt, respondedAt: $respondedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $StaffRequestSendItemDtoCopyWith<$Res>  {
  factory $StaffRequestSendItemDtoCopyWith(StaffRequestSendItemDto value, $Res Function(StaffRequestSendItemDto) _then) = _$StaffRequestSendItemDtoCopyWithImpl;
@useResult
$Res call({
 String? id, String receiverName, String shopId, String receiverId,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp requestedAt,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? respondedAt, String status
});




}
/// @nodoc
class _$StaffRequestSendItemDtoCopyWithImpl<$Res>
    implements $StaffRequestSendItemDtoCopyWith<$Res> {
  _$StaffRequestSendItemDtoCopyWithImpl(this._self, this._then);

  final StaffRequestSendItemDto _self;
  final $Res Function(StaffRequestSendItemDto) _then;

/// Create a copy of StaffRequestSendItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? receiverName = null,Object? shopId = null,Object? receiverId = null,Object? requestedAt = null,Object? respondedAt = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,receiverName: null == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as Timestamp?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffRequestSendItemDto].
extension StaffRequestSendItemDtoPatterns on StaffRequestSendItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffRequestSendItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffRequestSendItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffRequestSendItemDto value)  $default,){
final _that = this;
switch (_that) {
case _StaffRequestSendItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffRequestSendItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _StaffRequestSendItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String receiverName,  String shopId,  String receiverId, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp requestedAt, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? respondedAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffRequestSendItemDto() when $default != null:
return $default(_that.id,_that.receiverName,_that.shopId,_that.receiverId,_that.requestedAt,_that.respondedAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String receiverName,  String shopId,  String receiverId, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp requestedAt, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? respondedAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _StaffRequestSendItemDto():
return $default(_that.id,_that.receiverName,_that.shopId,_that.receiverId,_that.requestedAt,_that.respondedAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String receiverName,  String shopId,  String receiverId, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp requestedAt, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson)  Timestamp? respondedAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _StaffRequestSendItemDto() when $default != null:
return $default(_that.id,_that.receiverName,_that.shopId,_that.receiverId,_that.requestedAt,_that.respondedAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StaffRequestSendItemDto extends StaffRequestSendItemDto {
  const _StaffRequestSendItemDto({required this.id, required this.receiverName, required this.shopId, required this.receiverId, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.requestedAt, @JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) required this.respondedAt, required this.status}): super._();
  factory _StaffRequestSendItemDto.fromJson(Map<String, dynamic> json) => _$StaffRequestSendItemDtoFromJson(json);

@override final  String? id;
@override final  String receiverName;
@override final  String shopId;
@override final  String receiverId;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp requestedAt;
@override@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) final  Timestamp? respondedAt;
@override final  String status;

/// Create a copy of StaffRequestSendItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffRequestSendItemDtoCopyWith<_StaffRequestSendItemDto> get copyWith => __$StaffRequestSendItemDtoCopyWithImpl<_StaffRequestSendItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffRequestSendItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffRequestSendItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,receiverName,shopId,receiverId,requestedAt,respondedAt,status);

@override
String toString() {
  return 'StaffRequestSendItemDto(id: $id, receiverName: $receiverName, shopId: $shopId, receiverId: $receiverId, requestedAt: $requestedAt, respondedAt: $respondedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$StaffRequestSendItemDtoCopyWith<$Res> implements $StaffRequestSendItemDtoCopyWith<$Res> {
  factory _$StaffRequestSendItemDtoCopyWith(_StaffRequestSendItemDto value, $Res Function(_StaffRequestSendItemDto) _then) = __$StaffRequestSendItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String? id, String receiverName, String shopId, String receiverId,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp requestedAt,@JsonKey(fromJson: FirebaseHelper.nullableTimestampFromJson, toJson: FirebaseHelper.nullableTimestampToJson) Timestamp? respondedAt, String status
});




}
/// @nodoc
class __$StaffRequestSendItemDtoCopyWithImpl<$Res>
    implements _$StaffRequestSendItemDtoCopyWith<$Res> {
  __$StaffRequestSendItemDtoCopyWithImpl(this._self, this._then);

  final _StaffRequestSendItemDto _self;
  final $Res Function(_StaffRequestSendItemDto) _then;

/// Create a copy of StaffRequestSendItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? receiverName = null,Object? shopId = null,Object? receiverId = null,Object? requestedAt = null,Object? respondedAt = freezed,Object? status = null,}) {
  return _then(_StaffRequestSendItemDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,receiverName: null == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as Timestamp?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
