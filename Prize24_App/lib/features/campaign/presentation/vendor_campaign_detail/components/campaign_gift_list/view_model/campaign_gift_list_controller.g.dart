// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_gift_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CampaignGiftListController)
final campaignGiftListControllerProvider = CampaignGiftListControllerFamily._();

final class CampaignGiftListControllerProvider
    extends
        $AsyncNotifierProvider<CampaignGiftListController, List<GiftModel>> {
  CampaignGiftListControllerProvider._({
    required CampaignGiftListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'campaignGiftListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campaignGiftListControllerHash();

  @override
  String toString() {
    return r'campaignGiftListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CampaignGiftListController create() => CampaignGiftListController();

  @override
  bool operator ==(Object other) {
    return other is CampaignGiftListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campaignGiftListControllerHash() =>
    r'c3fa0e8f7915bb6377a8ca794cb86b33625f4cdc';

final class CampaignGiftListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CampaignGiftListController,
          AsyncValue<List<GiftModel>>,
          List<GiftModel>,
          FutureOr<List<GiftModel>>,
          String
        > {
  CampaignGiftListControllerFamily._()
    : super(
        retry: null,
        name: r'campaignGiftListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CampaignGiftListControllerProvider call({required String campaignId}) =>
      CampaignGiftListControllerProvider._(argument: campaignId, from: this);

  @override
  String toString() => r'campaignGiftListControllerProvider';
}

abstract class _$CampaignGiftListController
    extends $AsyncNotifier<List<GiftModel>> {
  late final _$args = ref.$arg as String;
  String get campaignId => _$args;

  FutureOr<List<GiftModel>> build({required String campaignId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<GiftModel>>, List<GiftModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<GiftModel>>, List<GiftModel>>,
              AsyncValue<List<GiftModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(campaignId: _$args));
  }
}
