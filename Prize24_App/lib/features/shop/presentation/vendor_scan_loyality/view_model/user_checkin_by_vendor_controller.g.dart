// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_checkin_by_vendor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserCheckinByVendorController)
final userCheckinByVendorControllerProvider =
    UserCheckinByVendorControllerProvider._();

final class UserCheckinByVendorControllerProvider
    extends
        $AsyncNotifierProvider<
          UserCheckinByVendorController,
          CheckInResponseModel?
        > {
  UserCheckinByVendorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userCheckinByVendorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userCheckinByVendorControllerHash();

  @$internal
  @override
  UserCheckinByVendorController create() => UserCheckinByVendorController();
}

String _$userCheckinByVendorControllerHash() =>
    r'ff8edff2535d054464bee42ef20922169b8bc858';

abstract class _$UserCheckinByVendorController
    extends $AsyncNotifier<CheckInResponseModel?> {
  FutureOr<CheckInResponseModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<CheckInResponseModel?>, CheckInResponseModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CheckInResponseModel?>,
                CheckInResponseModel?
              >,
              AsyncValue<CheckInResponseModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
