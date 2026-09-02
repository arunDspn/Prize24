// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_shop_list_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vendorsShopListUsecase)
final vendorsShopListUsecaseProvider = VendorsShopListUsecaseProvider._();

final class VendorsShopListUsecaseProvider
    extends
        $FunctionalProvider<
          VendorsShopListByVendorIdUsecase,
          VendorsShopListByVendorIdUsecase,
          VendorsShopListByVendorIdUsecase
        >
    with $Provider<VendorsShopListByVendorIdUsecase> {
  VendorsShopListUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorsShopListUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorsShopListUsecaseHash();

  @$internal
  @override
  $ProviderElement<VendorsShopListByVendorIdUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VendorsShopListByVendorIdUsecase create(Ref ref) {
    return vendorsShopListUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VendorsShopListByVendorIdUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VendorsShopListByVendorIdUsecase>(
        value,
      ),
    );
  }
}

String _$vendorsShopListUsecaseHash() =>
    r'0fab980c61953e4a6b60dae34b3d0646d2a49880';
