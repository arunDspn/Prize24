// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CampaignDto {

 String get name; String get description; String get vendorId; String get vendorName; int get totalParticipants; int get remainingParticipants;// required int totalParticipated,
 int get totalGifts; int get remainingGifts; CampaignVisibility get visibility; GiftType get allowedGiftType; DateTime get createdAt; DateTime get updatedAt; String get status; int get totalGiftsAdded;@JsonKey(defaultValue: 0) int get totalAvailed;@JsonKey(defaultValue: 0) int get totalRedeemed;@JsonKey(includeIfNull: false) String? get id;@JsonKey(includeIfNull: false) String? get publicSlug; List<CampaignSharedVendorsDto> get sharedVendors;
/// Create a copy of CampaignDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignDtoCopyWith<CampaignDto> get copyWith => _$CampaignDtoCopyWithImpl<CampaignDto>(this as CampaignDto, _$identity);

  /// Serializes this CampaignDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.remainingParticipants, remainingParticipants) || other.remainingParticipants == remainingParticipants)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.allowedGiftType, allowedGiftType) || other.allowedGiftType == allowedGiftType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalGiftsAdded, totalGiftsAdded) || other.totalGiftsAdded == totalGiftsAdded)&&(identical(other.totalAvailed, totalAvailed) || other.totalAvailed == totalAvailed)&&(identical(other.totalRedeemed, totalRedeemed) || other.totalRedeemed == totalRedeemed)&&(identical(other.id, id) || other.id == id)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&const DeepCollectionEquality().equals(other.sharedVendors, sharedVendors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,description,vendorId,vendorName,totalParticipants,remainingParticipants,totalGifts,remainingGifts,visibility,allowedGiftType,createdAt,updatedAt,status,totalGiftsAdded,totalAvailed,totalRedeemed,id,publicSlug,const DeepCollectionEquality().hash(sharedVendors)]);

@override
String toString() {
  return 'CampaignDto(name: $name, description: $description, vendorId: $vendorId, vendorName: $vendorName, totalParticipants: $totalParticipants, remainingParticipants: $remainingParticipants, totalGifts: $totalGifts, remainingGifts: $remainingGifts, visibility: $visibility, allowedGiftType: $allowedGiftType, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, totalGiftsAdded: $totalGiftsAdded, totalAvailed: $totalAvailed, totalRedeemed: $totalRedeemed, id: $id, publicSlug: $publicSlug, sharedVendors: $sharedVendors)';
}


}

/// @nodoc
abstract mixin class $CampaignDtoCopyWith<$Res>  {
  factory $CampaignDtoCopyWith(CampaignDto value, $Res Function(CampaignDto) _then) = _$CampaignDtoCopyWithImpl;
@useResult
$Res call({
 String name, String description, String vendorId, String vendorName, int totalParticipants, int remainingParticipants, int totalGifts, int remainingGifts, CampaignVisibility visibility, GiftType allowedGiftType, DateTime createdAt, DateTime updatedAt, String status, int totalGiftsAdded,@JsonKey(defaultValue: 0) int totalAvailed,@JsonKey(defaultValue: 0) int totalRedeemed,@JsonKey(includeIfNull: false) String? id,@JsonKey(includeIfNull: false) String? publicSlug, List<CampaignSharedVendorsDto> sharedVendors
});




}
/// @nodoc
class _$CampaignDtoCopyWithImpl<$Res>
    implements $CampaignDtoCopyWith<$Res> {
  _$CampaignDtoCopyWithImpl(this._self, this._then);

  final CampaignDto _self;
  final $Res Function(CampaignDto) _then;

/// Create a copy of CampaignDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? vendorId = null,Object? vendorName = null,Object? totalParticipants = null,Object? remainingParticipants = null,Object? totalGifts = null,Object? remainingGifts = null,Object? visibility = null,Object? allowedGiftType = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? totalGiftsAdded = null,Object? totalAvailed = null,Object? totalRedeemed = null,Object? id = freezed,Object? publicSlug = freezed,Object? sharedVendors = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,totalParticipants: null == totalParticipants ? _self.totalParticipants : totalParticipants // ignore: cast_nullable_to_non_nullable
as int,remainingParticipants: null == remainingParticipants ? _self.remainingParticipants : remainingParticipants // ignore: cast_nullable_to_non_nullable
as int,totalGifts: null == totalGifts ? _self.totalGifts : totalGifts // ignore: cast_nullable_to_non_nullable
as int,remainingGifts: null == remainingGifts ? _self.remainingGifts : remainingGifts // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as CampaignVisibility,allowedGiftType: null == allowedGiftType ? _self.allowedGiftType : allowedGiftType // ignore: cast_nullable_to_non_nullable
as GiftType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalGiftsAdded: null == totalGiftsAdded ? _self.totalGiftsAdded : totalGiftsAdded // ignore: cast_nullable_to_non_nullable
as int,totalAvailed: null == totalAvailed ? _self.totalAvailed : totalAvailed // ignore: cast_nullable_to_non_nullable
as int,totalRedeemed: null == totalRedeemed ? _self.totalRedeemed : totalRedeemed // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,publicSlug: freezed == publicSlug ? _self.publicSlug : publicSlug // ignore: cast_nullable_to_non_nullable
as String?,sharedVendors: null == sharedVendors ? _self.sharedVendors : sharedVendors // ignore: cast_nullable_to_non_nullable
as List<CampaignSharedVendorsDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignDto].
extension CampaignDtoPatterns on CampaignDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignDto value)  $default,){
final _that = this;
switch (_that) {
case _CampaignDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignDto value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  String vendorId,  String vendorName,  int totalParticipants,  int remainingParticipants,  int totalGifts,  int remainingGifts,  CampaignVisibility visibility,  GiftType allowedGiftType,  DateTime createdAt,  DateTime updatedAt,  String status,  int totalGiftsAdded, @JsonKey(defaultValue: 0)  int totalAvailed, @JsonKey(defaultValue: 0)  int totalRedeemed, @JsonKey(includeIfNull: false)  String? id, @JsonKey(includeIfNull: false)  String? publicSlug,  List<CampaignSharedVendorsDto> sharedVendors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignDto() when $default != null:
return $default(_that.name,_that.description,_that.vendorId,_that.vendorName,_that.totalParticipants,_that.remainingParticipants,_that.totalGifts,_that.remainingGifts,_that.visibility,_that.allowedGiftType,_that.createdAt,_that.updatedAt,_that.status,_that.totalGiftsAdded,_that.totalAvailed,_that.totalRedeemed,_that.id,_that.publicSlug,_that.sharedVendors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  String vendorId,  String vendorName,  int totalParticipants,  int remainingParticipants,  int totalGifts,  int remainingGifts,  CampaignVisibility visibility,  GiftType allowedGiftType,  DateTime createdAt,  DateTime updatedAt,  String status,  int totalGiftsAdded, @JsonKey(defaultValue: 0)  int totalAvailed, @JsonKey(defaultValue: 0)  int totalRedeemed, @JsonKey(includeIfNull: false)  String? id, @JsonKey(includeIfNull: false)  String? publicSlug,  List<CampaignSharedVendorsDto> sharedVendors)  $default,) {final _that = this;
switch (_that) {
case _CampaignDto():
return $default(_that.name,_that.description,_that.vendorId,_that.vendorName,_that.totalParticipants,_that.remainingParticipants,_that.totalGifts,_that.remainingGifts,_that.visibility,_that.allowedGiftType,_that.createdAt,_that.updatedAt,_that.status,_that.totalGiftsAdded,_that.totalAvailed,_that.totalRedeemed,_that.id,_that.publicSlug,_that.sharedVendors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  String vendorId,  String vendorName,  int totalParticipants,  int remainingParticipants,  int totalGifts,  int remainingGifts,  CampaignVisibility visibility,  GiftType allowedGiftType,  DateTime createdAt,  DateTime updatedAt,  String status,  int totalGiftsAdded, @JsonKey(defaultValue: 0)  int totalAvailed, @JsonKey(defaultValue: 0)  int totalRedeemed, @JsonKey(includeIfNull: false)  String? id, @JsonKey(includeIfNull: false)  String? publicSlug,  List<CampaignSharedVendorsDto> sharedVendors)?  $default,) {final _that = this;
switch (_that) {
case _CampaignDto() when $default != null:
return $default(_that.name,_that.description,_that.vendorId,_that.vendorName,_that.totalParticipants,_that.remainingParticipants,_that.totalGifts,_that.remainingGifts,_that.visibility,_that.allowedGiftType,_that.createdAt,_that.updatedAt,_that.status,_that.totalGiftsAdded,_that.totalAvailed,_that.totalRedeemed,_that.id,_that.publicSlug,_that.sharedVendors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignDto extends CampaignDto {
  const _CampaignDto({required this.name, required this.description, required this.vendorId, required this.vendorName, required this.totalParticipants, required this.remainingParticipants, required this.totalGifts, required this.remainingGifts, required this.visibility, required this.allowedGiftType, required this.createdAt, required this.updatedAt, required this.status, required this.totalGiftsAdded, @JsonKey(defaultValue: 0) required this.totalAvailed, @JsonKey(defaultValue: 0) required this.totalRedeemed, @JsonKey(includeIfNull: false) this.id, @JsonKey(includeIfNull: false) this.publicSlug, final  List<CampaignSharedVendorsDto> sharedVendors = const []}): _sharedVendors = sharedVendors,super._();
  factory _CampaignDto.fromJson(Map<String, dynamic> json) => _$CampaignDtoFromJson(json);

@override final  String name;
@override final  String description;
@override final  String vendorId;
@override final  String vendorName;
@override final  int totalParticipants;
@override final  int remainingParticipants;
// required int totalParticipated,
@override final  int totalGifts;
@override final  int remainingGifts;
@override final  CampaignVisibility visibility;
@override final  GiftType allowedGiftType;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String status;
@override final  int totalGiftsAdded;
@override@JsonKey(defaultValue: 0) final  int totalAvailed;
@override@JsonKey(defaultValue: 0) final  int totalRedeemed;
@override@JsonKey(includeIfNull: false) final  String? id;
@override@JsonKey(includeIfNull: false) final  String? publicSlug;
 final  List<CampaignSharedVendorsDto> _sharedVendors;
@override@JsonKey() List<CampaignSharedVendorsDto> get sharedVendors {
  if (_sharedVendors is EqualUnmodifiableListView) return _sharedVendors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedVendors);
}


/// Create a copy of CampaignDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignDtoCopyWith<_CampaignDto> get copyWith => __$CampaignDtoCopyWithImpl<_CampaignDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.remainingParticipants, remainingParticipants) || other.remainingParticipants == remainingParticipants)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.allowedGiftType, allowedGiftType) || other.allowedGiftType == allowedGiftType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalGiftsAdded, totalGiftsAdded) || other.totalGiftsAdded == totalGiftsAdded)&&(identical(other.totalAvailed, totalAvailed) || other.totalAvailed == totalAvailed)&&(identical(other.totalRedeemed, totalRedeemed) || other.totalRedeemed == totalRedeemed)&&(identical(other.id, id) || other.id == id)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&const DeepCollectionEquality().equals(other._sharedVendors, _sharedVendors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,description,vendorId,vendorName,totalParticipants,remainingParticipants,totalGifts,remainingGifts,visibility,allowedGiftType,createdAt,updatedAt,status,totalGiftsAdded,totalAvailed,totalRedeemed,id,publicSlug,const DeepCollectionEquality().hash(_sharedVendors)]);

@override
String toString() {
  return 'CampaignDto(name: $name, description: $description, vendorId: $vendorId, vendorName: $vendorName, totalParticipants: $totalParticipants, remainingParticipants: $remainingParticipants, totalGifts: $totalGifts, remainingGifts: $remainingGifts, visibility: $visibility, allowedGiftType: $allowedGiftType, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, totalGiftsAdded: $totalGiftsAdded, totalAvailed: $totalAvailed, totalRedeemed: $totalRedeemed, id: $id, publicSlug: $publicSlug, sharedVendors: $sharedVendors)';
}


}

/// @nodoc
abstract mixin class _$CampaignDtoCopyWith<$Res> implements $CampaignDtoCopyWith<$Res> {
  factory _$CampaignDtoCopyWith(_CampaignDto value, $Res Function(_CampaignDto) _then) = __$CampaignDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, String vendorId, String vendorName, int totalParticipants, int remainingParticipants, int totalGifts, int remainingGifts, CampaignVisibility visibility, GiftType allowedGiftType, DateTime createdAt, DateTime updatedAt, String status, int totalGiftsAdded,@JsonKey(defaultValue: 0) int totalAvailed,@JsonKey(defaultValue: 0) int totalRedeemed,@JsonKey(includeIfNull: false) String? id,@JsonKey(includeIfNull: false) String? publicSlug, List<CampaignSharedVendorsDto> sharedVendors
});




}
/// @nodoc
class __$CampaignDtoCopyWithImpl<$Res>
    implements _$CampaignDtoCopyWith<$Res> {
  __$CampaignDtoCopyWithImpl(this._self, this._then);

  final _CampaignDto _self;
  final $Res Function(_CampaignDto) _then;

/// Create a copy of CampaignDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? vendorId = null,Object? vendorName = null,Object? totalParticipants = null,Object? remainingParticipants = null,Object? totalGifts = null,Object? remainingGifts = null,Object? visibility = null,Object? allowedGiftType = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? totalGiftsAdded = null,Object? totalAvailed = null,Object? totalRedeemed = null,Object? id = freezed,Object? publicSlug = freezed,Object? sharedVendors = null,}) {
  return _then(_CampaignDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,totalParticipants: null == totalParticipants ? _self.totalParticipants : totalParticipants // ignore: cast_nullable_to_non_nullable
as int,remainingParticipants: null == remainingParticipants ? _self.remainingParticipants : remainingParticipants // ignore: cast_nullable_to_non_nullable
as int,totalGifts: null == totalGifts ? _self.totalGifts : totalGifts // ignore: cast_nullable_to_non_nullable
as int,remainingGifts: null == remainingGifts ? _self.remainingGifts : remainingGifts // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as CampaignVisibility,allowedGiftType: null == allowedGiftType ? _self.allowedGiftType : allowedGiftType // ignore: cast_nullable_to_non_nullable
as GiftType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalGiftsAdded: null == totalGiftsAdded ? _self.totalGiftsAdded : totalGiftsAdded // ignore: cast_nullable_to_non_nullable
as int,totalAvailed: null == totalAvailed ? _self.totalAvailed : totalAvailed // ignore: cast_nullable_to_non_nullable
as int,totalRedeemed: null == totalRedeemed ? _self.totalRedeemed : totalRedeemed // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,publicSlug: freezed == publicSlug ? _self.publicSlug : publicSlug // ignore: cast_nullable_to_non_nullable
as String?,sharedVendors: null == sharedVendors ? _self._sharedVendors : sharedVendors // ignore: cast_nullable_to_non_nullable
as List<CampaignSharedVendorsDto>,
  ));
}


}


/// @nodoc
mixin _$CampaignSharedVendorsDto {

@JsonKey(name: 'id') String get vendorId;@JsonKey(name: 'name') String get vendorName;@JsonKey(name: 'phone') String get vendorPhone;
/// Create a copy of CampaignSharedVendorsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignSharedVendorsDtoCopyWith<CampaignSharedVendorsDto> get copyWith => _$CampaignSharedVendorsDtoCopyWithImpl<CampaignSharedVendorsDto>(this as CampaignSharedVendorsDto, _$identity);

  /// Serializes this CampaignSharedVendorsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignSharedVendorsDto&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorPhone, vendorPhone) || other.vendorPhone == vendorPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendorId,vendorName,vendorPhone);

@override
String toString() {
  return 'CampaignSharedVendorsDto(vendorId: $vendorId, vendorName: $vendorName, vendorPhone: $vendorPhone)';
}


}

/// @nodoc
abstract mixin class $CampaignSharedVendorsDtoCopyWith<$Res>  {
  factory $CampaignSharedVendorsDtoCopyWith(CampaignSharedVendorsDto value, $Res Function(CampaignSharedVendorsDto) _then) = _$CampaignSharedVendorsDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String vendorId,@JsonKey(name: 'name') String vendorName,@JsonKey(name: 'phone') String vendorPhone
});




}
/// @nodoc
class _$CampaignSharedVendorsDtoCopyWithImpl<$Res>
    implements $CampaignSharedVendorsDtoCopyWith<$Res> {
  _$CampaignSharedVendorsDtoCopyWithImpl(this._self, this._then);

  final CampaignSharedVendorsDto _self;
  final $Res Function(CampaignSharedVendorsDto) _then;

/// Create a copy of CampaignSharedVendorsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vendorId = null,Object? vendorName = null,Object? vendorPhone = null,}) {
  return _then(_self.copyWith(
vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,vendorPhone: null == vendorPhone ? _self.vendorPhone : vendorPhone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignSharedVendorsDto].
extension CampaignSharedVendorsDtoPatterns on CampaignSharedVendorsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignSharedVendorsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignSharedVendorsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignSharedVendorsDto value)  $default,){
final _that = this;
switch (_that) {
case _CampaignSharedVendorsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignSharedVendorsDto value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignSharedVendorsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String vendorId, @JsonKey(name: 'name')  String vendorName, @JsonKey(name: 'phone')  String vendorPhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignSharedVendorsDto() when $default != null:
return $default(_that.vendorId,_that.vendorName,_that.vendorPhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String vendorId, @JsonKey(name: 'name')  String vendorName, @JsonKey(name: 'phone')  String vendorPhone)  $default,) {final _that = this;
switch (_that) {
case _CampaignSharedVendorsDto():
return $default(_that.vendorId,_that.vendorName,_that.vendorPhone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String vendorId, @JsonKey(name: 'name')  String vendorName, @JsonKey(name: 'phone')  String vendorPhone)?  $default,) {final _that = this;
switch (_that) {
case _CampaignSharedVendorsDto() when $default != null:
return $default(_that.vendorId,_that.vendorName,_that.vendorPhone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampaignSharedVendorsDto extends CampaignSharedVendorsDto {
  const _CampaignSharedVendorsDto({@JsonKey(name: 'id') required this.vendorId, @JsonKey(name: 'name') required this.vendorName, @JsonKey(name: 'phone') required this.vendorPhone}): super._();
  factory _CampaignSharedVendorsDto.fromJson(Map<String, dynamic> json) => _$CampaignSharedVendorsDtoFromJson(json);

@override@JsonKey(name: 'id') final  String vendorId;
@override@JsonKey(name: 'name') final  String vendorName;
@override@JsonKey(name: 'phone') final  String vendorPhone;

/// Create a copy of CampaignSharedVendorsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignSharedVendorsDtoCopyWith<_CampaignSharedVendorsDto> get copyWith => __$CampaignSharedVendorsDtoCopyWithImpl<_CampaignSharedVendorsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignSharedVendorsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignSharedVendorsDto&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorPhone, vendorPhone) || other.vendorPhone == vendorPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendorId,vendorName,vendorPhone);

@override
String toString() {
  return 'CampaignSharedVendorsDto(vendorId: $vendorId, vendorName: $vendorName, vendorPhone: $vendorPhone)';
}


}

/// @nodoc
abstract mixin class _$CampaignSharedVendorsDtoCopyWith<$Res> implements $CampaignSharedVendorsDtoCopyWith<$Res> {
  factory _$CampaignSharedVendorsDtoCopyWith(_CampaignSharedVendorsDto value, $Res Function(_CampaignSharedVendorsDto) _then) = __$CampaignSharedVendorsDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String vendorId,@JsonKey(name: 'name') String vendorName,@JsonKey(name: 'phone') String vendorPhone
});




}
/// @nodoc
class __$CampaignSharedVendorsDtoCopyWithImpl<$Res>
    implements _$CampaignSharedVendorsDtoCopyWith<$Res> {
  __$CampaignSharedVendorsDtoCopyWithImpl(this._self, this._then);

  final _CampaignSharedVendorsDto _self;
  final $Res Function(_CampaignSharedVendorsDto) _then;

/// Create a copy of CampaignSharedVendorsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vendorId = null,Object? vendorName = null,Object? vendorPhone = null,}) {
  return _then(_CampaignSharedVendorsDto(
vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,vendorPhone: null == vendorPhone ? _self.vendorPhone : vendorPhone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
