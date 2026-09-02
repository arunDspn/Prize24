import 'dart:async';
import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'send_staff_request_page_controller.g.dart';

@riverpod
class SendStaffRequestPageController extends _$SendStaffRequestPageController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  /// Send staff request to add a user as staff
  /// This method handles the API call and returns the result
  Future<void> sendStaffRequest({
    required String shopId,
    required String shopName,
    required String receiverId,
  }) async {
    // Validate input
    if (receiverId.trim().isEmpty) {
      throw Exception('Receiver ID cannot be empty');
    }

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final senderName =
          ref.read(authControllerProvider).requireValue?.userName ?? 'Unknown';
      await ref
          .read(shopRepositoryProvider)
          .sendAddStaffRequest(
            shopId: shopId,
            shopName: shopName,
            senderName: senderName,
            receiverId: receiverId,
          );

      await ref
          .read(analyticsServiceProvider)
          .logSocialRequest(requestType: RequestType.staff, targetId: shopId);

      // Simulate success
      return 'Staff request sent successfully';
    });
  }
}
