// A class that contains all routes names and its relative names So that can be used to navigate in UI
class AppRoutes {
  static const String splash = '/';
  static const String getStarted = '/getstarted';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String vendor = '/vendor';
  static const String qrScanScreen = '/qrscanscreen';
  static const String coupon = '/coupon';
  static const String couponDeepLink = '/coupon/:id';
  static const String addCoupon = '/add-coupon';

  // Profile
  static const String editProfile = '/edit-profile';
  static const String editVendorProfile = '/edit-vendor-profile';
  static const String deleteAccount = '/delete-account';
  static const String softDeleteAccount = '/soft-delete-account';
  static const String accountDeletionPending = '/account-deletion-pending';


  // Shops -----------------------------
  static const String shops = '/shops';
  // Add shop
  static const String addShop = '/add-shop';
  // Shop details
  static const String shopDetails = '/shop-details';

  // Shop Followers
  static const String shopFollowers = '/shop-followers';

  // Shop Follower details
  static const String shopFollowerDetails = '/shop-follower-details';

  // User's Shops
  static const String userShops = '/user-shops';

  // User shop details
  static const String userShopDetails = '/user-shop-details';

  // Shop Offers ----------------
  static const String shopOffersList = '/shop-offers-list';
  static const String addNewShopOffer = '/add-new-shop-offer';
  static const String shopOfferDetails = '/shop-offer-details_by_id';

  // Campaigns
  static const String vendorCampaigns = '/vendor-campaigns';
  static const String addVendorCampaign = '/add-vendor-campaign';
  static const String editVendorCampaign = '/edit-vendor-campaign';
  static const String vendorCampaignDetails = '/vendor-campaign-details';
  static const String campaignRedemptionAuditLog =
      '/campaign-redemption-audit-log';
  static const String campaignRedemptionAuditLogDetail =
      '/campaign-redemption-audit-log-detail';

  // Campaign Activity Log
  static const String campaignActivityLog = '/campaign-activity-log';
  static const String campaignActivityLogDetail =
      '/campaign-activity-log-detail';

  // Shop Activity Log
  static const String shopActivityLog = '/shop-activity-log';
  static const String shopActivityLogDetail = '/shop-activity-log-detail';

  // Vendor QR Code
  static const String vendorQrCode = '/vendor-qr-code';

  /// Avail Gift --------
  static const String availGiftByOwner = '/avail-gift-by-owner';
  static const String availGiftByStaff = '/avail-gift-by-staff';
  static const String availGiftBySharedVendor = '/avail-gift-by-shared-vendor';

  // Vendor Friends
  static const String vendorSendFriendRequest = '/vendor-send-friend-request';
  static const String vendorFriendsAndRequests = '/vendor-friends-and-requests';

  // Gifts
  // Add gift
  static const String addGift = '/add-gift';

  // Add  AutoRedeemableGiftPage
  static const String addAutoRedeemableGift = '/add-auto-redeemable-gift';

  // Edit AutoRedeemableGiftPage
  static const String editAutoRedeemableGift = '/edit-auto-redeemable-gift';

  // Vendor Gifts details
  static const String vendorGiftDetails = '/vendor-gift-details';

  // View Share Campaign Requests
  static const String shareCampaignRequests = '/share-campaign-requests';

  // Add vendors to campaign
  static const String vendorsToCampaign = '/vendors-to-campaign';

  // Become Staff Requests
  static const String userStaffRequests = '/user-staff-requests';

  // Send become staff request
  static const String sendBecomeStaffRequest = '/send-become-staff-request';

  // View Shop's Staffs
  static const String shopStaffs = '/shop-staffs';

  // View Staff Requests Sent
  static const String shopStaffRequestsSent = '/shop-staff-requests-sent';

  /// Redeem a availed gift by staff
  static const String redeemAvailedGiftByStaff =
      '/redeem-availed-gift-by-staff';

  /// Redeem a availed gift by owner
  static const String redeemAvailedGiftByOwner =
      '/redeem-availed-gift-by-owner';

  /// Redeem a availed gift by shared vendor
  static const String redeemAvailedGiftBySharedVendor =
      '/redeem-availed-gift-by-shared-vendor';

  // -- Staff Operations
  // View Staff Shops
  static const String staffShops = '/staff-shops';

  // Staff shop details
  static const String staffShopDetails = '/staff-shop-details';

  // Staff Campaigns details
  static const String staffCampaignDetails = '/staff-campaign-details';

  /// Clubs ----------------
  ///  Will be deprecated soon
  /// User Clubs
  static const String userClubs = '/user-clubs';

  /// User Club Details
  static const String userClubDetails = '/user-club-details';

  /// Vendor Clubs
  static const String vendorClubs = '/vendor-clubs';

  /// Add a new club by vendor
  static const String createClub = '/create-club';

  /// Vendor Club Details
  static const String vendorClubDetails = '/vendor-club-details';

  /// Vendor Club Member Details
  static const String clubMemberDetails = '/club-member-details';

  /// Add users to club by club owner
  static const String addUsersToClubByOwner = '/add-users-to-club-by-owner';

  /// Scan users for loyalty by club owner
  static const String scanUsersForLoyaltyByClubOwner =
      '/scan-users-for-loyalty-by-club-owner';

  /// Staff Clubs
  /// Scan users for loyalty by shop staff
  static const String scanUsersForLoyaltyByShopStaff =
      '/scan-users-for-loyalty-by-shop-staff';

  /// Become a Vendor Paywall
  static const String becomeAVendorPaywall = '/become-a-vendor-paywall';

  /// Subscriptions Management
  static const String manageSubscriptions = '/manage-subscriptions';
}
