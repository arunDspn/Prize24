// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_add_user_to_shop_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StaffAddUserToShopController)
final staffAddUserToShopControllerProvider =
    StaffAddUserToShopControllerProvider._();

final class StaffAddUserToShopControllerProvider
    extends
        $AsyncNotifierProvider<
          StaffAddUserToShopController,
          ShopFollowResponseModel?
        > {
  StaffAddUserToShopControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffAddUserToShopControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffAddUserToShopControllerHash();

  @$internal
  @override
  StaffAddUserToShopController create() => StaffAddUserToShopController();
}

String _$staffAddUserToShopControllerHash() =>
    r'cf9031384b15f7f6ee4ed0f7fcaa8f04cd4d8ccf';

abstract class _$StaffAddUserToShopController
    extends $AsyncNotifier<ShopFollowResponseModel?> {
  FutureOr<ShopFollowResponseModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ShopFollowResponseModel?>,
              ShopFollowResponseModel?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ShopFollowResponseModel?>,
                ShopFollowResponseModel?
              >,
              AsyncValue<ShopFollowResponseModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
