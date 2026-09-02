import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/shop_staffs/data/repository/i_staff_repository.dart';
import 'package:prize24_app/features/shop_staffs/data/service/i_staff_service.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_campaigns/staff_campaign_model.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_shops/staff_shop_model.dart';

class StaffRepository implements IStaffRepository {
  final IStaffService _staffService;

  const StaffRepository(this._staffService);

  @override
  Future<void> availGiftByStaff({
    required String campaignId,
    required String shopId,
  }) {
    return _staffService.availGiftByStaff(
      campaignId: campaignId,
      shopId: shopId,
    );
  }

  @override
  Future<PaginatedResult<StaffCampaignModel>> getCampaignsForShop(
    String shopId, {
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, nextCursor) = await _staffService.getCampaignsForShop(
      shopId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos.map((dto) => dto.toDomain()).toList(),
      cursor: nextCursor,
      hasMore: nextCursor != null,
    );
  }

  @override
  Future<List<StaffShopModel>> getShopsForStaff(
    String staffId, {
    int page = 1,
    int limit = 10,
  }) async {
    final shopDtos = await _staffService.getShopsForStaff(
      staffId,
      page: page,
      limit: limit,
    );

    // Convert DTOs to domain models
    return shopDtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<void> redeemGiftByStaff({
    required String giftId,
    required String shopId,
    required String campaignId,
  }) {
    return _staffService.redeemGiftByStaff(
      giftId: giftId,
      shopId: shopId,
      campaignId: campaignId,
    );
  }
}
