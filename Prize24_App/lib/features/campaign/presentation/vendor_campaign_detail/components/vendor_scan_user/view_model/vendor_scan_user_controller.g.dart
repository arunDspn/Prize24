// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_scan_user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorScanUserController)
final vendorScanUserControllerProvider = VendorScanUserControllerProvider._();

final class VendorScanUserControllerProvider
    extends
        $AsyncNotifierProvider<
          VendorScanUserController,
          ScanAvailReponseModel?
        > {
  VendorScanUserControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorScanUserControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorScanUserControllerHash();

  @$internal
  @override
  VendorScanUserController create() => VendorScanUserController();
}

String _$vendorScanUserControllerHash() =>
    r'a29d5ea9e9e4aadebab339184938bf86f8b6b2fb';

abstract class _$VendorScanUserController
    extends $AsyncNotifier<ScanAvailReponseModel?> {
  FutureOr<ScanAvailReponseModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ScanAvailReponseModel?>, ScanAvailReponseModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ScanAvailReponseModel?>,
                ScanAvailReponseModel?
              >,
              AsyncValue<ScanAvailReponseModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
