// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClubModel {

 String get id; String get name; String get description; int get giftDay; String get campaignId; String get campaignName; String get campaignDescription; DateTime get createdAt; DateTime get updatedAt;// required List<ClubShopListModel> shops,
 int get totalMembers; MultiplierRuleModel? get multipierStreak;
/// Create a copy of ClubModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClubModelCopyWith<ClubModel> get copyWith => _$ClubModelCopyWithImpl<ClubModel>(this as ClubModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClubModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDay, giftDay) || other.giftDay == giftDay)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.campaignDescription, campaignDescription) || other.campaignDescription == campaignDescription)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&(identical(other.multipierStreak, multipierStreak) || other.multipierStreak == multipierStreak));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,giftDay,campaignId,campaignName,campaignDescription,createdAt,updatedAt,totalMembers,multipierStreak);

@override
String toString() {
  return 'ClubModel(id: $id, name: $name, description: $description, giftDay: $giftDay, campaignId: $campaignId, campaignName: $campaignName, campaignDescription: $campaignDescription, createdAt: $createdAt, updatedAt: $updatedAt, totalMembers: $totalMembers, multipierStreak: $multipierStreak)';
}


}

/// @nodoc
abstract mixin class $ClubModelCopyWith<$Res>  {
  factory $ClubModelCopyWith(ClubModel value, $Res Function(ClubModel) _then) = _$ClubModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, int giftDay, String campaignId, String campaignName, String campaignDescription, DateTime createdAt, DateTime updatedAt, int totalMembers, MultiplierRuleModel? multipierStreak
});


$MultiplierRuleModelCopyWith<$Res>? get multipierStreak;

}
/// @nodoc
class _$ClubModelCopyWithImpl<$Res>
    implements $ClubModelCopyWith<$Res> {
  _$ClubModelCopyWithImpl(this._self, this._then);

  final ClubModel _self;
  final $Res Function(ClubModel) _then;

/// Create a copy of ClubModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? giftDay = null,Object? campaignId = null,Object? campaignName = null,Object? campaignDescription = null,Object? createdAt = null,Object? updatedAt = null,Object? totalMembers = null,Object? multipierStreak = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDay: null == giftDay ? _self.giftDay : giftDay // ignore: cast_nullable_to_non_nullable
as int,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,campaignDescription: null == campaignDescription ? _self.campaignDescription : campaignDescription // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalMembers: null == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int,multipierStreak: freezed == multipierStreak ? _self.multipierStreak : multipierStreak // ignore: cast_nullable_to_non_nullable
as MultiplierRuleModel?,
  ));
}
/// Create a copy of ClubModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultiplierRuleModelCopyWith<$Res>? get multipierStreak {
    if (_self.multipierStreak == null) {
    return null;
  }

  return $MultiplierRuleModelCopyWith<$Res>(_self.multipierStreak!, (value) {
    return _then(_self.copyWith(multipierStreak: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClubModel].
extension ClubModelPatterns on ClubModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClubModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClubModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClubModel value)  $default,){
final _that = this;
switch (_that) {
case _ClubModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClubModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClubModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  int giftDay,  String campaignId,  String campaignName,  String campaignDescription,  DateTime createdAt,  DateTime updatedAt,  int totalMembers,  MultiplierRuleModel? multipierStreak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClubModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.giftDay,_that.campaignId,_that.campaignName,_that.campaignDescription,_that.createdAt,_that.updatedAt,_that.totalMembers,_that.multipierStreak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  int giftDay,  String campaignId,  String campaignName,  String campaignDescription,  DateTime createdAt,  DateTime updatedAt,  int totalMembers,  MultiplierRuleModel? multipierStreak)  $default,) {final _that = this;
switch (_that) {
case _ClubModel():
return $default(_that.id,_that.name,_that.description,_that.giftDay,_that.campaignId,_that.campaignName,_that.campaignDescription,_that.createdAt,_that.updatedAt,_that.totalMembers,_that.multipierStreak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  int giftDay,  String campaignId,  String campaignName,  String campaignDescription,  DateTime createdAt,  DateTime updatedAt,  int totalMembers,  MultiplierRuleModel? multipierStreak)?  $default,) {final _that = this;
switch (_that) {
case _ClubModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.giftDay,_that.campaignId,_that.campaignName,_that.campaignDescription,_that.createdAt,_that.updatedAt,_that.totalMembers,_that.multipierStreak);case _:
  return null;

}
}

}

/// @nodoc


class _ClubModel implements ClubModel {
  const _ClubModel({required this.id, required this.name, required this.description, required this.giftDay, required this.campaignId, required this.campaignName, required this.campaignDescription, required this.createdAt, required this.updatedAt, required this.totalMembers, this.multipierStreak});
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  int giftDay;
@override final  String campaignId;
@override final  String campaignName;
@override final  String campaignDescription;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
// required List<ClubShopListModel> shops,
@override final  int totalMembers;
@override final  MultiplierRuleModel? multipierStreak;

/// Create a copy of ClubModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClubModelCopyWith<_ClubModel> get copyWith => __$ClubModelCopyWithImpl<_ClubModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClubModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.giftDay, giftDay) || other.giftDay == giftDay)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.campaignDescription, campaignDescription) || other.campaignDescription == campaignDescription)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&(identical(other.multipierStreak, multipierStreak) || other.multipierStreak == multipierStreak));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,giftDay,campaignId,campaignName,campaignDescription,createdAt,updatedAt,totalMembers,multipierStreak);

@override
String toString() {
  return 'ClubModel(id: $id, name: $name, description: $description, giftDay: $giftDay, campaignId: $campaignId, campaignName: $campaignName, campaignDescription: $campaignDescription, createdAt: $createdAt, updatedAt: $updatedAt, totalMembers: $totalMembers, multipierStreak: $multipierStreak)';
}


}

/// @nodoc
abstract mixin class _$ClubModelCopyWith<$Res> implements $ClubModelCopyWith<$Res> {
  factory _$ClubModelCopyWith(_ClubModel value, $Res Function(_ClubModel) _then) = __$ClubModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, int giftDay, String campaignId, String campaignName, String campaignDescription, DateTime createdAt, DateTime updatedAt, int totalMembers, MultiplierRuleModel? multipierStreak
});


@override $MultiplierRuleModelCopyWith<$Res>? get multipierStreak;

}
/// @nodoc
class __$ClubModelCopyWithImpl<$Res>
    implements _$ClubModelCopyWith<$Res> {
  __$ClubModelCopyWithImpl(this._self, this._then);

  final _ClubModel _self;
  final $Res Function(_ClubModel) _then;

/// Create a copy of ClubModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? giftDay = null,Object? campaignId = null,Object? campaignName = null,Object? campaignDescription = null,Object? createdAt = null,Object? updatedAt = null,Object? totalMembers = null,Object? multipierStreak = freezed,}) {
  return _then(_ClubModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,giftDay: null == giftDay ? _self.giftDay : giftDay // ignore: cast_nullable_to_non_nullable
as int,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,campaignDescription: null == campaignDescription ? _self.campaignDescription : campaignDescription // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalMembers: null == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int,multipierStreak: freezed == multipierStreak ? _self.multipierStreak : multipierStreak // ignore: cast_nullable_to_non_nullable
as MultiplierRuleModel?,
  ));
}

/// Create a copy of ClubModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultiplierRuleModelCopyWith<$Res>? get multipierStreak {
    if (_self.multipierStreak == null) {
    return null;
  }

  return $MultiplierRuleModelCopyWith<$Res>(_self.multipierStreak!, (value) {
    return _then(_self.copyWith(multipierStreak: value));
  });
}
}

/// @nodoc
mixin _$MultiplierRuleModel {

 int get bonusIncrement; int get daysRequired;
/// Create a copy of MultiplierRuleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultiplierRuleModelCopyWith<MultiplierRuleModel> get copyWith => _$MultiplierRuleModelCopyWithImpl<MultiplierRuleModel>(this as MultiplierRuleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MultiplierRuleModel&&(identical(other.bonusIncrement, bonusIncrement) || other.bonusIncrement == bonusIncrement)&&(identical(other.daysRequired, daysRequired) || other.daysRequired == daysRequired));
}


@override
int get hashCode => Object.hash(runtimeType,bonusIncrement,daysRequired);

@override
String toString() {
  return 'MultiplierRuleModel(bonusIncrement: $bonusIncrement, daysRequired: $daysRequired)';
}


}

/// @nodoc
abstract mixin class $MultiplierRuleModelCopyWith<$Res>  {
  factory $MultiplierRuleModelCopyWith(MultiplierRuleModel value, $Res Function(MultiplierRuleModel) _then) = _$MultiplierRuleModelCopyWithImpl;
@useResult
$Res call({
 int bonusIncrement, int daysRequired
});




}
/// @nodoc
class _$MultiplierRuleModelCopyWithImpl<$Res>
    implements $MultiplierRuleModelCopyWith<$Res> {
  _$MultiplierRuleModelCopyWithImpl(this._self, this._then);

  final MultiplierRuleModel _self;
  final $Res Function(MultiplierRuleModel) _then;

/// Create a copy of MultiplierRuleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bonusIncrement = null,Object? daysRequired = null,}) {
  return _then(_self.copyWith(
bonusIncrement: null == bonusIncrement ? _self.bonusIncrement : bonusIncrement // ignore: cast_nullable_to_non_nullable
as int,daysRequired: null == daysRequired ? _self.daysRequired : daysRequired // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MultiplierRuleModel].
extension MultiplierRuleModelPatterns on MultiplierRuleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MultiplierRuleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MultiplierRuleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MultiplierRuleModel value)  $default,){
final _that = this;
switch (_that) {
case _MultiplierRuleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MultiplierRuleModel value)?  $default,){
final _that = this;
switch (_that) {
case _MultiplierRuleModel() when $default != null:
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
case _MultiplierRuleModel() when $default != null:
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
case _MultiplierRuleModel():
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
case _MultiplierRuleModel() when $default != null:
return $default(_that.bonusIncrement,_that.daysRequired);case _:
  return null;

}
}

}

/// @nodoc


class _MultiplierRuleModel implements MultiplierRuleModel {
  const _MultiplierRuleModel({required this.bonusIncrement, required this.daysRequired});
  

@override final  int bonusIncrement;
@override final  int daysRequired;

/// Create a copy of MultiplierRuleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MultiplierRuleModelCopyWith<_MultiplierRuleModel> get copyWith => __$MultiplierRuleModelCopyWithImpl<_MultiplierRuleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MultiplierRuleModel&&(identical(other.bonusIncrement, bonusIncrement) || other.bonusIncrement == bonusIncrement)&&(identical(other.daysRequired, daysRequired) || other.daysRequired == daysRequired));
}


@override
int get hashCode => Object.hash(runtimeType,bonusIncrement,daysRequired);

@override
String toString() {
  return 'MultiplierRuleModel(bonusIncrement: $bonusIncrement, daysRequired: $daysRequired)';
}


}

/// @nodoc
abstract mixin class _$MultiplierRuleModelCopyWith<$Res> implements $MultiplierRuleModelCopyWith<$Res> {
  factory _$MultiplierRuleModelCopyWith(_MultiplierRuleModel value, $Res Function(_MultiplierRuleModel) _then) = __$MultiplierRuleModelCopyWithImpl;
@override @useResult
$Res call({
 int bonusIncrement, int daysRequired
});




}
/// @nodoc
class __$MultiplierRuleModelCopyWithImpl<$Res>
    implements _$MultiplierRuleModelCopyWith<$Res> {
  __$MultiplierRuleModelCopyWithImpl(this._self, this._then);

  final _MultiplierRuleModel _self;
  final $Res Function(_MultiplierRuleModel) _then;

/// Create a copy of MultiplierRuleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bonusIncrement = null,Object? daysRequired = null,}) {
  return _then(_MultiplierRuleModel(
bonusIncrement: null == bonusIncrement ? _self.bonusIncrement : bonusIncrement // ignore: cast_nullable_to_non_nullable
as int,daysRequired: null == daysRequired ? _self.daysRequired : daysRequired // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ClubShopListModel {

 String get shopId; String get shopName; String get shopAddress; String get phoneNumber;
/// Create a copy of ClubShopListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClubShopListModelCopyWith<ClubShopListModel> get copyWith => _$ClubShopListModelCopyWithImpl<ClubShopListModel>(this as ClubShopListModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClubShopListModel&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,shopAddress,phoneNumber);

@override
String toString() {
  return 'ClubShopListModel(shopId: $shopId, shopName: $shopName, shopAddress: $shopAddress, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $ClubShopListModelCopyWith<$Res>  {
  factory $ClubShopListModelCopyWith(ClubShopListModel value, $Res Function(ClubShopListModel) _then) = _$ClubShopListModelCopyWithImpl;
@useResult
$Res call({
 String shopId, String shopName, String shopAddress, String phoneNumber
});




}
/// @nodoc
class _$ClubShopListModelCopyWithImpl<$Res>
    implements $ClubShopListModelCopyWith<$Res> {
  _$ClubShopListModelCopyWithImpl(this._self, this._then);

  final ClubShopListModel _self;
  final $Res Function(ClubShopListModel) _then;

/// Create a copy of ClubShopListModel
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


/// Adds pattern-matching-related methods to [ClubShopListModel].
extension ClubShopListModelPatterns on ClubShopListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClubShopListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClubShopListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClubShopListModel value)  $default,){
final _that = this;
switch (_that) {
case _ClubShopListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClubShopListModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClubShopListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String shopId,  String shopName,  String shopAddress,  String phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClubShopListModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String shopId,  String shopName,  String shopAddress,  String phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _ClubShopListModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String shopId,  String shopName,  String shopAddress,  String phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _ClubShopListModel() when $default != null:
return $default(_that.shopId,_that.shopName,_that.shopAddress,_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc


class _ClubShopListModel implements ClubShopListModel {
  const _ClubShopListModel({required this.shopId, required this.shopName, required this.shopAddress, required this.phoneNumber});
  

@override final  String shopId;
@override final  String shopName;
@override final  String shopAddress;
@override final  String phoneNumber;

/// Create a copy of ClubShopListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClubShopListModelCopyWith<_ClubShopListModel> get copyWith => __$ClubShopListModelCopyWithImpl<_ClubShopListModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClubShopListModel&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopAddress, shopAddress) || other.shopAddress == shopAddress)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,shopId,shopName,shopAddress,phoneNumber);

@override
String toString() {
  return 'ClubShopListModel(shopId: $shopId, shopName: $shopName, shopAddress: $shopAddress, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$ClubShopListModelCopyWith<$Res> implements $ClubShopListModelCopyWith<$Res> {
  factory _$ClubShopListModelCopyWith(_ClubShopListModel value, $Res Function(_ClubShopListModel) _then) = __$ClubShopListModelCopyWithImpl;
@override @useResult
$Res call({
 String shopId, String shopName, String shopAddress, String phoneNumber
});




}
/// @nodoc
class __$ClubShopListModelCopyWithImpl<$Res>
    implements _$ClubShopListModelCopyWith<$Res> {
  __$ClubShopListModelCopyWithImpl(this._self, this._then);

  final _ClubShopListModel _self;
  final $Res Function(_ClubShopListModel) _then;

/// Create a copy of ClubShopListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? shopName = null,Object? shopAddress = null,Object? phoneNumber = null,}) {
  return _then(_ClubShopListModel(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopAddress: null == shopAddress ? _self.shopAddress : shopAddress // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
