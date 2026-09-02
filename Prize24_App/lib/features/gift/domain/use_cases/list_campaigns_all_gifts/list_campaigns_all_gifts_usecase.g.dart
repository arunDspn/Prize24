// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_campaigns_all_gifts_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listCampaignsAllGiftsUsecase)
final listCampaignsAllGiftsUsecaseProvider =
    ListCampaignsAllGiftsUsecaseProvider._();

final class ListCampaignsAllGiftsUsecaseProvider
    extends
        $FunctionalProvider<
          ListCampaignsAllGiftsUsecase,
          ListCampaignsAllGiftsUsecase,
          ListCampaignsAllGiftsUsecase
        >
    with $Provider<ListCampaignsAllGiftsUsecase> {
  ListCampaignsAllGiftsUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listCampaignsAllGiftsUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listCampaignsAllGiftsUsecaseHash();

  @$internal
  @override
  $ProviderElement<ListCampaignsAllGiftsUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ListCampaignsAllGiftsUsecase create(Ref ref) {
    return listCampaignsAllGiftsUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListCampaignsAllGiftsUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListCampaignsAllGiftsUsecase>(value),
    );
  }
}

String _$listCampaignsAllGiftsUsecaseHash() =>
    r'3f1096777f6d3966e8793c38e2266cc7d469b112';
