import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_campaign/staff_campaign_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_shop/staff_shop_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/service/firebase_staff_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'i_staff_service.g.dart';

abstract class IStaffService {
  /// Get shops for a specific staff member
  /// Returns a list of shops where the staff member works
  Future<List<StaffShopDto>> getShopsForStaff(
    String staffId, {
    int page = 1,
    int limit = 10,
  });

  /// Get campaigns for a specific shop
  /// Returns a list of campaigns associated with the given shop
  Future<(List<StaffCampaignDto>, Object?)> getCampaignsForShop(
    String shopId, {
    Object? cursor,
    int limit = 20,
  });

  /// Avail gift by staff member
  /// Marks a gift as available for distribution in a campaign
  Future<void> availGiftByStaff({
    required String campaignId,
    required String shopId,
  });

  /// Redeem gift by staff member
  /// Processes gift redemption for a customer
  Future<void> redeemGiftByStaff({
    required String giftId,
    required String shopId,
    required String campaignId,
  });
}

@riverpod
IStaffService staffServiceProvider(Ref ref) {
  return FirebaseStaffService();
}
