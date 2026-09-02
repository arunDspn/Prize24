// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respond_shared_campaign_request_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RespondSharedCampaignRequestController)
final respondSharedCampaignRequestControllerProvider =
    RespondSharedCampaignRequestControllerProvider._();

final class RespondSharedCampaignRequestControllerProvider
    extends
        $AsyncNotifierProvider<
          RespondSharedCampaignRequestController,
          (String?, String?)
        > {
  RespondSharedCampaignRequestControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'respondSharedCampaignRequestControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$respondSharedCampaignRequestControllerHash();

  @$internal
  @override
  RespondSharedCampaignRequestController create() =>
      RespondSharedCampaignRequestController();
}

String _$respondSharedCampaignRequestControllerHash() =>
    r'd233dceef4aea295d0a1bc0a259bc1fb84e5f605';

abstract class _$RespondSharedCampaignRequestController
    extends $AsyncNotifier<(String?, String?)> {
  FutureOr<(String?, String?)> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<(String?, String?)>, (String?, String?)>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<(String?, String?)>, (String?, String?)>,
              AsyncValue<(String?, String?)>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
