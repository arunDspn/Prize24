// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_vendor_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vendorServive)
final vendorServiveProvider = VendorServiveProvider._();

final class VendorServiveProvider
    extends $FunctionalProvider<IVendorService, IVendorService, IVendorService>
    with $Provider<IVendorService> {
  VendorServiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorServiveProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorServiveHash();

  @$internal
  @override
  $ProviderElement<IVendorService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IVendorService create(Ref ref) {
    return vendorServive(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IVendorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IVendorService>(value),
    );
  }
}

String _$vendorServiveHash() => r'5ae14a07ffa35d441065139cd0eaddd2b55d1379';
