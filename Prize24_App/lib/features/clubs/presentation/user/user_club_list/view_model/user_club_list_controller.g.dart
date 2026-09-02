// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_club_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserClubListController)
final userClubListControllerProvider = UserClubListControllerProvider._();

final class UserClubListControllerProvider
    extends
        $AsyncNotifierProvider<
          UserClubListController,
          List<ClubMemberUserDataModel>
        > {
  UserClubListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userClubListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userClubListControllerHash();

  @$internal
  @override
  UserClubListController create() => UserClubListController();
}

String _$userClubListControllerHash() =>
    r'e029cd40cb50c09f7b69130d754c6783b81dd079';

abstract class _$UserClubListController
    extends $AsyncNotifier<List<ClubMemberUserDataModel>> {
  FutureOr<List<ClubMemberUserDataModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ClubMemberUserDataModel>>,
              List<ClubMemberUserDataModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ClubMemberUserDataModel>>,
                List<ClubMemberUserDataModel>
              >,
              AsyncValue<List<ClubMemberUserDataModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
