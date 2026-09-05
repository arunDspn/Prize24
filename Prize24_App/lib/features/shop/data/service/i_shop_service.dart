import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/shop/data/dto/check_in_response_dto.dart';
import 'package:prize24_app/features/shop/data/dto/follower_streak_log_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_activity_log_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_follow_response_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_follower_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_offer_dto.dart';
import 'package:prize24_app/features/shop/data/dto/user_following_shop_dto.dart';
import 'package:prize24_app/features/shop/data/service/firebase_shop_service.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/become_staff_request_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/shop_staff_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_request_send_item_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_shop/staff_shop_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'i_shop_service.g.dart';

/// Abstract service interface for shop-related operations using DTOs.
abstract class IShopService {
  /// Adds a new shop.
  ///
  /// [shop]: The [ShopDto] instance to be added.
  /// Returns the added [ShopDto].
  Future<ShopDto> addNewShop({required ShopDto shop});

  /// Deletes a shop.
  ///
  /// Implementations should specify which shop is deleted.
  Future<void> deleteShop({required String shopId});

  /// Edits an existing shop.
  ///
  /// [shop]: The [ShopDto] instance with updated data.
  /// Returns the updated [ShopDto].
  Future<ShopDto> editShop({required ShopDto shop});

  /// Retrieves details of a shop by its ID.
  ///
  /// [shopId]: The unique identifier of the shop.
  /// Returns the corresponding [ShopDto].
  Future<ShopDto> getSingleShopDetail({required String shopId});

  /// Retrieves a paginated list of shops by vendor ID.
  ///
  /// [vendorId]: The unique identifier of the vendor.
  /// [page]: The page number (default is 1).
  /// [limit]: The number of items per page (default is 10).
  /// Returns a list of [ShopDto].
  Future<List<ShopDto>> getShopsByVendorId({
    required String vendorId,
    int page = 1,
    int limit = 10,
  });

  /// Retrieves shops associated with the given staff IDs.
  Future<(List<StaffShopDto>, Object?)> getStaffsShops({
    required List<String> shopIds,
    Object? cursor,
    int limit = 20,
  });

  /// Staff management methods

  /// Sends a request to add a staff member to a shop.
  Future<void> sendAddStaffRequest({
    required String shopId,
    required String shopName,
    required String senderName,
    required String receiverId,
  });

  Future<void> revokeShopStaff({
    required String shopId,
    required String staffUserId,
    String reason = '',
  });
  Future<(List<ShopStaffDto>, Object?)> getShopStaffs({
    required String shopId,
    Object? cursor,
    int limit = 20,
  });

  /// Get staff requests send by the Shop
  /// Used by the Shop Owner to see the requests send by him
  Future<List<StaffRequestSendItemDto>> getShopStaffRequestsSent({
    required String shopId,
  });

  /// Get staff requests received by the Staff
  Future<(List<BecomeStaffRequestDto>, Object?)> getShopStaffRequestsReceived({
    required String staffUserId,
    Object? cursor,
    int limit = 20,
  });

  ///
  Future<void> respondToStaffRequest({
    required String requestId,
    required String action, // accept or reject
    required String staffUserId,
    required String shopId,
  });

  Future<void> removeStaffMemberPermanent({
    required String shopId,
    required String staffUserId,
    String reason = '',
  });

  // Follower management

  Future<ShopFollowResponseDto> followShopByVendor({
    required String shopId,
    required String userId,
  });

  Future<ShopFollowResponseDto> followShopByStaff({
    required String shopId,
    required String userId,
  });

  Future<void> unfollowShopByUser({
    required String shopId,
    required String userFCMToken,
  });

  /// Force unfollow shop by vendor
  Future<void> unfollowShop({required String shopId});

  /// Fetches a page of shop followers.
  ///
  /// Returns a record of ([items], [lastDoc]) where [lastDoc] is `null` on
  /// the last page. Pass [cursor] from a previous call's [lastDoc] to get
  /// the next page.
  ///
  /// If [userId] is provided the result is filtered to that single user only.
  Future<(List<ShopFollowerDto>, Object?)> fetchShopFollowers({
    required String shopId,
    String? userId,
    Object? cursor,
    int limit = 20,
  });

  /// Lists shops followed by a user.
  Future<List<UserFollowingShopDto>> listUserFollowedShops({
    required String userId,
    int page = 1,
    int limit = 10,
  });

  /// Check in user by vendor
  Future<CheckInResponseDto> checkInUserToShopByVendor({
    required String shopId,
    required String userId,
    required String billNumber,
    required double billAmount,
  });

  /// Check in user by staff
  Future<CheckInResponseDto> checkInUserToShopByStaff({
    required String shopId,
    required String userId,
    required String staffUserId,
    required String billNumber,
    required double billAmount,
  });

  Future<void> toggleShopNotification({
    required String shopId,
    required String userId,
    required String userFCMToken,
    required bool enable,
  });

  /// Fetches a page of streak logs for a specific follower.
  ///
  /// Returns a record of ([items], [lastDoc]) where [lastDoc] is `null` on
  /// the last page. Pass [cursor] from a previous call's [lastDoc] to get
  /// the next page.
  Future<(List<FollowerStreakLogDto>, Object?)> viewFollowerStreakLogs({
    required String shopId,
    required String userId,
    Object? cursor,
    int limit = 20,
  });

  /// Shop Offers Management
  ///

  /// Adds a new shop offer.
  Future<void> addShopOffer({
    required String shopId,
    required String name,
    required String description,
    required String startDate,
    required String endDate,
  });

  /// Fetches a page of shop offers for a specific shop.
  ///
  /// Returns a record of ([items], [lastDoc]) where [lastDoc] is `null` on
  /// the last page. Pass [cursor] from a previous call's [lastDoc] to get
  /// the next page.
  Future<(List<ShopOfferDto>, Object?)> fetchShopOffers({
    required String shopId,
    Object? cursor,
    int limit = 20,
  });

  /// Get single shop offer by ID
  Future<ShopOfferDto?> fetchShopOfferById({
    required String shopId,
    required String shopOfferId,
  });

  /// Get shop activity logs.
  /// When [userId] is provided, results are scoped to logs belonging to that customer.
  Future<(List<ShopActivityLogDto>, Object?)> fetchShopActivityLogs({
    required String shopId,
    String? userId,
    Object? cursor,
    int limit = 20,
  });
}

// Riverpod Provider
@Riverpod(keepAlive: true)
IShopService shopService(Ref ref) {
  return FirebaseShopService();
}
