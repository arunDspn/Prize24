// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_shared_vendor_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CampaignSharedVendorDto {

 String get userId; String get vendorName; String get vendorId; List<SharedVendorsShop> get sharedVendorsShops;
/// Create a copy of CampaignSharedVendorDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignSharedVendorDtoCopyWith<CampaignSharedVendorDto> get copyWith => _$CampaignSharedVendorDtoCopyWithImpl<CampaignSharedVendorDto>(this as CampaignSharedVendorDto, _$identity);

  /// Serializes this CampaignSharedVendorDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignSharedVendorDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&const DeepCollectionEquality().equals(other.sharedVendorsShops, sharedVendorsShops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,vendorName,vendorId,const DeepCollectionEquality().hash(sharedVendorsShops));

@override
String toString() {
  return 'CampaignSharedVendorDto(userId: $userId, vendorName: $vendorName, vendorId: $vendorId, sharedVendorsShops: $sharedVendorsShops)';
}


}

/// @nodoc
abstract mixin class $CampaignSharedVendorDtoCopyWith<$Res>  {
  factory $CampaignSharedVendorDtoCopyWith(CampaignSharedVendorDto value, $Res Function(CampaignSharedVendorDto) _then) = _$CampaignSharedVendorDtoCopyWithImpl;
@useResult
$Res call({
 String userId, String vendorName, String vendorId, List<SharedVendorsShop> sharedVendorsShops
});




}
/// @nodoc
class _$CampaignSharedVendorDtoCopyWithImpl<$Res>
    implements $CampaignSharedVendorDtoCopyWith<$Res> {
  _$CampaignSharedVendorDtoCopyWithImpl(this._self, this._then);

  final CampaignSharedVendorDto _self;
  final $Res Function(CampaignSharedVendorDto) _then;

/// Create a copy of CampaignSharedVendorDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? vendorName = null,Object? vendorId = null,Object? sharedVendorsShops = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,sharedVendorsShops: null == sharedVendorsShops ? _self.sharedVendorsShops : sharedVendorsShops // ignore: cast_nullable_to_non_nullable
as List<SharedVendorsShop>,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignSharedVendorDto].
extension CampaignSharedVendorDtoPatterns on CampaignSharedVendorDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignSharedVendorDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignSharedVendorDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignSharedVendorDto value)  $default,){
final _that = this;
switch (_that) {
case _CampaignSharedVendorDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignSharedVendorDto value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignSharedVendorDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String vendorName,  String vendorId,  List<SharedVendorsShop> sharedVendorsShops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignSharedVendorDto() when $default != null:
return $default(_that.userId,_that.vendorName,_that.vendorId,_that.sharedVendorsShops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String vendorName,  String vendorId,  List<SharedVendorsShop> sharedVendorsShops)  $default,) {final _that = this;
switch (_that) {
case _CampaignSharedVendorDto():
return $default(_that.userId,_that.vendorName,_that.vendorId,_that.sharedVendorsShops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String vendorName,  String vendorId,  List<SharedVendorsShop> sharedVendorsShops)?  $default,) {final _that = this;
switch (_that) {
case _CampaignSharedVendorDto() when $default != null:
return $default(_that.userId,_that.vendorName,_that.vendorId,_that.sharedVendorsShops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignSharedVendorDto implements CampaignSharedVendorDto {
  const _CampaignSharedVendorDto({required this.userId, required this.vendorName, required this.vendorId, required final  List<SharedVendorsShop> sharedVendorsShops}): _sharedVendorsShops = sharedVendorsShops;
  factory _CampaignSharedVendorDto.fromJson(Map<String, dynamic> json) => _$CampaignSharedVendorDtoFromJson(json);

@override final  String userId;
@override final  String vendorName;
@override final  String vendorId;
 final  List<SharedVendorsShop> _sharedVendorsShops;
@override List<SharedVendorsShop> get sharedVendorsShops {
  if (_sharedVendorsShops is EqualUnmodifiableListView) return _sharedVendorsShops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedVendorsShops);
}


/// Create a copy of CampaignSharedVendorDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignSharedVendorDtoCopyWith<_CampaignSharedVendorDto> get copyWith => __$CampaignSharedVendorDtoCopyWithImpl<_CampaignSharedVendorDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignSharedVendorDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignSharedVendorDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&const DeepCollectionEquality().equals(other._sharedVendorsShops, _sharedVendorsShops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,vendorName,vendorId,const DeepCollectionEquality().hash(_sharedVendorsShops));

@override
String toString() {
  return 'CampaignSharedVendorDto(userId: $userId, vendorName: $vendorName, vendorId: $vendorId, sharedVendorsShops: $sharedVendorsShops)';
}


}

/// @nodoc
abstract mixin class _$CampaignSharedVendorDtoCopyWith<$Res> implements $CampaignSharedVendorDtoCopyWith<$Res> {
  factory _$CampaignSharedVendorDtoCopyWith(_CampaignSharedVendorDto value, $Res Function(_CampaignSharedVendorDto) _then) = __$CampaignSharedVendorDtoCopyWithImpl;
@override @useResult
$Res call({
 String userId, String vendorName, String vendorId, List<SharedVendorsShop> sharedVendorsShops
});




}
/// @nodoc
class __$CampaignSharedVendorDtoCopyWithImpl<$Res>
    implements _$CampaignSharedVendorDtoCopyWith<$Res> {
  __$CampaignSharedVendorDtoCopyWithImpl(this._self, this._then);

  final _CampaignSharedVendorDto _self;
  final $Res Function(_CampaignSharedVendorDto) _then;

/// Create a copy of CampaignSharedVendorDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? vendorName = null,Object? vendorId = null,Object? sharedVendorsShops = null,}) {
  return _then(_CampaignSharedVendorDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,sharedVendorsShops: null == sharedVendorsShops ? _self._sharedVendorsShops : sharedVendorsShops // ignore: cast_nullable_to_non_nullable
as List<SharedVendorsShop>,
  ));
}


}


/// @nodoc
mixin _$SharedVendorsShop {

 String get shopId; String get shopName; List<CampaignSharedVendorDto> get sharedVendors;
/// Create a copy of SharedVendorsShop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedVendorsShopCopyWith<SharedVendorsShop> get copyWith => _$SharedVendorsShopCopyWithImpl<SharedVendorsShop>(this as SharedVendorsShop, _$identity);

  /// Serializes this SharedVendorsShop to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedVendorsShop&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&const DeepCollectionEquality().equals(other.sharedVendors, sharedVendors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,const DeepCollectionEquality().hash(sharedVendors));

@override
String toString() {
  return 'SharedVendorsShop(shopId: $shopId, shopName: $shopName, sharedVendors: $sharedVendors)';
}


}

/// @nodoc
abstract mixin class $SharedVendorsShopCopyWith<$Res>  {
  factory $SharedVendorsShopCopyWith(SharedVendorsShop value, $Res Function(SharedVendorsShop) _then) = _$SharedVendorsShopCopyWithImpl;
@useResult
$Res call({
 String shopId, String shopName, List<CampaignSharedVendorDto> sharedVendors
});




}
/// @nodoc
class _$SharedVendorsShopCopyWithImpl<$Res>
    implements $SharedVendorsShopCopyWith<$Res> {
  _$SharedVendorsShopCopyWithImpl(this._self, this._then);

  final SharedVendorsShop _self;
  final $Res Function(SharedVendorsShop) _then;

/// Create a copy of SharedVendorsShop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? shopName = null,Object? sharedVendors = null,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,sharedVendors: null == sharedVendors ? _self.sharedVendors : sharedVendors // ignore: cast_nullable_to_non_nullable
as List<CampaignSharedVendorDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedVendorsShop].
extension SharedVendorsShopPatterns on SharedVendorsShop {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedVendorsShop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedVendorsShop() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedVendorsShop value)  $default,){
final _that = this;
switch (_that) {
case _SharedVendorsShop():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedVendorsShop value)?  $default,){
final _that = this;
switch (_that) {
case _SharedVendorsShop() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  String shopName,  List<CampaignSharedVendorDto> sharedVendors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedVendorsShop() when $default != null:
return $default(_that.shopId,_that.shopName,_that.sharedVendors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  String shopName,  List<CampaignSharedVendorDto> sharedVendors)  $default,) {final _that = this;
switch (_that) {
case _SharedVendorsShop():
return $default(_that.shopId,_that.shopName,_that.sharedVendors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  String shopName,  List<CampaignSharedVendorDto> sharedVendors)?  $default,) {final _that = this;
switch (_that) {
case _SharedVendorsShop() when $default != null:
return $default(_that.shopId,_that.shopName,_that.sharedVendors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SharedVendorsShop implements SharedVendorsShop {
  const _SharedVendorsShop({required this.shopId, required this.shopName, required final  List<CampaignSharedVendorDto> sharedVendors}): _sharedVendors = sharedVendors;
  factory _SharedVendorsShop.fromJson(Map<String, dynamic> json) => _$SharedVendorsShopFromJson(json);

@override final  String shopId;
@override final  String shopName;
 final  List<CampaignSharedVendorDto> _sharedVendors;
@override List<CampaignSharedVendorDto> get sharedVendors {
  if (_sharedVendors is EqualUnmodifiableListView) return _sharedVendors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedVendors);
}


/// Create a copy of SharedVendorsShop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedVendorsShopCopyWith<_SharedVendorsShop> get copyWith => __$SharedVendorsShopCopyWithImpl<_SharedVendorsShop>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SharedVendorsShopToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedVendorsShop&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&const DeepCollectionEquality().equals(other._sharedVendors, _sharedVendors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,const DeepCollectionEquality().hash(_sharedVendors));

@override
String toString() {
  return 'SharedVendorsShop(shopId: $shopId, shopName: $shopName, sharedVendors: $sharedVendors)';
}


}

/// @nodoc
abstract mixin class _$SharedVendorsShopCopyWith<$Res> implements $SharedVendorsShopCopyWith<$Res> {
  factory _$SharedVendorsShopCopyWith(_SharedVendorsShop value, $Res Function(_SharedVendorsShop) _then) = __$SharedVendorsShopCopyWithImpl;
@override @useResult
$Res call({
 String shopId, String shopName, List<CampaignSharedVendorDto> sharedVendors
});




}
/// @nodoc
class __$SharedVendorsShopCopyWithImpl<$Res>
    implements _$SharedVendorsShopCopyWith<$Res> {
  __$SharedVendorsShopCopyWithImpl(this._self, this._then);

  final _SharedVendorsShop _self;
  final $Res Function(_SharedVendorsShop) _then;

/// Create a copy of SharedVendorsShop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? shopName = null,Object? sharedVendors = null,}) {
  return _then(_SharedVendorsShop(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,sharedVendors: null == sharedVendors ? _self._sharedVendors : sharedVendors // ignore: cast_nullable_to_non_nullable
as List<CampaignSharedVendorDto>,
  ));
}


}

// dart format on
