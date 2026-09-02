import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'account_deletion_pending_controller.g.dart';

@riverpod
class AccountDeletionPendingController
    extends _$AccountDeletionPendingController {
  @override
  FutureOr<bool?> build() {
    return null;
  }

  // Cancel a previously submitted account deletion request
  Future<void> cancelAccountDeletion() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final result = await FirebaseFunctions.instance
          .httpsCallable('cancelAccountDeletion')
          .call<Map<Object?, Object?>>();

      final success = result.data['success'] == true;

      if (success) {
        final currentUser = ref.read(authControllerProvider).requireValue;
        if (currentUser != null) {
          ref
              .read(authControllerProvider.notifier)
              .updateAuthUser(
                user: currentUser.copyWith(deletionRequestedAt: null),
              );
        }
      }

      return success;
    });
  }
}
