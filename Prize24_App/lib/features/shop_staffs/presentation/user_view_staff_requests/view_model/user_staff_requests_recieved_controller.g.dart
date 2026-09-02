// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_staff_requests_recieved_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserStaffRequestsRecievedController)
final userStaffRequestsRecievedControllerProvider =
    UserStaffRequestsRecievedControllerProvider._();

final class UserStaffRequestsRecievedControllerProvider
    extends
        $AsyncNotifierProvider<
          UserStaffRequestsRecievedController,
          StaffRequestsPaginatedState
        > {
  UserStaffRequestsRecievedControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userStaffRequestsRecievedControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$userStaffRequestsRecievedControllerHash();

  @$internal
  @override
  UserStaffRequestsRecievedController create() =>
      UserStaffRequestsRecievedController();
}

String _$userStaffRequestsRecievedControllerHash() =>
    r'fb7df038d026d913b0cfaac29f22e6fa082b5e79';

abstract class _$UserStaffRequestsRecievedController
    extends $AsyncNotifier<StaffRequestsPaginatedState> {
  FutureOr<StaffRequestsPaginatedState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<StaffRequestsPaginatedState>,
              StaffRequestsPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<StaffRequestsPaginatedState>,
                StaffRequestsPaginatedState
              >,
              AsyncValue<StaffRequestsPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
