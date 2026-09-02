import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/shop_staffs/data/repository/staff_repository.dart';
import 'package:prize24_app/features/shop_staffs/data/service/i_staff_service.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_campaigns/staff_campaign_model.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_shops/staff_shop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'i_staff_repository.g.dart';

abstract class IStaffRepository {
  //todo: How this works
  // Future<void> acceptStaff(String staffId);
  // Future<void> deleteStaff(String staffId);
  // Future<void> addStaffToShop(String staffId, String shopId);

  // // List of all staffs
  // Future<List<ShopStaffModel>> getAllStaffs({
  //   int page = 1,
  //   int limit = 10,
  // });

  // List of staffs for a specific shop
  // Future<List<ShopStaffModel>> getStaffsForShop(
  //   String shopId, {
  //   int page = 1,
  //   int limit = 10,
  // });

  // List of shops for a specific staff
  Future<List<StaffShopModel>> getShopsForStaff(
    String staffId, {
    int page = 1,
    int limit = 10,
  });

  // Get campaigns associated with given shop
  Future<PaginatedResult<StaffCampaignModel>> getCampaignsForShop(
    String shopId, {
    Object? cursor,
    int limit = 20,
  });

  /// Avail Gift by Staff
  Future<void> availGiftByStaff({
    required String campaignId,
    required String shopId,
  });

  /// Redeem Gift by Staff
  Future<void> redeemGiftByStaff({
    required String giftId,
    required String shopId,
    required String campaignId,
  });
}

@riverpod
IStaffRepository staffRepositoryProvider(Ref ref) {
  return StaffRepository(ref.read(staffServiceProviderProvider));
}
