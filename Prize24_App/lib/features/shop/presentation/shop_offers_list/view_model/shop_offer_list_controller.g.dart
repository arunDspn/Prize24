// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_offer_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShopOfferListController)
final shopOfferListControllerProvider = ShopOfferListControllerFamily._();

final class ShopOfferListControllerProvider
    extends $AsyncNotifierProvider<ShopOfferListController, OfferListState> {
  ShopOfferListControllerProvider._({
    required ShopOfferListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'shopOfferListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shopOfferListControllerHash();

  @override
  String toString() {
    return r'shopOfferListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ShopOfferListController create() => ShopOfferListController();

  @override
  bool operator ==(Object other) {
    return other is ShopOfferListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shopOfferListControllerHash() =>
    r'19917803478e9ba8e558207e939ad1e7b34bb44a';

final class ShopOfferListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ShopOfferListController,
          AsyncValue<OfferListState>,
          OfferListState,
          FutureOr<OfferListState>,
          String
        > {
  ShopOfferListControllerFamily._()
    : super(
        retry: null,
        name: r'shopOfferListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ShopOfferListControllerProvider call({required String shopId}) =>
      ShopOfferListControllerProvider._(argument: shopId, from: this);

  @override
  String toString() => r'shopOfferListControllerProvider';
}

abstract class _$ShopOfferListController
    extends $AsyncNotifier<OfferListState> {
  late final _$args = ref.$arg as String;
  String get shopId => _$args;

  FutureOr<OfferListState> build({required String shopId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<OfferListState>, OfferListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OfferListState>, OfferListState>,
              AsyncValue<OfferListState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(shopId: _$args));
  }
}
