// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avail_full_text_campaign_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AvailFullTextCampaignController)
final availFullTextCampaignControllerProvider =
    AvailFullTextCampaignControllerProvider._();

final class AvailFullTextCampaignControllerProvider
    extends $AsyncNotifierProvider<AvailFullTextCampaignController, String?> {
  AvailFullTextCampaignControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availFullTextCampaignControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availFullTextCampaignControllerHash();

  @$internal
  @override
  AvailFullTextCampaignController create() => AvailFullTextCampaignController();
}

String _$availFullTextCampaignControllerHash() =>
    r'2268ec926616b8b296cbb460efaf68723a5f1282';

abstract class _$AvailFullTextCampaignController
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
