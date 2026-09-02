// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_club_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffClubDetailModel {

 String get id; String get name; String get description; int get giftDayCycle; String get campaignId;
/// Create a copy of StaffClubDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffClubDetailModelCopyWith<StaffClubDetailModel> get copyWith => _$StaffClubDetailModelCopyWithImpl<StaffClubDetailModel>(this as StaffClubDetailModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffClubDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDayCycle, giftDayCycle) || other.giftDayCycle == giftDayCycle)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,giftDayCycle,campaignId);

@override
String toString() {
  return 'StaffClubDetailModel(id: $id, name: $name, description: $description, giftDayCycle: $giftDayCycle, campaignId: $campaignId)';
}


}

/// @nodoc
abstract mixin class $StaffClubDetailModelCopyWith<$Res>  {
  factory $StaffClubDetailModelCopyWith(StaffClubDetailModel value, $Res Function(StaffClubDetailModel) _then) = _$StaffClubDetailModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, int giftDayCycle, String campaignId
});




}
/// @nodoc
class _$StaffClubDetailModelCopyWithImpl<$Res>
    implements $StaffClubDetailModelCopyWith<$Res> {
  _$StaffClubDetailModelCopyWithImpl(this._self, this._then);

  final StaffClubDetailModel _self;
  final $Res Function(StaffClubDetailModel) _then;

/// Create a copy of StaffClubDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? giftDayCycle = null,Object? campaignId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDayCycle: null == giftDayCycle ? _self.giftDayCycle : giftDayCycle // ignore: cast_nullable_to_non_nullable
as int,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffClubDetailModel].
extension StaffClubDetailModelPatterns on StaffClubDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffClubDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffClubDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffClubDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _StaffClubDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffClubDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _StaffClubDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  int giftDayCycle,  String campaignId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffClubDetailModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.giftDayCycle,_that.campaignId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  int giftDayCycle,  String campaignId)  $default,) {final _that = this;
switch (_that) {
case _StaffClubDetailModel():
return $default(_that.id,_that.name,_that.description,_that.giftDayCycle,_that.campaignId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  int giftDayCycle,  String campaignId)?  $default,) {final _that = this;
switch (_that) {
case _StaffClubDetailModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.giftDayCycle,_that.campaignId);case _:
  return null;

}
}

}

/// @nodoc


class _StaffClubDetailModel implements StaffClubDetailModel {
  const _StaffClubDetailModel({required this.id, required this.name, required this.description, required this.giftDayCycle, required this.campaignId});
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  int giftDayCycle;
@override final  String campaignId;

/// Create a copy of StaffClubDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffClubDetailModelCopyWith<_StaffClubDetailModel> get copyWith => __$StaffClubDetailModelCopyWithImpl<_StaffClubDetailModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffClubDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDayCycle, giftDayCycle) || other.giftDayCycle == giftDayCycle)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,giftDayCycle,campaignId);

@override
String toString() {
  return 'StaffClubDetailModel(id: $id, name: $name, description: $description, giftDayCycle: $giftDayCycle, campaignId: $campaignId)';
}


}

/// @nodoc
abstract mixin class _$StaffClubDetailModelCopyWith<$Res> implements $StaffClubDetailModelCopyWith<$Res> {
  factory _$StaffClubDetailModelCopyWith(_StaffClubDetailModel value, $Res Function(_StaffClubDetailModel) _then) = __$StaffClubDetailModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, int giftDayCycle, String campaignId
});




}
/// @nodoc
class __$StaffClubDetailModelCopyWithImpl<$Res>
    implements _$StaffClubDetailModelCopyWith<$Res> {
  __$StaffClubDetailModelCopyWithImpl(this._self, this._then);

  final _StaffClubDetailModel _self;
  final $Res Function(_StaffClubDetailModel) _then;

/// Create a copy of StaffClubDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? giftDayCycle = null,Object? campaignId = null,}) {
  return _then(_StaffClubDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDayCycle: null == giftDayCycle ? _self.giftDayCycle : giftDayCycle // ignore: cast_nullable_to_non_nullable
as int,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
