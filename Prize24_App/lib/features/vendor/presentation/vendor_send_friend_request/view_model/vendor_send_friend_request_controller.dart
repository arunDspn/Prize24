import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/vendor/data/repository/vendor_repository.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vendor_send_friend_request_controller.g.dart';

/// Controller for sending friend requests to vendors
/// This controller handles the business logic of sending friend requests
/// UI state (loading, scanning mode) is managed in the widget itself
@riverpod
class VendorSendFriendRequestController
    extends _$VendorSendFriendRequestController {
  @override
  FutureOr<VendorFriendModel?> build() {
    return null;
  }

  /// Send friend request to a vendor by their ID
  /// This method handles the API call and returns the result
  Future<void> sendFriendRequest(String receiverId) async {
    // Validate input
    if (receiverId.trim().isEmpty) {
      throw Exception('Vendor ID cannot be empty');
    }

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // Call the repository to send the friend request
      try {
        final vendorRepository = ref.read(vendorRepositoryProvider);
        await vendorRepository.sendVendorFriendRequest(receiverId: receiverId);

        await ref
            .read(analyticsServiceProvider)
            .logSocialRequest(
              requestType: RequestType.friend,
              targetId: receiverId,
            );

        return null;
      } catch (e) {
        rethrow;
      }
    });

    // try {
    //   // TODO: Replace with actual API call
    //   // Example: final result = await ref.read(vendorRepositoryProvider).sendFriendRequest(vendorId);

    //   // Mock successful response
    //   final friendModel = VendorFriendModel(
    //     id: DateTime.now().millisecondsSinceEpoch.toString(),
    //     userId: vendorId, // Using vendorId as userId for now
    //     vendorName: 'Vendor $vendorId', // Mock vendor name
    //   );

    //   state = AsyncValue.data(friendModel);
    //   return friendModel;
    // } catch (e, stack) {
    //   state = AsyncValue.error(e, stack);
    //   rethrow;
    // }
  }

  /// Reset the controller state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
