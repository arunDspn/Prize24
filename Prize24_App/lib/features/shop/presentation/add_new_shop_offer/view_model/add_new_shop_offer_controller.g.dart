// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_shop_offer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddNewShopOfferController)
final addNewShopOfferControllerProvider = AddNewShopOfferControllerProvider._();

final class AddNewShopOfferControllerProvider
    extends $AsyncNotifierProvider<AddNewShopOfferController, void> {
  AddNewShopOfferControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addNewShopOfferControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addNewShopOfferControllerHash();

  @$internal
  @override
  AddNewShopOfferController create() => AddNewShopOfferController();
}

String _$addNewShopOfferControllerHash() =>
    r'befd857da12a5b7052fb778395f85ee477ebe634';

abstract class _$AddNewShopOfferController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
