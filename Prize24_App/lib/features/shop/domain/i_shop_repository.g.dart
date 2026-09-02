// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_shop_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shopRepository)
final shopRepositoryProvider = ShopRepositoryProvider._();

final class ShopRepositoryProvider
    extends
        $FunctionalProvider<IShopRepository, IShopRepository, IShopRepository>
    with $Provider<IShopRepository> {
  ShopRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shopRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shopRepositoryHash();

  @$internal
  @override
  $ProviderElement<IShopRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IShopRepository create(Ref ref) {
    return shopRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IShopRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IShopRepository>(value),
    );
  }
}

String _$shopRepositoryHash() => r'e46aff06a11a767a6b97db2b54700f2724da8d8f';
