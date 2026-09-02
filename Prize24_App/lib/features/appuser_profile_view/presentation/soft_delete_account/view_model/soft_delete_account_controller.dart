import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'soft_delete_account_controller.g.dart';

// The `requestAccountDeletion` callable is expected to:
//  1. Create a doc in `accountDeletionRequests/{autoId}`:
//       { userId, requestedAt, status: 'pending', processedAt: null,
//         processedBy: null, reason: null }
//  2. Set `users/{userId}.deletionRequestedAt` to the same server timestamp
//     (denormalized flag used to gate login without querying the
//     requests collection).
// Cancelling a request should clear both: mark the request doc
// 'cancelled' and null out `deletionRequestedAt` on the user doc.

@riverpod
class SoftDeleteAccountController extends _$SoftDeleteAccountController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  // Request account deletion method
  Future<void> requestAccountDeletion() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final userId = ref.read(authControllerProvider).requireValue!.userId;

      final result = await FirebaseFunctions.instance
          .httpsCallable('requestAccountDeletion')
          .call<Map<Object?, Object?>>();

      if (result.data['success'] == true) {
        return userId;
      } else {
        return null;
      }
    });
  }
}
