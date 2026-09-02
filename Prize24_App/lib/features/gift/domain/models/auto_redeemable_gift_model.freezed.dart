// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auto_redeemable_gift_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AutoRedeemableGiftModel {

 String get campaignId; String get campaignName; String get createdAt; String get description; String get giftType; bool get isRedeemable; String get name; String? get publicSlug; int get remainingQuantity; List<GiftSupportedShopModel> get supportedShops; int get totalQuantity; String get updatedAt; String get userId;
/// Create a copy of AutoRedeemableGiftModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutoRedeemableGiftModelCopyWith<AutoRedeemableGiftModel> get copyWith => _$AutoRedeemableGiftModelCopyWithImpl<AutoRedeemableGiftModel>(this as AutoRedeemableGiftModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutoRedeemableGiftModel&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.name, name) || other.name == name)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&const DeepCollectionEquality().equals(other.supportedShops, supportedShops)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,campaignId,campaignName,createdAt,description,giftType,isRedeemable,name,publicSlug,remainingQuantity,const DeepCollectionEquality().hash(supportedShops),totalQuantity,updatedAt,userId);

@override
String toString() {
  return 'AutoRedeemableGiftModel(campaignId: $campaignId, campaignName: $campaignName, createdAt: $createdAt, description: $description, giftType: $giftType, isRedeemable: $isRedeemable, name: $name, publicSlug: $publicSlug, remainingQuantity: $remainingQuantity, supportedShops: $supportedShops, totalQuantity: $totalQuantity, updatedAt: $updatedAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $AutoRedeemableGiftModelCopyWith<$Res>  {
  factory $AutoRedeemableGiftModelCopyWith(AutoRedeemableGiftModel value, $Res Function(AutoRedeemableGiftModel) _then) = _$AutoRedeemableGiftModelCopyWithImpl;
@useResult
$Res call({
 String campaignId, String campaignName, String createdAt, String description, String giftType, bool isRedeemable, String name, String? publicSlug, int remainingQuantity, List<GiftSupportedShopModel> supportedShops, int totalQuantity, String updatedAt, String userId
});




}
/// @nodoc
class _$AutoRedeemableGiftModelCopyWithImpl<$Res>
    implements $AutoRedeemableGiftModelCopyWith<$Res> {
  _$AutoRedeemableGiftModelCopyWithImpl(this._self, this._then);

  final AutoRedeemableGiftModel _self;
  final $Res Function(AutoRedeemableGiftModel) _then;

/// Create a copy of AutoRedeemableGiftModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? campaignId = null,Object? campaignName = null,Object? createdAt = null,Object? description = null,Object? giftType = null,Object? isRedeemable = null,Object? name = null,Object? publicSlug = freezed,Object? remainingQuantity = null,Object? supportedShops = null,Object? totalQuantity = null,Object? updatedAt = null,Object? userId = null,}) {
  return _then(_self.copyWith(
campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftType: null == giftType ? _self.giftType : giftType // ignore: cast_nullable_to_non_nullable
as String,isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publicSlug: freezed == publicSlug ? _self.publicSlug : publicSlug // ignore: cast_nullable_to_non_nullable
as String?,remainingQuantity: null == remainingQuantity ? _self.remainingQuantity : remainingQuantity // ignore: cast_nullable_to_non_nullable
as int,supportedShops: null == supportedShops ? _self.supportedShops : supportedShops // ignore: cast_nullable_to_non_nullable
as List<GiftSupportedShopModel>,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AutoRedeemableGiftModel].
extension AutoRedeemableGiftModelPatterns on AutoRedeemableGiftModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutoRedeemableGiftModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutoRedeemableGiftModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutoRedeemableGiftModel value)  $default,){
final _that = this;
switch (_that) {
case _AutoRedeemableGiftModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutoRedeemableGiftModel value)?  $default,){
final _that = this;
switch (_that) {
case _AutoRedeemableGiftModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String campaignId,  String campaignName,  String createdAt,  String description,  String giftType,  bool isRedeemable,  String name,  String? publicSlug,  int remainingQuantity,  List<GiftSupportedShopModel> supportedShops,  int totalQuantity,  String updatedAt,  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutoRedeemableGiftModel() when $default != null:
return $default(_that.campaignId,_that.campaignName,_that.createdAt,_that.description,_that.giftType,_that.isRedeemable,_that.name,_that.publicSlug,_that.remainingQuantity,_that.supportedShops,_that.totalQuantity,_that.updatedAt,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String campaignId,  String campaignName,  String createdAt,  String description,  String giftType,  bool isRedeemable,  String name,  String? publicSlug,  int remainingQuantity,  List<GiftSupportedShopModel> supportedShops,  int totalQuantity,  String updatedAt,  String userId)  $default,) {final _that = this;
switch (_that) {
case _AutoRedeemableGiftModel():
return $default(_that.campaignId,_that.campaignName,_that.createdAt,_that.description,_that.giftType,_that.isRedeemable,_that.name,_that.publicSlug,_that.remainingQuantity,_that.supportedShops,_that.totalQuantity,_that.updatedAt,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String campaignId,  String campaignName,  String createdAt,  String description,  String giftType,  bool isRedeemable,  String name,  String? publicSlug,  int remainingQuantity,  List<GiftSupportedShopModel> supportedShops,  int totalQuantity,  String updatedAt,  String userId)?  $default,) {final _that = this;
switch (_that) {
case _AutoRedeemableGiftModel() when $default != null:
return $default(_that.campaignId,_that.campaignName,_that.createdAt,_that.description,_that.giftType,_that.isRedeemable,_that.name,_that.publicSlug,_that.remainingQuantity,_that.supportedShops,_that.totalQuantity,_that.updatedAt,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _AutoRedeemableGiftModel implements AutoRedeemableGiftModel {
  const _AutoRedeemableGiftModel({required this.campaignId, required this.campaignName, required this.createdAt, required this.description, required this.giftType, required this.isRedeemable, required this.name, required this.publicSlug, required this.remainingQuantity, required final  List<GiftSupportedShopModel> supportedShops, required this.totalQuantity, required this.updatedAt, required this.userId}): _supportedShops = supportedShops;
  

@override final  String campaignId;
@override final  String campaignName;
@override final  String createdAt;
@override final  String description;
@override final  String giftType;
@override final  bool isRedeemable;
@override final  String name;
@override final  String? publicSlug;
@override final  int remainingQuantity;
 final  List<GiftSupportedShopModel> _supportedShops;
@override List<GiftSupportedShopModel> get supportedShops {
  if (_supportedShops is EqualUnmodifiableListView) return _supportedShops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportedShops);
}

@override final  int totalQuantity;
@override final  String updatedAt;
@override final  String userId;

/// Create a copy of AutoRedeemableGiftModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutoRedeemableGiftModelCopyWith<_AutoRedeemableGiftModel> get copyWith => __$AutoRedeemableGiftModelCopyWithImpl<_AutoRedeemableGiftModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoRedeemableGiftModel&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.name, name) || other.name == name)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&const DeepCollectionEquality().equals(other._supportedShops, _supportedShops)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,campaignId,campaignName,createdAt,description,giftType,isRedeemable,name,publicSlug,remainingQuantity,const DeepCollectionEquality().hash(_supportedShops),totalQuantity,updatedAt,userId);

@override
String toString() {
  return 'AutoRedeemableGiftModel(campaignId: $campaignId, campaignName: $campaignName, createdAt: $createdAt, description: $description, giftType: $giftType, isRedeemable: $isRedeemable, name: $name, publicSlug: $publicSlug, remainingQuantity: $remainingQuantity, supportedShops: $supportedShops, totalQuantity: $totalQuantity, updatedAt: $updatedAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$AutoRedeemableGiftModelCopyWith<$Res> implements $AutoRedeemableGiftModelCopyWith<$Res> {
  factory _$AutoRedeemableGiftModelCopyWith(_AutoRedeemableGiftModel value, $Res Function(_AutoRedeemableGiftModel) _then) = __$AutoRedeemableGiftModelCopyWithImpl;
@override @useResult
$Res call({
 String campaignId, String campaignName, String createdAt, String description, String giftType, bool isRedeemable, String name, String? publicSlug, int remainingQuantity, List<GiftSupportedShopModel> supportedShops, int totalQuantity, String updatedAt, String userId
});




}
/// @nodoc
class __$AutoRedeemableGiftModelCopyWithImpl<$Res>
    implements _$AutoRedeemableGiftModelCopyWith<$Res> {
  __$AutoRedeemableGiftModelCopyWithImpl(this._self, this._then);

  final _AutoRedeemableGiftModel _self;
  final $Res Function(_AutoRedeemableGiftModel) _then;

/// Create a copy of AutoRedeemableGiftModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? campaignId = null,Object? campaignName = null,Object? createdAt = null,Object? description = null,Object? giftType = null,Object? isRedeemable = null,Object? name = null,Object? publicSlug = freezed,Object? remainingQuantity = null,Object? supportedShops = null,Object? totalQuantity = null,Object? updatedAt = null,Object? userId = null,}) {
  return _then(_AutoRedeemableGiftModel(
campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftType: null == giftType ? _self.giftType : giftType // ignore: cast_nullable_to_non_nullable
as String,isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,publicSlug: freezed == publicSlug ? _self.publicSlug : publicSlug // ignore: cast_nullable_to_non_nullable
as String?,remainingQuantity: null == remainingQuantity ? _self.remainingQuantity : remainingQuantity // ignore: cast_nullable_to_non_nullable
as int,supportedShops: null == supportedShops ? _self._supportedShops : supportedShops // ignore: cast_nullable_to_non_nullable
as List<GiftSupportedShopModel>,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$GiftSupportedShopModel {

 String get id; String get name; String get shopAddress; String get shopEmail; String get shopPhone; String get shopWebsite;
/// Create a copy of GiftSupportedShopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftSupportedShopModelCopyWith<GiftSupportedShopModel> get copyWith => _$GiftSupportedShopModelCopyWithImpl<GiftSupportedShopModel>(this as GiftSupportedShopModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftSupportedShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopWebsite, shopWebsite) || other.shopWebsite == shopWebsite));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,shopAddress,shopEmail,shopPhone,shopWebsite);

@override
String toString() {
  return 'GiftSupportedShopModel(id: $id, name: $name, shopAddress: $shopAddress, shopEmail: $shopEmail, shopPhone: $shopPhone, shopWebsite: $shopWebsite)';
}


}

/// @nodoc
abstract mixin class $GiftSupportedShopModelCopyWith<$Res>  {
  factory $GiftSupportedShopModelCopyWith(GiftSupportedShopModel value, $Res Function(GiftSupportedShopModel) _then) = _$GiftSupportedShopModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String shopAddress, String shopEmail, String shopPhone, String shopWebsite
});




}
/// @nodoc
class _$GiftSupportedShopModelCopyWithImpl<$Res>
    implements $GiftSupportedShopModelCopyWith<$Res> {
  _$GiftSupportedShopModelCopyWithImpl(this._self, this._then);

  final GiftSupportedShopModel _self;
  final $Res Function(GiftSupportedShopModel) _then;

/// Create a copy of GiftSupportedShopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shopAddress = null,Object? shopEmail = null,Object? shopPhone = null,Object? shopWebsite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopEmail: null == shopEmail ? _self.shopEmail : shopEmail // ignore: cast_nullable_to_non_nullable
as String,shopPhone: null == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String,shopWebsite: null == shopWebsite ? _self.shopWebsite : shopWebsite // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftSupportedShopModel].
extension GiftSupportedShopModelPatterns on GiftSupportedShopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftSupportedShopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftSupportedShopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftSupportedShopModel value)  $default,){
final _that = this;
switch (_that) {
case _GiftSupportedShopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftSupportedShopModel value)?  $default,){
final _that = this;
switch (_that) {
case _GiftSupportedShopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String shopAddress,  String shopEmail,  String shopPhone,  String shopWebsite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftSupportedShopModel() when $default != null:
return $default(_that.id,_that.name,_that.shopAddress,_that.shopEmail,_that.shopPhone,_that.shopWebsite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String shopAddress,  String shopEmail,  String shopPhone,  String shopWebsite)  $default,) {final _that = this;
switch (_that) {
case _GiftSupportedShopModel():
return $default(_that.id,_that.name,_that.shopAddress,_that.shopEmail,_that.shopPhone,_that.shopWebsite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String shopAddress,  String shopEmail,  String shopPhone,  String shopWebsite)?  $default,) {final _that = this;
switch (_that) {
case _GiftSupportedShopModel() when $default != null:
return $default(_that.id,_that.name,_that.shopAddress,_that.shopEmail,_that.shopPhone,_that.shopWebsite);case _:
  return null;

}
}

}

/// @nodoc


class _GiftSupportedShopModel implements GiftSupportedShopModel {
  const _GiftSupportedShopModel({required this.id, required this.name, required this.shopAddress, required this.shopEmail, required this.shopPhone, required this.shopWebsite});
  

@override final  String id;
@override final  String name;
@override final  String shopAddress;
@override final  String shopEmail;
@override final  String shopPhone;
@override final  String shopWebsite;

/// Create a copy of GiftSupportedShopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftSupportedShopModelCopyWith<_GiftSupportedShopModel> get copyWith => __$GiftSupportedShopModelCopyWithImpl<_GiftSupportedShopModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftSupportedShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopWebsite, shopWebsite) || other.shopWebsite == shopWebsite));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,shopAddress,shopEmail,shopPhone,shopWebsite);

@override
String toString() {
  return 'GiftSupportedShopModel(id: $id, name: $name, shopAddress: $shopAddress, shopEmail: $shopEmail, shopPhone: $shopPhone, shopWebsite: $shopWebsite)';
}


}

/// @nodoc
abstract mixin class _$GiftSupportedShopModelCopyWith<$Res> implements $GiftSupportedShopModelCopyWith<$Res> {
  factory _$GiftSupportedShopModelCopyWith(_GiftSupportedShopModel value, $Res Function(_GiftSupportedShopModel) _then) = __$GiftSupportedShopModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String shopAddress, String shopEmail, String shopPhone, String shopWebsite
});




}
/// @nodoc
class __$GiftSupportedShopModelCopyWithImpl<$Res>
    implements _$GiftSupportedShopModelCopyWith<$Res> {
  __$GiftSupportedShopModelCopyWithImpl(this._self, this._then);

  final _GiftSupportedShopModel _self;
  final $Res Function(_GiftSupportedShopModel) _then;

/// Create a copy of GiftSupportedShopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shopAddress = null,Object? shopEmail = null,Object? shopPhone = null,Object? shopWebsite = null,}) {
  return _then(_GiftSupportedShopModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,shopEmail: null == shopEmail ? _self.shopEmail : shopEmail // ignore: cast_nullable_to_non_nullable
as String,shopPhone: null == shopPhone ? _self.shopPhone : shopPhone // ignore: cast_nullable_to_non_nullable
as String,shopWebsite: null == shopWebsite ? _self.shopWebsite : shopWebsite // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
