// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_analytics_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GiftAnalyticsDto {

 String get giftId; String get giftName; int get totalRedeemed; int get totalRemaining; DateTime get lastRedeemedAt; DateTime get createdAt; DateTime get updatedAt;/// Campaign ID to which this gift belongs
 String get campaignId; String get campaignName;
/// Create a copy of GiftAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftAnalyticsDtoCopyWith<GiftAnalyticsDto> get copyWith => _$GiftAnalyticsDtoCopyWithImpl<GiftAnalyticsDto>(this as GiftAnalyticsDto, _$identity);

  /// Serializes this GiftAnalyticsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftAnalyticsDto&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.totalRedeemed, totalRedeemed) || other.totalRedeemed == totalRedeemed)&&(identical(other.totalRemaining, totalRemaining) || other.totalRemaining == totalRemaining)&&(identical(other.lastRedeemedAt, lastRedeemedAt) || other.lastRedeemedAt == lastRedeemedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,giftId,giftName,totalRedeemed,totalRemaining,lastRedeemedAt,createdAt,updatedAt,campaignId,campaignName);

@override
String toString() {
  return 'GiftAnalyticsDto(giftId: $giftId, giftName: $giftName, totalRedeemed: $totalRedeemed, totalRemaining: $totalRemaining, lastRedeemedAt: $lastRedeemedAt, createdAt: $createdAt, updatedAt: $updatedAt, campaignId: $campaignId, campaignName: $campaignName)';
}


}

/// @nodoc
abstract mixin class $GiftAnalyticsDtoCopyWith<$Res>  {
  factory $GiftAnalyticsDtoCopyWith(GiftAnalyticsDto value, $Res Function(GiftAnalyticsDto) _then) = _$GiftAnalyticsDtoCopyWithImpl;
@useResult
$Res call({
 String giftId, String giftName, int totalRedeemed, int totalRemaining, DateTime lastRedeemedAt, DateTime createdAt, DateTime updatedAt, String campaignId, String campaignName
});




}
/// @nodoc
class _$GiftAnalyticsDtoCopyWithImpl<$Res>
    implements $GiftAnalyticsDtoCopyWith<$Res> {
  _$GiftAnalyticsDtoCopyWithImpl(this._self, this._then);

  final GiftAnalyticsDto _self;
  final $Res Function(GiftAnalyticsDto) _then;

/// Create a copy of GiftAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? giftId = null,Object? giftName = null,Object? totalRedeemed = null,Object? totalRemaining = null,Object? lastRedeemedAt = null,Object? createdAt = null,Object? updatedAt = null,Object? campaignId = null,Object? campaignName = null,}) {
  return _then(_self.copyWith(
giftId: null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,totalRedeemed: null == totalRedeemed ? _self.totalRedeemed : totalRedeemed // ignore: cast_nullable_to_non_nullable
as int,totalRemaining: null == totalRemaining ? _self.totalRemaining : totalRemaining // ignore: cast_nullable_to_non_nullable
as int,lastRedeemedAt: null == lastRedeemedAt ? _self.lastRedeemedAt : lastRedeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftAnalyticsDto].
extension GiftAnalyticsDtoPatterns on GiftAnalyticsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftAnalyticsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftAnalyticsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftAnalyticsDto value)  $default,){
final _that = this;
switch (_that) {
case _GiftAnalyticsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftAnalyticsDto value)?  $default,){
final _that = this;
switch (_that) {
case _GiftAnalyticsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String giftId,  String giftName,  int totalRedeemed,  int totalRemaining,  DateTime lastRedeemedAt,  DateTime createdAt,  DateTime updatedAt,  String campaignId,  String campaignName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftAnalyticsDto() when $default != null:
return $default(_that.giftId,_that.giftName,_that.totalRedeemed,_that.totalRemaining,_that.lastRedeemedAt,_that.createdAt,_that.updatedAt,_that.campaignId,_that.campaignName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String giftId,  String giftName,  int totalRedeemed,  int totalRemaining,  DateTime lastRedeemedAt,  DateTime createdAt,  DateTime updatedAt,  String campaignId,  String campaignName)  $default,) {final _that = this;
switch (_that) {
case _GiftAnalyticsDto():
return $default(_that.giftId,_that.giftName,_that.totalRedeemed,_that.totalRemaining,_that.lastRedeemedAt,_that.createdAt,_that.updatedAt,_that.campaignId,_that.campaignName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String giftId,  String giftName,  int totalRedeemed,  int totalRemaining,  DateTime lastRedeemedAt,  DateTime createdAt,  DateTime updatedAt,  String campaignId,  String campaignName)?  $default,) {final _that = this;
switch (_that) {
case _GiftAnalyticsDto() when $default != null:
return $default(_that.giftId,_that.giftName,_that.totalRedeemed,_that.totalRemaining,_that.lastRedeemedAt,_that.createdAt,_that.updatedAt,_that.campaignId,_that.campaignName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftAnalyticsDto implements GiftAnalyticsDto {
  const _GiftAnalyticsDto({required this.giftId, required this.giftName, required this.totalRedeemed, required this.totalRemaining, required this.lastRedeemedAt, required this.createdAt, required this.updatedAt, required this.campaignId, required this.campaignName});
  factory _GiftAnalyticsDto.fromJson(Map<String, dynamic> json) => _$GiftAnalyticsDtoFromJson(json);

@override final  String giftId;
@override final  String giftName;
@override final  int totalRedeemed;
@override final  int totalRemaining;
@override final  DateTime lastRedeemedAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
/// Campaign ID to which this gift belongs
@override final  String campaignId;
@override final  String campaignName;

/// Create a copy of GiftAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftAnalyticsDtoCopyWith<_GiftAnalyticsDto> get copyWith => __$GiftAnalyticsDtoCopyWithImpl<_GiftAnalyticsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftAnalyticsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftAnalyticsDto&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.totalRedeemed, totalRedeemed) || other.totalRedeemed == totalRedeemed)&&(identical(other.totalRemaining, totalRemaining) || other.totalRemaining == totalRemaining)&&(identical(other.lastRedeemedAt, lastRedeemedAt) || other.lastRedeemedAt == lastRedeemedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,giftId,giftName,totalRedeemed,totalRemaining,lastRedeemedAt,createdAt,updatedAt,campaignId,campaignName);

@override
String toString() {
  return 'GiftAnalyticsDto(giftId: $giftId, giftName: $giftName, totalRedeemed: $totalRedeemed, totalRemaining: $totalRemaining, lastRedeemedAt: $lastRedeemedAt, createdAt: $createdAt, updatedAt: $updatedAt, campaignId: $campaignId, campaignName: $campaignName)';
}


}

/// @nodoc
abstract mixin class _$GiftAnalyticsDtoCopyWith<$Res> implements $GiftAnalyticsDtoCopyWith<$Res> {
  factory _$GiftAnalyticsDtoCopyWith(_GiftAnalyticsDto value, $Res Function(_GiftAnalyticsDto) _then) = __$GiftAnalyticsDtoCopyWithImpl;
@override @useResult
$Res call({
 String giftId, String giftName, int totalRedeemed, int totalRemaining, DateTime lastRedeemedAt, DateTime createdAt, DateTime updatedAt, String campaignId, String campaignName
});




}
/// @nodoc
class __$GiftAnalyticsDtoCopyWithImpl<$Res>
    implements _$GiftAnalyticsDtoCopyWith<$Res> {
  __$GiftAnalyticsDtoCopyWithImpl(this._self, this._then);

  final _GiftAnalyticsDto _self;
  final $Res Function(_GiftAnalyticsDto) _then;

/// Create a copy of GiftAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? giftId = null,Object? giftName = null,Object? totalRedeemed = null,Object? totalRemaining = null,Object? lastRedeemedAt = null,Object? createdAt = null,Object? updatedAt = null,Object? campaignId = null,Object? campaignName = null,}) {
  return _then(_GiftAnalyticsDto(
giftId: null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,totalRedeemed: null == totalRedeemed ? _self.totalRedeemed : totalRedeemed // ignore: cast_nullable_to_non_nullable
as int,totalRemaining: null == totalRemaining ? _self.totalRemaining : totalRemaining // ignore: cast_nullable_to_non_nullable
as int,lastRedeemedAt: null == lastRedeemedAt ? _self.lastRedeemedAt : lastRedeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
