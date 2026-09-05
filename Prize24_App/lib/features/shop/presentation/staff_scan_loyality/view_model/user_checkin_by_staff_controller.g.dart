// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_checkin_by_staff_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserCheckinByStaffController)
final userCheckinByStaffControllerProvider =
    UserCheckinByStaffControllerProvider._();

final class UserCheckinByStaffControllerProvider
    extends
        $AsyncNotifierProvider<
          UserCheckinByStaffController,
          CheckInResponseModel?
        > {
  UserCheckinByStaffControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userCheckinByStaffControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userCheckinByStaffControllerHash();

  @$internal
  @override
  UserCheckinByStaffController create() => UserCheckinByStaffController();
}

String _$userCheckinByStaffControllerHash() =>
    r'ab47c90f930cf715aae3dec106fb9ba14a777120';

abstract class _$UserCheckinByStaffController
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
