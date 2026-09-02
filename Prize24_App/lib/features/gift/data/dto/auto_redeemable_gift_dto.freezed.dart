// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auto_redeemable_gift_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AutoRedeemableGiftDto {

 String get campaignId; String get campaignName; String get createdAt; String get description; String get giftType; bool get isRedeemable; String get name; String? get publicSlug; int get remainingQuantity; List<GiftSupportedShopDto> get supportedShops; int get totalQuantity; String get updatedAt; String get userId;
/// Create a copy of AutoRedeemableGiftDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutoRedeemableGiftDtoCopyWith<AutoRedeemableGiftDto> get copyWith => _$AutoRedeemableGiftDtoCopyWithImpl<AutoRedeemableGiftDto>(this as AutoRedeemableGiftDto, _$identity);

  /// Serializes this AutoRedeemableGiftDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutoRedeemableGiftDto&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.name, name) || other.name == name)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&const DeepCollectionEquality().equals(other.supportedShops, supportedShops)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,campaignId,campaignName,createdAt,description,giftType,isRedeemable,name,publicSlug,remainingQuantity,const DeepCollectionEquality().hash(supportedShops),totalQuantity,updatedAt,userId);

@override
String toString() {
  return 'AutoRedeemableGiftDto(campaignId: $campaignId, campaignName: $campaignName, createdAt: $createdAt, description: $description, giftType: $giftType, isRedeemable: $isRedeemable, name: $name, publicSlug: $publicSlug, remainingQuantity: $remainingQuantity, supportedShops: $supportedShops, totalQuantity: $totalQuantity, updatedAt: $updatedAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $AutoRedeemableGiftDtoCopyWith<$Res>  {
  factory $AutoRedeemableGiftDtoCopyWith(AutoRedeemableGiftDto value, $Res Function(AutoRedeemableGiftDto) _then) = _$AutoRedeemableGiftDtoCopyWithImpl;
@useResult
$Res call({
 String campaignId, String campaignName, String createdAt, String description, String giftType, bool isRedeemable, String name, String? publicSlug, int remainingQuantity, List<GiftSupportedShopDto> supportedShops, int totalQuantity, String updatedAt, String userId
});




}
/// @nodoc
class _$AutoRedeemableGiftDtoCopyWithImpl<$Res>
    implements $AutoRedeemableGiftDtoCopyWith<$Res> {
  _$AutoRedeemableGiftDtoCopyWithImpl(this._self, this._then);

  final AutoRedeemableGiftDto _self;
  final $Res Function(AutoRedeemableGiftDto) _then;

/// Create a copy of AutoRedeemableGiftDto
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
as List<GiftSupportedShopDto>,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AutoRedeemableGiftDto].
extension AutoRedeemableGiftDtoPatterns on AutoRedeemableGiftDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutoRedeemableGiftDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutoRedeemableGiftDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutoRedeemableGiftDto value)  $default,){
final _that = this;
switch (_that) {
case _AutoRedeemableGiftDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutoRedeemableGiftDto value)?  $default,){
final _that = this;
switch (_that) {
case _AutoRedeemableGiftDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String campaignId,  String campaignName,  String createdAt,  String description,  String giftType,  bool isRedeemable,  String name,  String? publicSlug,  int remainingQuantity,  List<GiftSupportedShopDto> supportedShops,  int totalQuantity,  String updatedAt,  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutoRedeemableGiftDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String campaignId,  String campaignName,  String createdAt,  String description,  String giftType,  bool isRedeemable,  String name,  String? publicSlug,  int remainingQuantity,  List<GiftSupportedShopDto> supportedShops,  int totalQuantity,  String updatedAt,  String userId)  $default,) {final _that = this;
switch (_that) {
case _AutoRedeemableGiftDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String campaignId,  String campaignName,  String createdAt,  String description,  String giftType,  bool isRedeemable,  String name,  String? publicSlug,  int remainingQuantity,  List<GiftSupportedShopDto> supportedShops,  int totalQuantity,  String updatedAt,  String userId)?  $default,) {final _that = this;
switch (_that) {
case _AutoRedeemableGiftDto() when $default != null:
return $default(_that.campaignId,_that.campaignName,_that.createdAt,_that.description,_that.giftType,_that.isRedeemable,_that.name,_that.publicSlug,_that.remainingQuantity,_that.supportedShops,_that.totalQuantity,_that.updatedAt,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutoRedeemableGiftDto extends AutoRedeemableGiftDto {
  const _AutoRedeemableGiftDto({required this.campaignId, required this.campaignName, required this.createdAt, required this.description, required this.giftType, required this.isRedeemable, required this.name, required this.publicSlug, required this.remainingQuantity, required final  List<GiftSupportedShopDto> supportedShops, required this.totalQuantity, required this.updatedAt, required this.userId}): _supportedShops = supportedShops,super._();
  factory _AutoRedeemableGiftDto.fromJson(Map<String, dynamic> json) => _$AutoRedeemableGiftDtoFromJson(json);

@override final  String campaignId;
@override final  String campaignName;
@override final  String createdAt;
@override final  String description;
@override final  String giftType;
@override final  bool isRedeemable;
@override final  String name;
@override final  String? publicSlug;
@override final  int remainingQuantity;
 final  List<GiftSupportedShopDto> _supportedShops;
@override List<GiftSupportedShopDto> get supportedShops {
  if (_supportedShops is EqualUnmodifiableListView) return _supportedShops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportedShops);
}

@override final  int totalQuantity;
@override final  String updatedAt;
@override final  String userId;

/// Create a copy of AutoRedeemableGiftDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutoRedeemableGiftDtoCopyWith<_AutoRedeemableGiftDto> get copyWith => __$AutoRedeemableGiftDtoCopyWithImpl<_AutoRedeemableGiftDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutoRedeemableGiftDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoRedeemableGiftDto&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.name, name) || other.name == name)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&const DeepCollectionEquality().equals(other._supportedShops, _supportedShops)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,campaignId,campaignName,createdAt,description,giftType,isRedeemable,name,publicSlug,remainingQuantity,const DeepCollectionEquality().hash(_supportedShops),totalQuantity,updatedAt,userId);

@override
String toString() {
  return 'AutoRedeemableGiftDto(campaignId: $campaignId, campaignName: $campaignName, createdAt: $createdAt, description: $description, giftType: $giftType, isRedeemable: $isRedeemable, name: $name, publicSlug: $publicSlug, remainingQuantity: $remainingQuantity, supportedShops: $supportedShops, totalQuantity: $totalQuantity, updatedAt: $updatedAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$AutoRedeemableGiftDtoCopyWith<$Res> implements $AutoRedeemableGiftDtoCopyWith<$Res> {
  factory _$AutoRedeemableGiftDtoCopyWith(_AutoRedeemableGiftDto value, $Res Function(_AutoRedeemableGiftDto) _then) = __$AutoRedeemableGiftDtoCopyWithImpl;
@override @useResult
$Res call({
 String campaignId, String campaignName, String createdAt, String description, String giftType, bool isRedeemable, String name, String? publicSlug, int remainingQuantity, List<GiftSupportedShopDto> supportedShops, int totalQuantity, String updatedAt, String userId
});




}
/// @nodoc
class __$AutoRedeemableGiftDtoCopyWithImpl<$Res>
    implements _$AutoRedeemableGiftDtoCopyWith<$Res> {
  __$AutoRedeemableGiftDtoCopyWithImpl(this._self, this._then);

  final _AutoRedeemableGiftDto _self;
  final $Res Function(_AutoRedeemableGiftDto) _then;

/// Create a copy of AutoRedeemableGiftDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? campaignId = null,Object? campaignName = null,Object? createdAt = null,Object? description = null,Object? giftType = null,Object? isRedeemable = null,Object? name = null,Object? publicSlug = freezed,Object? remainingQuantity = null,Object? supportedShops = null,Object? totalQuantity = null,Object? updatedAt = null,Object? userId = null,}) {
  return _then(_AutoRedeemableGiftDto(
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
as List<GiftSupportedShopDto>,totalQuantity: null == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GiftSupportedShopDto {

 String get id; String get name; String get shopAddress; String get shopEmail; String get shopPhone; String get shopWebsite;
/// Create a copy of GiftSupportedShopDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftSupportedShopDtoCopyWith<GiftSupportedShopDto> get copyWith => _$GiftSupportedShopDtoCopyWithImpl<GiftSupportedShopDto>(this as GiftSupportedShopDto, _$identity);

  /// Serializes this GiftSupportedShopDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftSupportedShopDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopWebsite, shopWebsite) || other.shopWebsite == shopWebsite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shopAddress,shopEmail,shopPhone,shopWebsite);

@override
String toString() {
  return 'GiftSupportedShopDto(id: $id, name: $name, shopAddress: $shopAddress, shopEmail: $shopEmail, shopPhone: $shopPhone, shopWebsite: $shopWebsite)';
}


}

/// @nodoc
abstract mixin class $GiftSupportedShopDtoCopyWith<$Res>  {
  factory $GiftSupportedShopDtoCopyWith(GiftSupportedShopDto value, $Res Function(GiftSupportedShopDto) _then) = _$GiftSupportedShopDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String shopAddress, String shopEmail, String shopPhone, String shopWebsite
});




}
/// @nodoc
class _$GiftSupportedShopDtoCopyWithImpl<$Res>
    implements $GiftSupportedShopDtoCopyWith<$Res> {
  _$GiftSupportedShopDtoCopyWithImpl(this._self, this._then);

  final GiftSupportedShopDto _self;
  final $Res Function(GiftSupportedShopDto) _then;

/// Create a copy of GiftSupportedShopDto
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


/// Adds pattern-matching-related methods to [GiftSupportedShopDto].
extension GiftSupportedShopDtoPatterns on GiftSupportedShopDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftSupportedShopDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftSupportedShopDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftSupportedShopDto value)  $default,){
final _that = this;
switch (_that) {
case _GiftSupportedShopDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftSupportedShopDto value)?  $default,){
final _that = this;
switch (_that) {
case _GiftSupportedShopDto() when $default != null:
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
case _GiftSupportedShopDto() when $default != null:
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
case _GiftSupportedShopDto():
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
case _GiftSupportedShopDto() when $default != null:
return $default(_that.id,_that.name,_that.shopAddress,_that.shopEmail,_that.shopPhone,_that.shopWebsite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftSupportedShopDto extends GiftSupportedShopDto {
  const _GiftSupportedShopDto({required this.id, required this.name, required this.shopAddress, required this.shopEmail, required this.shopPhone, required this.shopWebsite}): super._();
  factory _GiftSupportedShopDto.fromJson(Map<String, dynamic> json) => _$GiftSupportedShopDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String shopAddress;
@override final  String shopEmail;
@override final  String shopPhone;
@override final  String shopWebsite;

/// Create a copy of GiftSupportedShopDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftSupportedShopDtoCopyWith<_GiftSupportedShopDto> get copyWith => __$GiftSupportedShopDtoCopyWithImpl<_GiftSupportedShopDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftSupportedShopDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftSupportedShopDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopWebsite, shopWebsite) || other.shopWebsite == shopWebsite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shopAddress,shopEmail,shopPhone,shopWebsite);

@override
String toString() {
  return 'GiftSupportedShopDto(id: $id, name: $name, shopAddress: $shopAddress, shopEmail: $shopEmail, shopPhone: $shopPhone, shopWebsite: $shopWebsite)';
}


}

/// @nodoc
abstract mixin class _$GiftSupportedShopDtoCopyWith<$Res> implements $GiftSupportedShopDtoCopyWith<$Res> {
  factory _$GiftSupportedShopDtoCopyWith(_GiftSupportedShopDto value, $Res Function(_GiftSupportedShopDto) _then) = __$GiftSupportedShopDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String shopAddress, String shopEmail, String shopPhone, String shopWebsite
});




}
/// @nodoc
class __$GiftSupportedShopDtoCopyWithImpl<$Res>
    implements _$GiftSupportedShopDtoCopyWith<$Res> {
  __$GiftSupportedShopDtoCopyWithImpl(this._self, this._then);

  final _GiftSupportedShopDto _self;
  final $Res Function(_GiftSupportedShopDto) _then;

/// Create a copy of GiftSupportedShopDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shopAddress = null,Object? shopEmail = null,Object? shopPhone = null,Object? shopWebsite = null,}) {
  return _then(_GiftSupportedShopDto(
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
