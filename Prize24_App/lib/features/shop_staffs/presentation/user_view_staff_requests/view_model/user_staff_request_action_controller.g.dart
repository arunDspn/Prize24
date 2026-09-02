// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_staff_request_action_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserStaffRequestActionController)
final userStaffRequestActionControllerProvider =
    UserStaffRequestActionControllerProvider._();

final class UserStaffRequestActionControllerProvider
    extends
        $AsyncNotifierProvider<
          UserStaffRequestActionController,
          (String?, String?)?
        > {
  UserStaffRequestActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userStaffRequestActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userStaffRequestActionControllerHash();

  @$internal
  @override
  UserStaffRequestActionController create() =>
      UserStaffRequestActionController();
}

String _$userStaffRequestActionControllerHash() =>
    r'7c13225f92efa63c8733637924a5ec2ecc1b24a6';

abstract class _$UserStaffRequestActionController
    extends $AsyncNotifier<(String?, String?)?> {
  FutureOr<(String?, String?)?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<(String?, String?)?>, (String?, String?)?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<(String?, String?)?>, (String?, String?)?>,
              AsyncValue<(String?, String?)?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
