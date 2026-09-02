// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_redemption_audit_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GiftRedemptionAuditLogModel {

 String get action; String get redeemedBy; String get redeemerRole; String get functionName; bool get success; DateTime get timestamp; String? get giftId; String? get customerId; String? get shopId; String? get errorCode; String? get errorMessage; String? get phoneNumber;
/// Create a copy of GiftRedemptionAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftRedemptionAuditLogModelCopyWith<GiftRedemptionAuditLogModel> get copyWith => _$GiftRedemptionAuditLogModelCopyWithImpl<GiftRedemptionAuditLogModel>(this as GiftRedemptionAuditLogModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftRedemptionAuditLogModel&&(identical(other.action, action) || other.action == action)&&(identical(other.redeemedBy, redeemedBy) || other.redeemedBy == redeemedBy)&&(identical(other.redeemerRole, redeemerRole) || other.redeemerRole == redeemerRole)&&(identical(other.functionName, functionName) || other.functionName == functionName)&&(identical(other.success, success) || other.success == success)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,action,redeemedBy,redeemerRole,functionName,success,timestamp,giftId,customerId,shopId,errorCode,errorMessage,phoneNumber);

@override
String toString() {
  return 'GiftRedemptionAuditLogModel(action: $action, redeemedBy: $redeemedBy, redeemerRole: $redeemerRole, functionName: $functionName, success: $success, timestamp: $timestamp, giftId: $giftId, customerId: $customerId, shopId: $shopId, errorCode: $errorCode, errorMessage: $errorMessage, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $GiftRedemptionAuditLogModelCopyWith<$Res>  {
  factory $GiftRedemptionAuditLogModelCopyWith(GiftRedemptionAuditLogModel value, $Res Function(GiftRedemptionAuditLogModel) _then) = _$GiftRedemptionAuditLogModelCopyWithImpl;
@useResult
$Res call({
 String action, String redeemedBy, String redeemerRole, String functionName, bool success, DateTime timestamp, String? giftId, String? customerId, String? shopId, String? errorCode, String? errorMessage, String? phoneNumber
});




}
/// @nodoc
class _$GiftRedemptionAuditLogModelCopyWithImpl<$Res>
    implements $GiftRedemptionAuditLogModelCopyWith<$Res> {
  _$GiftRedemptionAuditLogModelCopyWithImpl(this._self, this._then);

  final GiftRedemptionAuditLogModel _self;
  final $Res Function(GiftRedemptionAuditLogModel) _then;

/// Create a copy of GiftRedemptionAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? redeemedBy = null,Object? redeemerRole = null,Object? functionName = null,Object? success = null,Object? timestamp = null,Object? giftId = freezed,Object? customerId = freezed,Object? shopId = freezed,Object? errorCode = freezed,Object? errorMessage = freezed,Object? phoneNumber = freezed,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,redeemedBy: null == redeemedBy ? _self.redeemedBy : redeemedBy // ignore: cast_nullable_to_non_nullable
as String,redeemerRole: null == redeemerRole ? _self.redeemerRole : redeemerRole // ignore: cast_nullable_to_non_nullable
as String,functionName: null == functionName ? _self.functionName : functionName // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,giftId: freezed == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftRedemptionAuditLogModel].
extension GiftRedemptionAuditLogModelPatterns on GiftRedemptionAuditLogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftRedemptionAuditLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftRedemptionAuditLogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftRedemptionAuditLogModel value)  $default,){
final _that = this;
switch (_that) {
case _GiftRedemptionAuditLogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftRedemptionAuditLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _GiftRedemptionAuditLogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String action,  String redeemedBy,  String redeemerRole,  String functionName,  bool success,  DateTime timestamp,  String? giftId,  String? customerId,  String? shopId,  String? errorCode,  String? errorMessage,  String? phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftRedemptionAuditLogModel() when $default != null:
return $default(_that.action,_that.redeemedBy,_that.redeemerRole,_that.functionName,_that.success,_that.timestamp,_that.giftId,_that.customerId,_that.shopId,_that.errorCode,_that.errorMessage,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String action,  String redeemedBy,  String redeemerRole,  String functionName,  bool success,  DateTime timestamp,  String? giftId,  String? customerId,  String? shopId,  String? errorCode,  String? errorMessage,  String? phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _GiftRedemptionAuditLogModel():
return $default(_that.action,_that.redeemedBy,_that.redeemerRole,_that.functionName,_that.success,_that.timestamp,_that.giftId,_that.customerId,_that.shopId,_that.errorCode,_that.errorMessage,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String action,  String redeemedBy,  String redeemerRole,  String functionName,  bool success,  DateTime timestamp,  String? giftId,  String? customerId,  String? shopId,  String? errorCode,  String? errorMessage,  String? phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _GiftRedemptionAuditLogModel() when $default != null:
return $default(_that.action,_that.redeemedBy,_that.redeemerRole,_that.functionName,_that.success,_that.timestamp,_that.giftId,_that.customerId,_that.shopId,_that.errorCode,_that.errorMessage,_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc


class _GiftRedemptionAuditLogModel implements GiftRedemptionAuditLogModel {
  const _GiftRedemptionAuditLogModel({required this.action, required this.redeemedBy, required this.redeemerRole, required this.functionName, required this.success, required this.timestamp, this.giftId, this.customerId, this.shopId, this.errorCode, this.errorMessage, this.phoneNumber});
  

@override final  String action;
@override final  String redeemedBy;
@override final  String redeemerRole;
@override final  String functionName;
@override final  bool success;
@override final  DateTime timestamp;
@override final  String? giftId;
@override final  String? customerId;
@override final  String? shopId;
@override final  String? errorCode;
@override final  String? errorMessage;
@override final  String? phoneNumber;

/// Create a copy of GiftRedemptionAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftRedemptionAuditLogModelCopyWith<_GiftRedemptionAuditLogModel> get copyWith => __$GiftRedemptionAuditLogModelCopyWithImpl<_GiftRedemptionAuditLogModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftRedemptionAuditLogModel&&(identical(other.action, action) || other.action == action)&&(identical(other.redeemedBy, redeemedBy) || other.redeemedBy == redeemedBy)&&(identical(other.redeemerRole, redeemerRole) || other.redeemerRole == redeemerRole)&&(identical(other.functionName, functionName) || other.functionName == functionName)&&(identical(other.success, success) || other.success == success)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,action,redeemedBy,redeemerRole,functionName,success,timestamp,giftId,customerId,shopId,errorCode,errorMessage,phoneNumber);

@override
String toString() {
  return 'GiftRedemptionAuditLogModel(action: $action, redeemedBy: $redeemedBy, redeemerRole: $redeemerRole, functionName: $functionName, success: $success, timestamp: $timestamp, giftId: $giftId, customerId: $customerId, shopId: $shopId, errorCode: $errorCode, errorMessage: $errorMessage, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$GiftRedemptionAuditLogModelCopyWith<$Res> implements $GiftRedemptionAuditLogModelCopyWith<$Res> {
  factory _$GiftRedemptionAuditLogModelCopyWith(_GiftRedemptionAuditLogModel value, $Res Function(_GiftRedemptionAuditLogModel) _then) = __$GiftRedemptionAuditLogModelCopyWithImpl;
@override @useResult
$Res call({
 String action, String redeemedBy, String redeemerRole, String functionName, bool success, DateTime timestamp, String? giftId, String? customerId, String? shopId, String? errorCode, String? errorMessage, String? phoneNumber
});




}
/// @nodoc
class __$GiftRedemptionAuditLogModelCopyWithImpl<$Res>
    implements _$GiftRedemptionAuditLogModelCopyWith<$Res> {
  __$GiftRedemptionAuditLogModelCopyWithImpl(this._self, this._then);

  final _GiftRedemptionAuditLogModel _self;
  final $Res Function(_GiftRedemptionAuditLogModel) _then;

/// Create a copy of GiftRedemptionAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? redeemedBy = null,Object? redeemerRole = null,Object? functionName = null,Object? success = null,Object? timestamp = null,Object? giftId = freezed,Object? customerId = freezed,Object? shopId = freezed,Object? errorCode = freezed,Object? errorMessage = freezed,Object? phoneNumber = freezed,}) {
  return _then(_GiftRedemptionAuditLogModel(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,redeemedBy: null == redeemedBy ? _self.redeemedBy : redeemedBy // ignore: cast_nullable_to_non_nullable
as String,redeemerRole: null == redeemerRole ? _self.redeemerRole : redeemerRole // ignore: cast_nullable_to_non_nullable
as String,functionName: null == functionName ? _self.functionName : functionName // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,giftId: freezed == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
