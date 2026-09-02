// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_vendor_campaign_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddEditVendorCampaignController)
final addEditVendorCampaignControllerProvider =
    AddEditVendorCampaignControllerProvider._();

final class AddEditVendorCampaignControllerProvider
    extends
        $AsyncNotifierProvider<
          AddEditVendorCampaignController,
          CampaignModel?
        > {
  AddEditVendorCampaignControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addEditVendorCampaignControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addEditVendorCampaignControllerHash();

  @$internal
  @override
  AddEditVendorCampaignController create() => AddEditVendorCampaignController();
}

String _$addEditVendorCampaignControllerHash() =>
    r'a6536e6214f2bb489b3fc79abbef9a92ef6a0643';

abstract class _$AddEditVendorCampaignController
    extends $AsyncNotifier<CampaignModel?> {
  FutureOr<CampaignModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CampaignModel?>, CampaignModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CampaignModel?>, CampaignModel?>,
              AsyncValue<CampaignModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
