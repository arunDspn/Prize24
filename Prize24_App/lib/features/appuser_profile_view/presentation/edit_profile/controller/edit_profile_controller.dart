import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/repository/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'edit_profile_controller.g.dart';

@riverpod
class EditProfileController extends _$EditProfileController {
  @override
  FutureOr<AppUser?> build() {
    return null;
  }

  Future<void> onSave(AppUser user) async {
    state = const AsyncLoading();

    // state = await AsyncValue.guard(
    //   () async {
    //     await ref.read(userRepositoryProvider).editUserProfile(
    //           userName: user.displayName,
    //           imageUrl: user.profilePic,
    //           userId: user.userId,
    //         );

    //     return user;
    //   },
    // );
  }
}
