// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vendorRepository)
final vendorRepositoryProvider = VendorRepositoryProvider._();

final class VendorRepositoryProvider
    extends
        $FunctionalProvider<
          IVendorRepository,
          IVendorRepository,
          IVendorRepository
        >
    with $Provider<IVendorRepository> {
  VendorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorRepositoryHash();

  @$internal
  @override
  $ProviderElement<IVendorRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IVendorRepository create(Ref ref) {
    return vendorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IVendorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IVendorRepository>(value),
    );
  }
}

String _$vendorRepositoryHash() => r'c6b8cfa83836070e9a096e196ac3cba6912d008c';
