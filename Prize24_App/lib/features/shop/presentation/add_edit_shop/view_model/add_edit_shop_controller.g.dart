// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_shop_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddEditShopController)
final addEditShopControllerProvider = AddEditShopControllerProvider._();

final class AddEditShopControllerProvider
    extends $AsyncNotifierProvider<AddEditShopController, ShopModel?> {
  AddEditShopControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addEditShopControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addEditShopControllerHash();

  @$internal
  @override
  AddEditShopController create() => AddEditShopController();
}

String _$addEditShopControllerHash() =>
    r'06410bcc0125c2e38f94be966893803e3a59a6d4';

abstract class _$AddEditShopController extends $AsyncNotifier<ShopModel?> {
  FutureOr<ShopModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ShopModel?>, ShopModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ShopModel?>, ShopModel?>,
              AsyncValue<ShopModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
