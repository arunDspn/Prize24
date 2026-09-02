// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_shop_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorShopListController)
final vendorShopListControllerProvider = VendorShopListControllerProvider._();

final class VendorShopListControllerProvider
    extends $AsyncNotifierProvider<VendorShopListController, List<ShopModel>> {
  VendorShopListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorShopListControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorShopListControllerHash();

  @$internal
  @override
  VendorShopListController create() => VendorShopListController();
}

String _$vendorShopListControllerHash() =>
    r'5514491673986f96043d5d9c3a4d8ba364f79037';

abstract class _$VendorShopListController
    extends $AsyncNotifier<List<ShopModel>> {
  FutureOr<List<ShopModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<ShopModel>>, List<ShopModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ShopModel>>, List<ShopModel>>,
              AsyncValue<List<ShopModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
