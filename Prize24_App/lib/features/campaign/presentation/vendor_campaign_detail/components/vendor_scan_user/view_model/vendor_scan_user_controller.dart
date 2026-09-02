import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/campaign/domain/models/scan_avail_response/scan_avail_reponse_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'vendor_scan_user_controller.g.dart';

@riverpod
class VendorScanUserController extends _$VendorScanUserController {
  @override
  FutureOr<ScanAvailReponseModel?> build() async {
    return null;
  }

  /// Method to handle the scanned code
  Future<void> handleScannedCodeByOwner({
    required String userId,
    required String campaignId,
    bool availedViaStreak = false,
    String? shopId,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      //Todo: Use Repository pattern here
      final result = await FirebaseFunctions.instance
          .httpsCallable('scanAvailPublicPrivateAutoCampaign')
          .call<Map<Object?, Object?>>({
            'userId': userId,
            'campaignId': campaignId,
            'availedViaStreak': availedViaStreak,
            if (shopId != null) 'streakShopID': shopId,
          });

      state = const AsyncValue.loading();

      // await Future.delayed(const Duration(seconds: 10));

      /// Create a mock response for testing locally based ScanAvailReponseModel
      ///
      //         final sucessresult = '''
      // {
      //     "success": true,
      //     "error": null,
      //     "data": {
      //         "isRedeemable": true,
      //         "giftName": "Sample Gift",
      //         "giftDescription": "This is a sample gift description.",
      //         "redemptionId": "redeem12345",
      //         "error": {
      //             "code": "",
      //             "message": ""
      //         }
      //     }
      // }
      // ''';

      //         final failedResult = '''
      // {
      //     "success": false,
      //     "error": {
      //         "code": "NOT_FOUND",
      //         "message": "Campaign not found"
      //     },
      //     "data": null
      // }
      // ''';

      // Convert Map<Object?, Object?> to Map<String, dynamic> (recursively)
      final Map<String, dynamic> stringData = convertMapToStringDynamic(
        result.data,
      );
      final response = ScanAvailReponseModel.fromJson(stringData);

      if (response.success) {
        await ref
            .read(analyticsServiceProvider)
            .logQrScanSuccess(
              purpose: ScanPurpose.avail,
              scannedId: userId,
              shopId: shopId ?? '',
              campaignId: campaignId,
            );
      }

      return response;
    });
  }

  // 2 methods to handle scanned code by shared vendor and staff
  Future<void> handleScannedCodeBySharedVendor({
    required String userId,
    required String campaignId,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final result = await FirebaseFunctions.instance
          .httpsCallable('scanToAvailPublicPrivateAutoCampaignBySharedVendor')
          .call<Map<Object?, Object?>>({
            'userId': userId,
            'campaignId': campaignId,
          });

      state = const AsyncValue.loading();

      // Convert Map<Object?, Object?> to Map<String, dynamic> (recursively)
      final Map<String, dynamic> stringData = convertMapToStringDynamic(
        result.data,
      );
      final response = ScanAvailReponseModel.fromJson(stringData);

      if (response.success) {
        await ref
            .read(analyticsServiceProvider)
            .logQrScanSuccess(
              purpose: ScanPurpose.avail,
              scannedId: userId,
              shopId: '',
              campaignId: campaignId,
            );
      }

      return response;
    });
  }

  Future<void> handleScannedCodeByStaff({
    required String userId,
    required String campaignId,
    required String shopId,
    bool availedViaStreak = false,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final result = await FirebaseFunctions.instance
          .httpsCallable('scanToAvailPublicPrivateAutoCampaignByStaff')
          .call<Map<Object?, Object?>>({
            'userId': userId,
            'campaignId': campaignId,
            'shopId': shopId,
            'streakShopID': shopId,
            'availedViaStreak': availedViaStreak,
          });

      state = const AsyncValue.loading();

      // Convert Map<Object?, Object?> to Map<String, dynamic> (recursively)
      final Map<String, dynamic> stringData = convertMapToStringDynamic(
        result.data,
      );
      final response = ScanAvailReponseModel.fromJson(stringData);

      if (response.success) {
        await ref
            .read(analyticsServiceProvider)
            .logQrScanSuccess(
              purpose: ScanPurpose.avail,
              scannedId: userId,
              shopId: shopId,
              campaignId: campaignId,
            );
      }

      return response;
    });
  }

  /// Recursively converts a Map with Object keys to Map<String, dynamic>
  Map<String, dynamic> convertMapToStringDynamic(Object? data) {
    if (data is Map) {
      return Map<String, dynamic>.fromEntries(
        data.entries.map((entry) {
          final key = entry.key.toString();
          final value = entry.value;

          if (value is Map) {
            return MapEntry(key, convertMapToStringDynamic(value));
          } else if (value is List) {
            return MapEntry(key, _convertListItems(value));
          } else {
            return MapEntry(key, value);
          }
        }),
      );
    }
    return {}; // Return empty map as fallback
  }

  /// Helper method to process list items
  List<dynamic> _convertListItems(List<dynamic> items) {
    return items.map((item) {
      if (item is Map) {
        return convertMapToStringDynamic(item);
      } else if (item is List) {
        return _convertListItems(item);
      } else {
        return item;
      }
    }).toList();
  }
}
