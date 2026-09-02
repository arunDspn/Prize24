// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_gift_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(giftService)
final giftServiceProvider = GiftServiceProvider._();

final class GiftServiceProvider
    extends $FunctionalProvider<IGiftService, IGiftService, IGiftService>
    with $Provider<IGiftService> {
  GiftServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'giftServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$giftServiceHash();

  @$internal
  @override
  $ProviderElement<IGiftService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IGiftService create(Ref ref) {
    return giftService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IGiftService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IGiftService>(value),
    );
  }
}

String _$giftServiceHash() => r'2184907256ee4bbe7e25c54fd3cd02aa79c2f992';
