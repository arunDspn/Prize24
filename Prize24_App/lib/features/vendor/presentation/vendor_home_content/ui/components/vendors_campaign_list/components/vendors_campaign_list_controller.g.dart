// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_campaign_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorsCampaignListController)
final vendorsCampaignListControllerProvider =
    VendorsCampaignListControllerProvider._();

final class VendorsCampaignListControllerProvider
    extends
        $AsyncNotifierProvider<
          VendorsCampaignListController,
          List<CampaignModel>
        > {
  VendorsCampaignListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorsCampaignListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorsCampaignListControllerHash();

  @$internal
  @override
  VendorsCampaignListController create() => VendorsCampaignListController();
}

String _$vendorsCampaignListControllerHash() =>
    r'4a1359884a5c550b241e056852f00703d4a6ec6c';

abstract class _$VendorsCampaignListController
    extends $AsyncNotifier<List<CampaignModel>> {
  FutureOr<List<CampaignModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<CampaignModel>>, List<CampaignModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CampaignModel>>, List<CampaignModel>>,
              AsyncValue<List<CampaignModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
