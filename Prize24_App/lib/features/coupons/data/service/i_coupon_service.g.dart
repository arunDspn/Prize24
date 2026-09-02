// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_coupon_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(couponService)
final couponServiceProvider = CouponServiceProvider._();

final class CouponServiceProvider
    extends $FunctionalProvider<ICouponService, ICouponService, ICouponService>
    with $Provider<ICouponService> {
  CouponServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'couponServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$couponServiceHash();

  @$internal
  @override
  $ProviderElement<ICouponService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ICouponService create(Ref ref) {
    return couponService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ICouponService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ICouponService>(value),
    );
  }
}

String _$couponServiceHash() => r'b56a9f8219a181a5b393701d0455583ed74e7b84';
