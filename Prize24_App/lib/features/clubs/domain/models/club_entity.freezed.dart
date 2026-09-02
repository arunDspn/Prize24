// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClubEntity {

 String get name; String get description; int get giftDay; String get attachedCampaignId; int? get multipierStreakDaysRequired; int get bonusIncrement;
/// Create a copy of ClubEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClubEntityCopyWith<ClubEntity> get copyWith => _$ClubEntityCopyWithImpl<ClubEntity>(this as ClubEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClubEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDay, giftDay) || other.giftDay == giftDay)&&(identical(other.attachedCampaignId, attachedCampaignId) || other.attachedCampaignId == attachedCampaignId)&&(identical(other.multipierStreakDaysRequired, multipierStreakDaysRequired) || other.multipierStreakDaysRequired == multipierStreakDaysRequired)&&(identical(other.bonusIncrement, bonusIncrement) || other.bonusIncrement == bonusIncrement));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,giftDay,attachedCampaignId,multipierStreakDaysRequired,bonusIncrement);

@override
String toString() {
  return 'ClubEntity(name: $name, description: $description, giftDay: $giftDay, attachedCampaignId: $attachedCampaignId, multipierStreakDaysRequired: $multipierStreakDaysRequired, bonusIncrement: $bonusIncrement)';
}


}

/// @nodoc
abstract mixin class $ClubEntityCopyWith<$Res>  {
  factory $ClubEntityCopyWith(ClubEntity value, $Res Function(ClubEntity) _then) = _$ClubEntityCopyWithImpl;
@useResult
$Res call({
 String name, String description, int giftDay, String attachedCampaignId, int? multipierStreakDaysRequired, int bonusIncrement
});




}
/// @nodoc
class _$ClubEntityCopyWithImpl<$Res>
    implements $ClubEntityCopyWith<$Res> {
  _$ClubEntityCopyWithImpl(this._self, this._then);

  final ClubEntity _self;
  final $Res Function(ClubEntity) _then;

/// Create a copy of ClubEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? giftDay = null,Object? attachedCampaignId = null,Object? multipierStreakDaysRequired = freezed,Object? bonusIncrement = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDay: null == giftDay ? _self.giftDay : giftDay // ignore: cast_nullable_to_non_nullable
as int,attachedCampaignId: null == attachedCampaignId ? _self.attachedCampaignId : attachedCampaignId // ignore: cast_nullable_to_non_nullable
as String,multipierStreakDaysRequired: freezed == multipierStreakDaysRequired ? _self.multipierStreakDaysRequired : multipierStreakDaysRequired // ignore: cast_nullable_to_non_nullable
as int?,bonusIncrement: null == bonusIncrement ? _self.bonusIncrement : bonusIncrement // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClubEntity].
extension ClubEntityPatterns on ClubEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClubEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClubEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClubEntity value)  $default,){
final _that = this;
switch (_that) {
case _ClubEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClubEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ClubEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  int giftDay,  String attachedCampaignId,  int? multipierStreakDaysRequired,  int bonusIncrement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClubEntity() when $default != null:
return $default(_that.name,_that.description,_that.giftDay,_that.attachedCampaignId,_that.multipierStreakDaysRequired,_that.bonusIncrement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  int giftDay,  String attachedCampaignId,  int? multipierStreakDaysRequired,  int bonusIncrement)  $default,) {final _that = this;
switch (_that) {
case _ClubEntity():
return $default(_that.name,_that.description,_that.giftDay,_that.attachedCampaignId,_that.multipierStreakDaysRequired,_that.bonusIncrement);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  int giftDay,  String attachedCampaignId,  int? multipierStreakDaysRequired,  int bonusIncrement)?  $default,) {final _that = this;
switch (_that) {
case _ClubEntity() when $default != null:
return $default(_that.name,_that.description,_that.giftDay,_that.attachedCampaignId,_that.multipierStreakDaysRequired,_that.bonusIncrement);case _:
  return null;

}
}

}

/// @nodoc


class _ClubEntity implements ClubEntity {
  const _ClubEntity({required this.name, required this.description, required this.giftDay, required this.attachedCampaignId, this.multipierStreakDaysRequired, this.bonusIncrement = 2});
  

@override final  String name;
@override final  String description;
@override final  int giftDay;
@override final  String attachedCampaignId;
@override final  int? multipierStreakDaysRequired;
@override@JsonKey() final  int bonusIncrement;

/// Create a copy of ClubEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClubEntityCopyWith<_ClubEntity> get copyWith => __$ClubEntityCopyWithImpl<_ClubEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClubEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDay, giftDay) || other.giftDay == giftDay)&&(identical(other.attachedCampaignId, attachedCampaignId) || other.attachedCampaignId == attachedCampaignId)&&(identical(other.multipierStreakDaysRequired, multipierStreakDaysRequired) || other.multipierStreakDaysRequired == multipierStreakDaysRequired)&&(identical(other.bonusIncrement, bonusIncrement) || other.bonusIncrement == bonusIncrement));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,giftDay,attachedCampaignId,multipierStreakDaysRequired,bonusIncrement);

@override
String toString() {
  return 'ClubEntity(name: $name, description: $description, giftDay: $giftDay, attachedCampaignId: $attachedCampaignId, multipierStreakDaysRequired: $multipierStreakDaysRequired, bonusIncrement: $bonusIncrement)';
}


}

/// @nodoc
abstract mixin class _$ClubEntityCopyWith<$Res> implements $ClubEntityCopyWith<$Res> {
  factory _$ClubEntityCopyWith(_ClubEntity value, $Res Function(_ClubEntity) _then) = __$ClubEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, int giftDay, String attachedCampaignId, int? multipierStreakDaysRequired, int bonusIncrement
});




}
/// @nodoc
class __$ClubEntityCopyWithImpl<$Res>
    implements _$ClubEntityCopyWith<$Res> {
  __$ClubEntityCopyWithImpl(this._self, this._then);

  final _ClubEntity _self;
  final $Res Function(_ClubEntity) _then;

/// Create a copy of ClubEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? giftDay = null,Object? attachedCampaignId = null,Object? multipierStreakDaysRequired = freezed,Object? bonusIncrement = null,}) {
  return _then(_ClubEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDay: null == giftDay ? _self.giftDay : giftDay // ignore: cast_nullable_to_non_nullable
as int,attachedCampaignId: null == attachedCampaignId ? _self.attachedCampaignId : attachedCampaignId // ignore: cast_nullable_to_non_nullable
as String,multipierStreakDaysRequired: freezed == multipierStreakDaysRequired ? _self.multipierStreakDaysRequired : multipierStreakDaysRequired // ignore: cast_nullable_to_non_nullable
as int?,bonusIncrement: null == bonusIncrement ? _self.bonusIncrement : bonusIncrement // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
