// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_activity_log_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShopActivityLogListController)
final shopActivityLogListControllerProvider =
    ShopActivityLogListControllerFamily._();

final class ShopActivityLogListControllerProvider
    extends
        $AsyncNotifierProvider<
          ShopActivityLogListController,
          PaginatedShopActivityLogState
        > {
  ShopActivityLogListControllerProvider._({
    required ShopActivityLogListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'shopActivityLogListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shopActivityLogListControllerHash();

  @override
  String toString() {
    return r'shopActivityLogListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ShopActivityLogListController create() => ShopActivityLogListController();

  @override
  bool operator ==(Object other) {
    return other is ShopActivityLogListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shopActivityLogListControllerHash() =>
    r'43704b16a525e5766f7fd85749068cfad8754aae';

final class ShopActivityLogListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ShopActivityLogListController,
          AsyncValue<PaginatedShopActivityLogState>,
          PaginatedShopActivityLogState,
          FutureOr<PaginatedShopActivityLogState>,
          String
        > {
  ShopActivityLogListControllerFamily._()
    : super(
        retry: null,
        name: r'shopActivityLogListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ShopActivityLogListControllerProvider call({required String shopId}) =>
      ShopActivityLogListControllerProvider._(argument: shopId, from: this);

  @override
  String toString() => r'shopActivityLogListControllerProvider';
}

abstract class _$ShopActivityLogListController
    extends $AsyncNotifier<PaginatedShopActivityLogState> {
  late final _$args = ref.$arg as String;
  String get shopId => _$args;

  FutureOr<PaginatedShopActivityLogState> build({required String shopId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PaginatedShopActivityLogState>,
              PaginatedShopActivityLogState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedShopActivityLogState>,
                PaginatedShopActivityLogState
              >,
              AsyncValue<PaginatedShopActivityLogState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(shopId: _$args));
  }
}
