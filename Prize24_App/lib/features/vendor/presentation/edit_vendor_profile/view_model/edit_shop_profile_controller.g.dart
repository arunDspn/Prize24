// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_shop_profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EditShopProfileController)
final editShopProfileControllerProvider = EditShopProfileControllerProvider._();

final class EditShopProfileControllerProvider
    extends $AsyncNotifierProvider<EditShopProfileController, ShopModel?> {
  EditShopProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editShopProfileControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editShopProfileControllerHash();

  @$internal
  @override
  EditShopProfileController create() => EditShopProfileController();
}

String _$editShopProfileControllerHash() =>
    r'94689518ccad4af1642ab6cccd34c59ad3a864a2';

abstract class _$EditShopProfileController extends $AsyncNotifier<ShopModel?> {
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
