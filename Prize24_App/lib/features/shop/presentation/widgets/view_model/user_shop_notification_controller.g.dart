// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shop_notification_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserShopNotificationController)
final userShopNotificationControllerProvider =
    UserShopNotificationControllerProvider._();

final class UserShopNotificationControllerProvider
    extends
        $AsyncNotifierProvider<
          UserShopNotificationController,
          (String, bool)?
        > {
  UserShopNotificationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userShopNotificationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userShopNotificationControllerHash();

  @$internal
  @override
  UserShopNotificationController create() => UserShopNotificationController();
}

String _$userShopNotificationControllerHash() =>
    r'82e55eabac42eaba95b90ba660c4cd3563c6f7dd';

abstract class _$UserShopNotificationController
    extends $AsyncNotifier<(String, bool)?> {
  FutureOr<(String, bool)?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<(String, bool)?>, (String, bool)?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<(String, bool)?>, (String, bool)?>,
              AsyncValue<(String, bool)?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
