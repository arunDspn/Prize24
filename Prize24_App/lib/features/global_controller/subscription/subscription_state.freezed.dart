// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionState {

 int get maxShops; int get maxCampaigns; int get maxUserFollowing; int get coinBalance; String get rcEntitlementName;
/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateCopyWith<SubscriptionState> get copyWith => _$SubscriptionStateCopyWithImpl<SubscriptionState>(this as SubscriptionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionState&&(identical(other.maxShops, maxShops) || other.maxShops == maxShops)&&(identical(other.maxCampaigns, maxCampaigns) || other.maxCampaigns == maxCampaigns)&&(identical(other.maxUserFollowing, maxUserFollowing) || other.maxUserFollowing == maxUserFollowing)&&(identical(other.coinBalance, coinBalance) || other.coinBalance == coinBalance)&&(identical(other.rcEntitlementName, rcEntitlementName) || other.rcEntitlementName == rcEntitlementName));
}


@override
int get hashCode => Object.hash(runtimeType,maxShops,maxCampaigns,maxUserFollowing,coinBalance,rcEntitlementName);

@override
String toString() {
  return 'SubscriptionState(maxShops: $maxShops, maxCampaigns: $maxCampaigns, maxUserFollowing: $maxUserFollowing, coinBalance: $coinBalance, rcEntitlementName: $rcEntitlementName)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateCopyWith<$Res>  {
  factory $SubscriptionStateCopyWith(SubscriptionState value, $Res Function(SubscriptionState) _then) = _$SubscriptionStateCopyWithImpl;
@useResult
$Res call({
 int maxShops, int maxCampaigns, int maxUserFollowing, int coinBalance, String rcEntitlementName
});




}
/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._self, this._then);

  final SubscriptionState _self;
  final $Res Function(SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxShops = null,Object? maxCampaigns = null,Object? maxUserFollowing = null,Object? coinBalance = null,Object? rcEntitlementName = null,}) {
  return _then(_self.copyWith(
maxShops: null == maxShops ? _self.maxShops : maxShops // ignore: cast_nullable_to_non_nullable
as int,maxCampaigns: null == maxCampaigns ? _self.maxCampaigns : maxCampaigns // ignore: cast_nullable_to_non_nullable
as int,maxUserFollowing: null == maxUserFollowing ? _self.maxUserFollowing : maxUserFollowing // ignore: cast_nullable_to_non_nullable
as int,coinBalance: null == coinBalance ? _self.coinBalance : coinBalance // ignore: cast_nullable_to_non_nullable
as int,rcEntitlementName: null == rcEntitlementName ? _self.rcEntitlementName : rcEntitlementName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionState].
extension SubscriptionStatePatterns on SubscriptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionState value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionState value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxShops,  int maxCampaigns,  int maxUserFollowing,  int coinBalance,  String rcEntitlementName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.maxShops,_that.maxCampaigns,_that.maxUserFollowing,_that.coinBalance,_that.rcEntitlementName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxShops,  int maxCampaigns,  int maxUserFollowing,  int coinBalance,  String rcEntitlementName)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState():
return $default(_that.maxShops,_that.maxCampaigns,_that.maxUserFollowing,_that.coinBalance,_that.rcEntitlementName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxShops,  int maxCampaigns,  int maxUserFollowing,  int coinBalance,  String rcEntitlementName)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.maxShops,_that.maxCampaigns,_that.maxUserFollowing,_that.coinBalance,_that.rcEntitlementName);case _:
  return null;

}
}

}

/// @nodoc


class _SubscriptionState implements SubscriptionState {
  const _SubscriptionState({required this.maxShops, required this.maxCampaigns, required this.maxUserFollowing, required this.coinBalance, required this.rcEntitlementName});
  

@override final  int maxShops;
@override final  int maxCampaigns;
@override final  int maxUserFollowing;
@override final  int coinBalance;
@override final  String rcEntitlementName;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionStateCopyWith<_SubscriptionState> get copyWith => __$SubscriptionStateCopyWithImpl<_SubscriptionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionState&&(identical(other.maxShops, maxShops) || other.maxShops == maxShops)&&(identical(other.maxCampaigns, maxCampaigns) || other.maxCampaigns == maxCampaigns)&&(identical(other.maxUserFollowing, maxUserFollowing) || other.maxUserFollowing == maxUserFollowing)&&(identical(other.coinBalance, coinBalance) || other.coinBalance == coinBalance)&&(identical(other.rcEntitlementName, rcEntitlementName) || other.rcEntitlementName == rcEntitlementName));
}


@override
int get hashCode => Object.hash(runtimeType,maxShops,maxCampaigns,maxUserFollowing,coinBalance,rcEntitlementName);

@override
String toString() {
  return 'SubscriptionState(maxShops: $maxShops, maxCampaigns: $maxCampaigns, maxUserFollowing: $maxUserFollowing, coinBalance: $coinBalance, rcEntitlementName: $rcEntitlementName)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionStateCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory _$SubscriptionStateCopyWith(_SubscriptionState value, $Res Function(_SubscriptionState) _then) = __$SubscriptionStateCopyWithImpl;
@override @useResult
$Res call({
 int maxShops, int maxCampaigns, int maxUserFollowing, int coinBalance, String rcEntitlementName
});




}
/// @nodoc
class __$SubscriptionStateCopyWithImpl<$Res>
    implements _$SubscriptionStateCopyWith<$Res> {
  __$SubscriptionStateCopyWithImpl(this._self, this._then);

  final _SubscriptionState _self;
  final $Res Function(_SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxShops = null,Object? maxCampaigns = null,Object? maxUserFollowing = null,Object? coinBalance = null,Object? rcEntitlementName = null,}) {
  return _then(_SubscriptionState(
maxShops: null == maxShops ? _self.maxShops : maxShops // ignore: cast_nullable_to_non_nullable
as int,maxCampaigns: null == maxCampaigns ? _self.maxCampaigns : maxCampaigns // ignore: cast_nullable_to_non_nullable
as int,maxUserFollowing: null == maxUserFollowing ? _self.maxUserFollowing : maxUserFollowing // ignore: cast_nullable_to_non_nullable
as int,coinBalance: null == coinBalance ? _self.coinBalance : coinBalance // ignore: cast_nullable_to_non_nullable
as int,rcEntitlementName: null == rcEntitlementName ? _self.rcEntitlementName : rcEntitlementName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
