// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_vendor_campaigns_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listVendorCampaignsUsecase)
final listVendorCampaignsUsecaseProvider =
    ListVendorCampaignsUsecaseProvider._();

final class ListVendorCampaignsUsecaseProvider
    extends
        $FunctionalProvider<
          ListVendorCampaignsUsecase,
          ListVendorCampaignsUsecase,
          ListVendorCampaignsUsecase
        >
    with $Provider<ListVendorCampaignsUsecase> {
  ListVendorCampaignsUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listVendorCampaignsUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listVendorCampaignsUsecaseHash();

  @$internal
  @override
  $ProviderElement<ListVendorCampaignsUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ListVendorCampaignsUsecase create(Ref ref) {
    return listVendorCampaignsUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListVendorCampaignsUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListVendorCampaignsUsecase>(value),
    );
  }
}

String _$listVendorCampaignsUsecaseHash() =>
    r'9459b0e5d47c0066341c1270e907e71ee4d5eef4';
