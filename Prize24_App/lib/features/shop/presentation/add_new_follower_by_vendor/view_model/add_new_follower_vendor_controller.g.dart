// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_follower_vendor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddNewFollowerVendorController)
final addNewFollowerVendorControllerProvider =
    AddNewFollowerVendorControllerProvider._();

final class AddNewFollowerVendorControllerProvider
    extends
        $AsyncNotifierProvider<
          AddNewFollowerVendorController,
          ShopFollowerModel?
        > {
  AddNewFollowerVendorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addNewFollowerVendorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addNewFollowerVendorControllerHash();

  @$internal
  @override
  AddNewFollowerVendorController create() => AddNewFollowerVendorController();
}

String _$addNewFollowerVendorControllerHash() =>
    r'9931c3c0b6bc598159cbcb372f49ca348fd6fb20';

abstract class _$AddNewFollowerVendorController
    extends $AsyncNotifier<ShopFollowerModel?> {
  FutureOr<ShopFollowerModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ShopFollowerModel?>, ShopFollowerModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ShopFollowerModel?>, ShopFollowerModel?>,
              AsyncValue<ShopFollowerModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
