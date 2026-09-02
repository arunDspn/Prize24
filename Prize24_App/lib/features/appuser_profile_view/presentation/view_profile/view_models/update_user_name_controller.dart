import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/repository/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'update_user_name_controller.g.dart';

@riverpod
class UpdateUserNameController extends _$UpdateUserNameController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  // Updates the user name
  Future<void> updateUserName(String newUserName) async {
    final trimmedName = newUserName.trim();
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final userID = ref.read(authControllerProvider).requireValue!.userId;
      await ref.read(userRepositoryProvider).updateUserName(
            userId: userID,
            newUserName: trimmedName,
          );
      return trimmedName;
    });
  }
}
