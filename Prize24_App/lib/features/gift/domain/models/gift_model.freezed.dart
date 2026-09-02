// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GiftModel {

 String? get id; String get name; String get description; DateTime get createdAt; DateTime get updatedAt; String get campaignId; String get campaignName; int get totalQuantity; int get remainingQuantity; String get giftType;// 'auto' or 'code'
 bool get isRedeemable; String get userId;// Creator's user ID
// For public campaigns only - URL-friendly identifier for the gift
 String? get publicgSlug;// For CODE type gifts only - contains all the gift codes
// Sub collection of GiftCodeModel
// List<GiftCodeModel>? giftCodes,
// For REDEEMABLE gifts only (both auto and code types)
// Contains shops where this gift can be redeemed
// Array of SupportedShopModel
 List<SupportedShopModel>? get supportedShops;
/// Create a copy of GiftModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftModelCopyWith<GiftModel> get copyWith => _$GiftModelCopyWithImpl<GiftModel>(this as GiftModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.publicgSlug, publicgSlug) || other.publicgSlug == publicgSlug)&&const DeepCollectionEquality().equals(other.supportedShops, supportedShops));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,updatedAt,campaignId,campaignName,totalQuantity,remainingQuantity,giftType,isRedeemable,userId,publicgSlug,const DeepCollectionEquality().hash(supportedShops));

@override
String toString() {
  return 'GiftModel(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, campaignId: $campaignId, campaignName: $campaignName, totalQuantity: $totalQuantity, remainingQuantity: $remainingQuantity, giftType: $giftType, isRedeemable: $isRedeemable, userId: $userId, publicgSlug: $publicgSlug, supportedShops: $supportedShops)';
}


}

/// @nodoc
abstract mixin class $GiftModelCopyWith<$Res>  {
  factory $GiftModelCopyWith(GiftModel value, $Res Function(GiftModel) _then) = _$GiftModelCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String description, DateTime createdAt, DateTime updatedAt, String campaignId, String campaignName, int totalQuantity, int remainingQuantity, String giftType, bool isRedeemable, String userId, String? publicgSlug, List<SupportedShopModel>? supportedShops
});




}
/// @nodoc
class _$GiftModelCopyWithImpl<$Res>
    implements $GiftModelCopyWith<$Res> {
  _$GiftModelCopyWithImpl(this._self, this._then);

  final GiftModel _self;
  final $Res Function(GiftModel) _then;

/// Create a copy of GiftModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? campaignId = null,Object? campaignName = null,Object? totalQuantity = null,Object? remainingQuantity = null,Object? giftType = null,Object? isRedeemable = null,Object? userId = null,Object? publicgSlug = freezed,Object? supportedShops = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,remainingQuantity: null == remainingQuantity ? _self.remainingQuantity : remainingQuantity // ignore: cast_nullable_to_non_nullable
as int,giftType: null == giftType ? _self.giftType : giftType // ignore: cast_nullable_to_non_nullable
as String,isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,publicgSlug: freezed == publicgSlug ? _self.publicgSlug : publicgSlug // ignore: cast_nullable_to_non_nullable
as String?,supportedShops: freezed == supportedShops ? _self.supportedShops : supportedShops // ignore: cast_nullable_to_non_nullable
as List<SupportedShopModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftModel].
extension GiftModelPatterns on GiftModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftModel value)  $default,){
final _that = this;
switch (_that) {
case _GiftModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftModel value)?  $default,){
final _that = this;
switch (_that) {
case _GiftModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String description,  DateTime createdAt,  DateTime updatedAt,  String campaignId,  String campaignName,  int totalQuantity,  int remainingQuantity,  String giftType,  bool isRedeemable,  String userId,  String? publicgSlug,  List<SupportedShopModel>? supportedShops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.campaignId,_that.campaignName,_that.totalQuantity,_that.remainingQuantity,_that.giftType,_that.isRedeemable,_that.userId,_that.publicgSlug,_that.supportedShops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String description,  DateTime createdAt,  DateTime updatedAt,  String campaignId,  String campaignName,  int totalQuantity,  int remainingQuantity,  String giftType,  bool isRedeemable,  String userId,  String? publicgSlug,  List<SupportedShopModel>? supportedShops)  $default,) {final _that = this;
switch (_that) {
case _GiftModel():
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.campaignId,_that.campaignName,_that.totalQuantity,_that.remainingQuantity,_that.giftType,_that.isRedeemable,_that.userId,_that.publicgSlug,_that.supportedShops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String description,  DateTime createdAt,  DateTime updatedAt,  String campaignId,  String campaignName,  int totalQuantity,  int remainingQuantity,  String giftType,  bool isRedeemable,  String userId,  String? publicgSlug,  List<SupportedShopModel>? supportedShops)?  $default,) {final _that = this;
switch (_that) {
case _GiftModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.campaignId,_that.campaignName,_that.totalQuantity,_that.remainingQuantity,_that.giftType,_that.isRedeemable,_that.userId,_that.publicgSlug,_that.supportedShops);case _:
  return null;

}
}

}

/// @nodoc


class _GiftModel extends GiftModel {
  const _GiftModel({required this.id, required this.name, required this.description, required this.createdAt, required this.updatedAt, required this.campaignId, required this.campaignName, required this.totalQuantity, required this.remainingQuantity, required this.giftType, required this.isRedeemable, required this.userId, this.publicgSlug, final  List<SupportedShopModel>? supportedShops}): _supportedShops = supportedShops,super._();
  

@override final  String? id;
@override final  String name;
@override final  String description;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String campaignId;
@override final  String campaignName;
@override final  int totalQuantity;
@override final  int remainingQuantity;
@override final  String giftType;
// 'auto' or 'code'
@override final  bool isRedeemable;
@override final  String userId;
// Creator's user ID
// For public campaigns only - URL-friendly identifier for the gift
@override final  String? publicgSlug;
// For CODE type gifts only - contains all the gift codes
// Sub collection of GiftCodeModel
// List<GiftCodeModel>? giftCodes,
// For REDEEMABLE gifts only (both auto and code types)
// Contains shops where this gift can be redeemed
// Array of SupportedShopModel
 final  List<SupportedShopModel>? _supportedShops;
// For CODE type gifts only - contains all the gift codes
// Sub collection of GiftCodeModel
// List<GiftCodeModel>? giftCodes,
// For REDEEMABLE gifts only (both auto and code types)
// Contains shops where this gift can be redeemed
// Array of SupportedShopModel
@override List<SupportedShopModel>? get supportedShops {
  final value = _supportedShops;
  if (value == null) return null;
  if (_supportedShops is EqualUnmodifiableListView) return _supportedShops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of GiftModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftModelCopyWith<_GiftModel> get copyWith => __$GiftModelCopyWithImpl<_GiftModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.publicgSlug, publicgSlug) || other.publicgSlug == publicgSlug)&&const DeepCollectionEquality().equals(other._supportedShops, _supportedShops));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,updatedAt,campaignId,campaignName,totalQuantity,remainingQuantity,giftType,isRedeemable,userId,publicgSlug,const DeepCollectionEquality().hash(_supportedShops));

@override
String toString() {
  return 'GiftModel(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, campaignId: $campaignId, campaignName: $campaignName, totalQuantity: $totalQuantity, remainingQuantity: $remainingQuantity, giftType: $giftType, isRedeemable: $isRedeemable, userId: $userId, publicgSlug: $publicgSlug, supportedShops: $supportedShops)';
}


}

/// @nodoc
abstract mixin class _$GiftModelCopyWith<$Res> implements $GiftModelCopyWith<$Res> {
  factory _$GiftModelCopyWith(_GiftModel value, $Res Function(_GiftModel) _then) = __$GiftModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String description, DateTime createdAt, DateTime updatedAt, String campaignId, String campaignName, int totalQuantity, int remainingQuantity, String giftType, bool isRedeemable, String userId, String? publicgSlug, List<SupportedShopModel>? supportedShops
});




}
/// @nodoc
class __$GiftModelCopyWithImpl<$Res>
    implements _$GiftModelCopyWith<$Res> {
  __$GiftModelCopyWithImpl(this._self, this._then);

  final _GiftModel _self;
  final $Res Function(_GiftModel) _then;

/// Create a copy of GiftModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? campaignId = null,Object? campaignName = null,Object? totalQuantity = null,Object? remainingQuantity = null,Object? giftType = null,Object? isRedeemable = null,Object? userId = null,Object? publicgSlug = freezed,Object? supportedShops = freezed,}) {
  return _then(_GiftModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,remainingQuantity: null == remainingQuantity ? _self.remainingQuantity : remainingQuantity // ignore: cast_nullable_to_non_nullable
as int,giftType: null == giftType ? _self.giftType : giftType // ignore: cast_nullable_to_non_nullable
as String,isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,publicgSlug: freezed == publicgSlug ? _self.publicgSlug : publicgSlug // ignore: cast_nullable_to_non_nullable
as String?,supportedShops: freezed == supportedShops ? _self._supportedShops : supportedShops // ignore: cast_nullable_to_non_nullable
as List<SupportedShopModel>?,
  ));
}


}

/// @nodoc
mixin _$CodeGiftCodeModel {

 String? get id; String get code; bool get isRedeemed; String? get payload; String? get redeemedByUserId;
/// Create a copy of CodeGiftCodeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeGiftCodeModelCopyWith<CodeGiftCodeModel> get copyWith => _$CodeGiftCodeModelCopyWithImpl<CodeGiftCodeModel>(this as CodeGiftCodeModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeGiftCodeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.isRedeemed, isRedeemed) || other.isRedeemed == isRedeemed)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.redeemedByUserId, redeemedByUserId) || other.redeemedByUserId == redeemedByUserId));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,isRedeemed,payload,redeemedByUserId);

@override
String toString() {
  return 'CodeGiftCodeModel(id: $id, code: $code, isRedeemed: $isRedeemed, payload: $payload, redeemedByUserId: $redeemedByUserId)';
}


}

/// @nodoc
abstract mixin class $CodeGiftCodeModelCopyWith<$Res>  {
  factory $CodeGiftCodeModelCopyWith(CodeGiftCodeModel value, $Res Function(CodeGiftCodeModel) _then) = _$CodeGiftCodeModelCopyWithImpl;
@useResult
$Res call({
 String? id, String code, bool isRedeemed, String? payload, String? redeemedByUserId
});




}
/// @nodoc
class _$CodeGiftCodeModelCopyWithImpl<$Res>
    implements $CodeGiftCodeModelCopyWith<$Res> {
  _$CodeGiftCodeModelCopyWithImpl(this._self, this._then);

  final CodeGiftCodeModel _self;
  final $Res Function(CodeGiftCodeModel) _then;

/// Create a copy of CodeGiftCodeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? code = null,Object? isRedeemed = null,Object? payload = freezed,Object? redeemedByUserId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,isRedeemed: null == isRedeemed ? _self.isRedeemed : isRedeemed // ignore: cast_nullable_to_non_nullable
as bool,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,redeemedByUserId: freezed == redeemedByUserId ? _self.redeemedByUserId : redeemedByUserId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CodeGiftCodeModel].
extension CodeGiftCodeModelPatterns on CodeGiftCodeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CodeGiftCodeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CodeGiftCodeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CodeGiftCodeModel value)  $default,){
final _that = this;
switch (_that) {
case _CodeGiftCodeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CodeGiftCodeModel value)?  $default,){
final _that = this;
switch (_that) {
case _CodeGiftCodeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String code,  bool isRedeemed,  String? payload,  String? redeemedByUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CodeGiftCodeModel() when $default != null:
return $default(_that.id,_that.code,_that.isRedeemed,_that.payload,_that.redeemedByUserId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String code,  bool isRedeemed,  String? payload,  String? redeemedByUserId)  $default,) {final _that = this;
switch (_that) {
case _CodeGiftCodeModel():
return $default(_that.id,_that.code,_that.isRedeemed,_that.payload,_that.redeemedByUserId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String code,  bool isRedeemed,  String? payload,  String? redeemedByUserId)?  $default,) {final _that = this;
switch (_that) {
case _CodeGiftCodeModel() when $default != null:
return $default(_that.id,_that.code,_that.isRedeemed,_that.payload,_that.redeemedByUserId);case _:
  return null;

}
}

}

/// @nodoc


class _CodeGiftCodeModel implements CodeGiftCodeModel {
  const _CodeGiftCodeModel({required this.id, required this.code, required this.isRedeemed, required this.payload, this.redeemedByUserId});
  

@override final  String? id;
@override final  String code;
@override final  bool isRedeemed;
@override final  String? payload;
@override final  String? redeemedByUserId;

/// Create a copy of CodeGiftCodeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeGiftCodeModelCopyWith<_CodeGiftCodeModel> get copyWith => __$CodeGiftCodeModelCopyWithImpl<_CodeGiftCodeModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeGiftCodeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.isRedeemed, isRedeemed) || other.isRedeemed == isRedeemed)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.redeemedByUserId, redeemedByUserId) || other.redeemedByUserId == redeemedByUserId));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,isRedeemed,payload,redeemedByUserId);

@override
String toString() {
  return 'CodeGiftCodeModel(id: $id, code: $code, isRedeemed: $isRedeemed, payload: $payload, redeemedByUserId: $redeemedByUserId)';
}


}

/// @nodoc
abstract mixin class _$CodeGiftCodeModelCopyWith<$Res> implements $CodeGiftCodeModelCopyWith<$Res> {
  factory _$CodeGiftCodeModelCopyWith(_CodeGiftCodeModel value, $Res Function(_CodeGiftCodeModel) _then) = __$CodeGiftCodeModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String code, bool isRedeemed, String? payload, String? redeemedByUserId
});




}
/// @nodoc
class __$CodeGiftCodeModelCopyWithImpl<$Res>
    implements _$CodeGiftCodeModelCopyWith<$Res> {
  __$CodeGiftCodeModelCopyWithImpl(this._self, this._then);

  final _CodeGiftCodeModel _self;
  final $Res Function(_CodeGiftCodeModel) _then;

/// Create a copy of CodeGiftCodeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? code = null,Object? isRedeemed = null,Object? payload = freezed,Object? redeemedByUserId = freezed,}) {
  return _then(_CodeGiftCodeModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,isRedeemed: null == isRedeemed ? _self.isRedeemed : isRedeemed // ignore: cast_nullable_to_non_nullable
as bool,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,redeemedByUserId: freezed == redeemedByUserId ? _self.redeemedByUserId : redeemedByUserId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AutoGiftPayloadModel {

 String? get id; String get content;// Optional fields
 DateTime? get redeemedAt; String? get redeemedByUserId;
/// Create a copy of AutoGiftPayloadModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutoGiftPayloadModelCopyWith<AutoGiftPayloadModel> get copyWith => _$AutoGiftPayloadModelCopyWithImpl<AutoGiftPayloadModel>(this as AutoGiftPayloadModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutoGiftPayloadModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&(identical(other.redeemedByUserId, redeemedByUserId) || other.redeemedByUserId == redeemedByUserId));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,redeemedAt,redeemedByUserId);

@override
String toString() {
  return 'AutoGiftPayloadModel(id: $id, content: $content, redeemedAt: $redeemedAt, redeemedByUserId: $redeemedByUserId)';
}


}

/// @nodoc
abstract mixin class $AutoGiftPayloadModelCopyWith<$Res>  {
  factory $AutoGiftPayloadModelCopyWith(AutoGiftPayloadModel value, $Res Function(AutoGiftPayloadModel) _then) = _$AutoGiftPayloadModelCopyWithImpl;
@useResult
$Res call({
 String? id, String content, DateTime? redeemedAt, String? redeemedByUserId
});




}
/// @nodoc
class _$AutoGiftPayloadModelCopyWithImpl<$Res>
    implements $AutoGiftPayloadModelCopyWith<$Res> {
  _$AutoGiftPayloadModelCopyWithImpl(this._self, this._then);

  final AutoGiftPayloadModel _self;
  final $Res Function(AutoGiftPayloadModel) _then;

/// Create a copy of AutoGiftPayloadModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? content = null,Object? redeemedAt = freezed,Object? redeemedByUserId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,redeemedAt: freezed == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,redeemedByUserId: freezed == redeemedByUserId ? _self.redeemedByUserId : redeemedByUserId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AutoGiftPayloadModel].
extension AutoGiftPayloadModelPatterns on AutoGiftPayloadModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutoGiftPayloadModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutoGiftPayloadModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutoGiftPayloadModel value)  $default,){
final _that = this;
switch (_that) {
case _AutoGiftPayloadModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutoGiftPayloadModel value)?  $default,){
final _that = this;
switch (_that) {
case _AutoGiftPayloadModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String content,  DateTime? redeemedAt,  String? redeemedByUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutoGiftPayloadModel() when $default != null:
return $default(_that.id,_that.content,_that.redeemedAt,_that.redeemedByUserId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String content,  DateTime? redeemedAt,  String? redeemedByUserId)  $default,) {final _that = this;
switch (_that) {
case _AutoGiftPayloadModel():
return $default(_that.id,_that.content,_that.redeemedAt,_that.redeemedByUserId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String content,  DateTime? redeemedAt,  String? redeemedByUserId)?  $default,) {final _that = this;
switch (_that) {
case _AutoGiftPayloadModel() when $default != null:
return $default(_that.id,_that.content,_that.redeemedAt,_that.redeemedByUserId);case _:
  return null;

}
}

}

/// @nodoc


class _AutoGiftPayloadModel implements AutoGiftPayloadModel {
  const _AutoGiftPayloadModel({required this.id, required this.content, this.redeemedAt, this.redeemedByUserId});
  

@override final  String? id;
@override final  String content;
// Optional fields
@override final  DateTime? redeemedAt;
@override final  String? redeemedByUserId;

/// Create a copy of AutoGiftPayloadModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutoGiftPayloadModelCopyWith<_AutoGiftPayloadModel> get copyWith => __$AutoGiftPayloadModelCopyWithImpl<_AutoGiftPayloadModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoGiftPayloadModel&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&(identical(other.redeemedByUserId, redeemedByUserId) || other.redeemedByUserId == redeemedByUserId));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,redeemedAt,redeemedByUserId);

@override
String toString() {
  return 'AutoGiftPayloadModel(id: $id, content: $content, redeemedAt: $redeemedAt, redeemedByUserId: $redeemedByUserId)';
}


}

/// @nodoc
abstract mixin class _$AutoGiftPayloadModelCopyWith<$Res> implements $AutoGiftPayloadModelCopyWith<$Res> {
  factory _$AutoGiftPayloadModelCopyWith(_AutoGiftPayloadModel value, $Res Function(_AutoGiftPayloadModel) _then) = __$AutoGiftPayloadModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String content, DateTime? redeemedAt, String? redeemedByUserId
});




}
/// @nodoc
class __$AutoGiftPayloadModelCopyWithImpl<$Res>
    implements _$AutoGiftPayloadModelCopyWith<$Res> {
  __$AutoGiftPayloadModelCopyWithImpl(this._self, this._then);

  final _AutoGiftPayloadModel _self;
  final $Res Function(_AutoGiftPayloadModel) _then;

/// Create a copy of AutoGiftPayloadModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? content = null,Object? redeemedAt = freezed,Object? redeemedByUserId = freezed,}) {
  return _then(_AutoGiftPayloadModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,redeemedAt: freezed == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,redeemedByUserId: freezed == redeemedByUserId ? _self.redeemedByUserId : redeemedByUserId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SupportedShopModel {

 String get id; String get name; String get shopAddress; String get shopPhone; String? get shopEmail;// Made optional to match ShopModel
 String? get shopWebsite;
/// Create a copy of SupportedShopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedShopModelCopyWith<SupportedShopModel> get copyWith => _$SupportedShopModelCopyWithImpl<SupportedShopModel>(this as SupportedShopModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopWebsite, shopWebsite) || other.shopWebsite == shopWebsite));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,shopAddress,shopPhone,shopEmail,shopWebsite);

@override
String toString() {
  return 'SupportedShopModel(id: $id, name: $name, shopAddress: $shopAddress, shopPhone: $shopPhone, shopEmail: $shopEmail, shopWebsite: $shopWebsite)';
}


}

/// @nodoc
abstract mixin class $SupportedShopModelCopyWith<$Res>  {
  factory $SupportedShopModelCopyWith(SupportedShopModel value, $Res Function(SupportedShopModel) _then) = _$SupportedShopModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String shopAddress, String shopPhone, String? shopEmail, String? shopWebsite
});




}
/// @nodoc
class _$SupportedShopModelCopyWithImpl<$Res>
    implements $SupportedShopModelCopyWith<$Res> {
  _$SupportedShopModelCopyWithImpl(this._self, this._then);

  final SupportedShopModel _self;
  final $Res Function(SupportedShopModel) _then;

/// Create a copy of SupportedShopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shopAddress = null,Object? shopPhone = null,Object? shopEmail = freezed,Object? shopWebsite = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopPhone: null == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String,shopEmail: freezed == shopEmail ? _self.shopEmail : shopEmail // ignore: cast_nullable_to_non_nullable
as String?,shopWebsite: freezed == shopWebsite ? _self.shopWebsite : shopWebsite // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportedShopModel].
extension SupportedShopModelPatterns on SupportedShopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportedShopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportedShopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportedShopModel value)  $default,){
final _that = this;
switch (_that) {
case _SupportedShopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportedShopModel value)?  $default,){
final _that = this;
switch (_that) {
case _SupportedShopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String shopAddress,  String shopPhone,  String? shopEmail,  String? shopWebsite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportedShopModel() when $default != null:
return $default(_that.id,_that.name,_that.shopAddress,_that.shopPhone,_that.shopEmail,_that.shopWebsite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String shopAddress,  String shopPhone,  String? shopEmail,  String? shopWebsite)  $default,) {final _that = this;
switch (_that) {
case _SupportedShopModel():
return $default(_that.id,_that.name,_that.shopAddress,_that.shopPhone,_that.shopEmail,_that.shopWebsite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String shopAddress,  String shopPhone,  String? shopEmail,  String? shopWebsite)?  $default,) {final _that = this;
switch (_that) {
case _SupportedShopModel() when $default != null:
return $default(_that.id,_that.name,_that.shopAddress,_that.shopPhone,_that.shopEmail,_that.shopWebsite);case _:
  return null;

}
}

}

/// @nodoc


class _SupportedShopModel implements SupportedShopModel {
  const _SupportedShopModel({required this.id, required this.name, required this.shopAddress, required this.shopPhone, this.shopEmail, this.shopWebsite});
  

@override final  String id;
@override final  String name;
@override final  String shopAddress;
@override final  String shopPhone;
@override final  String? shopEmail;
// Made optional to match ShopModel
@override final  String? shopWebsite;

/// Create a copy of SupportedShopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportedShopModelCopyWith<_SupportedShopModel> get copyWith => __$SupportedShopModelCopyWithImpl<_SupportedShopModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportedShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopWebsite, shopWebsite) || other.shopWebsite == shopWebsite));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,shopAddress,shopPhone,shopEmail,shopWebsite);

@override
String toString() {
  return 'SupportedShopModel(id: $id, name: $name, shopAddress: $shopAddress, shopPhone: $shopPhone, shopEmail: $shopEmail, shopWebsite: $shopWebsite)';
}


}

/// @nodoc
abstract mixin class _$SupportedShopModelCopyWith<$Res> implements $SupportedShopModelCopyWith<$Res> {
  factory _$SupportedShopModelCopyWith(_SupportedShopModel value, $Res Function(_SupportedShopModel) _then) = __$SupportedShopModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String shopAddress, String shopPhone, String? shopEmail, String? shopWebsite
});




}
/// @nodoc
class __$SupportedShopModelCopyWithImpl<$Res>
    implements _$SupportedShopModelCopyWith<$Res> {
  __$SupportedShopModelCopyWithImpl(this._self, this._then);

  final _SupportedShopModel _self;
  final $Res Function(_SupportedShopModel) _then;

/// Create a copy of SupportedShopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shopAddress = null,Object? shopPhone = null,Object? shopEmail = freezed,Object? shopWebsite = freezed,}) {
  return _then(_SupportedShopModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopPhone: null == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String,shopEmail: freezed == shopEmail ? _self.shopEmail : shopEmail // ignore: cast_nullable_to_non_nullable
as String?,shopWebsite: freezed == shopWebsite ? _self.shopWebsite : shopWebsite // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
