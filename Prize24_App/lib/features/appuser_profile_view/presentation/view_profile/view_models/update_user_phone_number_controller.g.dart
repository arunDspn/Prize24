// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_phone_number_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateUserPhoneNumberController)
final updateUserPhoneNumberControllerProvider =
    UpdateUserPhoneNumberControllerProvider._();

final class UpdateUserPhoneNumberControllerProvider
    extends $AsyncNotifierProvider<UpdateUserPhoneNumberController, String?> {
  UpdateUserPhoneNumberControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateUserPhoneNumberControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateUserPhoneNumberControllerHash();

  @$internal
  @override
  UpdateUserPhoneNumberController create() => UpdateUserPhoneNumberController();
}

String _$updateUserPhoneNumberControllerHash() =>
    r'06b9b4b9ff7b1bb99fb1cc03082cbdff58493df9';

abstract class _$UpdateUserPhoneNumberController
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
