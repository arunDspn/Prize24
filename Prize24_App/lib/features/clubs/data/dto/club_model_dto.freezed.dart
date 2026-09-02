// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_model_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClubModelDto {

 String get name; String get description; int get giftDay;@JsonKey(name: 'campaignId') String get attachedCampaignId; String get campaignName; String get campaignDescription;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get createdAt;@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp get updatedAt;// @JsonKey(name: 'shopList') required List<ClubShopListDto> shops,
 int get totalMembers; String? get id; MultiplierRuleDto? get multipierStreak;
/// Create a copy of ClubModelDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClubModelDtoCopyWith<ClubModelDto> get copyWith => _$ClubModelDtoCopyWithImpl<ClubModelDto>(this as ClubModelDto, _$identity);

  /// Serializes this ClubModelDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClubModelDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDay, giftDay) || other.giftDay == giftDay)&&(identical(other.attachedCampaignId, attachedCampaignId) || other.attachedCampaignId == attachedCampaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.campaignDescription, campaignDescription) || other.campaignDescription == campaignDescription)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&(identical(other.id, id) || other.id == id)&&(identical(other.multipierStreak, multipierStreak) || other.multipierStreak == multipierStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,giftDay,attachedCampaignId,campaignName,campaignDescription,createdAt,updatedAt,totalMembers,id,multipierStreak);

@override
String toString() {
  return 'ClubModelDto(name: $name, description: $description, giftDay: $giftDay, attachedCampaignId: $attachedCampaignId, campaignName: $campaignName, campaignDescription: $campaignDescription, createdAt: $createdAt, updatedAt: $updatedAt, totalMembers: $totalMembers, id: $id, multipierStreak: $multipierStreak)';
}


}

/// @nodoc
abstract mixin class $ClubModelDtoCopyWith<$Res>  {
  factory $ClubModelDtoCopyWith(ClubModelDto value, $Res Function(ClubModelDto) _then) = _$ClubModelDtoCopyWithImpl;
@useResult
$Res call({
 String name, String description, int giftDay,@JsonKey(name: 'campaignId') String attachedCampaignId, String campaignName, String campaignDescription,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp createdAt,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp updatedAt, int totalMembers, String? id, MultiplierRuleDto? multipierStreak
});


$MultiplierRuleDtoCopyWith<$Res>? get multipierStreak;

}
/// @nodoc
class _$ClubModelDtoCopyWithImpl<$Res>
    implements $ClubModelDtoCopyWith<$Res> {
  _$ClubModelDtoCopyWithImpl(this._self, this._then);

  final ClubModelDto _self;
  final $Res Function(ClubModelDto) _then;

/// Create a copy of ClubModelDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? giftDay = null,Object? attachedCampaignId = null,Object? campaignName = null,Object? campaignDescription = null,Object? createdAt = null,Object? updatedAt = null,Object? totalMembers = null,Object? id = freezed,Object? multipierStreak = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDay: null == giftDay ? _self.giftDay : giftDay // ignore: cast_nullable_to_non_nullable
as int,attachedCampaignId: null == attachedCampaignId ? _self.attachedCampaignId : attachedCampaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,campaignDescription: null == campaignDescription ? _self.campaignDescription : campaignDescription // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,totalMembers: null == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,multipierStreak: freezed == multipierStreak ? _self.multipierStreak : multipierStreak // ignore: cast_nullable_to_non_nullable
as MultiplierRuleDto?,
  ));
}
/// Create a copy of ClubModelDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultiplierRuleDtoCopyWith<$Res>? get multipierStreak {
    if (_self.multipierStreak == null) {
    return null;
  }

  return $MultiplierRuleDtoCopyWith<$Res>(_self.multipierStreak!, (value) {
    return _then(_self.copyWith(multipierStreak: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClubModelDto].
extension ClubModelDtoPatterns on ClubModelDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClubModelDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClubModelDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClubModelDto value)  $default,){
final _that = this;
switch (_that) {
case _ClubModelDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClubModelDto value)?  $default,){
final _that = this;
switch (_that) {
case _ClubModelDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  int giftDay, @JsonKey(name: 'campaignId')  String attachedCampaignId,  String campaignName,  String campaignDescription, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp createdAt, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp updatedAt,  int totalMembers,  String? id,  MultiplierRuleDto? multipierStreak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClubModelDto() when $default != null:
return $default(_that.name,_that.description,_that.giftDay,_that.attachedCampaignId,_that.campaignName,_that.campaignDescription,_that.createdAt,_that.updatedAt,_that.totalMembers,_that.id,_that.multipierStreak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  int giftDay, @JsonKey(name: 'campaignId')  String attachedCampaignId,  String campaignName,  String campaignDescription, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp createdAt, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp updatedAt,  int totalMembers,  String? id,  MultiplierRuleDto? multipierStreak)  $default,) {final _that = this;
switch (_that) {
case _ClubModelDto():
return $default(_that.name,_that.description,_that.giftDay,_that.attachedCampaignId,_that.campaignName,_that.campaignDescription,_that.createdAt,_that.updatedAt,_that.totalMembers,_that.id,_that.multipierStreak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  int giftDay, @JsonKey(name: 'campaignId')  String attachedCampaignId,  String campaignName,  String campaignDescription, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp createdAt, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson)  Timestamp updatedAt,  int totalMembers,  String? id,  MultiplierRuleDto? multipierStreak)?  $default,) {final _that = this;
switch (_that) {
case _ClubModelDto() when $default != null:
return $default(_that.name,_that.description,_that.giftDay,_that.attachedCampaignId,_that.campaignName,_that.campaignDescription,_that.createdAt,_that.updatedAt,_that.totalMembers,_that.id,_that.multipierStreak);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClubModelDto extends ClubModelDto {
  const _ClubModelDto({required this.name, required this.description, required this.giftDay, @JsonKey(name: 'campaignId') required this.attachedCampaignId, required this.campaignName, required this.campaignDescription, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.createdAt, @JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) required this.updatedAt, required this.totalMembers, this.id, this.multipierStreak}): super._();
  factory _ClubModelDto.fromJson(Map<String, dynamic> json) => _$ClubModelDtoFromJson(json);

@override final  String name;
@override final  String description;
@override final  int giftDay;
@override@JsonKey(name: 'campaignId') final  String attachedCampaignId;
@override final  String campaignName;
@override final  String campaignDescription;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp createdAt;
@override@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) final  Timestamp updatedAt;
// @JsonKey(name: 'shopList') required List<ClubShopListDto> shops,
@override final  int totalMembers;
@override final  String? id;
@override final  MultiplierRuleDto? multipierStreak;

/// Create a copy of ClubModelDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClubModelDtoCopyWith<_ClubModelDto> get copyWith => __$ClubModelDtoCopyWithImpl<_ClubModelDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClubModelDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClubModelDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDay, giftDay) || other.giftDay == giftDay)&&(identical(other.attachedCampaignId, attachedCampaignId) || other.attachedCampaignId == attachedCampaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.campaignDescription, campaignDescription) || other.campaignDescription == campaignDescription)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&(identical(other.id, id) || other.id == id)&&(identical(other.multipierStreak, multipierStreak) || other.multipierStreak == multipierStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,giftDay,attachedCampaignId,campaignName,campaignDescription,createdAt,updatedAt,totalMembers,id,multipierStreak);

@override
String toString() {
  return 'ClubModelDto(name: $name, description: $description, giftDay: $giftDay, attachedCampaignId: $attachedCampaignId, campaignName: $campaignName, campaignDescription: $campaignDescription, createdAt: $createdAt, updatedAt: $updatedAt, totalMembers: $totalMembers, id: $id, multipierStreak: $multipierStreak)';
}


}

/// @nodoc
abstract mixin class _$ClubModelDtoCopyWith<$Res> implements $ClubModelDtoCopyWith<$Res> {
  factory _$ClubModelDtoCopyWith(_ClubModelDto value, $Res Function(_ClubModelDto) _then) = __$ClubModelDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, int giftDay,@JsonKey(name: 'campaignId') String attachedCampaignId, String campaignName, String campaignDescription,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp createdAt,@JsonKey(fromJson: FirebaseHelper.timestampFromJson, toJson: FirebaseHelper.timestampToJson) Timestamp updatedAt, int totalMembers, String? id, MultiplierRuleDto? multipierStreak
});


@override $MultiplierRuleDtoCopyWith<$Res>? get multipierStreak;

}
/// @nodoc
class __$ClubModelDtoCopyWithImpl<$Res>
    implements _$ClubModelDtoCopyWith<$Res> {
  __$ClubModelDtoCopyWithImpl(this._self, this._then);

  final _ClubModelDto _self;
  final $Res Function(_ClubModelDto) _then;

/// Create a copy of ClubModelDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? giftDay = null,Object? attachedCampaignId = null,Object? campaignName = null,Object? campaignDescription = null,Object? createdAt = null,Object? updatedAt = null,Object? totalMembers = null,Object? id = freezed,Object? multipierStreak = freezed,}) {
  return _then(_ClubModelDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDay: null == giftDay ? _self.giftDay : giftDay // ignore: cast_nullable_to_non_nullable
as int,attachedCampaignId: null == attachedCampaignId ? _self.attachedCampaignId : attachedCampaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,campaignDescription: null == campaignDescription ? _self.campaignDescription : campaignDescription // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,totalMembers: null == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,multipierStreak: freezed == multipierStreak ? _self.multipierStreak : multipierStreak // ignore: cast_nullable_to_non_nullable
as MultiplierRuleDto?,
  ));
}

/// Create a copy of ClubModelDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultiplierRuleDtoCopyWith<$Res>? get multipierStreak {
    if (_self.multipierStreak == null) {
    return null;
  }

  return $MultiplierRuleDtoCopyWith<$Res>(_self.multipierStreak!, (value) {
    return _then(_self.copyWith(multipierStreak: value));
  });
}
}


/// @nodoc
mixin _$MultiplierRuleDto {

 int get bonusIncrement; int get daysRequired;
/// Create a copy of MultiplierRuleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultiplierRuleDtoCopyWith<MultiplierRuleDto> get copyWith => _$MultiplierRuleDtoCopyWithImpl<MultiplierRuleDto>(this as MultiplierRuleDto, _$identity);

  /// Serializes this MultiplierRuleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MultiplierRuleDto&&(identical(other.bonusIncrement, bonusIncrement) || other.bonusIncrement == bonusIncrement)&&(identical(other.daysRequired, daysRequired) || other.daysRequired == daysRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bonusIncrement,daysRequired);

@override
String toString() {
  return 'MultiplierRuleDto(bonusIncrement: $bonusIncrement, daysRequired: $daysRequired)';
}


}

/// @nodoc
abstract mixin class $MultiplierRuleDtoCopyWith<$Res>  {
  factory $MultiplierRuleDtoCopyWith(MultiplierRuleDto value, $Res Function(MultiplierRuleDto) _then) = _$MultiplierRuleDtoCopyWithImpl;
@useResult
$Res call({
 int bonusIncrement, int daysRequired
});




}
/// @nodoc
class _$MultiplierRuleDtoCopyWithImpl<$Res>
    implements $MultiplierRuleDtoCopyWith<$Res> {
  _$MultiplierRuleDtoCopyWithImpl(this._self, this._then);

  final MultiplierRuleDto _self;
  final $Res Function(MultiplierRuleDto) _then;

/// Create a copy of MultiplierRuleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bonusIncrement = null,Object? daysRequired = null,}) {
  return _then(_self.copyWith(
bonusIncrement: null == bonusIncrement ? _self.bonusIncrement : bonusIncrement // ignore: cast_nullable_to_non_nullable
as int,daysRequired: null == daysRequired ? _self.daysRequired : daysRequired // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MultiplierRuleDto].
extension MultiplierRuleDtoPatterns on MultiplierRuleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MultiplierRuleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MultiplierRuleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MultiplierRuleDto value)  $default,){
final _that = this;
switch (_that) {
case _MultiplierRuleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MultiplierRuleDto value)?  $default,){
final _that = this;
switch (_that) {
case _MultiplierRuleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bonusIncrement,  int daysRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MultiplierRuleDto() when $default != null:
return $default(_that.bonusIncrement,_that.daysRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bonusIncrement,  int daysRequired)  $default,) {final _that = this;
switch (_that) {
case _MultiplierRuleDto():
return $default(_that.bonusIncrement,_that.daysRequired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bonusIncrement,  int daysRequired)?  $default,) {final _that = this;
switch (_that) {
case _MultiplierRuleDto() when $default != null:
return $default(_that.bonusIncrement,_that.daysRequired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MultiplierRuleDto implements MultiplierRuleDto {
  const _MultiplierRuleDto({required this.bonusIncrement, required this.daysRequired});
  factory _MultiplierRuleDto.fromJson(Map<String, dynamic> json) => _$MultiplierRuleDtoFromJson(json);

@override final  int bonusIncrement;
@override final  int daysRequired;

/// Create a copy of MultiplierRuleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MultiplierRuleDtoCopyWith<_MultiplierRuleDto> get copyWith => __$MultiplierRuleDtoCopyWithImpl<_MultiplierRuleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MultiplierRuleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MultiplierRuleDto&&(identical(other.bonusIncrement, bonusIncrement) || other.bonusIncrement == bonusIncrement)&&(identical(other.daysRequired, daysRequired) || other.daysRequired == daysRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bonusIncrement,daysRequired);

@override
String toString() {
  return 'MultiplierRuleDto(bonusIncrement: $bonusIncrement, daysRequired: $daysRequired)';
}


}

/// @nodoc
abstract mixin class _$MultiplierRuleDtoCopyWith<$Res> implements $MultiplierRuleDtoCopyWith<$Res> {
  factory _$MultiplierRuleDtoCopyWith(_MultiplierRuleDto value, $Res Function(_MultiplierRuleDto) _then) = __$MultiplierRuleDtoCopyWithImpl;
@override @useResult
$Res call({
 int bonusIncrement, int daysRequired
});




}
/// @nodoc
class __$MultiplierRuleDtoCopyWithImpl<$Res>
    implements _$MultiplierRuleDtoCopyWith<$Res> {
  __$MultiplierRuleDtoCopyWithImpl(this._self, this._then);

  final _MultiplierRuleDto _self;
  final $Res Function(_MultiplierRuleDto) _then;

/// Create a copy of MultiplierRuleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bonusIncrement = null,Object? daysRequired = null,}) {
  return _then(_MultiplierRuleDto(
bonusIncrement: null == bonusIncrement ? _self.bonusIncrement : bonusIncrement // ignore: cast_nullable_to_non_nullable
as int,daysRequired: null == daysRequired ? _self.daysRequired : daysRequired // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClubShopListDto {

 String get shopId; String get shopName;@JsonKey(name: 'address') String get shopAddress; String get phoneNumber;
/// Create a copy of ClubShopListDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClubShopListDtoCopyWith<ClubShopListDto> get copyWith => _$ClubShopListDtoCopyWithImpl<ClubShopListDto>(this as ClubShopListDto, _$identity);

  /// Serializes this ClubShopListDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClubShopListDto&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,shopAddress,phoneNumber);

@override
String toString() {
  return 'ClubShopListDto(shopId: $shopId, shopName: $shopName, shopAddress: $shopAddress, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $ClubShopListDtoCopyWith<$Res>  {
  factory $ClubShopListDtoCopyWith(ClubShopListDto value, $Res Function(ClubShopListDto) _then) = _$ClubShopListDtoCopyWithImpl;
@useResult
$Res call({
 String shopId, String shopName,@JsonKey(name: 'address') String shopAddress, String phoneNumber
});




}
/// @nodoc
class _$ClubShopListDtoCopyWithImpl<$Res>
    implements $ClubShopListDtoCopyWith<$Res> {
  _$ClubShopListDtoCopyWithImpl(this._self, this._then);

  final ClubShopListDto _self;
  final $Res Function(ClubShopListDto) _then;

/// Create a copy of ClubShopListDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? shopName = null,Object? shopAddress = null,Object? phoneNumber = null,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClubShopListDto].
extension ClubShopListDtoPatterns on ClubShopListDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClubShopListDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClubShopListDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClubShopListDto value)  $default,){
final _that = this;
switch (_that) {
case _ClubShopListDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClubShopListDto value)?  $default,){
final _that = this;
switch (_that) {
case _ClubShopListDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  String shopName, @JsonKey(name: 'address')  String shopAddress,  String phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClubShopListDto() when $default != null:
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  String shopName, @JsonKey(name: 'address')  String shopAddress,  String phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _ClubShopListDto():
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  String shopName, @JsonKey(name: 'address')  String shopAddress,  String phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _ClubShopListDto() when $default != null:
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClubShopListDto implements ClubShopListDto {
  const _ClubShopListDto({required this.shopId, required this.shopName, @JsonKey(name: 'address') required this.shopAddress, required this.phoneNumber});
  factory _ClubShopListDto.fromJson(Map<String, dynamic> json) => _$ClubShopListDtoFromJson(json);

@override final  String shopId;
@override final  String shopName;
@override@JsonKey(name: 'address') final  String shopAddress;
@override final  String phoneNumber;

/// Create a copy of ClubShopListDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClubShopListDtoCopyWith<_ClubShopListDto> get copyWith => __$ClubShopListDtoCopyWithImpl<_ClubShopListDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClubShopListDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClubShopListDto&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,shopAddress,phoneNumber);

@override
String toString() {
  return 'ClubShopListDto(shopId: $shopId, shopName: $shopName, shopAddress: $shopAddress, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$ClubShopListDtoCopyWith<$Res> implements $ClubShopListDtoCopyWith<$Res> {
  factory _$ClubShopListDtoCopyWith(_ClubShopListDto value, $Res Function(_ClubShopListDto) _then) = __$ClubShopListDtoCopyWithImpl;
@override @useResult
$Res call({
 String shopId, String shopName,@JsonKey(name: 'address') String shopAddress, String phoneNumber
});




}
/// @nodoc
class __$ClubShopListDtoCopyWithImpl<$Res>
    implements _$ClubShopListDtoCopyWith<$Res> {
  __$ClubShopListDtoCopyWithImpl(this._self, this._then);

  final _ClubShopListDto _self;
  final $Res Function(_ClubShopListDto) _then;

/// Create a copy of ClubShopListDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? shopName = null,Object? shopAddress = null,Object? phoneNumber = null,}) {
  return _then(_ClubShopListDto(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
