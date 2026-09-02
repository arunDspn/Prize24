// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_gift_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserGiftModel {

 String get id; String get userId; String get giftId; String get giftName; String get giftDescription; bool get isRedeemable; bool? get isRedeemed; bool get availedViaClub;// If is Redeemable is false,
// Availed at is same as redeemed at
 DateTime get availedAt;// If is Redeemable is true,
// Redeemed at will be null before redemption
 DateTime? get redeemedAt;// If is Redeemable is true,
 List<SupportedShopModel>? get supportedShops;// If is Redeemable is false,
 String? get payload; bool? get availedViaStreak; String? get streakShopID;
/// Create a copy of UserGiftModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserGiftModelCopyWith<UserGiftModel> get copyWith => _$UserGiftModelCopyWithImpl<UserGiftModel>(this as UserGiftModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserGiftModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.giftDescription, giftDescription) || other.giftDescription == giftDescription)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.isRedeemed, isRedeemed) || other.isRedeemed == isRedeemed)&&(identical(other.availedViaClub, availedViaClub) || other.availedViaClub == availedViaClub)&&(identical(other.availedAt, availedAt) || other.availedAt == availedAt)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&const DeepCollectionEquality().equals(other.supportedShops, supportedShops)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.availedViaStreak, availedViaStreak) || other.availedViaStreak == availedViaStreak)&&(identical(other.streakShopID, streakShopID) || other.streakShopID == streakShopID));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,giftId,giftName,giftDescription,isRedeemable,isRedeemed,availedViaClub,availedAt,redeemedAt,const DeepCollectionEquality().hash(supportedShops),payload,availedViaStreak,streakShopID);

@override
String toString() {
  return 'UserGiftModel(id: $id, userId: $userId, giftId: $giftId, giftName: $giftName, giftDescription: $giftDescription, isRedeemable: $isRedeemable, isRedeemed: $isRedeemed, availedViaClub: $availedViaClub, availedAt: $availedAt, redeemedAt: $redeemedAt, supportedShops: $supportedShops, payload: $payload, availedViaStreak: $availedViaStreak, streakShopID: $streakShopID)';
}


}

/// @nodoc
abstract mixin class $UserGiftModelCopyWith<$Res>  {
  factory $UserGiftModelCopyWith(UserGiftModel value, $Res Function(UserGiftModel) _then) = _$UserGiftModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String giftId, String giftName, String giftDescription, bool isRedeemable, bool? isRedeemed, bool availedViaClub, DateTime availedAt, DateTime? redeemedAt, List<SupportedShopModel>? supportedShops, String? payload, bool? availedViaStreak, String? streakShopID
});




}
/// @nodoc
class _$UserGiftModelCopyWithImpl<$Res>
    implements $UserGiftModelCopyWith<$Res> {
  _$UserGiftModelCopyWithImpl(this._self, this._then);

  final UserGiftModel _self;
  final $Res Function(UserGiftModel) _then;

/// Create a copy of UserGiftModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? giftId = null,Object? giftName = null,Object? giftDescription = null,Object? isRedeemable = null,Object? isRedeemed = freezed,Object? availedViaClub = null,Object? availedAt = null,Object? redeemedAt = freezed,Object? supportedShops = freezed,Object? payload = freezed,Object? availedViaStreak = freezed,Object? streakShopID = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,giftId: null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,giftDescription: null == giftDescription ? _self.giftDescription : giftDescription // ignore: cast_nullable_to_non_nullable
as String,isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,isRedeemed: freezed == isRedeemed ? _self.isRedeemed : isRedeemed // ignore: cast_nullable_to_non_nullable
as bool?,availedViaClub: null == availedViaClub ? _self.availedViaClub : availedViaClub // ignore: cast_nullable_to_non_nullable
as bool,availedAt: null == availedAt ? _self.availedAt : availedAt // ignore: cast_nullable_to_non_nullable
as DateTime,redeemedAt: freezed == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,supportedShops: freezed == supportedShops ? _self.supportedShops : supportedShops // ignore: cast_nullable_to_non_nullable
as List<SupportedShopModel>?,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,availedViaStreak: freezed == availedViaStreak ? _self.availedViaStreak : availedViaStreak // ignore: cast_nullable_to_non_nullable
as bool?,streakShopID: freezed == streakShopID ? _self.streakShopID : streakShopID // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserGiftModel].
extension UserGiftModelPatterns on UserGiftModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserGiftModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserGiftModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserGiftModel value)  $default,){
final _that = this;
switch (_that) {
case _UserGiftModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserGiftModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserGiftModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String giftId,  String giftName,  String giftDescription,  bool isRedeemable,  bool? isRedeemed,  bool availedViaClub,  DateTime availedAt,  DateTime? redeemedAt,  List<SupportedShopModel>? supportedShops,  String? payload,  bool? availedViaStreak,  String? streakShopID)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserGiftModel() when $default != null:
return $default(_that.id,_that.userId,_that.giftId,_that.giftName,_that.giftDescription,_that.isRedeemable,_that.isRedeemed,_that.availedViaClub,_that.availedAt,_that.redeemedAt,_that.supportedShops,_that.payload,_that.availedViaStreak,_that.streakShopID);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String giftId,  String giftName,  String giftDescription,  bool isRedeemable,  bool? isRedeemed,  bool availedViaClub,  DateTime availedAt,  DateTime? redeemedAt,  List<SupportedShopModel>? supportedShops,  String? payload,  bool? availedViaStreak,  String? streakShopID)  $default,) {final _that = this;
switch (_that) {
case _UserGiftModel():
return $default(_that.id,_that.userId,_that.giftId,_that.giftName,_that.giftDescription,_that.isRedeemable,_that.isRedeemed,_that.availedViaClub,_that.availedAt,_that.redeemedAt,_that.supportedShops,_that.payload,_that.availedViaStreak,_that.streakShopID);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String giftId,  String giftName,  String giftDescription,  bool isRedeemable,  bool? isRedeemed,  bool availedViaClub,  DateTime availedAt,  DateTime? redeemedAt,  List<SupportedShopModel>? supportedShops,  String? payload,  bool? availedViaStreak,  String? streakShopID)?  $default,) {final _that = this;
switch (_that) {
case _UserGiftModel() when $default != null:
return $default(_that.id,_that.userId,_that.giftId,_that.giftName,_that.giftDescription,_that.isRedeemable,_that.isRedeemed,_that.availedViaClub,_that.availedAt,_that.redeemedAt,_that.supportedShops,_that.payload,_that.availedViaStreak,_that.streakShopID);case _:
  return null;

}
}

}

/// @nodoc


class _UserGiftModel implements UserGiftModel {
  const _UserGiftModel({required this.id, required this.userId, required this.giftId, required this.giftName, required this.giftDescription, required this.isRedeemable, required this.isRedeemed, required this.availedViaClub, required this.availedAt, this.redeemedAt, final  List<SupportedShopModel>? supportedShops, this.payload, this.availedViaStreak, this.streakShopID}): _supportedShops = supportedShops;
  

@override final  String id;
@override final  String userId;
@override final  String giftId;
@override final  String giftName;
@override final  String giftDescription;
@override final  bool isRedeemable;
@override final  bool? isRedeemed;
@override final  bool availedViaClub;
// If is Redeemable is false,
// Availed at is same as redeemed at
@override final  DateTime availedAt;
// If is Redeemable is true,
// Redeemed at will be null before redemption
@override final  DateTime? redeemedAt;
// If is Redeemable is true,
 final  List<SupportedShopModel>? _supportedShops;
// If is Redeemable is true,
@override List<SupportedShopModel>? get supportedShops {
  final value = _supportedShops;
  if (value == null) return null;
  if (_supportedShops is EqualUnmodifiableListView) return _supportedShops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// If is Redeemable is false,
@override final  String? payload;
@override final  bool? availedViaStreak;
@override final  String? streakShopID;

/// Create a copy of UserGiftModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserGiftModelCopyWith<_UserGiftModel> get copyWith => __$UserGiftModelCopyWithImpl<_UserGiftModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserGiftModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.giftDescription, giftDescription) || other.giftDescription == giftDescription)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.isRedeemed, isRedeemed) || other.isRedeemed == isRedeemed)&&(identical(other.availedViaClub, availedViaClub) || other.availedViaClub == availedViaClub)&&(identical(other.availedAt, availedAt) || other.availedAt == availedAt)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&const DeepCollectionEquality().equals(other._supportedShops, _supportedShops)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.availedViaStreak, availedViaStreak) || other.availedViaStreak == availedViaStreak)&&(identical(other.streakShopID, streakShopID) || other.streakShopID == streakShopID));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,giftId,giftName,giftDescription,isRedeemable,isRedeemed,availedViaClub,availedAt,redeemedAt,const DeepCollectionEquality().hash(_supportedShops),payload,availedViaStreak,streakShopID);

@override
String toString() {
  return 'UserGiftModel(id: $id, userId: $userId, giftId: $giftId, giftName: $giftName, giftDescription: $giftDescription, isRedeemable: $isRedeemable, isRedeemed: $isRedeemed, availedViaClub: $availedViaClub, availedAt: $availedAt, redeemedAt: $redeemedAt, supportedShops: $supportedShops, payload: $payload, availedViaStreak: $availedViaStreak, streakShopID: $streakShopID)';
}


}

/// @nodoc
abstract mixin class _$UserGiftModelCopyWith<$Res> implements $UserGiftModelCopyWith<$Res> {
  factory _$UserGiftModelCopyWith(_UserGiftModel value, $Res Function(_UserGiftModel) _then) = __$UserGiftModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String giftId, String giftName, String giftDescription, bool isRedeemable, bool? isRedeemed, bool availedViaClub, DateTime availedAt, DateTime? redeemedAt, List<SupportedShopModel>? supportedShops, String? payload, bool? availedViaStreak, String? streakShopID
});




}
/// @nodoc
class __$UserGiftModelCopyWithImpl<$Res>
    implements _$UserGiftModelCopyWith<$Res> {
  __$UserGiftModelCopyWithImpl(this._self, this._then);

  final _UserGiftModel _self;
  final $Res Function(_UserGiftModel) _then;

/// Create a copy of UserGiftModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? giftId = null,Object? giftName = null,Object? giftDescription = null,Object? isRedeemable = null,Object? isRedeemed = freezed,Object? availedViaClub = null,Object? availedAt = null,Object? redeemedAt = freezed,Object? supportedShops = freezed,Object? payload = freezed,Object? availedViaStreak = freezed,Object? streakShopID = freezed,}) {
  return _then(_UserGiftModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,giftId: null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,giftDescription: null == giftDescription ? _self.giftDescription : giftDescription // ignore: cast_nullable_to_non_nullable
as String,isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,isRedeemed: freezed == isRedeemed ? _self.isRedeemed : isRedeemed // ignore: cast_nullable_to_non_nullable
as bool?,availedViaClub: null == availedViaClub ? _self.availedViaClub : availedViaClub // ignore: cast_nullable_to_non_nullable
as bool,availedAt: null == availedAt ? _self.availedAt : availedAt // ignore: cast_nullable_to_non_nullable
as DateTime,redeemedAt: freezed == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,supportedShops: freezed == supportedShops ? _self._supportedShops : supportedShops // ignore: cast_nullable_to_non_nullable
as List<SupportedShopModel>?,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,availedViaStreak: freezed == availedViaStreak ? _self.availedViaStreak : availedViaStreak // ignore: cast_nullable_to_non_nullable
as bool?,streakShopID: freezed == streakShopID ? _self.streakShopID : streakShopID // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
