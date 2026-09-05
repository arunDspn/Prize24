import 'package:prize24_app/features/happy_hours/domain/model/shop_follower_model.dart';
import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/shop/data/repository/shop_repository.dart';
import 'package:prize24_app/features/shop/data/service/i_shop_service.dart';
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
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'i_shop_repository.g.dart';

/// Abstract repository interface for shop-related operations.
abstract class IShopRepository {
  /// Adds a new shop.
  ///
  /// [shop]: The [ShopModel] instance to be added.
  /// Returns the added [ShopModel].
  Future<ShopModel> addNewShop({required ShopModel shop});

  /// Deletes a shop.
  ///
  /// Implementations should specify which shop is deleted.
  Future<void> deleteShop({required String shopId});

  /// Edits an existing shop.
  ///
  /// [shop]: The [ShopModel] instance with updated data.
  /// Returns the updated [ShopModel].
  Future<ShopModel> editShop({required ShopModel shop});

  /// Retrieves details of a shop by its ID.
  ///
  /// [shopId]: The unique identifier of the shop.
  /// Returns the corresponding [ShopModel].
  Future<ShopModel> getShopDetails({required String shopId});

  /// Retrieves a paginated list of shops by vendor ID.
  ///
  /// [vendorId]: The unique identifier of the vendor.
  /// [page]: The page number (default is 1).
  /// [limit]: The number of items per page (default is 10).
  /// Returns a list of [ShopModel].
  Future<List<ShopModel>> listAllShopsOfVendor({
    required String vendorId,
    int page = 1,
    int limit = 10,
  });

  // Staff management methods ---------------------------

  /// Sends a request to add a staff member to a shop.
  Future<void> sendAddStaffRequest({
    required String shopId,
    required String shopName,
    required String senderName,
    required String receiverId,
  });

  /// Retrieves the list of staff members for a given shop.
  Future<PaginatedResult<ShopStaffModel>> getShopStaffs({
    required String shopId,
    Object? cursor,
    int limit = 20,
  });

  /// Get staff requests send by the Shop
  /// Used by the Shop Owner to see the requests send by him
  Future<List<StaffRequestSendModel>> getShopStaffRequestsSent({
    required String shopId,
  });

  /// Get staff requests received by the Staff
  Future<PaginatedResult<BecomeStaffRequestModel>>
  getShopStaffRequestsReceived({
    required String staffUserId,
    Object? cursor,
    int limit = 20,
  });

  /// Respond to a staff request (accept or reject)
  Future<void> respondToStaffRequest({
    required String requestId,
    //Todo: use enum
    required String action, // accept or reject
    required String staffUserId,
    required String shopId,
  });

  Future<void> revokeShopStaff({
    required String shopId,
    required String staffUserId,
    String reason = '',
  });

  // User Shop Relationships ---------------------------

  /// Follows a shop.
  /// Add a user to  the shop's followers list by the vendor
  Future<ShopFollowResponseModel> followShopByVendor({
    required String shopId,
    required String userId,
  });

  /// Adds a user to the shop's followers list by the staff
  Future<ShopFollowResponseModel> followShopByStaff({
    required String shopId,
    required String userId,
  });

  /// Unfollows a shop by user
  Future<void> unfollowShopByUser({
    required String shopId,
    required String userFCMToken,
  });

  /// Force unfollow shop by vendor
  Future<void> unfollowShop({required String shopId});

  /// Fetches a page of followers for a specific shop.
  ///
  /// Pass the [cursor] returned from the previous call to load the next page.
  /// Omit [cursor] (or pass `null`) to fetch the first page.
  ///
  /// If [userId] is provided the result is scoped to that single user.
  Future<PaginatedResult<ShopFollowerModel>> fetchShopFollowers({
    required String shopId,
    String? userId,
    Object? cursor,
    int limit = 20,
  });

  /// Lists shops followed by a user.
  Future<List<UserFollowingShopModel>> listUserFollowedShops({
    required String userId,
    int page = 1,
    int limit = 10,
  });

  /// Check in user by vendor
  Future<CheckInResponseModel> checkInUserToShopByVendor({
    required String shopId,
    required String userId,
    required String billNumber,
    required double billAmount,
  });

  /// Check in user by staff
  Future<CheckInResponseModel> checkInUserToShopByStaff({
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
  /// Pass the [cursor] returned from the previous call to load the next page.
  /// Omit [cursor] (or pass `null`) to fetch the first page.
  ///
  /// When the returned [PaginatedResult.hasMore] is `false`, all pages have
  /// been loaded.
  Future<PaginatedResult<FollowerStreakLogModel>> viewFollowerStreakLogs({
    required String shopId,
    required String userId,
    Object? cursor,
    int limit = 20,
  });

  Future<PaginatedResult<StaffShopModel>> getStaffsShops({
    required List<String> shopIds,
    Object? cursor,
    int limit = 20,
  });

  /// Shop offers related methods

  Future<void> addShopOffer({
    required String shopId,
    required String name,
    required String description,
    required String startDate,
    required String endDate,
  });

  Future<void> deleteShopOffer({
    required String shopId,
    required String offerId,
  });

  /// Lists a page of offers for a specific shop.
  ///
  /// Pass the [cursor] returned from the previous call to fetch the next page.
  /// Omit [cursor] (or pass `null`) to fetch the first page.
  /// When the returned [PaginatedResult.hasMore] is `false`, all pages have
  /// been loaded.
  Future<PaginatedResult<ShopOfferModel>> listShopOffers({
    required String shopId,
    Object? cursor,
    int limit = 20,
  });

  /// Get single shop offer by ID
  Future<ShopOfferModel?> getShopOfferById({
    required String shopId,
    required String shopOfferId,
  });

  /// Get shop activity logs with pagination.
  /// Pass the [cursor] returned from the previous call to fetch the next page.
  /// Omit [cursor] (or pass `null`) to fetch the first page.
  /// When the returned list is empty, all pages have been loaded.
  /// When [userId] is provided, results are scoped to logs for that customer.
  Future<PaginatedResult<ShopActivityLogEntry>> getShopActivityLogs({
    required String shopId,
    String? userId,
    Object? cursor,
    int limit = 20,
  });
}

// Riverpod Provider
@Riverpod(keepAlive: true)
IShopRepository shopRepository(Ref ref) {
  final shopService = ref.watch(shopServiceProvider);
  return ShopRepository(shopService: shopService);
}
