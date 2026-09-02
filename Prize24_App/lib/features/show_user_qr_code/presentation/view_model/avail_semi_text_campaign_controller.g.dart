// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avail_semi_text_campaign_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AvailSemiTextCampaignController)
final availSemiTextCampaignControllerProvider =
    AvailSemiTextCampaignControllerProvider._();

final class AvailSemiTextCampaignControllerProvider
    extends $AsyncNotifierProvider<AvailSemiTextCampaignController, String?> {
  AvailSemiTextCampaignControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availSemiTextCampaignControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availSemiTextCampaignControllerHash();

  @$internal
  @override
  AvailSemiTextCampaignController create() => AvailSemiTextCampaignController();
}

String _$availSemiTextCampaignControllerHash() =>
    r'75df0e132b173ac40ebcbe6938d7c40f7eb8f881';

abstract class _$AvailSemiTextCampaignController
    extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
