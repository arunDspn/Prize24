// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_campaign_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffCampaignModel {

 String get id; String get name; String get description; String get visibility; String get giftType;// Total number of gifts available in this campaign
 int get totalGifts;// Number of gifts remaining
 int get remainingGifts;// Total participants
 int get totalParticipants;// Total gifts added
 int get totalGiftsAdded;
/// Create a copy of StaffCampaignModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffCampaignModelCopyWith<StaffCampaignModel> get copyWith => _$StaffCampaignModelCopyWithImpl<StaffCampaignModel>(this as StaffCampaignModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffCampaignModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.totalGiftsAdded, totalGiftsAdded) || other.totalGiftsAdded == totalGiftsAdded));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,visibility,giftType,totalGifts,remainingGifts,totalParticipants,totalGiftsAdded);

@override
String toString() {
  return 'StaffCampaignModel(id: $id, name: $name, description: $description, visibility: $visibility, giftType: $giftType, totalGifts: $totalGifts, remainingGifts: $remainingGifts, totalParticipants: $totalParticipants, totalGiftsAdded: $totalGiftsAdded)';
}


}

/// @nodoc
abstract mixin class $StaffCampaignModelCopyWith<$Res>  {
  factory $StaffCampaignModelCopyWith(StaffCampaignModel value, $Res Function(StaffCampaignModel) _then) = _$StaffCampaignModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String visibility, String giftType, int totalGifts, int remainingGifts, int totalParticipants, int totalGiftsAdded
});




}
/// @nodoc
class _$StaffCampaignModelCopyWithImpl<$Res>
    implements $StaffCampaignModelCopyWith<$Res> {
  _$StaffCampaignModelCopyWithImpl(this._self, this._then);

  final StaffCampaignModel _self;
  final $Res Function(StaffCampaignModel) _then;

/// Create a copy of StaffCampaignModel
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


/// Adds pattern-matching-related methods to [StaffCampaignModel].
extension StaffCampaignModelPatterns on StaffCampaignModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffCampaignModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffCampaignModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffCampaignModel value)  $default,){
final _that = this;
switch (_that) {
case _StaffCampaignModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffCampaignModel value)?  $default,){
final _that = this;
switch (_that) {
case _StaffCampaignModel() when $default != null:
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
case _StaffCampaignModel() when $default != null:
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
case _StaffCampaignModel():
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
case _StaffCampaignModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.visibility,_that.giftType,_that.totalGifts,_that.remainingGifts,_that.totalParticipants,_that.totalGiftsAdded);case _:
  return null;

}
}

}

/// @nodoc


class _StaffCampaignModel implements StaffCampaignModel {
  const _StaffCampaignModel({required this.id, required this.name, required this.description, required this.visibility, required this.giftType, required this.totalGifts, required this.remainingGifts, required this.totalParticipants, required this.totalGiftsAdded});
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String visibility;
@override final  String giftType;
// Total number of gifts available in this campaign
@override final  int totalGifts;
// Number of gifts remaining
@override final  int remainingGifts;
// Total participants
@override final  int totalParticipants;
// Total gifts added
@override final  int totalGiftsAdded;

/// Create a copy of StaffCampaignModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffCampaignModelCopyWith<_StaffCampaignModel> get copyWith => __$StaffCampaignModelCopyWithImpl<_StaffCampaignModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffCampaignModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.giftType, giftType) || other.giftType == giftType)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.remainingGifts, remainingGifts) || other.remainingGifts == remainingGifts)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.totalGiftsAdded, totalGiftsAdded) || other.totalGiftsAdded == totalGiftsAdded));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,visibility,giftType,totalGifts,remainingGifts,totalParticipants,totalGiftsAdded);

@override
String toString() {
  return 'StaffCampaignModel(id: $id, name: $name, description: $description, visibility: $visibility, giftType: $giftType, totalGifts: $totalGifts, remainingGifts: $remainingGifts, totalParticipants: $totalParticipants, totalGiftsAdded: $totalGiftsAdded)';
}


}

/// @nodoc
abstract mixin class _$StaffCampaignModelCopyWith<$Res> implements $StaffCampaignModelCopyWith<$Res> {
  factory _$StaffCampaignModelCopyWith(_StaffCampaignModel value, $Res Function(_StaffCampaignModel) _then) = __$StaffCampaignModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String visibility, String giftType, int totalGifts, int remainingGifts, int totalParticipants, int totalGiftsAdded
});




}
/// @nodoc
class __$StaffCampaignModelCopyWithImpl<$Res>
    implements _$StaffCampaignModelCopyWith<$Res> {
  __$StaffCampaignModelCopyWithImpl(this._self, this._then);

  final _StaffCampaignModel _self;
  final $Res Function(_StaffCampaignModel) _then;

/// Create a copy of StaffCampaignModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? visibility = null,Object? giftType = null,Object? totalGifts = null,Object? remainingGifts = null,Object? totalParticipants = null,Object? totalGiftsAdded = null,}) {
  return _then(_StaffCampaignModel(
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
