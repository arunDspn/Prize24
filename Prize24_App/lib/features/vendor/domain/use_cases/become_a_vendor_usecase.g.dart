// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'become_a_vendor_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(becomeAVendorUsecase)
final becomeAVendorUsecaseProvider = BecomeAVendorUsecaseProvider._();

final class BecomeAVendorUsecaseProvider
    extends
        $FunctionalProvider<
          BecomeAVendorUseCase,
          BecomeAVendorUseCase,
          BecomeAVendorUseCase
        >
    with $Provider<BecomeAVendorUseCase> {
  BecomeAVendorUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'becomeAVendorUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$becomeAVendorUsecaseHash();

  @$internal
  @override
  $ProviderElement<BecomeAVendorUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BecomeAVendorUseCase create(Ref ref) {
    return becomeAVendorUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BecomeAVendorUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BecomeAVendorUseCase>(value),
    );
  }
}

String _$becomeAVendorUsecaseHash() =>
    r'c7996accc8f1f9f1dd53c3ef067aaf45e025ff5c';
