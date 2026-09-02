import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/happy_hours/domain/model/shop_follower_model.dart';
import 'package:prize24_app/features/shop/data/dto/shop_dto.dart';
import 'package:prize24_app/features/shop/data/service/i_shop_service.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/check_in_response_model.dart';
import 'package:prize24_app/features/shop/domain/model/follower_streak_log_model.dart';
import 'package:prize24_app/features/shop/domain/model/shop_activity_log.dart';
import 'package:prize24_app/features/shop/domain/model/shop_follow_response_model.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:prize24_app/features/shop/domain/model/shop_offer_model.dart';
import 'package:prize24_app/features/shop/domain/model/user_following_shop_model.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/become_staff_request_model.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/shop_staff_model.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_request_send_model.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_shops/staff_shop_model.dart';

class ShopRepository extends IShopRepository {
  ShopRepository({required IShopService shopService})
    : _shopService = shopService;

  final IShopService _shopService;
  @override
  Future<ShopModel> addNewShop({required ShopModel shop}) async {
    // Convert the ShopModel to a DTO if necessary
    // final shopDto = ShopModelMapper().toDto(shop);

    // Call the service to add the new shop
    final shopDto = await _shopService.addNewShop(
      shop: ShopDto.fromModel(shop),
    );

    // Convert the DTO back to a ShopModel if necessary
    // return ShopModelMapper().fromDto(shopDto);

    return ShopModel(
      id: shopDto.shopId,
      shopName: shopDto.shopName,
      shopPhone: shopDto.shopPhone,
      shopAddress: shopDto.shopAddress,
      shopDescription: shopDto.shopDescription,
      shopOwnerId: shopDto.shopOwnerId,
      createdAt: shopDto.createdAt,
      updatedAt: shopDto.updatedAt,
      bonusIncrementDaysRequired: shopDto.bonusIncrementDaysRequired,
      bonusIncrementValue: shopDto.bonusIncrementValue,
      giftCycleDay: shopDto.giftCycleDay,
      totalFollowers: shopDto.totalFollowers,
      associatedCampaignId: shopDto.associatedCampaignId,
    );
  }

  @override
  Future<void> deleteShop({required String shopId}) {
    // TODO: implement deleteShop
    throw UnimplementedError();
  }

  @override
  Future<ShopModel> editShop({required ShopModel shop}) async {
    // Convert the ShopModel to a DTO if necessary
    // final shopDto = ShopModelMapper().toDto(shop);

    // Call the service to edit the shop
    final shopDto = await _shopService.editShop(shop: ShopDto.fromModel(shop));

    // Convert the DTO back to a ShopModel if necessary
    // return ShopModelMapper().fromDto(shopDto);

    return ShopModel(
      id: shopDto.shopId,
      shopName: shopDto.shopName,
      shopPhone: shopDto.shopPhone,
      shopAddress: shopDto.shopAddress,
      shopDescription: shopDto.shopDescription,
      shopOwnerId: shopDto.shopOwnerId,
      createdAt: shopDto.createdAt,
      updatedAt: shopDto.updatedAt,
      bonusIncrementDaysRequired: shopDto.bonusIncrementDaysRequired,
      bonusIncrementValue: shopDto.bonusIncrementValue,
      giftCycleDay: shopDto.giftCycleDay,
      totalFollowers: shopDto.totalFollowers,
      associatedCampaignId: shopDto.associatedCampaignId,
      shopEmail: shopDto.shopEmail,
    );
  }

  @override
  Future<ShopModel> getShopDetails({required String shopId}) {
    // TODO: implement getShopDetails
    throw UnimplementedError();
  }

  @override
  Future<List<ShopModel>> listAllShopsOfVendor({
    required String vendorId,
    int page = 1,
    int limit = 10,
  }) async {
    // Call the service to get shops by vendor ID
    final shopDtos = await _shopService.getShopsByVendorId(
      vendorId: vendorId,
      page: page,
      limit: limit,
    );

    // Convert the list of ShopDto to a list of ShopModel
    return shopDtos
        .map(
          (shopDto) => ShopModel(
            id: shopDto.shopId,
            shopName: shopDto.shopName,
            shopPhone: shopDto.shopPhone,
            shopAddress: shopDto.shopAddress,
            shopDescription: shopDto.shopDescription,
            shopOwnerId: shopDto.shopOwnerId,
            shopEmail: shopDto.shopEmail,
            createdAt: shopDto.createdAt,
            updatedAt: shopDto.updatedAt,
            bonusIncrementDaysRequired: shopDto.bonusIncrementDaysRequired,
            bonusIncrementValue: shopDto.bonusIncrementValue,
            giftCycleDay: shopDto.giftCycleDay,
            totalFollowers: shopDto.totalFollowers,
            associatedCampaignId: shopDto.associatedCampaignId,
          ),
        )
        .toList();
  }

  @override
  Future<PaginatedResult<BecomeStaffRequestModel>>
  getShopStaffRequestsReceived({
    required String staffUserId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, lastDoc) = await _shopService.getShopStaffRequestsReceived(
      staffUserId: staffUserId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos.map((dto) => dto.toDomain()).toList(),
      cursor: lastDoc,
      hasMore: lastDoc != null,
    );
  }

  @override
  Future<List<StaffRequestSendModel>> getShopStaffRequestsSent({
    required String shopId,
  }) async {
    // Call the service to get staff requests sent by shop ID
    final requestDtos = await _shopService.getShopStaffRequestsSent(
      shopId: shopId,
    );

    // Convert the list of StaffRequestSendDto to a list of StaffRequestSendModel
    return requestDtos.map((requestDto) => requestDto.toModel()).toList();
  }

  @override
  Future<PaginatedResult<ShopStaffModel>> getShopStaffs({
    required String shopId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, lastDoc) = await _shopService.getShopStaffs(
      shopId: shopId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos.map((dto) => dto.toDomain()).toList(),
      cursor: lastDoc,
      hasMore: lastDoc != null,
    );
  }

  @override
  Future<void> respondToStaffRequest({
    required String requestId,
    required String action,
    required String staffUserId,
    required String shopId,
  }) async {
    await _shopService.respondToStaffRequest(
      requestId: requestId,
      action: action,
      shopId: shopId,
      staffUserId: staffUserId,
    );
  }

  @override
  Future<void> revokeShopStaff({
    required String shopId,
    required String staffUserId,
    String reason = '',
  }) {
    // TODO: implement revokeShopStaff
    throw UnimplementedError();
  }

  @override
  Future<void> sendAddStaffRequest({
    required String shopId,
    required String shopName,
    required String senderName,
    required String receiverId,
  }) async {
    await _shopService.sendAddStaffRequest(
      shopId: shopId,
      shopName: shopName,
      senderName: senderName,
      receiverId: receiverId,
    );
  }

  @override
  Future<CheckInResponseModel> checkInUserToShopByStaff({
    required String shopId,
    required String userId,
    required String staffUserId,
  }) async {
    final response = await _shopService.checkInUserToShopByStaff(
      shopId: shopId,
      userId: userId,
      staffUserId: staffUserId,
    );
    return response.toDomain();
  }

  @override
  Future<CheckInResponseModel> checkInUserToShopByVendor({
    required String shopId,
    required String userId,
  }) async {
    final response = await _shopService.checkInUserToShopByVendor(
      shopId: shopId,
      userId: userId,
    );
    return response.toDomain();
  }

  @override
  Future<PaginatedResult<ShopFollowerModel>> fetchShopFollowers({
    required String shopId,
    String? userId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, lastDoc) = await _shopService.fetchShopFollowers(
      shopId: shopId,
      userId: userId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos.map((dto) => dto.toDomain()).toList(),
      cursor: lastDoc,
      hasMore: lastDoc != null,
    );
  }

  @override
  Future<ShopFollowResponseModel> followShopByStaff({
    required String shopId,
    required String userId,
  }) async {
    final userFollowingShopDto = await _shopService.followShopByStaff(
      shopId: shopId,
      userId: userId,
    );

    return userFollowingShopDto.toDomain();
  }

  @override
  Future<ShopFollowResponseModel> followShopByVendor({
    required String shopId,
    required String userId,
  }) async {
    final userFollowingShopDto = await _shopService.followShopByVendor(
      shopId: shopId,
      userId: userId,
    );

    return userFollowingShopDto.toDomain();
  }

  @override
  Future<List<UserFollowingShopModel>> listUserFollowedShops({
    required String userId,
    int page = 1,
    int limit = 10,
  }) async {
    final followedShopDtos = await _shopService.listUserFollowedShops(
      userId: userId,
      page: page,
      limit: limit,
    );

    return followedShopDtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<void> toggleShopNotification({
    required String shopId,
    required String userId,
    required String userFCMToken,
    required bool enable,
  }) async {
    await _shopService.toggleShopNotification(
      shopId: shopId,
      userId: userId,
      userFCMToken: userFCMToken,
      enable: enable,
    );
  }

  @override
  Future<void> unfollowShop({required String shopId}) {
    // TODO: implement unfollowShop
    throw UnimplementedError();
  }

  @override
  Future<void> unfollowShopByUser({
    required String shopId,
    required String userFCMToken,
  }) {
    // TODO: implement unfollowShopByUser
    throw UnimplementedError();
  }

  @override
  Future<PaginatedResult<FollowerStreakLogModel>> viewFollowerStreakLogs({
    required String shopId,
    required String userId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, lastDoc) = await _shopService.viewFollowerStreakLogs(
      shopId: shopId,
      userId: userId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos.map((dto) => dto.toDomain()).toList(),
      cursor: lastDoc,
      hasMore: lastDoc != null,
    );
  }

  @override
  Future<void> addShopOffer({
    required String shopId,
    required String name,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    return await _shopService.addShopOffer(
      shopId: shopId,
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<void> deleteShopOffer({
    required String shopId,
    required String offerId,
  }) {
    // TODO: implement deleteShopOffer
    throw UnimplementedError();
  }

  @override
  Future<PaginatedResult<ShopOfferModel>> listShopOffers({
    required String shopId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, lastDoc) = await _shopService.fetchShopOffers(
      shopId: shopId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos.map((dto) => dto.toDomain()).toList(),
      cursor: lastDoc,
      hasMore: lastDoc != null,
    );
  }

  @override
  Future<ShopOfferModel?> getShopOfferById({
    required String shopId,
    required String shopOfferId,
  }) async {
    final offerDto = await _shopService.fetchShopOfferById(
      shopId: shopId,
      shopOfferId: shopOfferId,
    );
    return offerDto?.toDomain();
  }

  @override
  Future<PaginatedResult<StaffShopModel>> getStaffsShops({
    required List<String> shopIds,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, nextCursor) = await _shopService.getStaffsShops(
      shopIds: shopIds,
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
  Future<PaginatedResult<ShopActivityLogEntry>> getShopActivityLogs({
    required String shopId,
    String? userId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, lastDoc) = await _shopService.fetchShopActivityLogs(
      shopId: shopId,
      userId: userId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos
          .map(
            (dto) => dto.toEntry(
              timestampConverter: (ts) => (ts as Timestamp).toDate(),
            ),
          )
          .toList(),
      cursor: lastDoc,
      hasMore: lastDoc != null,
    );
  }
}
