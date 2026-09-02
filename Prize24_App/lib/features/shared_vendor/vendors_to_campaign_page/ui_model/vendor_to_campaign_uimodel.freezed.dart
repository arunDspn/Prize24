// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_to_campaign_uimodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorToCampaignUimodel {

 String get vendorId; String get vendorName; String get vendorPhone; bool get isAlreadyAdded; bool get isRequestSent;
/// Create a copy of VendorToCampaignUimodel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorToCampaignUimodelCopyWith<VendorToCampaignUimodel> get copyWith => _$VendorToCampaignUimodelCopyWithImpl<VendorToCampaignUimodel>(this as VendorToCampaignUimodel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorToCampaignUimodel&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorPhone, vendorPhone) || other.vendorPhone == vendorPhone)&&(identical(other.isAlreadyAdded, isAlreadyAdded) || other.isAlreadyAdded == isAlreadyAdded)&&(identical(other.isRequestSent, isRequestSent) || other.isRequestSent == isRequestSent));
}


@override
int get hashCode => Object.hash(runtimeType,vendorId,vendorName,vendorPhone,isAlreadyAdded,isRequestSent);

@override
String toString() {
  return 'VendorToCampaignUimodel(vendorId: $vendorId, vendorName: $vendorName, vendorPhone: $vendorPhone, isAlreadyAdded: $isAlreadyAdded, isRequestSent: $isRequestSent)';
}


}

/// @nodoc
abstract mixin class $VendorToCampaignUimodelCopyWith<$Res>  {
  factory $VendorToCampaignUimodelCopyWith(VendorToCampaignUimodel value, $Res Function(VendorToCampaignUimodel) _then) = _$VendorToCampaignUimodelCopyWithImpl;
@useResult
$Res call({
 String vendorId, String vendorName, String vendorPhone, bool isAlreadyAdded, bool isRequestSent
});




}
/// @nodoc
class _$VendorToCampaignUimodelCopyWithImpl<$Res>
    implements $VendorToCampaignUimodelCopyWith<$Res> {
  _$VendorToCampaignUimodelCopyWithImpl(this._self, this._then);

  final VendorToCampaignUimodel _self;
  final $Res Function(VendorToCampaignUimodel) _then;

/// Create a copy of VendorToCampaignUimodel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vendorId = null,Object? vendorName = null,Object? vendorPhone = null,Object? isAlreadyAdded = null,Object? isRequestSent = null,}) {
  return _then(_self.copyWith(
vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,vendorPhone: null == vendorPhone ? _self.vendorPhone : vendorPhone // ignore: cast_nullable_to_non_nullable
as String,isAlreadyAdded: null == isAlreadyAdded ? _self.isAlreadyAdded : isAlreadyAdded // ignore: cast_nullable_to_non_nullable
as bool,isRequestSent: null == isRequestSent ? _self.isRequestSent : isRequestSent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorToCampaignUimodel].
extension VendorToCampaignUimodelPatterns on VendorToCampaignUimodel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorToCampaignUimodel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorToCampaignUimodel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorToCampaignUimodel value)  $default,){
final _that = this;
switch (_that) {
case _VendorToCampaignUimodel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorToCampaignUimodel value)?  $default,){
final _that = this;
switch (_that) {
case _VendorToCampaignUimodel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String vendorId,  String vendorName,  String vendorPhone,  bool isAlreadyAdded,  bool isRequestSent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorToCampaignUimodel() when $default != null:
return $default(_that.vendorId,_that.vendorName,_that.vendorPhone,_that.isAlreadyAdded,_that.isRequestSent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String vendorId,  String vendorName,  String vendorPhone,  bool isAlreadyAdded,  bool isRequestSent)  $default,) {final _that = this;
switch (_that) {
case _VendorToCampaignUimodel():
return $default(_that.vendorId,_that.vendorName,_that.vendorPhone,_that.isAlreadyAdded,_that.isRequestSent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String vendorId,  String vendorName,  String vendorPhone,  bool isAlreadyAdded,  bool isRequestSent)?  $default,) {final _that = this;
switch (_that) {
case _VendorToCampaignUimodel() when $default != null:
return $default(_that.vendorId,_that.vendorName,_that.vendorPhone,_that.isAlreadyAdded,_that.isRequestSent);case _:
  return null;

}
}

}

/// @nodoc


class _VendorToCampaignUimodel implements VendorToCampaignUimodel {
  const _VendorToCampaignUimodel({required this.vendorId, required this.vendorName, required this.vendorPhone, required this.isAlreadyAdded, required this.isRequestSent});
  

@override final  String vendorId;
@override final  String vendorName;
@override final  String vendorPhone;
@override final  bool isAlreadyAdded;
@override final  bool isRequestSent;

/// Create a copy of VendorToCampaignUimodel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorToCampaignUimodelCopyWith<_VendorToCampaignUimodel> get copyWith => __$VendorToCampaignUimodelCopyWithImpl<_VendorToCampaignUimodel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorToCampaignUimodel&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorPhone, vendorPhone) || other.vendorPhone == vendorPhone)&&(identical(other.isAlreadyAdded, isAlreadyAdded) || other.isAlreadyAdded == isAlreadyAdded)&&(identical(other.isRequestSent, isRequestSent) || other.isRequestSent == isRequestSent));
}


@override
int get hashCode => Object.hash(runtimeType,vendorId,vendorName,vendorPhone,isAlreadyAdded,isRequestSent);

@override
String toString() {
  return 'VendorToCampaignUimodel(vendorId: $vendorId, vendorName: $vendorName, vendorPhone: $vendorPhone, isAlreadyAdded: $isAlreadyAdded, isRequestSent: $isRequestSent)';
}


}

/// @nodoc
abstract mixin class _$VendorToCampaignUimodelCopyWith<$Res> implements $VendorToCampaignUimodelCopyWith<$Res> {
  factory _$VendorToCampaignUimodelCopyWith(_VendorToCampaignUimodel value, $Res Function(_VendorToCampaignUimodel) _then) = __$VendorToCampaignUimodelCopyWithImpl;
@override @useResult
$Res call({
 String vendorId, String vendorName, String vendorPhone, bool isAlreadyAdded, bool isRequestSent
});




}
/// @nodoc
class __$VendorToCampaignUimodelCopyWithImpl<$Res>
    implements _$VendorToCampaignUimodelCopyWith<$Res> {
  __$VendorToCampaignUimodelCopyWithImpl(this._self, this._then);

  final _VendorToCampaignUimodel _self;
  final $Res Function(_VendorToCampaignUimodel) _then;

/// Create a copy of VendorToCampaignUimodel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vendorId = null,Object? vendorName = null,Object? vendorPhone = null,Object? isAlreadyAdded = null,Object? isRequestSent = null,}) {
  return _then(_VendorToCampaignUimodel(
vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,vendorPhone: null == vendorPhone ? _self.vendorPhone : vendorPhone // ignore: cast_nullable_to_non_nullable
as String,isAlreadyAdded: null == isAlreadyAdded ? _self.isAlreadyAdded : isAlreadyAdded // ignore: cast_nullable_to_non_nullable
as bool,isRequestSent: null == isRequestSent ? _self.isRequestSent : isRequestSent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
