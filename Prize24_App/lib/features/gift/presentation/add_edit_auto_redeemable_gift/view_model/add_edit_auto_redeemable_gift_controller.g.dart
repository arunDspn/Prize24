// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_auto_redeemable_gift_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddEditAutoRedeemableGiftController)
final addEditAutoRedeemableGiftControllerProvider =
    AddEditAutoRedeemableGiftControllerProvider._();

final class AddEditAutoRedeemableGiftControllerProvider
    extends
        $AsyncNotifierProvider<
          AddEditAutoRedeemableGiftController,
          GiftModel?
        > {
  AddEditAutoRedeemableGiftControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addEditAutoRedeemableGiftControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$addEditAutoRedeemableGiftControllerHash();

  @$internal
  @override
  AddEditAutoRedeemableGiftController create() =>
      AddEditAutoRedeemableGiftController();
}

String _$addEditAutoRedeemableGiftControllerHash() =>
    r'03965b7dcef80d1b419fbc136fe782025fcf162b';

abstract class _$AddEditAutoRedeemableGiftController
    extends $AsyncNotifier<GiftModel?> {
  FutureOr<GiftModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<GiftModel?>, GiftModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GiftModel?>, GiftModel?>,
              AsyncValue<GiftModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
