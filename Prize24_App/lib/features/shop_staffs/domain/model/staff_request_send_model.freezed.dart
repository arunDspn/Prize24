// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_request_send_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffRequestSendModel {

 String get id; String get receiverName; DateTime get requestedAt; DateTime? get respondedAt; StaffRequestStatus get status; String get shopId; String get receiverId;
/// Create a copy of StaffRequestSendModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffRequestSendModelCopyWith<StaffRequestSendModel> get copyWith => _$StaffRequestSendModelCopyWithImpl<StaffRequestSendModel>(this as StaffRequestSendModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffRequestSendModel&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId));
}


@override
int get hashCode => Object.hash(runtimeType,id,receiverName,requestedAt,respondedAt,status,shopId,receiverId);

@override
String toString() {
  return 'StaffRequestSendModel(id: $id, receiverName: $receiverName, requestedAt: $requestedAt, respondedAt: $respondedAt, status: $status, shopId: $shopId, receiverId: $receiverId)';
}


}

/// @nodoc
abstract mixin class $StaffRequestSendModelCopyWith<$Res>  {
  factory $StaffRequestSendModelCopyWith(StaffRequestSendModel value, $Res Function(StaffRequestSendModel) _then) = _$StaffRequestSendModelCopyWithImpl;
@useResult
$Res call({
 String id, String receiverName, DateTime requestedAt, DateTime? respondedAt, StaffRequestStatus status, String shopId, String receiverId
});




}
/// @nodoc
class _$StaffRequestSendModelCopyWithImpl<$Res>
    implements $StaffRequestSendModelCopyWith<$Res> {
  _$StaffRequestSendModelCopyWithImpl(this._self, this._then);

  final StaffRequestSendModel _self;
  final $Res Function(StaffRequestSendModel) _then;

/// Create a copy of StaffRequestSendModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? receiverName = null,Object? requestedAt = null,Object? respondedAt = freezed,Object? status = null,Object? shopId = null,Object? receiverId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,receiverName: null == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StaffRequestStatus,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffRequestSendModel].
extension StaffRequestSendModelPatterns on StaffRequestSendModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffRequestSendModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffRequestSendModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffRequestSendModel value)  $default,){
final _that = this;
switch (_that) {
case _StaffRequestSendModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffRequestSendModel value)?  $default,){
final _that = this;
switch (_that) {
case _StaffRequestSendModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String receiverName,  DateTime requestedAt,  DateTime? respondedAt,  StaffRequestStatus status,  String shopId,  String receiverId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffRequestSendModel() when $default != null:
return $default(_that.id,_that.receiverName,_that.requestedAt,_that.respondedAt,_that.status,_that.shopId,_that.receiverId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String receiverName,  DateTime requestedAt,  DateTime? respondedAt,  StaffRequestStatus status,  String shopId,  String receiverId)  $default,) {final _that = this;
switch (_that) {
case _StaffRequestSendModel():
return $default(_that.id,_that.receiverName,_that.requestedAt,_that.respondedAt,_that.status,_that.shopId,_that.receiverId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String receiverName,  DateTime requestedAt,  DateTime? respondedAt,  StaffRequestStatus status,  String shopId,  String receiverId)?  $default,) {final _that = this;
switch (_that) {
case _StaffRequestSendModel() when $default != null:
return $default(_that.id,_that.receiverName,_that.requestedAt,_that.respondedAt,_that.status,_that.shopId,_that.receiverId);case _:
  return null;

}
}

}

/// @nodoc


class _StaffRequestSendModel implements StaffRequestSendModel {
  const _StaffRequestSendModel({required this.id, required this.receiverName, required this.requestedAt, required this.respondedAt, required this.status, required this.shopId, required this.receiverId});
  

@override final  String id;
@override final  String receiverName;
@override final  DateTime requestedAt;
@override final  DateTime? respondedAt;
@override final  StaffRequestStatus status;
@override final  String shopId;
@override final  String receiverId;

/// Create a copy of StaffRequestSendModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffRequestSendModelCopyWith<_StaffRequestSendModel> get copyWith => __$StaffRequestSendModelCopyWithImpl<_StaffRequestSendModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffRequestSendModel&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId));
}


@override
int get hashCode => Object.hash(runtimeType,id,receiverName,requestedAt,respondedAt,status,shopId,receiverId);

@override
String toString() {
  return 'StaffRequestSendModel(id: $id, receiverName: $receiverName, requestedAt: $requestedAt, respondedAt: $respondedAt, status: $status, shopId: $shopId, receiverId: $receiverId)';
}


}

/// @nodoc
abstract mixin class _$StaffRequestSendModelCopyWith<$Res> implements $StaffRequestSendModelCopyWith<$Res> {
  factory _$StaffRequestSendModelCopyWith(_StaffRequestSendModel value, $Res Function(_StaffRequestSendModel) _then) = __$StaffRequestSendModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String receiverName, DateTime requestedAt, DateTime? respondedAt, StaffRequestStatus status, String shopId, String receiverId
});




}
/// @nodoc
class __$StaffRequestSendModelCopyWithImpl<$Res>
    implements _$StaffRequestSendModelCopyWith<$Res> {
  __$StaffRequestSendModelCopyWithImpl(this._self, this._then);

  final _StaffRequestSendModel _self;
  final $Res Function(_StaffRequestSendModel) _then;

/// Create a copy of StaffRequestSendModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? receiverName = null,Object? requestedAt = null,Object? respondedAt = freezed,Object? status = null,Object? shopId = null,Object? receiverId = null,}) {
  return _then(_StaffRequestSendModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,receiverName: null == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StaffRequestStatus,shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
