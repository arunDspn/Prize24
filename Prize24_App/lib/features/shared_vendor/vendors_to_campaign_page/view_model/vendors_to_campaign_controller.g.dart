// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_to_campaign_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorsToCampaignController)
final vendorsToCampaignControllerProvider =
    VendorsToCampaignControllerProvider._();

final class VendorsToCampaignControllerProvider
    extends $AsyncNotifierProvider<VendorsToCampaignController, String?> {
  VendorsToCampaignControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorsToCampaignControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorsToCampaignControllerHash();

  @$internal
  @override
  VendorsToCampaignController create() => VendorsToCampaignController();
}

String _$vendorsToCampaignControllerHash() =>
    r'a6bf154f329c2a8acb7ed683ff3713df76ec483f';

abstract class _$VendorsToCampaignController extends $AsyncNotifier<String?> {
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
