// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_phone_number_registeration_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorPhoneNumberRegisterationController)
final vendorPhoneNumberRegisterationControllerProvider =
    VendorPhoneNumberRegisterationControllerProvider._();

final class VendorPhoneNumberRegisterationControllerProvider
    extends
        $AsyncNotifierProvider<
          VendorPhoneNumberRegisterationController,
          String?
        > {
  VendorPhoneNumberRegisterationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorPhoneNumberRegisterationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$vendorPhoneNumberRegisterationControllerHash();

  @$internal
  @override
  VendorPhoneNumberRegisterationController create() =>
      VendorPhoneNumberRegisterationController();
}

String _$vendorPhoneNumberRegisterationControllerHash() =>
    r'156b2be9b4a6da34af4347b49e229642e8267b51';

abstract class _$VendorPhoneNumberRegisterationController
    extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
