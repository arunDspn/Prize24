import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/repository/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_user_phone_number_controller.g.dart';

@riverpod
class UpdateUserPhoneNumberController
    extends _$UpdateUserPhoneNumberController {
  @override
  FutureOr<String?> build() => null;

  Future<void> updateUserPhoneNumber(String phoneNumber) async {
    final normalizedPhoneNumber = phoneNumber.trim();
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final userId = ref.read(authControllerProvider).requireValue!.userId;
      await ref
          .read(userRepositoryProvider)
          .updateUserPhoneNumber(
            userId: userId,
            userPhoneNumber: normalizedPhoneNumber,
          );
      return normalizedPhoneNumber;
    });
  }
}
