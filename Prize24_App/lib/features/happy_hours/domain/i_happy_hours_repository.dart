import 'package:prize24_app/features/happy_hours/domain/model/shop_follower_model.dart';
import 'package:prize24_app/features/shop/domain/model/user_following_shop_model.dart';

abstract class IHappyHoursRepository {
  /// User follows a shop
  Future<UserFollowingShopModel> followShop({
    required String userFCMToken,
    required String shopId,
  });

  /// Unfollow a shop
  Future<void> unfollowShop({
    required String shopId,
    required String userFCMToken,
  });

  /// Toggle notification for a followed shop
  Future<void> toggleShopNotification({
    required String shopId,
    required String userFCMToken,
    required bool enable,
  });

  /// List users followed shops
  Future<List<UserFollowingShopModel>> listUserFollowedShops({
    required String userId,
  });

  /// Fetch shop followers by shop ID
  Future<List<ShopFollowerModel>> fetchShopFollowers({
    required String shopId,
  });
}
