// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampaignModel {

 String get name; String get description; String get vendorId; String get vendorName; int get totalParticipants; int get remainingParticipants;// required int totalParticipated,
 int get totalGifts; int get remainingGifts; CampaignVisibility get visibility; GiftType get allowedGiftType; DateTime get createdAt; DateTime get updatedAt; int get totalGiftsAdded;@JsonKey(defaultValue: CampaignStatus.active) CampaignStatus get status; int get totalAvailed; int get totalRedeemed;@JsonKey(includeIfNull: true) String? get id; String? get publicSlug; List<CampaignSharedVendorModel> get sharedVendors;
/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignModelCopyWith<CampaignModel> get copyWith => _$CampaignModelCopyWithImpl<CampaignModel>(this as CampaignModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.remainingParticipants, remainingParticipants) || other.remainingParticipants == remainingParticipants)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.allowedGiftType, allowedGiftType) || other.allowedGiftType == allowedGiftType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalGiftsAdded, totalGiftsAdded) || other.totalGiftsAdded == totalGiftsAdded)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAvailed, totalAvailed) || other.totalAvailed == totalAvailed)&&(identical(other.totalRedeemed, totalRedeemed) || other.totalRedeemed == totalRedeemed)&&(identical(other.id, id) || other.id == id)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&const DeepCollectionEquality().equals(other.sharedVendors, sharedVendors));
}


@override
int get hashCode => Object.hashAll([runtimeType,name,description,vendorId,vendorName,totalParticipants,remainingParticipants,totalGifts,remainingGifts,visibility,allowedGiftType,createdAt,updatedAt,totalGiftsAdded,status,totalAvailed,totalRedeemed,id,publicSlug,const DeepCollectionEquality().hash(sharedVendors)]);

@override
String toString() {
  return 'CampaignModel(name: $name, description: $description, vendorId: $vendorId, vendorName: $vendorName, totalParticipants: $totalParticipants, remainingParticipants: $remainingParticipants, totalGifts: $totalGifts, remainingGifts: $remainingGifts, visibility: $visibility, allowedGiftType: $allowedGiftType, createdAt: $createdAt, updatedAt: $updatedAt, totalGiftsAdded: $totalGiftsAdded, status: $status, totalAvailed: $totalAvailed, totalRedeemed: $totalRedeemed, id: $id, publicSlug: $publicSlug, sharedVendors: $sharedVendors)';
}


}

/// @nodoc
abstract mixin class $CampaignModelCopyWith<$Res>  {
  factory $CampaignModelCopyWith(CampaignModel value, $Res Function(CampaignModel) _then) = _$CampaignModelCopyWithImpl;
@useResult
$Res call({
 String name, String description, String vendorId, String vendorName, int totalParticipants, int remainingParticipants, int totalGifts, int remainingGifts, CampaignVisibility visibility, GiftType allowedGiftType, DateTime createdAt, DateTime updatedAt, int totalGiftsAdded,@JsonKey(defaultValue: CampaignStatus.active) CampaignStatus status, int totalAvailed, int totalRedeemed,@JsonKey(includeIfNull: true) String? id, String? publicSlug, List<CampaignSharedVendorModel> sharedVendors
});




}
/// @nodoc
class _$CampaignModelCopyWithImpl<$Res>
    implements $CampaignModelCopyWith<$Res> {
  _$CampaignModelCopyWithImpl(this._self, this._then);

  final CampaignModel _self;
  final $Res Function(CampaignModel) _then;

/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? vendorId = null,Object? vendorName = null,Object? totalParticipants = null,Object? remainingParticipants = null,Object? totalGifts = null,Object? remainingGifts = null,Object? visibility = null,Object? allowedGiftType = null,Object? createdAt = null,Object? updatedAt = null,Object? totalGiftsAdded = null,Object? status = null,Object? totalAvailed = null,Object? totalRedeemed = null,Object? id = freezed,Object? publicSlug = freezed,Object? sharedVendors = null,}) {
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
as DateTime,totalGiftsAdded: null == totalGiftsAdded ? _self.totalGiftsAdded : totalGiftsAdded // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,totalAvailed: null == totalAvailed ? _self.totalAvailed : totalAvailed // ignore: cast_nullable_to_non_nullable
as int,totalRedeemed: null == totalRedeemed ? _self.totalRedeemed : totalRedeemed // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,publicSlug: freezed == publicSlug ? _self.publicSlug : publicSlug // ignore: cast_nullable_to_non_nullable
as String?,sharedVendors: null == sharedVendors ? _self.sharedVendors : sharedVendors // ignore: cast_nullable_to_non_nullable
as List<CampaignSharedVendorModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignModel].
extension CampaignModelPatterns on CampaignModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignModel value)  $default,){
final _that = this;
switch (_that) {
case _CampaignModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignModel value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  String vendorId,  String vendorName,  int totalParticipants,  int remainingParticipants,  int totalGifts,  int remainingGifts,  CampaignVisibility visibility,  GiftType allowedGiftType,  DateTime createdAt,  DateTime updatedAt,  int totalGiftsAdded, @JsonKey(defaultValue: CampaignStatus.active)  CampaignStatus status,  int totalAvailed,  int totalRedeemed, @JsonKey(includeIfNull: true)  String? id,  String? publicSlug,  List<CampaignSharedVendorModel> sharedVendors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignModel() when $default != null:
return $default(_that.name,_that.description,_that.vendorId,_that.vendorName,_that.totalParticipants,_that.remainingParticipants,_that.totalGifts,_that.remainingGifts,_that.visibility,_that.allowedGiftType,_that.createdAt,_that.updatedAt,_that.totalGiftsAdded,_that.status,_that.totalAvailed,_that.totalRedeemed,_that.id,_that.publicSlug,_that.sharedVendors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  String vendorId,  String vendorName,  int totalParticipants,  int remainingParticipants,  int totalGifts,  int remainingGifts,  CampaignVisibility visibility,  GiftType allowedGiftType,  DateTime createdAt,  DateTime updatedAt,  int totalGiftsAdded, @JsonKey(defaultValue: CampaignStatus.active)  CampaignStatus status,  int totalAvailed,  int totalRedeemed, @JsonKey(includeIfNull: true)  String? id,  String? publicSlug,  List<CampaignSharedVendorModel> sharedVendors)  $default,) {final _that = this;
switch (_that) {
case _CampaignModel():
return $default(_that.name,_that.description,_that.vendorId,_that.vendorName,_that.totalParticipants,_that.remainingParticipants,_that.totalGifts,_that.remainingGifts,_that.visibility,_that.allowedGiftType,_that.createdAt,_that.updatedAt,_that.totalGiftsAdded,_that.status,_that.totalAvailed,_that.totalRedeemed,_that.id,_that.publicSlug,_that.sharedVendors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  String vendorId,  String vendorName,  int totalParticipants,  int remainingParticipants,  int totalGifts,  int remainingGifts,  CampaignVisibility visibility,  GiftType allowedGiftType,  DateTime createdAt,  DateTime updatedAt,  int totalGiftsAdded, @JsonKey(defaultValue: CampaignStatus.active)  CampaignStatus status,  int totalAvailed,  int totalRedeemed, @JsonKey(includeIfNull: true)  String? id,  String? publicSlug,  List<CampaignSharedVendorModel> sharedVendors)?  $default,) {final _that = this;
switch (_that) {
case _CampaignModel() when $default != null:
return $default(_that.name,_that.description,_that.vendorId,_that.vendorName,_that.totalParticipants,_that.remainingParticipants,_that.totalGifts,_that.remainingGifts,_that.visibility,_that.allowedGiftType,_that.createdAt,_that.updatedAt,_that.totalGiftsAdded,_that.status,_that.totalAvailed,_that.totalRedeemed,_that.id,_that.publicSlug,_that.sharedVendors);case _:
  return null;

}
}

}

/// @nodoc


class _CampaignModel implements CampaignModel {
  const _CampaignModel({required this.name, required this.description, required this.vendorId, required this.vendorName, required this.totalParticipants, required this.remainingParticipants, required this.totalGifts, required this.remainingGifts, required this.visibility, required this.allowedGiftType, required this.createdAt, required this.updatedAt, this.totalGiftsAdded = 0, @JsonKey(defaultValue: CampaignStatus.active) required this.status, required this.totalAvailed, required this.totalRedeemed, @JsonKey(includeIfNull: true) this.id, this.publicSlug, final  List<CampaignSharedVendorModel> sharedVendors = const []}): _sharedVendors = sharedVendors;
  

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
@override@JsonKey() final  int totalGiftsAdded;
@override@JsonKey(defaultValue: CampaignStatus.active) final  CampaignStatus status;
@override final  int totalAvailed;
@override final  int totalRedeemed;
@override@JsonKey(includeIfNull: true) final  String? id;
@override final  String? publicSlug;
 final  List<CampaignSharedVendorModel> _sharedVendors;
@override@JsonKey() List<CampaignSharedVendorModel> get sharedVendors {
  if (_sharedVendors is EqualUnmodifiableListView) return _sharedVendors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedVendors);
}


/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignModelCopyWith<_CampaignModel> get copyWith => __$CampaignModelCopyWithImpl<_CampaignModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.remainingParticipants, remainingParticipants) || other.remainingParticipants == remainingParticipants)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.allowedGiftType, allowedGiftType) || other.allowedGiftType == allowedGiftType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalGiftsAdded, totalGiftsAdded) || other.totalGiftsAdded == totalGiftsAdded)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAvailed, totalAvailed) || other.totalAvailed == totalAvailed)&&(identical(other.totalRedeemed, totalRedeemed) || other.totalRedeemed == totalRedeemed)&&(identical(other.id, id) || other.id == id)&&(identical(other.publicSlug, publicSlug) || other.publicSlug == publicSlug)&&const DeepCollectionEquality().equals(other._sharedVendors, _sharedVendors));
}


@override
int get hashCode => Object.hashAll([runtimeType,name,description,vendorId,vendorName,totalParticipants,remainingParticipants,totalGifts,remainingGifts,visibility,allowedGiftType,createdAt,updatedAt,totalGiftsAdded,status,totalAvailed,totalRedeemed,id,publicSlug,const DeepCollectionEquality().hash(_sharedVendors)]);

@override
String toString() {
  return 'CampaignModel(name: $name, description: $description, vendorId: $vendorId, vendorName: $vendorName, totalParticipants: $totalParticipants, remainingParticipants: $remainingParticipants, totalGifts: $totalGifts, remainingGifts: $remainingGifts, visibility: $visibility, allowedGiftType: $allowedGiftType, createdAt: $createdAt, updatedAt: $updatedAt, totalGiftsAdded: $totalGiftsAdded, status: $status, totalAvailed: $totalAvailed, totalRedeemed: $totalRedeemed, id: $id, publicSlug: $publicSlug, sharedVendors: $sharedVendors)';
}


}

/// @nodoc
abstract mixin class _$CampaignModelCopyWith<$Res> implements $CampaignModelCopyWith<$Res> {
  factory _$CampaignModelCopyWith(_CampaignModel value, $Res Function(_CampaignModel) _then) = __$CampaignModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, String vendorId, String vendorName, int totalParticipants, int remainingParticipants, int totalGifts, int remainingGifts, CampaignVisibility visibility, GiftType allowedGiftType, DateTime createdAt, DateTime updatedAt, int totalGiftsAdded,@JsonKey(defaultValue: CampaignStatus.active) CampaignStatus status, int totalAvailed, int totalRedeemed,@JsonKey(includeIfNull: true) String? id, String? publicSlug, List<CampaignSharedVendorModel> sharedVendors
});




}
/// @nodoc
class __$CampaignModelCopyWithImpl<$Res>
    implements _$CampaignModelCopyWith<$Res> {
  __$CampaignModelCopyWithImpl(this._self, this._then);

  final _CampaignModel _self;
  final $Res Function(_CampaignModel) _then;

/// Create a copy of CampaignModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? vendorId = null,Object? vendorName = null,Object? totalParticipants = null,Object? remainingParticipants = null,Object? totalGifts = null,Object? remainingGifts = null,Object? visibility = null,Object? allowedGiftType = null,Object? createdAt = null,Object? updatedAt = null,Object? totalGiftsAdded = null,Object? status = null,Object? totalAvailed = null,Object? totalRedeemed = null,Object? id = freezed,Object? publicSlug = freezed,Object? sharedVendors = null,}) {
  return _then(_CampaignModel(
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
as DateTime,totalGiftsAdded: null == totalGiftsAdded ? _self.totalGiftsAdded : totalGiftsAdded // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,totalAvailed: null == totalAvailed ? _self.totalAvailed : totalAvailed // ignore: cast_nullable_to_non_nullable
as int,totalRedeemed: null == totalRedeemed ? _self.totalRedeemed : totalRedeemed // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,publicSlug: freezed == publicSlug ? _self.publicSlug : publicSlug // ignore: cast_nullable_to_non_nullable
as String?,sharedVendors: null == sharedVendors ? _self._sharedVendors : sharedVendors // ignore: cast_nullable_to_non_nullable
as List<CampaignSharedVendorModel>,
  ));
}


}

/// @nodoc
mixin _$CampaignSharedVendorModel {

 String get vendorId; String get vendorName; String get vendorPhone;
/// Create a copy of CampaignSharedVendorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignSharedVendorModelCopyWith<CampaignSharedVendorModel> get copyWith => _$CampaignSharedVendorModelCopyWithImpl<CampaignSharedVendorModel>(this as CampaignSharedVendorModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignSharedVendorModel&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorPhone, vendorPhone) || other.vendorPhone == vendorPhone));
}


@override
int get hashCode => Object.hash(runtimeType,vendorId,vendorName,vendorPhone);

@override
String toString() {
  return 'CampaignSharedVendorModel(vendorId: $vendorId, vendorName: $vendorName, vendorPhone: $vendorPhone)';
}


}

/// @nodoc
abstract mixin class $CampaignSharedVendorModelCopyWith<$Res>  {
  factory $CampaignSharedVendorModelCopyWith(CampaignSharedVendorModel value, $Res Function(CampaignSharedVendorModel) _then) = _$CampaignSharedVendorModelCopyWithImpl;
@useResult
$Res call({
 String vendorId, String vendorName, String vendorPhone
});




}
/// @nodoc
class _$CampaignSharedVendorModelCopyWithImpl<$Res>
    implements $CampaignSharedVendorModelCopyWith<$Res> {
  _$CampaignSharedVendorModelCopyWithImpl(this._self, this._then);

  final CampaignSharedVendorModel _self;
  final $Res Function(CampaignSharedVendorModel) _then;

/// Create a copy of CampaignSharedVendorModel
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


/// Adds pattern-matching-related methods to [CampaignSharedVendorModel].
extension CampaignSharedVendorModelPatterns on CampaignSharedVendorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignSharedVendorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignSharedVendorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignSharedVendorModel value)  $default,){
final _that = this;
switch (_that) {
case _CampaignSharedVendorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignSharedVendorModel value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignSharedVendorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String vendorId,  String vendorName,  String vendorPhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignSharedVendorModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String vendorId,  String vendorName,  String vendorPhone)  $default,) {final _that = this;
switch (_that) {
case _CampaignSharedVendorModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String vendorId,  String vendorName,  String vendorPhone)?  $default,) {final _that = this;
switch (_that) {
case _CampaignSharedVendorModel() when $default != null:
return $default(_that.vendorId,_that.vendorName,_that.vendorPhone);case _:
  return null;

}
}

}

/// @nodoc


class _CampaignSharedVendorModel implements CampaignSharedVendorModel {
  const _CampaignSharedVendorModel({required this.vendorId, required this.vendorName, required this.vendorPhone});
  

@override final  String vendorId;
@override final  String vendorName;
@override final  String vendorPhone;

/// Create a copy of CampaignSharedVendorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignSharedVendorModelCopyWith<_CampaignSharedVendorModel> get copyWith => __$CampaignSharedVendorModelCopyWithImpl<_CampaignSharedVendorModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignSharedVendorModel&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorPhone, vendorPhone) || other.vendorPhone == vendorPhone));
}


@override
int get hashCode => Object.hash(runtimeType,vendorId,vendorName,vendorPhone);

@override
String toString() {
  return 'CampaignSharedVendorModel(vendorId: $vendorId, vendorName: $vendorName, vendorPhone: $vendorPhone)';
}


}

/// @nodoc
abstract mixin class _$CampaignSharedVendorModelCopyWith<$Res> implements $CampaignSharedVendorModelCopyWith<$Res> {
  factory _$CampaignSharedVendorModelCopyWith(_CampaignSharedVendorModel value, $Res Function(_CampaignSharedVendorModel) _then) = __$CampaignSharedVendorModelCopyWithImpl;
@override @useResult
$Res call({
 String vendorId, String vendorName, String vendorPhone
});




}
/// @nodoc
class __$CampaignSharedVendorModelCopyWithImpl<$Res>
    implements _$CampaignSharedVendorModelCopyWith<$Res> {
  __$CampaignSharedVendorModelCopyWithImpl(this._self, this._then);

  final _CampaignSharedVendorModel _self;
  final $Res Function(_CampaignSharedVendorModel) _then;

/// Create a copy of CampaignSharedVendorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vendorId = null,Object? vendorName = null,Object? vendorPhone = null,}) {
  return _then(_CampaignSharedVendorModel(
vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,vendorPhone: null == vendorPhone ? _self.vendorPhone : vendorPhone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
