// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_gift_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(giftRepository)
final giftRepositoryProvider = GiftRepositoryProvider._();

final class GiftRepositoryProvider
    extends
        $FunctionalProvider<IGiftRepository, IGiftRepository, IGiftRepository>
    with $Provider<IGiftRepository> {
  GiftRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'giftRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$giftRepositoryHash();

  @$internal
  @override
  $ProviderElement<IGiftRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IGiftRepository create(Ref ref) {
    return giftRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IGiftRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IGiftRepository>(value),
    );
  }
}

String _$giftRepositoryHash() => r'c4b709073eb8ef02d6a548aa737e91c500e77d60';
