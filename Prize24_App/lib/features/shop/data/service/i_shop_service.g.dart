// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_shop_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shopService)
final shopServiceProvider = ShopServiceProvider._();

final class ShopServiceProvider
    extends $FunctionalProvider<IShopService, IShopService, IShopService>
    with $Provider<IShopService> {
  ShopServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shopServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shopServiceHash();

  @$internal
  @override
  $ProviderElement<IShopService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IShopService create(Ref ref) {
    return shopService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IShopService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IShopService>(value),
    );
  }
}

String _$shopServiceHash() => r'8b70a9af7ae80e6fba885b61aa563ea12b99ec78';
