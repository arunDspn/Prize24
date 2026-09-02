// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_campaign_selection_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentCampaignSelectionController)
final currentCampaignSelectionControllerProvider =
    CurrentCampaignSelectionControllerProvider._();

final class CurrentCampaignSelectionControllerProvider
    extends
        $AsyncNotifierProvider<
          CurrentCampaignSelectionController,
          CampaignModel?
        > {
  CurrentCampaignSelectionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentCampaignSelectionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$currentCampaignSelectionControllerHash();

  @$internal
  @override
  CurrentCampaignSelectionController create() =>
      CurrentCampaignSelectionController();
}

String _$currentCampaignSelectionControllerHash() =>
    r'04cbfa2aecff84cf00b0bd17657077492b7faa5a';

abstract class _$CurrentCampaignSelectionController
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
