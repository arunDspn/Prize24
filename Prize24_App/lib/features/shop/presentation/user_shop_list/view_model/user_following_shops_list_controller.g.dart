// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_following_shops_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserFollowingShopsListController)
final userFollowingShopsListControllerProvider =
    UserFollowingShopsListControllerProvider._();

final class UserFollowingShopsListControllerProvider
    extends
        $AsyncNotifierProvider<
          UserFollowingShopsListController,
          List<UserFollowingShopModel>
        > {
  UserFollowingShopsListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userFollowingShopsListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userFollowingShopsListControllerHash();

  @$internal
  @override
  UserFollowingShopsListController create() =>
      UserFollowingShopsListController();
}

String _$userFollowingShopsListControllerHash() =>
    r'029ee59759fd1a99499e4fec0e9866129dbd1163';

abstract class _$UserFollowingShopsListController
    extends $AsyncNotifier<List<UserFollowingShopModel>> {
  FutureOr<List<UserFollowingShopModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<UserFollowingShopModel>>,
              List<UserFollowingShopModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<UserFollowingShopModel>>,
                List<UserFollowingShopModel>
              >,
              AsyncValue<List<UserFollowingShopModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
