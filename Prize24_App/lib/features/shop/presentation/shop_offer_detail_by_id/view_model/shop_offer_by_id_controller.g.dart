// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_offer_by_id_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShopOfferByIdController)
final shopOfferByIdControllerProvider = ShopOfferByIdControllerFamily._();

final class ShopOfferByIdControllerProvider
    extends $AsyncNotifierProvider<ShopOfferByIdController, ShopOfferModel?> {
  ShopOfferByIdControllerProvider._({
    required ShopOfferByIdControllerFamily super.from,
    required ({String shopOfferId, String shopId}) super.argument,
  }) : super(
         retry: null,
         name: r'shopOfferByIdControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shopOfferByIdControllerHash();

  @override
  String toString() {
    return r'shopOfferByIdControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ShopOfferByIdController create() => ShopOfferByIdController();

  @override
  bool operator ==(Object other) {
    return other is ShopOfferByIdControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shopOfferByIdControllerHash() =>
    r'119225ad41df91008c5dc1997c6cd5ff3c625d9c';

final class ShopOfferByIdControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ShopOfferByIdController,
          AsyncValue<ShopOfferModel?>,
          ShopOfferModel?,
          FutureOr<ShopOfferModel?>,
          ({String shopOfferId, String shopId})
        > {
  ShopOfferByIdControllerFamily._()
    : super(
        retry: null,
        name: r'shopOfferByIdControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ShopOfferByIdControllerProvider call({
    required String shopOfferId,
    required String shopId,
  }) => ShopOfferByIdControllerProvider._(
    argument: (shopOfferId: shopOfferId, shopId: shopId),
    from: this,
  );

  @override
  String toString() => r'shopOfferByIdControllerProvider';
}

abstract class _$ShopOfferByIdController
    extends $AsyncNotifier<ShopOfferModel?> {
  late final _$args = ref.$arg as ({String shopOfferId, String shopId});
  String get shopOfferId => _$args.shopOfferId;
  String get shopId => _$args.shopId;

  FutureOr<ShopOfferModel?> build({
    required String shopOfferId,
    required String shopId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ShopOfferModel?>, ShopOfferModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ShopOfferModel?>, ShopOfferModel?>,
              AsyncValue<ShopOfferModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(
      ref,
      () => build(shopOfferId: _$args.shopOfferId, shopId: _$args.shopId),
    );
  }
}
