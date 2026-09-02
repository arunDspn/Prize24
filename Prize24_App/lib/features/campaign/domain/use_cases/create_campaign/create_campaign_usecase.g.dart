// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_campaign_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(createCampaignUsecase)
final createCampaignUsecaseProvider = CreateCampaignUsecaseProvider._();

final class CreateCampaignUsecaseProvider
    extends
        $FunctionalProvider<
          CreateCampaignUsecase,
          CreateCampaignUsecase,
          CreateCampaignUsecase
        >
    with $Provider<CreateCampaignUsecase> {
  CreateCampaignUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createCampaignUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createCampaignUsecaseHash();

  @$internal
  @override
  $ProviderElement<CreateCampaignUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateCampaignUsecase create(Ref ref) {
    return createCampaignUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateCampaignUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateCampaignUsecase>(value),
    );
  }
}

String _$createCampaignUsecaseHash() =>
    r'7dc93eab10b45762576ccadfd3e0930dc5900552';
