import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'delete_account_controller.g.dart';

@riverpod
class DeleteAccountController extends _$DeleteAccountController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  // Delete account method
  Future<void> deleteAccount() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final userId = ref.read(authControllerProvider).requireValue!.userId;

      final result = await FirebaseFunctions.instance
          .httpsCallable('deleteAccount')
          .call<Map<Object?, Object?>>();

      if (result.data['success'] == true) {
        return userId;
      } else {
        return null;
      }
    });
  }
}
