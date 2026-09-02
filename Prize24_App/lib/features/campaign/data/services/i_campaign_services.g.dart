// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_campaign_services.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(couponService)
final couponServiceProvider = CouponServiceProvider._();

final class CouponServiceProvider
    extends
        $FunctionalProvider<
          ICampaignService,
          ICampaignService,
          ICampaignService
        >
    with $Provider<ICampaignService> {
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
  $ProviderElement<ICampaignService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ICampaignService create(Ref ref) {
    return couponService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ICampaignService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ICampaignService>(value),
    );
  }
}

String _$couponServiceHash() => r'4f12f51293eb3ecccf7606a065531dc1803c6733';
