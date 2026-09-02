// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user_as_vendor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RegisterUserAsVendorController)
final registerUserAsVendorControllerProvider =
    RegisterUserAsVendorControllerProvider._();

final class RegisterUserAsVendorControllerProvider
    extends $AsyncNotifierProvider<RegisterUserAsVendorController, String?> {
  RegisterUserAsVendorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerUserAsVendorControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerUserAsVendorControllerHash();

  @$internal
  @override
  RegisterUserAsVendorController create() => RegisterUserAsVendorController();
}

String _$registerUserAsVendorControllerHash() =>
    r'3109069cfe4066f03f573d32a4537369a430df36';

abstract class _$RegisterUserAsVendorController
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
