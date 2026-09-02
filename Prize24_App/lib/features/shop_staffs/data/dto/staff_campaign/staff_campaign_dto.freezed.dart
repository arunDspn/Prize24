// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_campaign_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StaffCampaignDto {

 String get id; String get name; String get description; String get visibility; String get giftType;// Total number of gifts available in this campaign
 int get totalGifts;// Number of gifts remaining
 int get remainingGifts;// Maximum participants
 int get totalParticipants; int get totalGiftsAdded;
/// Create a copy of StaffCampaignDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffCampaignDtoCopyWith<StaffCampaignDto> get copyWith => _$StaffCampaignDtoCopyWithImpl<StaffCampaignDto>(this as StaffCampaignDto, _$identity);

  /// Serializes this StaffCampaignDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffCampaignDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.totalGiftsAdded, totalGiftsAdded) || other.totalGiftsAdded == totalGiftsAdded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,visibility,giftType,totalGifts,remainingGifts,totalParticipants,totalGiftsAdded);

@override
String toString() {
  return 'StaffCampaignDto(id: $id, name: $name, description: $description, visibility: $visibility, giftType: $giftType, totalGifts: $totalGifts, remainingGifts: $remainingGifts, totalParticipants: $totalParticipants, totalGiftsAdded: $totalGiftsAdded)';
}


}

/// @nodoc
abstract mixin class $StaffCampaignDtoCopyWith<$Res>  {
  factory $StaffCampaignDtoCopyWith(StaffCampaignDto value, $Res Function(StaffCampaignDto) _then) = _$StaffCampaignDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String visibility, String giftType, int totalGifts, int remainingGifts, int totalParticipants, int totalGiftsAdded
});




}
/// @nodoc
class _$StaffCampaignDtoCopyWithImpl<$Res>
    implements $StaffCampaignDtoCopyWith<$Res> {
  _$StaffCampaignDtoCopyWithImpl(this._self, this._then);

  final StaffCampaignDto _self;
  final $Res Function(StaffCampaignDto) _then;

/// Create a copy of StaffCampaignDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? visibility = null,Object? giftType = null,Object? totalGifts = null,Object? remainingGifts = null,Object? totalParticipants = null,Object? totalGiftsAdded = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,giftType: null == giftType ? _self.giftType : giftType // ignore: cast_nullable_to_non_nullable
as String,totalGifts: null == totalGifts ? _self.totalGifts : totalGifts // ignore: cast_nullable_to_non_nullable
as int,remainingGifts: null == remainingGifts ? _self.remainingGifts : remainingGifts // ignore: cast_nullable_to_non_nullable
as int,totalParticipants: null == totalParticipants ? _self.totalParticipants : totalParticipants // ignore: cast_nullable_to_non_nullable
as int,totalGiftsAdded: null == totalGiftsAdded ? _self.totalGiftsAdded : totalGiftsAdded // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffCampaignDto].
extension StaffCampaignDtoPatterns on StaffCampaignDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffCampaignDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffCampaignDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffCampaignDto value)  $default,){
final _that = this;
switch (_that) {
case _StaffCampaignDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffCampaignDto value)?  $default,){
final _that = this;
switch (_that) {
case _StaffCampaignDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String visibility,  String giftType,  int totalGifts,  int remainingGifts,  int totalParticipants,  int totalGiftsAdded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffCampaignDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.visibility,_that.giftType,_that.totalGifts,_that.remainingGifts,_that.totalParticipants,_that.totalGiftsAdded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String visibility,  String giftType,  int totalGifts,  int remainingGifts,  int totalParticipants,  int totalGiftsAdded)  $default,) {final _that = this;
switch (_that) {
case _StaffCampaignDto():
return $default(_that.id,_that.name,_that.description,_that.visibility,_that.giftType,_that.totalGifts,_that.remainingGifts,_that.totalParticipants,_that.totalGiftsAdded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String visibility,  String giftType,  int totalGifts,  int remainingGifts,  int totalParticipants,  int totalGiftsAdded)?  $default,) {final _that = this;
switch (_that) {
case _StaffCampaignDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.visibility,_that.giftType,_that.totalGifts,_that.remainingGifts,_that.totalParticipants,_that.totalGiftsAdded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StaffCampaignDto extends StaffCampaignDto {
  const _StaffCampaignDto({required this.id, required this.name, required this.description, required this.visibility, required this.giftType, required this.totalGifts, required this.remainingGifts, required this.totalParticipants, required this.totalGiftsAdded}): super._();
  factory _StaffCampaignDto.fromJson(Map<String, dynamic> json) => _$StaffCampaignDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String visibility;
@override final  String giftType;
// Total number of gifts available in this campaign
@override final  int totalGifts;
// Number of gifts remaining
@override final  int remainingGifts;
// Maximum participants
@override final  int totalParticipants;
@override final  int totalGiftsAdded;

/// Create a copy of StaffCampaignDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffCampaignDtoCopyWith<_StaffCampaignDto> get copyWith => __$StaffCampaignDtoCopyWithImpl<_StaffCampaignDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffCampaignDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffCampaignDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.totalGiftsAdded, totalGiftsAdded) || other.totalGiftsAdded == totalGiftsAdded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,visibility,giftType,totalGifts,remainingGifts,totalParticipants,totalGiftsAdded);

@override
String toString() {
  return 'StaffCampaignDto(id: $id, name: $name, description: $description, visibility: $visibility, giftType: $giftType, totalGifts: $totalGifts, remainingGifts: $remainingGifts, totalParticipants: $totalParticipants, totalGiftsAdded: $totalGiftsAdded)';
}


}

/// @nodoc
abstract mixin class _$StaffCampaignDtoCopyWith<$Res> implements $StaffCampaignDtoCopyWith<$Res> {
  factory _$StaffCampaignDtoCopyWith(_StaffCampaignDto value, $Res Function(_StaffCampaignDto) _then) = __$StaffCampaignDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String visibility, String giftType, int totalGifts, int remainingGifts, int totalParticipants, int totalGiftsAdded
});




}
/// @nodoc
class __$StaffCampaignDtoCopyWithImpl<$Res>
    implements _$StaffCampaignDtoCopyWith<$Res> {
  __$StaffCampaignDtoCopyWithImpl(this._self, this._then);

  final _StaffCampaignDto _self;
  final $Res Function(_StaffCampaignDto) _then;

/// Create a copy of StaffCampaignDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? visibility = null,Object? giftType = null,Object? totalGifts = null,Object? remainingGifts = null,Object? totalParticipants = null,Object? totalGiftsAdded = null,}) {
  return _then(_StaffCampaignDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,giftType: null == giftType ? _self.giftType : giftType // ignore: cast_nullable_to_non_nullable
as String,totalGifts: null == totalGifts ? _self.totalGifts : totalGifts // ignore: cast_nullable_to_non_nullable
as int,remainingGifts: null == remainingGifts ? _self.remainingGifts : remainingGifts // ignore: cast_nullable_to_non_nullable
as int,totalParticipants: null == totalParticipants ? _self.totalParticipants : totalParticipants // ignore: cast_nullable_to_non_nullable
as int,totalGiftsAdded: null == totalGiftsAdded ? _self.totalGiftsAdded : totalGiftsAdded // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
