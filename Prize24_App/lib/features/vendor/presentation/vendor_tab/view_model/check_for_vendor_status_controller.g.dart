// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_for_vendor_status_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CheckForVendorStatusController)
final checkForVendorStatusControllerProvider =
    CheckForVendorStatusControllerProvider._();

final class CheckForVendorStatusControllerProvider
    extends $AsyncNotifierProvider<CheckForVendorStatusController, bool> {
  CheckForVendorStatusControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkForVendorStatusControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkForVendorStatusControllerHash();

  @$internal
  @override
  CheckForVendorStatusController create() => CheckForVendorStatusController();
}

String _$checkForVendorStatusControllerHash() =>
    r'082c346b779b7e71c4385410a7a05ccbd8d0c2af';

abstract class _$CheckForVendorStatusController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
