// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_club_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorClubListController)
final vendorClubListControllerProvider = VendorClubListControllerProvider._();

final class VendorClubListControllerProvider
    extends $AsyncNotifierProvider<VendorClubListController, List<ClubModel>> {
  VendorClubListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorClubListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorClubListControllerHash();

  @$internal
  @override
  VendorClubListController create() => VendorClubListController();
}

String _$vendorClubListControllerHash() =>
    r'108ab222772a6d002f58f83944d1469744f782ee';

abstract class _$VendorClubListController
    extends $AsyncNotifier<List<ClubModel>> {
  FutureOr<List<ClubModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<ClubModel>>, List<ClubModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ClubModel>>, List<ClubModel>>,
              AsyncValue<List<ClubModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
