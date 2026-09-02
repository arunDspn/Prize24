// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_edit_gift_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddEditGiftState {

// Basic form fields
 String get giftName; String get description; String get totalGifts; bool get isRedeemable; String get plugSlugName;// Collections
 List<GiftCodeData> get giftCodes; List<String> get giftPayloads; List<ShopModel> get selectedShops;// UI State
 bool get isLoading; bool get isSubmitting; String? get errorMessage;// Form validation
 Map<String, String> get fieldErrors;// Edit mode data
 GiftModel? get existingGift;
/// Create a copy of AddEditGiftState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddEditGiftStateCopyWith<AddEditGiftState> get copyWith => _$AddEditGiftStateCopyWithImpl<AddEditGiftState>(this as AddEditGiftState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddEditGiftState&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.description, description) || other.description == description)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.plugSlugName, plugSlugName) || other.plugSlugName == plugSlugName)&&const DeepCollectionEquality().equals(other.giftCodes, giftCodes)&&const DeepCollectionEquality().equals(other.giftPayloads, giftPayloads)&&const DeepCollectionEquality().equals(other.selectedShops, selectedShops)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.fieldErrors, fieldErrors)&&(identical(other.existingGift, existingGift) || other.existingGift == existingGift));
}


@override
int get hashCode => Object.hash(runtimeType,giftName,description,totalGifts,isRedeemable,plugSlugName,const DeepCollectionEquality().hash(giftCodes),const DeepCollectionEquality().hash(giftPayloads),const DeepCollectionEquality().hash(selectedShops),isLoading,isSubmitting,errorMessage,const DeepCollectionEquality().hash(fieldErrors),existingGift);

@override
String toString() {
  return 'AddEditGiftState(giftName: $giftName, description: $description, totalGifts: $totalGifts, isRedeemable: $isRedeemable, plugSlugName: $plugSlugName, giftCodes: $giftCodes, giftPayloads: $giftPayloads, selectedShops: $selectedShops, isLoading: $isLoading, isSubmitting: $isSubmitting, errorMessage: $errorMessage, fieldErrors: $fieldErrors, existingGift: $existingGift)';
}


}

/// @nodoc
abstract mixin class $AddEditGiftStateCopyWith<$Res>  {
  factory $AddEditGiftStateCopyWith(AddEditGiftState value, $Res Function(AddEditGiftState) _then) = _$AddEditGiftStateCopyWithImpl;
@useResult
$Res call({
 String giftName, String description, String totalGifts, bool isRedeemable, String plugSlugName, List<GiftCodeData> giftCodes, List<String> giftPayloads, List<ShopModel> selectedShops, bool isLoading, bool isSubmitting, String? errorMessage, Map<String, String> fieldErrors, GiftModel? existingGift
});


$GiftModelCopyWith<$Res>? get existingGift;

}
/// @nodoc
class _$AddEditGiftStateCopyWithImpl<$Res>
    implements $AddEditGiftStateCopyWith<$Res> {
  _$AddEditGiftStateCopyWithImpl(this._self, this._then);

  final AddEditGiftState _self;
  final $Res Function(AddEditGiftState) _then;

/// Create a copy of AddEditGiftState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? giftName = null,Object? description = null,Object? totalGifts = null,Object? isRedeemable = null,Object? plugSlugName = null,Object? giftCodes = null,Object? giftPayloads = null,Object? selectedShops = null,Object? isLoading = null,Object? isSubmitting = null,Object? errorMessage = freezed,Object? fieldErrors = null,Object? existingGift = freezed,}) {
  return _then(_self.copyWith(
giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,totalGifts: null == totalGifts ? _self.totalGifts : totalGifts // ignore: cast_nullable_to_non_nullable
as String,isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,plugSlugName: null == plugSlugName ? _self.plugSlugName : plugSlugName // ignore: cast_nullable_to_non_nullable
as String,giftCodes: null == giftCodes ? _self.giftCodes : giftCodes // ignore: cast_nullable_to_non_nullable
as List<GiftCodeData>,giftPayloads: null == giftPayloads ? _self.giftPayloads : giftPayloads // ignore: cast_nullable_to_non_nullable
as List<String>,selectedShops: null == selectedShops ? _self.selectedShops : selectedShops // ignore: cast_nullable_to_non_nullable
as List<ShopModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,fieldErrors: null == fieldErrors ? _self.fieldErrors : fieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,existingGift: freezed == existingGift ? _self.existingGift : existingGift // ignore: cast_nullable_to_non_nullable
as GiftModel?,
  ));
}
/// Create a copy of AddEditGiftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftModelCopyWith<$Res>? get existingGift {
    if (_self.existingGift == null) {
    return null;
  }

  return $GiftModelCopyWith<$Res>(_self.existingGift!, (value) {
    return _then(_self.copyWith(existingGift: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddEditGiftState].
extension AddEditGiftStatePatterns on AddEditGiftState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddEditGiftState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddEditGiftState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddEditGiftState value)  $default,){
final _that = this;
switch (_that) {
case _AddEditGiftState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddEditGiftState value)?  $default,){
final _that = this;
switch (_that) {
case _AddEditGiftState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String giftName,  String description,  String totalGifts,  bool isRedeemable,  String plugSlugName,  List<GiftCodeData> giftCodes,  List<String> giftPayloads,  List<ShopModel> selectedShops,  bool isLoading,  bool isSubmitting,  String? errorMessage,  Map<String, String> fieldErrors,  GiftModel? existingGift)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddEditGiftState() when $default != null:
return $default(_that.giftName,_that.description,_that.totalGifts,_that.isRedeemable,_that.plugSlugName,_that.giftCodes,_that.giftPayloads,_that.selectedShops,_that.isLoading,_that.isSubmitting,_that.errorMessage,_that.fieldErrors,_that.existingGift);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String giftName,  String description,  String totalGifts,  bool isRedeemable,  String plugSlugName,  List<GiftCodeData> giftCodes,  List<String> giftPayloads,  List<ShopModel> selectedShops,  bool isLoading,  bool isSubmitting,  String? errorMessage,  Map<String, String> fieldErrors,  GiftModel? existingGift)  $default,) {final _that = this;
switch (_that) {
case _AddEditGiftState():
return $default(_that.giftName,_that.description,_that.totalGifts,_that.isRedeemable,_that.plugSlugName,_that.giftCodes,_that.giftPayloads,_that.selectedShops,_that.isLoading,_that.isSubmitting,_that.errorMessage,_that.fieldErrors,_that.existingGift);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String giftName,  String description,  String totalGifts,  bool isRedeemable,  String plugSlugName,  List<GiftCodeData> giftCodes,  List<String> giftPayloads,  List<ShopModel> selectedShops,  bool isLoading,  bool isSubmitting,  String? errorMessage,  Map<String, String> fieldErrors,  GiftModel? existingGift)?  $default,) {final _that = this;
switch (_that) {
case _AddEditGiftState() when $default != null:
return $default(_that.giftName,_that.description,_that.totalGifts,_that.isRedeemable,_that.plugSlugName,_that.giftCodes,_that.giftPayloads,_that.selectedShops,_that.isLoading,_that.isSubmitting,_that.errorMessage,_that.fieldErrors,_that.existingGift);case _:
  return null;

}
}

}

/// @nodoc


class _AddEditGiftState implements AddEditGiftState {
  const _AddEditGiftState({this.giftName = '', this.description = '', this.totalGifts = '1', this.isRedeemable = true, this.plugSlugName = '', final  List<GiftCodeData> giftCodes = const [], final  List<String> giftPayloads = const [], final  List<ShopModel> selectedShops = const [], this.isLoading = false, this.isSubmitting = false, this.errorMessage, final  Map<String, String> fieldErrors = const {}, this.existingGift}): _giftCodes = giftCodes,_giftPayloads = giftPayloads,_selectedShops = selectedShops,_fieldErrors = fieldErrors;
  

// Basic form fields
@override@JsonKey() final  String giftName;
@override@JsonKey() final  String description;
@override@JsonKey() final  String totalGifts;
@override@JsonKey() final  bool isRedeemable;
@override@JsonKey() final  String plugSlugName;
// Collections
 final  List<GiftCodeData> _giftCodes;
// Collections
@override@JsonKey() List<GiftCodeData> get giftCodes {
  if (_giftCodes is EqualUnmodifiableListView) return _giftCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_giftCodes);
}

 final  List<String> _giftPayloads;
@override@JsonKey() List<String> get giftPayloads {
  if (_giftPayloads is EqualUnmodifiableListView) return _giftPayloads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_giftPayloads);
}

 final  List<ShopModel> _selectedShops;
@override@JsonKey() List<ShopModel> get selectedShops {
  if (_selectedShops is EqualUnmodifiableListView) return _selectedShops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedShops);
}

// UI State
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSubmitting;
@override final  String? errorMessage;
// Form validation
 final  Map<String, String> _fieldErrors;
// Form validation
@override@JsonKey() Map<String, String> get fieldErrors {
  if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fieldErrors);
}

// Edit mode data
@override final  GiftModel? existingGift;

/// Create a copy of AddEditGiftState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddEditGiftStateCopyWith<_AddEditGiftState> get copyWith => __$AddEditGiftStateCopyWithImpl<_AddEditGiftState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddEditGiftState&&(identical(other.giftName, giftName) || other.giftName == giftName)&&(identical(other.description, description) || other.description == description)&&(identical(other.totalGifts, totalGifts) || other.totalGifts == totalGifts)&&(identical(other.isRedeemable, isRedeemable) || other.isRedeemable == isRedeemable)&&(identical(other.plugSlugName, plugSlugName) || other.plugSlugName == plugSlugName)&&const DeepCollectionEquality().equals(other._giftCodes, _giftCodes)&&const DeepCollectionEquality().equals(other._giftPayloads, _giftPayloads)&&const DeepCollectionEquality().equals(other._selectedShops, _selectedShops)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._fieldErrors, _fieldErrors)&&(identical(other.existingGift, existingGift) || other.existingGift == existingGift));
}


@override
int get hashCode => Object.hash(runtimeType,giftName,description,totalGifts,isRedeemable,plugSlugName,const DeepCollectionEquality().hash(_giftCodes),const DeepCollectionEquality().hash(_giftPayloads),const DeepCollectionEquality().hash(_selectedShops),isLoading,isSubmitting,errorMessage,const DeepCollectionEquality().hash(_fieldErrors),existingGift);

@override
String toString() {
  return 'AddEditGiftState(giftName: $giftName, description: $description, totalGifts: $totalGifts, isRedeemable: $isRedeemable, plugSlugName: $plugSlugName, giftCodes: $giftCodes, giftPayloads: $giftPayloads, selectedShops: $selectedShops, isLoading: $isLoading, isSubmitting: $isSubmitting, errorMessage: $errorMessage, fieldErrors: $fieldErrors, existingGift: $existingGift)';
}


}

/// @nodoc
abstract mixin class _$AddEditGiftStateCopyWith<$Res> implements $AddEditGiftStateCopyWith<$Res> {
  factory _$AddEditGiftStateCopyWith(_AddEditGiftState value, $Res Function(_AddEditGiftState) _then) = __$AddEditGiftStateCopyWithImpl;
@override @useResult
$Res call({
 String giftName, String description, String totalGifts, bool isRedeemable, String plugSlugName, List<GiftCodeData> giftCodes, List<String> giftPayloads, List<ShopModel> selectedShops, bool isLoading, bool isSubmitting, String? errorMessage, Map<String, String> fieldErrors, GiftModel? existingGift
});


@override $GiftModelCopyWith<$Res>? get existingGift;

}
/// @nodoc
class __$AddEditGiftStateCopyWithImpl<$Res>
    implements _$AddEditGiftStateCopyWith<$Res> {
  __$AddEditGiftStateCopyWithImpl(this._self, this._then);

  final _AddEditGiftState _self;
  final $Res Function(_AddEditGiftState) _then;

/// Create a copy of AddEditGiftState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? giftName = null,Object? description = null,Object? totalGifts = null,Object? isRedeemable = null,Object? plugSlugName = null,Object? giftCodes = null,Object? giftPayloads = null,Object? selectedShops = null,Object? isLoading = null,Object? isSubmitting = null,Object? errorMessage = freezed,Object? fieldErrors = null,Object? existingGift = freezed,}) {
  return _then(_AddEditGiftState(
giftName: null == giftName ? _self.giftName : giftName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,totalGifts: null == totalGifts ? _self.totalGifts : totalGifts // ignore: cast_nullable_to_non_nullable
as String,isRedeemable: null == isRedeemable ? _self.isRedeemable : isRedeemable // ignore: cast_nullable_to_non_nullable
as bool,plugSlugName: null == plugSlugName ? _self.plugSlugName : plugSlugName // ignore: cast_nullable_to_non_nullable
as String,giftCodes: null == giftCodes ? _self._giftCodes : giftCodes // ignore: cast_nullable_to_non_nullable
as List<GiftCodeData>,giftPayloads: null == giftPayloads ? _self._giftPayloads : giftPayloads // ignore: cast_nullable_to_non_nullable
as List<String>,selectedShops: null == selectedShops ? _self._selectedShops : selectedShops // ignore: cast_nullable_to_non_nullable
as List<ShopModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,fieldErrors: null == fieldErrors ? _self._fieldErrors : fieldErrors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,existingGift: freezed == existingGift ? _self.existingGift : existingGift // ignore: cast_nullable_to_non_nullable
as GiftModel?,
  ));
}

/// Create a copy of AddEditGiftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftModelCopyWith<$Res>? get existingGift {
    if (_self.existingGift == null) {
    return null;
  }

  return $GiftModelCopyWith<$Res>(_self.existingGift!, (value) {
    return _then(_self.copyWith(existingGift: value));
  });
}
}

/// @nodoc
mixin _$GiftCodeData {

 String get code; String get payload;
/// Create a copy of GiftCodeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftCodeDataCopyWith<GiftCodeData> get copyWith => _$GiftCodeDataCopyWithImpl<GiftCodeData>(this as GiftCodeData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftCodeData&&(identical(other.code, code) || other.code == code)&&(identical(other.payload, payload) || other.payload == payload));
}


@override
int get hashCode => Object.hash(runtimeType,code,payload);

@override
String toString() {
  return 'GiftCodeData(code: $code, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $GiftCodeDataCopyWith<$Res>  {
  factory $GiftCodeDataCopyWith(GiftCodeData value, $Res Function(GiftCodeData) _then) = _$GiftCodeDataCopyWithImpl;
@useResult
$Res call({
 String code, String payload
});




}
/// @nodoc
class _$GiftCodeDataCopyWithImpl<$Res>
    implements $GiftCodeDataCopyWith<$Res> {
  _$GiftCodeDataCopyWithImpl(this._self, this._then);

  final GiftCodeData _self;
  final $Res Function(GiftCodeData) _then;

/// Create a copy of GiftCodeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? payload = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftCodeData].
extension GiftCodeDataPatterns on GiftCodeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftCodeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftCodeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftCodeData value)  $default,){
final _that = this;
switch (_that) {
case _GiftCodeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftCodeData value)?  $default,){
final _that = this;
switch (_that) {
case _GiftCodeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftCodeData() when $default != null:
return $default(_that.code,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String payload)  $default,) {final _that = this;
switch (_that) {
case _GiftCodeData():
return $default(_that.code,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String payload)?  $default,) {final _that = this;
switch (_that) {
case _GiftCodeData() when $default != null:
return $default(_that.code,_that.payload);case _:
  return null;

}
}

}

/// @nodoc


class _GiftCodeData implements GiftCodeData {
  const _GiftCodeData({this.code = '', this.payload = ''});
  

@override@JsonKey() final  String code;
@override@JsonKey() final  String payload;

/// Create a copy of GiftCodeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftCodeDataCopyWith<_GiftCodeData> get copyWith => __$GiftCodeDataCopyWithImpl<_GiftCodeData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftCodeData&&(identical(other.code, code) || other.code == code)&&(identical(other.payload, payload) || other.payload == payload));
}


@override
int get hashCode => Object.hash(runtimeType,code,payload);

@override
String toString() {
  return 'GiftCodeData(code: $code, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$GiftCodeDataCopyWith<$Res> implements $GiftCodeDataCopyWith<$Res> {
  factory _$GiftCodeDataCopyWith(_GiftCodeData value, $Res Function(_GiftCodeData) _then) = __$GiftCodeDataCopyWithImpl;
@override @useResult
$Res call({
 String code, String payload
});




}
/// @nodoc
class __$GiftCodeDataCopyWithImpl<$Res>
    implements _$GiftCodeDataCopyWith<$Res> {
  __$GiftCodeDataCopyWithImpl(this._self, this._then);

  final _GiftCodeData _self;
  final $Res Function(_GiftCodeData) _then;

/// Create a copy of GiftCodeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? payload = null,}) {
  return _then(_GiftCodeData(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
