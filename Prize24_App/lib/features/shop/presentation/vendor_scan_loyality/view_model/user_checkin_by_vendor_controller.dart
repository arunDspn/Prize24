import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/check_in_response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_checkin_by_vendor_controller.g.dart';

@riverpod
class UserCheckinByVendorController extends _$UserCheckinByVendorController {
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
      final data = await ref
          .read(shopRepositoryProvider)
          .checkInUserToShopByVendor(
            userId: userId,
            shopId: shopId,
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

      // // Simulated delay and response for demonstration purposes
      // await Future.delayed(const Duration(seconds: 2));
      // // Error simulation
      // throw Exception("Simulated check-in error");
    });
  }
}
