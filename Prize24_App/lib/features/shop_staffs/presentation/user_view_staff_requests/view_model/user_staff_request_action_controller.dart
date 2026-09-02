import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/become_staff_request_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_staff_request_action_controller.g.dart';

// @riverpod
// Future<String> userStaffRequestActionController(
//   Ref ref, {
//   required BecomeStaffRequestModel request,
//   required String action,
// }) async {
//   final userId = ref.watch(authControllerProvider).requireValue!.userId;
//   if (action == 'accept') {
//     await ref.read(shopRepositoryProvider).respondToStaffRequest(
//           action: 'accept',
//           requestId: request.id,
//           shopId: request.shopId,
//           staffUserId: userId,
//         );

//     return request.id;
//   } else if (action == 'decline') {
//     await ref.read(shopRepositoryProvider).respondToStaffRequest(
//           action: 'decline',
//           requestId: request.id,
//           shopId: request.shopId,
//           staffUserId: userId,
//         );

//     return request.id;
//   } else {
//     throw Exception('Invalid action: $action');
//   }
// }o

@riverpod
class UserStaffRequestActionController
    extends _$UserStaffRequestActionController {
  @override
  FutureOr<(String?, String?)?> build() {
    return null;
  }

  // Accept or Decline staff request
  Future<void> performAction({
    required BecomeStaffRequestModel request,
    required String action,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userId = ref.watch(authControllerProvider).requireValue!.userId;
      await ref
          .read(shopRepositoryProvider)
          .respondToStaffRequest(
            action: action,
            requestId: request.id,
            shopId: request.shopId,
            staffUserId: userId,
          );
      await ref
          .read(analyticsServiceProvider)
          .logRequestResponse(requestType: RequestType.staff, action: action);

      if (action == RequestResponseAction.accept) {
        await ref
            .read(analyticsServiceProvider)
            .logMemberUpdate(
              action: MemberAction.add,
              role: MemberRole.staff,
              shopId: request.shopId,
            );
      }

      return (request.id, request.shopId);
    });
  }
}
