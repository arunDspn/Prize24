// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GiftDto {

/// Name of the gift
 String get name; String get description; DateTime get createdAt; DateTime get updatedAt;/// Campaign ID to which this gift belongs
 String get campaignId; String get campaignName;/// Total quantity of the gift available
 int get totalQuantity;/// Remaining quantity of the gift available
 int get remainingQuantity;/// Gift type -> 'auto' or 'code'
 String get giftType; bool get isRedeemable; String get userId;/// Unique identifier for the gift
@JsonKey(includeIfNull: false) String? get id;/// For public campaigns only - URL-friendly identifier for the gift
 String? get publicSlug;/// User ID of the creator of the gift
// required String userId,
// Conditional fields based on gift type and redeemability:
// For CODE type gifts only - contains all the gift codes
// List<GiftCode>? codegiftCodes,
// For REDEEMABLE gifts only (both auto and code types)
// Contains shops where this gift can be redeemed
 List<SupportedShopDto>? get supportedShops;
/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftDtoCopyWith<GiftDto> get copyWith => _$GiftDtoCopyWithImpl<GiftDto>(this as GiftDto, _$identity);

  /// Serializes this GiftDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.id, id) || other.id == id)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&const DeepCollectionEquality().equals(other.supportedShops, supportedShops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,createdAt,updatedAt,campaignId,campaignName,totalQuantity,remainingQuantity,giftType,isRedeemable,userId,id,publicSlug,const DeepCollectionEquality().hash(supportedShops));

@override
String toString() {
  return 'GiftDto(name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, campaignId: $campaignId, campaignName: $campaignName, totalQuantity: $totalQuantity, remainingQuantity: $remainingQuantity, giftType: $giftType, isRedeemable: $isRedeemable, userId: $userId, id: $id, publicSlug: $publicSlug, supportedShops: $supportedShops)';
}


}

/// @nodoc
abstract mixin class $GiftDtoCopyWith<$Res>  {
  factory $GiftDtoCopyWith(GiftDto value, $Res Function(GiftDto) _then) = _$GiftDtoCopyWithImpl;
@useResult
$Res call({
 String name, String description, DateTime createdAt, DateTime updatedAt, String campaignId, String campaignName, int totalQuantity, int remainingQuantity, String giftType, bool isRedeemable, String userId,@JsonKey(includeIfNull: false) String? id, String? publicSlug, List<SupportedShopDto>? supportedShops
});




}
/// @nodoc
class _$GiftDtoCopyWithImpl<$Res>
    implements $GiftDtoCopyWith<$Res> {
  _$GiftDtoCopyWithImpl(this._self, this._then);

  final GiftDto _self;
  final $Res Function(GiftDto) _then;

/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? campaignId = null,Object? campaignName = null,Object? totalQuantity = null,Object? remainingQuantity = null,Object? giftType = null,Object? isRedeemable = null,Object? userId = null,Object? id = freezed,Object? publicSlug = freezed,Object? supportedShops = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
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
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,publicSlug: freezed == publicSlug ? _self.publicSlug : publicSlug // ignore: cast_nullable_to_non_nullable
as String?,supportedShops: freezed == supportedShops ? _self.supportedShops : supportedShops // ignore: cast_nullable_to_non_nullable
as List<SupportedShopDto>?,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftDto].
extension GiftDtoPatterns on GiftDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftDto value)  $default,){
final _that = this;
switch (_that) {
case _GiftDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftDto value)?  $default,){
final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  DateTime createdAt,  DateTime updatedAt,  String campaignId,  String campaignName,  int totalQuantity,  int remainingQuantity,  String giftType,  bool isRedeemable,  String userId, @JsonKey(includeIfNull: false)  String? id,  String? publicSlug,  List<SupportedShopDto>? supportedShops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
return $default(_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.campaignId,_that.campaignName,_that.totalQuantity,_that.remainingQuantity,_that.giftType,_that.isRedeemable,_that.userId,_that.id,_that.publicSlug,_that.supportedShops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  DateTime createdAt,  DateTime updatedAt,  String campaignId,  String campaignName,  int totalQuantity,  int remainingQuantity,  String giftType,  bool isRedeemable,  String userId, @JsonKey(includeIfNull: false)  String? id,  String? publicSlug,  List<SupportedShopDto>? supportedShops)  $default,) {final _that = this;
switch (_that) {
case _GiftDto():
return $default(_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.campaignId,_that.campaignName,_that.totalQuantity,_that.remainingQuantity,_that.giftType,_that.isRedeemable,_that.userId,_that.id,_that.publicSlug,_that.supportedShops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  DateTime createdAt,  DateTime updatedAt,  String campaignId,  String campaignName,  int totalQuantity,  int remainingQuantity,  String giftType,  bool isRedeemable,  String userId, @JsonKey(includeIfNull: false)  String? id,  String? publicSlug,  List<SupportedShopDto>? supportedShops)?  $default,) {final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
return $default(_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.campaignId,_that.campaignName,_that.totalQuantity,_that.remainingQuantity,_that.giftType,_that.isRedeemable,_that.userId,_that.id,_that.publicSlug,_that.supportedShops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftDto extends GiftDto {
  const _GiftDto({required this.name, required this.description, required this.createdAt, required this.updatedAt, required this.campaignId, required this.campaignName, required this.totalQuantity, required this.remainingQuantity, required this.giftType, required this.isRedeemable, required this.userId, @JsonKey(includeIfNull: false) this.id, this.publicSlug, final  List<SupportedShopDto>? supportedShops}): _supportedShops = supportedShops,super._();
  factory _GiftDto.fromJson(Map<String, dynamic> json) => _$GiftDtoFromJson(json);

/// Name of the gift
@override final  String name;
@override final  String description;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
/// Campaign ID to which this gift belongs
@override final  String campaignId;
@override final  String campaignName;
/// Total quantity of the gift available
@override final  int totalQuantity;
/// Remaining quantity of the gift available
@override final  int remainingQuantity;
/// Gift type -> 'auto' or 'code'
@override final  String giftType;
@override final  bool isRedeemable;
@override final  String userId;
/// Unique identifier for the gift
@override@JsonKey(includeIfNull: false) final  String? id;
/// For public campaigns only - URL-friendly identifier for the gift
@override final  String? publicSlug;
/// User ID of the creator of the gift
// required String userId,
// Conditional fields based on gift type and redeemability:
// For CODE type gifts only - contains all the gift codes
// List<GiftCode>? codegiftCodes,
// For REDEEMABLE gifts only (both auto and code types)
// Contains shops where this gift can be redeemed
 final  List<SupportedShopDto>? _supportedShops;
/// User ID of the creator of the gift
// required String userId,
// Conditional fields based on gift type and redeemability:
// For CODE type gifts only - contains all the gift codes
// List<GiftCode>? codegiftCodes,
// For REDEEMABLE gifts only (both auto and code types)
// Contains shops where this gift can be redeemed
@override List<SupportedShopDto>? get supportedShops {
  final value = _supportedShops;
  if (value == null) return null;
  if (_supportedShops is EqualUnmodifiableListView) return _supportedShops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftDtoCopyWith<_GiftDto> get copyWith => __$GiftDtoCopyWithImpl<_GiftDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.remainingQuantity, remainingQuantity) || other.remainingQuantity == remainingQuantity)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.id, id) || other.id == id)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&const DeepCollectionEquality().equals(other._supportedShops, _supportedShops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,createdAt,updatedAt,campaignId,campaignName,totalQuantity,remainingQuantity,giftType,isRedeemable,userId,id,publicSlug,const DeepCollectionEquality().hash(_supportedShops));

@override
String toString() {
  return 'GiftDto(name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, campaignId: $campaignId, campaignName: $campaignName, totalQuantity: $totalQuantity, remainingQuantity: $remainingQuantity, giftType: $giftType, isRedeemable: $isRedeemable, userId: $userId, id: $id, publicSlug: $publicSlug, supportedShops: $supportedShops)';
}


}

/// @nodoc
abstract mixin class _$GiftDtoCopyWith<$Res> implements $GiftDtoCopyWith<$Res> {
  factory _$GiftDtoCopyWith(_GiftDto value, $Res Function(_GiftDto) _then) = __$GiftDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, DateTime createdAt, DateTime updatedAt, String campaignId, String campaignName, int totalQuantity, int remainingQuantity, String giftType, bool isRedeemable, String userId,@JsonKey(includeIfNull: false) String? id, String? publicSlug, List<SupportedShopDto>? supportedShops
});




}
/// @nodoc
class __$GiftDtoCopyWithImpl<$Res>
    implements _$GiftDtoCopyWith<$Res> {
  __$GiftDtoCopyWithImpl(this._self, this._then);

  final _GiftDto _self;
  final $Res Function(_GiftDto) _then;

/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? campaignId = null,Object? campaignName = null,Object? totalQuantity = null,Object? remainingQuantity = null,Object? giftType = null,Object? isRedeemable = null,Object? userId = null,Object? id = freezed,Object? publicSlug = freezed,Object? supportedShops = freezed,}) {
  return _then(_GiftDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
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
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,publicSlug: freezed == publicSlug ? _self.publicSlug : publicSlug // ignore: cast_nullable_to_non_nullable
as String?,supportedShops: freezed == supportedShops ? _self._supportedShops : supportedShops // ignore: cast_nullable_to_non_nullable
as List<SupportedShopDto>?,
  ));
}


}


/// @nodoc
mixin _$CodeGiftCodeDto {

@JsonKey(includeIfNull: false) String? get id; String get code;@JsonKey(includeIfNull: false) String? get payload; bool get isRedeemed; String? get redeemedByUserId;
/// Create a copy of CodeGiftCodeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeGiftCodeDtoCopyWith<CodeGiftCodeDto> get copyWith => _$CodeGiftCodeDtoCopyWithImpl<CodeGiftCodeDto>(this as CodeGiftCodeDto, _$identity);

  /// Serializes this CodeGiftCodeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeGiftCodeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.isRedeemed, isRedeemed) || other.isRedeemed == isRedeemed)&&(identical(other.redeemedByUserId, redeemedByUserId) || other.redeemedByUserId == redeemedByUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,payload,isRedeemed,redeemedByUserId);

@override
String toString() {
  return 'CodeGiftCodeDto(id: $id, code: $code, payload: $payload, isRedeemed: $isRedeemed, redeemedByUserId: $redeemedByUserId)';
}


}

/// @nodoc
abstract mixin class $CodeGiftCodeDtoCopyWith<$Res>  {
  factory $CodeGiftCodeDtoCopyWith(CodeGiftCodeDto value, $Res Function(CodeGiftCodeDto) _then) = _$CodeGiftCodeDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? id, String code,@JsonKey(includeIfNull: false) String? payload, bool isRedeemed, String? redeemedByUserId
});




}
/// @nodoc
class _$CodeGiftCodeDtoCopyWithImpl<$Res>
    implements $CodeGiftCodeDtoCopyWith<$Res> {
  _$CodeGiftCodeDtoCopyWithImpl(this._self, this._then);

  final CodeGiftCodeDto _self;
  final $Res Function(CodeGiftCodeDto) _then;

/// Create a copy of CodeGiftCodeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? code = null,Object? payload = freezed,Object? isRedeemed = null,Object? redeemedByUserId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,isRedeemed: null == isRedeemed ? _self.isRedeemed : isRedeemed // ignore: cast_nullable_to_non_nullable
as bool,redeemedByUserId: freezed == redeemedByUserId ? _self.redeemedByUserId : redeemedByUserId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CodeGiftCodeDto].
extension CodeGiftCodeDtoPatterns on CodeGiftCodeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CodeGiftCodeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CodeGiftCodeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CodeGiftCodeDto value)  $default,){
final _that = this;
switch (_that) {
case _CodeGiftCodeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CodeGiftCodeDto value)?  $default,){
final _that = this;
switch (_that) {
case _CodeGiftCodeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id,  String code, @JsonKey(includeIfNull: false)  String? payload,  bool isRedeemed,  String? redeemedByUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CodeGiftCodeDto() when $default != null:
return $default(_that.id,_that.code,_that.payload,_that.isRedeemed,_that.redeemedByUserId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id,  String code, @JsonKey(includeIfNull: false)  String? payload,  bool isRedeemed,  String? redeemedByUserId)  $default,) {final _that = this;
switch (_that) {
case _CodeGiftCodeDto():
return $default(_that.id,_that.code,_that.payload,_that.isRedeemed,_that.redeemedByUserId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? id,  String code, @JsonKey(includeIfNull: false)  String? payload,  bool isRedeemed,  String? redeemedByUserId)?  $default,) {final _that = this;
switch (_that) {
case _CodeGiftCodeDto() when $default != null:
return $default(_that.id,_that.code,_that.payload,_that.isRedeemed,_that.redeemedByUserId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CodeGiftCodeDto extends CodeGiftCodeDto {
  const _CodeGiftCodeDto({@JsonKey(includeIfNull: false) required this.id, required this.code, @JsonKey(includeIfNull: false) required this.payload, required this.isRedeemed, this.redeemedByUserId}): super._();
  factory _CodeGiftCodeDto.fromJson(Map<String, dynamic> json) => _$CodeGiftCodeDtoFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? id;
@override final  String code;
@override@JsonKey(includeIfNull: false) final  String? payload;
@override final  bool isRedeemed;
@override final  String? redeemedByUserId;

/// Create a copy of CodeGiftCodeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeGiftCodeDtoCopyWith<_CodeGiftCodeDto> get copyWith => __$CodeGiftCodeDtoCopyWithImpl<_CodeGiftCodeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CodeGiftCodeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeGiftCodeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.isRedeemed, isRedeemed) || other.isRedeemed == isRedeemed)&&(identical(other.redeemedByUserId, redeemedByUserId) || other.redeemedByUserId == redeemedByUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,payload,isRedeemed,redeemedByUserId);

@override
String toString() {
  return 'CodeGiftCodeDto(id: $id, code: $code, payload: $payload, isRedeemed: $isRedeemed, redeemedByUserId: $redeemedByUserId)';
}


}

/// @nodoc
abstract mixin class _$CodeGiftCodeDtoCopyWith<$Res> implements $CodeGiftCodeDtoCopyWith<$Res> {
  factory _$CodeGiftCodeDtoCopyWith(_CodeGiftCodeDto value, $Res Function(_CodeGiftCodeDto) _then) = __$CodeGiftCodeDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? id, String code,@JsonKey(includeIfNull: false) String? payload, bool isRedeemed, String? redeemedByUserId
});




}
/// @nodoc
class __$CodeGiftCodeDtoCopyWithImpl<$Res>
    implements _$CodeGiftCodeDtoCopyWith<$Res> {
  __$CodeGiftCodeDtoCopyWithImpl(this._self, this._then);

  final _CodeGiftCodeDto _self;
  final $Res Function(_CodeGiftCodeDto) _then;

/// Create a copy of CodeGiftCodeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? code = null,Object? payload = freezed,Object? isRedeemed = null,Object? redeemedByUserId = freezed,}) {
  return _then(_CodeGiftCodeDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,isRedeemed: null == isRedeemed ? _self.isRedeemed : isRedeemed // ignore: cast_nullable_to_non_nullable
as bool,redeemedByUserId: freezed == redeemedByUserId ? _self.redeemedByUserId : redeemedByUserId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AutoGiftPayloadDto {

@JsonKey(includeIfNull: false) String? get id; String get content;// Optional fields
 DateTime? get redeemedAt; String? get redeemedByUserId;
/// Create a copy of AutoGiftPayloadDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutoGiftPayloadDtoCopyWith<AutoGiftPayloadDto> get copyWith => _$AutoGiftPayloadDtoCopyWithImpl<AutoGiftPayloadDto>(this as AutoGiftPayloadDto, _$identity);

  /// Serializes this AutoGiftPayloadDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutoGiftPayloadDto&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&(identical(other.redeemedByUserId, redeemedByUserId) || other.redeemedByUserId == redeemedByUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,redeemedAt,redeemedByUserId);

@override
String toString() {
  return 'AutoGiftPayloadDto(id: $id, content: $content, redeemedAt: $redeemedAt, redeemedByUserId: $redeemedByUserId)';
}


}

/// @nodoc
abstract mixin class $AutoGiftPayloadDtoCopyWith<$Res>  {
  factory $AutoGiftPayloadDtoCopyWith(AutoGiftPayloadDto value, $Res Function(AutoGiftPayloadDto) _then) = _$AutoGiftPayloadDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? id, String content, DateTime? redeemedAt, String? redeemedByUserId
});




}
/// @nodoc
class _$AutoGiftPayloadDtoCopyWithImpl<$Res>
    implements $AutoGiftPayloadDtoCopyWith<$Res> {
  _$AutoGiftPayloadDtoCopyWithImpl(this._self, this._then);

  final AutoGiftPayloadDto _self;
  final $Res Function(AutoGiftPayloadDto) _then;

/// Create a copy of AutoGiftPayloadDto
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


/// Adds pattern-matching-related methods to [AutoGiftPayloadDto].
extension AutoGiftPayloadDtoPatterns on AutoGiftPayloadDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutoGiftPayloadDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutoGiftPayloadDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutoGiftPayloadDto value)  $default,){
final _that = this;
switch (_that) {
case _AutoGiftPayloadDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutoGiftPayloadDto value)?  $default,){
final _that = this;
switch (_that) {
case _AutoGiftPayloadDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id,  String content,  DateTime? redeemedAt,  String? redeemedByUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutoGiftPayloadDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id,  String content,  DateTime? redeemedAt,  String? redeemedByUserId)  $default,) {final _that = this;
switch (_that) {
case _AutoGiftPayloadDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? id,  String content,  DateTime? redeemedAt,  String? redeemedByUserId)?  $default,) {final _that = this;
switch (_that) {
case _AutoGiftPayloadDto() when $default != null:
return $default(_that.id,_that.content,_that.redeemedAt,_that.redeemedByUserId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutoGiftPayloadDto extends AutoGiftPayloadDto {
  const _AutoGiftPayloadDto({@JsonKey(includeIfNull: false) required this.id, required this.content, this.redeemedAt, this.redeemedByUserId}): super._();
  factory _AutoGiftPayloadDto.fromJson(Map<String, dynamic> json) => _$AutoGiftPayloadDtoFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? id;
@override final  String content;
// Optional fields
@override final  DateTime? redeemedAt;
@override final  String? redeemedByUserId;

/// Create a copy of AutoGiftPayloadDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutoGiftPayloadDtoCopyWith<_AutoGiftPayloadDto> get copyWith => __$AutoGiftPayloadDtoCopyWithImpl<_AutoGiftPayloadDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutoGiftPayloadDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoGiftPayloadDto&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&(identical(other.redeemedByUserId, redeemedByUserId) || other.redeemedByUserId == redeemedByUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,redeemedAt,redeemedByUserId);

@override
String toString() {
  return 'AutoGiftPayloadDto(id: $id, content: $content, redeemedAt: $redeemedAt, redeemedByUserId: $redeemedByUserId)';
}


}

/// @nodoc
abstract mixin class _$AutoGiftPayloadDtoCopyWith<$Res> implements $AutoGiftPayloadDtoCopyWith<$Res> {
  factory _$AutoGiftPayloadDtoCopyWith(_AutoGiftPayloadDto value, $Res Function(_AutoGiftPayloadDto) _then) = __$AutoGiftPayloadDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? id, String content, DateTime? redeemedAt, String? redeemedByUserId
});




}
/// @nodoc
class __$AutoGiftPayloadDtoCopyWithImpl<$Res>
    implements _$AutoGiftPayloadDtoCopyWith<$Res> {
  __$AutoGiftPayloadDtoCopyWithImpl(this._self, this._then);

  final _AutoGiftPayloadDto _self;
  final $Res Function(_AutoGiftPayloadDto) _then;

/// Create a copy of AutoGiftPayloadDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? content = null,Object? redeemedAt = freezed,Object? redeemedByUserId = freezed,}) {
  return _then(_AutoGiftPayloadDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,redeemedAt: freezed == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,redeemedByUserId: freezed == redeemedByUserId ? _self.redeemedByUserId : redeemedByUserId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SupportedShopDto {

 String get id; String get name; String get shopAddress; String get shopPhone; String? get shopEmail;// Made optional to match domain model
 String? get shopWebsite;
/// Create a copy of SupportedShopDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedShopDtoCopyWith<SupportedShopDto> get copyWith => _$SupportedShopDtoCopyWithImpl<SupportedShopDto>(this as SupportedShopDto, _$identity);

  /// Serializes this SupportedShopDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedShopDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopWebsite, shopWebsite) || other.shopWebsite == shopWebsite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shopAddress,shopPhone,shopEmail,shopWebsite);

@override
String toString() {
  return 'SupportedShopDto(id: $id, name: $name, shopAddress: $shopAddress, shopPhone: $shopPhone, shopEmail: $shopEmail, shopWebsite: $shopWebsite)';
}


}

/// @nodoc
abstract mixin class $SupportedShopDtoCopyWith<$Res>  {
  factory $SupportedShopDtoCopyWith(SupportedShopDto value, $Res Function(SupportedShopDto) _then) = _$SupportedShopDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String shopAddress, String shopPhone, String? shopEmail, String? shopWebsite
});




}
/// @nodoc
class _$SupportedShopDtoCopyWithImpl<$Res>
    implements $SupportedShopDtoCopyWith<$Res> {
  _$SupportedShopDtoCopyWithImpl(this._self, this._then);

  final SupportedShopDto _self;
  final $Res Function(SupportedShopDto) _then;

/// Create a copy of SupportedShopDto
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


/// Adds pattern-matching-related methods to [SupportedShopDto].
extension SupportedShopDtoPatterns on SupportedShopDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportedShopDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportedShopDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportedShopDto value)  $default,){
final _that = this;
switch (_that) {
case _SupportedShopDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportedShopDto value)?  $default,){
final _that = this;
switch (_that) {
case _SupportedShopDto() when $default != null:
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
case _SupportedShopDto() when $default != null:
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
case _SupportedShopDto():
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
case _SupportedShopDto() when $default != null:
return $default(_that.id,_that.name,_that.shopAddress,_that.shopPhone,_that.shopEmail,_that.shopWebsite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportedShopDto extends SupportedShopDto {
  const _SupportedShopDto({required this.id, required this.name, required this.shopAddress, required this.shopPhone, this.shopEmail, this.shopWebsite}): super._();
  factory _SupportedShopDto.fromJson(Map<String, dynamic> json) => _$SupportedShopDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String shopAddress;
@override final  String shopPhone;
@override final  String? shopEmail;
// Made optional to match domain model
@override final  String? shopWebsite;

/// Create a copy of SupportedShopDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportedShopDtoCopyWith<_SupportedShopDto> get copyWith => __$SupportedShopDtoCopyWithImpl<_SupportedShopDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedShopDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportedShopDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.shopPhone, shopPhone) || other.shopPhone == shopPhone)&&(identical(other.shopEmail, shopEmail) || other.shopEmail == shopEmail)&&(identical(other.shopWebsite, shopWebsite) || other.shopWebsite == shopWebsite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shopAddress,shopPhone,shopEmail,shopWebsite);

@override
String toString() {
  return 'SupportedShopDto(id: $id, name: $name, shopAddress: $shopAddress, shopPhone: $shopPhone, shopEmail: $shopEmail, shopWebsite: $shopWebsite)';
}


}

/// @nodoc
abstract mixin class _$SupportedShopDtoCopyWith<$Res> implements $SupportedShopDtoCopyWith<$Res> {
  factory _$SupportedShopDtoCopyWith(_SupportedShopDto value, $Res Function(_SupportedShopDto) _then) = __$SupportedShopDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String shopAddress, String shopPhone, String? shopEmail, String? shopWebsite
});




}
/// @nodoc
class __$SupportedShopDtoCopyWithImpl<$Res>
    implements _$SupportedShopDtoCopyWith<$Res> {
  __$SupportedShopDtoCopyWithImpl(this._self, this._then);

  final _SupportedShopDto _self;
  final $Res Function(_SupportedShopDto) _then;

/// Create a copy of SupportedShopDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shopAddress = null,Object? shopPhone = null,Object? shopEmail = freezed,Object? shopWebsite = freezed,}) {
  return _then(_SupportedShopDto(
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
