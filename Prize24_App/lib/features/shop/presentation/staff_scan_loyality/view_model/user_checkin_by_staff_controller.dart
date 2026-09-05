import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/check_in_response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_checkin_by_staff_controller.g.dart';

@riverpod
class UserCheckinByStaffController extends _$UserCheckinByStaffController {
  @override
  FutureOr<CheckInResponseModel?> build() {
    return null;
  }

  // Check In
  Future<void> checkInUser({
    required String userId,
    required String shopId,
    required String billNumber,
    required double billAmount,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final vendor = ref.read(authControllerProvider).requireValue!;

      final data = await ref
          .read(shopRepositoryProvider)
          .checkInUserToShopByStaff(
            userId: userId,
            shopId: shopId,
            staffUserId: vendor.userId,
            billNumber: billNumber,
            billAmount: billAmount,
          );

      if (data.success) {
        await ref
            .read(analyticsServiceProvider)
            .logQrScanSuccess(
              purpose: ScanPurpose.checkIn,
              scannedId: userId,
              shopId: shopId,
            );

        if (data.data != null && data.data!.isNewUser) {
          await ref
              .read(analyticsServiceProvider)
              .logMemberUpdate(
                action: MemberAction.add,
                role: MemberRole.staff,
                shopId: shopId,
              );
        }
      }

      return data;
    });
  }
}
