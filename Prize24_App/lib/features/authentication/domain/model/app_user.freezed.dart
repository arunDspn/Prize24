// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {

 String get userId; String get userEmail; String get userName; bool get isVendor; String get fcmToken; String get referralCode;// @Default(0) int p24Coins,
 List<String>? get subscribedShopTopics; List<String>? get staffShopIds; String? get profilePic; String? get userPhoneNumber;// int? maximumShops,
// int? maximumCampaigns,
// int? maximumUserFollowing,
 String? get vendorPhoneNumber;// Referrer's userId, if any
 String? get referredBy;// Set when the user has requested account deletion; null while active.
// Source of truth for the request itself lives in the
// `accountDeletionRequests` collection - this is a denormalized copy
// used to gate login without an extra query.
@TimestampConverter() DateTime? get deletionRequestedAt;
/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUserCopyWith<AppUser> get copyWith => _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.isVendor, isVendor) || other.isVendor == isVendor)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&const DeepCollectionEquality().equals(other.subscribedShopTopics, subscribedShopTopics)&&const DeepCollectionEquality().equals(other.staffShopIds, staffShopIds)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.userPhoneNumber, userPhoneNumber) || other.userPhoneNumber == userPhoneNumber)&&(identical(other.vendorPhoneNumber, vendorPhoneNumber) || other.vendorPhoneNumber == vendorPhoneNumber)&&(identical(other.referredBy, referredBy) || other.referredBy == referredBy)&&(identical(other.deletionRequestedAt, deletionRequestedAt) || other.deletionRequestedAt == deletionRequestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userEmail,userName,isVendor,fcmToken,referralCode,const DeepCollectionEquality().hash(subscribedShopTopics),const DeepCollectionEquality().hash(staffShopIds),profilePic,userPhoneNumber,vendorPhoneNumber,referredBy,deletionRequestedAt);

@override
String toString() {
  return 'AppUser(userId: $userId, userEmail: $userEmail, userName: $userName, isVendor: $isVendor, fcmToken: $fcmToken, referralCode: $referralCode, subscribedShopTopics: $subscribedShopTopics, staffShopIds: $staffShopIds, profilePic: $profilePic, userPhoneNumber: $userPhoneNumber, vendorPhoneNumber: $vendorPhoneNumber, referredBy: $referredBy, deletionRequestedAt: $deletionRequestedAt)';
}


}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res>  {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) = _$AppUserCopyWithImpl;
@useResult
$Res call({
 String userId, String userEmail, String userName, bool isVendor, String fcmToken, String referralCode, List<String>? subscribedShopTopics, List<String>? staffShopIds, String? profilePic, String? userPhoneNumber, String? vendorPhoneNumber, String? referredBy,@TimestampConverter() DateTime? deletionRequestedAt
});




}
/// @nodoc
class _$AppUserCopyWithImpl<$Res>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userEmail = null,Object? userName = null,Object? isVendor = null,Object? fcmToken = null,Object? referralCode = null,Object? subscribedShopTopics = freezed,Object? staffShopIds = freezed,Object? profilePic = freezed,Object? userPhoneNumber = freezed,Object? vendorPhoneNumber = freezed,Object? referredBy = freezed,Object? deletionRequestedAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,isVendor: null == isVendor ? _self.isVendor : isVendor // ignore: cast_nullable_to_non_nullable
as bool,fcmToken: null == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String,referralCode: null == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String,subscribedShopTopics: freezed == subscribedShopTopics ? _self.subscribedShopTopics : subscribedShopTopics // ignore: cast_nullable_to_non_nullable
as List<String>?,staffShopIds: freezed == staffShopIds ? _self.staffShopIds : staffShopIds // ignore: cast_nullable_to_non_nullable
as List<String>?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,userPhoneNumber: freezed == userPhoneNumber ? _self.userPhoneNumber : userPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,vendorPhoneNumber: freezed == vendorPhoneNumber ? _self.vendorPhoneNumber : vendorPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,referredBy: freezed == referredBy ? _self.referredBy : referredBy // ignore: cast_nullable_to_non_nullable
as String?,deletionRequestedAt: freezed == deletionRequestedAt ? _self.deletionRequestedAt : deletionRequestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUser value)  $default,){
final _that = this;
switch (_that) {
case _AppUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUser value)?  $default,){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userEmail,  String userName,  bool isVendor,  String fcmToken,  String referralCode,  List<String>? subscribedShopTopics,  List<String>? staffShopIds,  String? profilePic,  String? userPhoneNumber,  String? vendorPhoneNumber,  String? referredBy, @TimestampConverter()  DateTime? deletionRequestedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.userId,_that.userEmail,_that.userName,_that.isVendor,_that.fcmToken,_that.referralCode,_that.subscribedShopTopics,_that.staffShopIds,_that.profilePic,_that.userPhoneNumber,_that.vendorPhoneNumber,_that.referredBy,_that.deletionRequestedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userEmail,  String userName,  bool isVendor,  String fcmToken,  String referralCode,  List<String>? subscribedShopTopics,  List<String>? staffShopIds,  String? profilePic,  String? userPhoneNumber,  String? vendorPhoneNumber,  String? referredBy, @TimestampConverter()  DateTime? deletionRequestedAt)  $default,) {final _that = this;
switch (_that) {
case _AppUser():
return $default(_that.userId,_that.userEmail,_that.userName,_that.isVendor,_that.fcmToken,_that.referralCode,_that.subscribedShopTopics,_that.staffShopIds,_that.profilePic,_that.userPhoneNumber,_that.vendorPhoneNumber,_that.referredBy,_that.deletionRequestedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userEmail,  String userName,  bool isVendor,  String fcmToken,  String referralCode,  List<String>? subscribedShopTopics,  List<String>? staffShopIds,  String? profilePic,  String? userPhoneNumber,  String? vendorPhoneNumber,  String? referredBy, @TimestampConverter()  DateTime? deletionRequestedAt)?  $default,) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.userId,_that.userEmail,_that.userName,_that.isVendor,_that.fcmToken,_that.referralCode,_that.subscribedShopTopics,_that.staffShopIds,_that.profilePic,_that.userPhoneNumber,_that.vendorPhoneNumber,_that.referredBy,_that.deletionRequestedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppUser implements AppUser {
  const _AppUser({required this.userId, required this.userEmail, required this.userName, required this.isVendor, required this.fcmToken, required this.referralCode, final  List<String>? subscribedShopTopics, final  List<String>? staffShopIds, this.profilePic, this.userPhoneNumber, this.vendorPhoneNumber, this.referredBy, @TimestampConverter() this.deletionRequestedAt}): _subscribedShopTopics = subscribedShopTopics,_staffShopIds = staffShopIds;
  factory _AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

@override final  String userId;
@override final  String userEmail;
@override final  String userName;
@override final  bool isVendor;
@override final  String fcmToken;
@override final  String referralCode;
// @Default(0) int p24Coins,
 final  List<String>? _subscribedShopTopics;
// @Default(0) int p24Coins,
@override List<String>? get subscribedShopTopics {
  final value = _subscribedShopTopics;
  if (value == null) return null;
  if (_subscribedShopTopics is EqualUnmodifiableListView) return _subscribedShopTopics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _staffShopIds;
@override List<String>? get staffShopIds {
  final value = _staffShopIds;
  if (value == null) return null;
  if (_staffShopIds is EqualUnmodifiableListView) return _staffShopIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? profilePic;
@override final  String? userPhoneNumber;
// int? maximumShops,
// int? maximumCampaigns,
// int? maximumUserFollowing,
@override final  String? vendorPhoneNumber;
// Referrer's userId, if any
@override final  String? referredBy;
// Set when the user has requested account deletion; null while active.
// Source of truth for the request itself lives in the
// `accountDeletionRequests` collection - this is a denormalized copy
// used to gate login without an extra query.
@override@TimestampConverter() final  DateTime? deletionRequestedAt;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUserCopyWith<_AppUser> get copyWith => __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.isVendor, isVendor) || other.isVendor == isVendor)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&const DeepCollectionEquality().equals(other._subscribedShopTopics, _subscribedShopTopics)&&const DeepCollectionEquality().equals(other._staffShopIds, _staffShopIds)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.userPhoneNumber, userPhoneNumber) || other.userPhoneNumber == userPhoneNumber)&&(identical(other.vendorPhoneNumber, vendorPhoneNumber) || other.vendorPhoneNumber == vendorPhoneNumber)&&(identical(other.referredBy, referredBy) || other.referredBy == referredBy)&&(identical(other.deletionRequestedAt, deletionRequestedAt) || other.deletionRequestedAt == deletionRequestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userEmail,userName,isVendor,fcmToken,referralCode,const DeepCollectionEquality().hash(_subscribedShopTopics),const DeepCollectionEquality().hash(_staffShopIds),profilePic,userPhoneNumber,vendorPhoneNumber,referredBy,deletionRequestedAt);

@override
String toString() {
  return 'AppUser(userId: $userId, userEmail: $userEmail, userName: $userName, isVendor: $isVendor, fcmToken: $fcmToken, referralCode: $referralCode, subscribedShopTopics: $subscribedShopTopics, staffShopIds: $staffShopIds, profilePic: $profilePic, userPhoneNumber: $userPhoneNumber, vendorPhoneNumber: $vendorPhoneNumber, referredBy: $referredBy, deletionRequestedAt: $deletionRequestedAt)';
}


}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) = __$AppUserCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userEmail, String userName, bool isVendor, String fcmToken, String referralCode, List<String>? subscribedShopTopics, List<String>? staffShopIds, String? profilePic, String? userPhoneNumber, String? vendorPhoneNumber, String? referredBy,@TimestampConverter() DateTime? deletionRequestedAt
});




}
/// @nodoc
class __$AppUserCopyWithImpl<$Res>
    implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userEmail = null,Object? userName = null,Object? isVendor = null,Object? fcmToken = null,Object? referralCode = null,Object? subscribedShopTopics = freezed,Object? staffShopIds = freezed,Object? profilePic = freezed,Object? userPhoneNumber = freezed,Object? vendorPhoneNumber = freezed,Object? referredBy = freezed,Object? deletionRequestedAt = freezed,}) {
  return _then(_AppUser(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,isVendor: null == isVendor ? _self.isVendor : isVendor // ignore: cast_nullable_to_non_nullable
as bool,fcmToken: null == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String,referralCode: null == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String,subscribedShopTopics: freezed == subscribedShopTopics ? _self._subscribedShopTopics : subscribedShopTopics // ignore: cast_nullable_to_non_nullable
as List<String>?,staffShopIds: freezed == staffShopIds ? _self._staffShopIds : staffShopIds // ignore: cast_nullable_to_non_nullable
as List<String>?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,userPhoneNumber: freezed == userPhoneNumber ? _self.userPhoneNumber : userPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,vendorPhoneNumber: freezed == vendorPhoneNumber ? _self.vendorPhoneNumber : vendorPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,referredBy: freezed == referredBy ? _self.referredBy : referredBy // ignore: cast_nullable_to_non_nullable
as String?,deletionRequestedAt: freezed == deletionRequestedAt ? _self.deletionRequestedAt : deletionRequestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
