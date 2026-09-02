import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'redeem_gift_controller.g.dart';

@riverpod
class RedeemGiftController extends _$RedeemGiftController {
  @override
  FutureOr<void> build() {
    return null;
  }

  // 3 Functions for 3 types of redeemers

  Future<void> handleScannedCodeAsOwner({
    required String campaignId,
    required String giftId,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // Call the Firebase Function to handle the scanned code
      try {
        await FirebaseFunctions.instance
            .httpsCallable('scanToRedeemByOwner')
            .call<Map<String, dynamic>>({
              'campaignId': campaignId,
              'userGiftId': giftId,
            });

        await ref
            .read(analyticsServiceProvider)
            .logQrScanSuccess(
              purpose: ScanPurpose.redeem,
              scannedId: giftId,
              shopId: '',
              campaignId: campaignId,
            );
      } catch (e) {
        // TODO
        rethrow;
      }
    });
  }

  Future<void> handleScannedCodeAsSharedVendor({
    required String userGiftId,
    required String campaignId,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // Call the Firebase Function to handle the scanned code
      await FirebaseFunctions.instance
          .httpsCallable('scanToRedeemBySharedVendor')
          .call<void>({'userGiftId': userGiftId, 'campaignId': campaignId});

      await ref
          .read(analyticsServiceProvider)
          .logQrScanSuccess(
            purpose: ScanPurpose.redeem,
            scannedId: userGiftId,
            shopId: '',
            campaignId: campaignId,
          );
    });
  }

  Future<void> handleScannedCodeAsStaff({
    required String userId,
    required String campaignId,
    required String shopId,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // Call the Firebase Function to handle the scanned code
      await FirebaseFunctions.instance
          .httpsCallable('scanToRedeemByStaff')
          .call<void>({
            'userGiftId': userId,
            'campaignId': campaignId,
            'shopId': shopId,
          });

      await ref
          .read(analyticsServiceProvider)
          .logQrScanSuccess(
            purpose: ScanPurpose.redeem,
            scannedId: userId,
            shopId: shopId,
            campaignId: campaignId,
          );
    });
  }
}
