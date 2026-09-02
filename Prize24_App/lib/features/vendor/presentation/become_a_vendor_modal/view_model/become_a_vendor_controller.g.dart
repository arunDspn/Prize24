// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'become_a_vendor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BecomeAVendorController)
final becomeAVendorControllerProvider = BecomeAVendorControllerProvider._();

final class BecomeAVendorControllerProvider
    extends $AsyncNotifierProvider<BecomeAVendorController, void> {
  BecomeAVendorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'becomeAVendorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$becomeAVendorControllerHash();

  @$internal
  @override
  BecomeAVendorController create() => BecomeAVendorController();
}

String _$becomeAVendorControllerHash() =>
    r'4a3b2e01db912b40f536ee18dd51c7e2cddd6447';

abstract class _$BecomeAVendorController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
