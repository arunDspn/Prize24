import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/account_deletion_pending/account_deletion_pending_page.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/delete_account/delete_account_page.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/soft_delete_account/soft_delete_account_page.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/edit_profile/edit_profile_page.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/view_profile/ui/profile_page.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/authentication/presentation/pages/get_start/get_start_page.dart';
import 'package:prize24_app/features/authentication/presentation/pages/splash_page/splash_page.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/campaign/domain/models/gift_redemption_audit_log_model.dart';
import 'package:prize24_app/features/campaign/presentation/add_edit_vendor_campaign/view/add_edit_vendor_campagin_page.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_activity_log.dart';
import 'package:prize24_app/features/campaign/presentation/campaign_activity_log/campaign_activity_log_detail/ui/campaign_activity_log_detail_page.dart';
import 'package:prize24_app/features/campaign/presentation/campaign_activity_log/campaign_activity_log_list/ui/campaign_activity_log_list_page.dart';
import 'package:prize24_app/features/campaign/presentation/campaign_redemption_audit_log/log_detail/ui/campaign_redemption_audit_log_detail_page.dart';
import 'package:prize24_app/features/campaign/presentation/campaign_redemption_audit_log/log_list/ui/campaign_redemption_audit_log_list_page.dart';
import 'package:prize24_app/features/shop/domain/model/shop_activity_log.dart';
import 'package:prize24_app/features/shop/presentation/shop_activity_log/activity_log_detail/ui/shop_activity_log_detail_page.dart';
import 'package:prize24_app/features/shop/presentation/shop_activity_log/activity_log_list/ui/shop_activity_log_list_page.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/single_gift_detail/ui/vendor_single_gift_detail_view.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/vendor_scan_user/ui/vendor_scanner_for_user_gift_page.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/ui/vendor_campaign_detail_page.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_vendor_data_model.dart';
import 'package:prize24_app/features/clubs/domain/models/club_model.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/create_club/ui/create_club_page.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/vendor_club_detail/ui/components/club_members_detail/club_member_detail_page.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/vendor_club_detail/ui/vendor_club_detail_page.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/vendor_club_list/ui/vendor_club_list_page.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';
import 'package:prize24_app/features/gift/presentation/add_edit_auto_redeemable_gift/add_edit_auto_redeemable_gift_page.dart';
import 'package:prize24_app/features/gift/presentation/add_edit_gift/ui/add_edit_gift_page.dart';
import 'package:prize24_app/features/gift/presentation/home_users_gift_list/ui/home_user_redmeed_coupons.dart';
import 'package:prize24_app/features/gift/presentation/user_gift_detail/user_gift_details_page.dart';
import 'package:prize24_app/features/happy_hours/domain/model/shop_follower_model.dart';
import 'package:prize24_app/features/home_shell/home_shell_page.dart';
import 'package:prize24_app/features/redeem_gift/ui/redeem_gift_page.dart';
import 'package:prize24_app/features/shared_vendor/shared_vendor_requests_page/ui/shared_vendor_request_list_page.dart';
import 'package:prize24_app/features/shared_vendor/vendors_to_campaign_page/ui/vendors_to_campaign_page.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:prize24_app/features/shop/domain/model/user_following_shop_model.dart';
import 'package:prize24_app/features/shop/presentation/add_edit_shop/ui/add_edit_shop_page.dart';
import 'package:prize24_app/features/shop/presentation/add_new_shop_offer/ui/add_new_shop_offer_page.dart';
import 'package:prize24_app/features/shop/presentation/send_staff_request/ui/send_staff_request_page.dart';
import 'package:prize24_app/features/shop/presentation/shop_follower_detail/ui/shop_follower_detail_page.dart';
import 'package:prize24_app/features/shop/presentation/shop_offer_detail_by_id/ui/shop_offer_detail_by_id.dart';
import 'package:prize24_app/features/shop/presentation/shop_offers_list/ui/shop_offer_list_page.dart';
import 'package:prize24_app/features/shop/presentation/staff_requests_send_list/ui/staff_request_send_page.dart';
import 'package:prize24_app/features/shop/presentation/staff_scan_loyality/ui/staff_scan_loyality_page.dart';
import 'package:prize24_app/features/shop/presentation/user_shop_detail_with_streak/ui/user_shop_detail_page.dart';
import 'package:prize24_app/features/shop/presentation/user_shop_list/ui/user_following_shops_list_page.dart';
import 'package:prize24_app/features/shop/presentation/vendor_add_user_to_shop/ui/vendor_add_user_to_shop_page.dart';
import 'package:prize24_app/features/shop/presentation/vendor_scan_loyality/ui/vendor_scan_loyality_page.dart';
import 'package:prize24_app/features/shop/presentation/vendor_shop_detail/ui/vendor_shop_detail_page.dart';
import 'package:prize24_app/features/shop/presentation/view_shop_staff/ui/view_shop_staffs_page.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_shops/staff_shop_model.dart';
import 'package:prize24_app/features/shop_staffs/presentation/staff_operations/staff_campaign_detail/ui/staff_campaign_detail_page.dart';
import 'package:prize24_app/features/shop_staffs/presentation/staff_operations/staff_shop_detail/ui/staff_shop_detail_page.dart';
import 'package:prize24_app/features/shop_staffs/presentation/staff_operations/staff_shop_list/ui/staff_shop_list_page.dart';
import 'package:prize24_app/features/shop_staffs/presentation/user_view_staff_requests/ui/user_list_staff_requests_page.dart';
import 'package:prize24_app/features/show_user_qr_code/presentation/ui/user_qrscan_page.dart';
import 'package:prize24_app/features/subscriptions/presentation/manage_subscriptions/ui/manage_subscriptions_page.dart';
import 'package:prize24_app/features/vendor/presentation/edit_vendor_profile/ui/edit_vendor_profile_page.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_friends_and_requests/vendor_friends_and_requests_page.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_qr_code/vendor_qr_code_page.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_send_friend_request/ui/vendor_send_friend_request_page.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_tab/ui/vendor_home_page1.dart';
import 'package:prize24_app/routing/app_routes.dart';
import 'package:prize24_app/routing/go_observor.dart';

// Global navigator key for accessing router outside BuildContext
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  observers: [
    GoRouterObserver(),
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
  ],
  routes: [
    // Initial Routes
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.getStarted,
      builder: (context, state) => const GetStartPage(),
    ),
    // GoRoute(
    //   path: AppRoutes.login,
    //   builder: (context, state) => const LoginPage(),
    // ),
    // GoRoute(
    //   path: AppRoutes.signup,
    //   builder: (context, state) => const RegisterPage(),
    // ),

    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) => const HomeShellScreen(),
    // ),
    // GoRoute(
    //   path: '/homepage',
    //   builder: (context, state) => const HomePageCoupons(),
    // ),
    // GoRoute(
    //   path: '/profile',
    //   builder: (context, state) => const ProfilePage(),
    // ),
    // GoRoute(
    //   path: '/vendor',
    //   builder: (context, state) => const VendorPage(),
    // ),

    // User QR Code Page
    GoRoute(
      path: AppRoutes.qrScanScreen,
      builder: (context, state) => const UserQRCodePage(),
    ),

    // User's Redeemed and Available Gifts Details Page
    GoRoute(
      path: AppRoutes.coupon,
      builder: (context, state) {
        // final id = state.pathParameters['id'];
        final coupon = state.extra! as UserGiftModel;

        return UserGiftDetailsPage(userGift: coupon);
      },
    ),

    // For Deeplink

    // GoRoute(
    //   path: AppRoutes.coupon,
    //   builder: (context, state) {
    //     // final id = state.pathParameters['id'];
    //     return CouponDetailsPage(
    //       coupon: coupon,
    //     );
    //   },
    // ),

    // Home Shell Page with Indexed Stack
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return HomeShellPage(child: child);
      },
      branches: [
        // Home Branches
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePageCoupons(),
            ),
          ],
        ),

        // // User Clubs Branches
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: AppRoutes.userClubs,
        //       builder: (context, state) => const UserClubListPage(),
        //     ),
        //   ],
        // ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.userShops,
              builder: (context, state) {
                return const UserFollowingShopsListPage();
              },
            ),
          ],
        ),

        // 9188958033

        // Vendor Branches
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.vendor,
              builder: (context, state) => const VendorHomePage(),
            ),
          ],
        ),

        // User's Profile Branches
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),

    // Gifts

    // GoRoute(
    //   path: AppRoutes.addCoupon,
    //   builder: (context, state) => const AddOrEditVoucherPage(),
    // ),
    GoRoute(
      path: AppRoutes.editVendorProfile,
      builder: (context, state) {
        final shop = state.extra! as ShopModel;

        return EditVendorProfilePage(shop: shop);
      },
    ),

    GoRoute(
      path: AppRoutes.editProfile,
      builder: (context, state) {
        final user = state.extra! as AppUser;
        return EditProfilePage(user: user);
      },
    ),

    // Delete Account Page
    GoRoute(
      path: AppRoutes.deleteAccount,
      builder: (context, state) => const DeleteAccountPage(),
    ),

    // Soft Delete Account Page
    GoRoute(
      path: AppRoutes.softDeleteAccount,
      builder: (context, state) => const SoftDeleteAccountPage(),
    ),

    // Account Deletion Pending Page
    GoRoute(
      path: AppRoutes.accountDeletionPending,
      builder: (context, state) => const AccountDeletionPendingPage(),
    ),

    // Shop

    // Add or Edit Shop Page
    GoRoute(
      path: AppRoutes.addShop,
      builder: (context, state) {
        final shop = state.extra as ShopModel?;
        return AddOrEditShopPage(shop: shop);
      },
    ),

    // Shop Details Page
    GoRoute(
      path: AppRoutes.shopDetails,
      builder: (context, state) {
        final shop = state.extra as ShopModel?;
        return VendorShopDetailsPage(shop: shop!);
      },
    ),

    // Vendor QR Code Page
    GoRoute(
      path: AppRoutes.vendorQrCode,
      builder: (context, state) => const VendorQrCodePage(),
    ),

    // Vendor Send Friend Request Page
    GoRoute(
      path: AppRoutes.vendorSendFriendRequest,
      builder: (context, state) => const VendorSendFriendRequestPage(),
    ),

    // Vendor Friends and Requests Page
    GoRoute(
      path: AppRoutes.vendorFriendsAndRequests,
      builder: (context, state) => const VendorFriendsAndRequestsPage(),
    ),

    // Campaigns
    // Add for Add Edit Details Page
    GoRoute(
      path: AppRoutes.addVendorCampaign,
      builder: (context, state) {
        final campaign = state.extra as CampaignModel?;
        return AddEditVendorCampaginPage(existingCampaign: campaign);
      },
    ),

    // Campaigns Details Page
    GoRoute(
      path: AppRoutes.vendorCampaignDetails,
      builder: (context, state) {
        // final campaign = state.extra! as CampaignModel;
        return const VendorCampaignDetailPage(
          // campaign: campaign,
        );
      },
    ),

    // Campaign Redemption Audit Log Page
    GoRoute(
      path: AppRoutes.campaignRedemptionAuditLog,
      builder: (context, state) {
        final campaignId = state.extra! as String;
        return CampaignRedemptionAuditLogListPage(campaignId: campaignId);
      },
    ),

    // Campaign Redemption Audit Log Detail Page
    GoRoute(
      path: AppRoutes.campaignRedemptionAuditLogDetail,
      builder: (context, state) {
        final log = state.extra! as GiftRedemptionAuditLogModel;
        return CampaignRedemptionAuditLogDetailPage(log: log);
      },
    ),

    // Campaign Activity Log List Page
    GoRoute(
      path: AppRoutes.campaignActivityLog,
      builder: (context, state) {
        final campaignId = state.extra! as String;
        return CampaignActivityLogListPage(campaignId: campaignId);
      },
    ),

    // Campaign Activity Log Detail Page
    GoRoute(
      path: AppRoutes.campaignActivityLogDetail,
      builder: (context, state) {
        final entry = state.extra! as CampaignActivityLogEntry;
        return CampaignActivityLogDetailPage(entry: entry);
      },
    ),

    // Shop Activity Log List Page
    GoRoute(
      path: AppRoutes.shopActivityLog,
      builder: (context, state) {
        final shopId = state.extra! as String;
        return ShopActivityLogListPage(shopId: shopId);
      },
    ),

    // Shop Activity Log Detail Page
    GoRoute(
      path: AppRoutes.shopActivityLogDetail,
      builder: (context, state) {
        final entry = state.extra! as ShopActivityLogEntry;
        return ShopActivityLogDetailPage(entry: entry);
      },
    ),

    /// Gift Avail -------------
    ///
    /// Avail Gift by SOwnner
    GoRoute(
      path: AppRoutes.availGiftByOwner,
      builder: (context, state) {
        final campaignData = state.extra! as AvailGiftUIData;
        return ScannerToAvailGiftPage.owner(
          campaignDetailsUIData: campaignData,
        );
      },
    ),

    /// Avail Gift by Staff
    GoRoute(
      path: AppRoutes.availGiftByStaff,
      builder: (context, state) {
        final campaignData = state.extra! as AvailGiftUIData;
        return ScannerToAvailGiftPage.staff(
          campaignDetailsUIData: campaignData,
        );
      },
    ),

    /// Avail Gift by Shared Vendor
    GoRoute(
      path: AppRoutes.availGiftBySharedVendor,
      builder: (context, state) {
        final campaignData = state.extra! as AvailGiftUIData;
        return ScannerToAvailGiftPage.sharedVendor(
          campaignDetailsUIData: campaignData,
        );
      },
    ),

    // Add or Edit Gift Page
    GoRoute(
      path: AppRoutes.addGift,
      builder: (context, state) {
        final uiData = state.extra! as AddNewGiftUIDataParcel;

        return AddEditGiftPage(uiData: uiData);
      },
    ),

    // Add AutoRedeemableGift Page
    GoRoute(
      path: AppRoutes.editAutoRedeemableGift,
      builder: (context, state) {
        final uiData = state.extra! as (GiftModel?, int, String);

        return AddEditAutoRedeemableGiftPage.edit(
          existingGift: uiData.$1,
          totalAllowedGifts: uiData.$2,
          campaignId: uiData.$3,
        );
      },
    ),

    // Edit AutoRedeemableGift Page
    GoRoute(
      path: AppRoutes.addAutoRedeemableGift,
      builder: (context, state) {
        final uiData = state.extra! as (String, String, int);

        return AddEditAutoRedeemableGiftPage(
          campaignId: uiData.$1,
          campaignName: uiData.$2,
          totalAllowedGifts: uiData.$3,
        );
      },
    ),

    // View Share Campaign Requests Page
    GoRoute(
      path: AppRoutes.shareCampaignRequests,
      builder: (context, state) => const SharedVendorRequestListPage(),
    ),

    // Add Vendors to Campaign Page
    GoRoute(
      path: AppRoutes.vendorsToCampaign,
      builder: (context, state) {
        final data = state.extra! as Map<String, dynamic>;
        final alreadyAddedVendorIds = data['vendorIds'] as List<String>;
        final campaignId = data['campaignId'] as String;

        return VendorsToCampaignPage(alreadyAddedVendorIds, campaignId);
      },
    ),

    // Become Staff Requests Page
    GoRoute(
      path: AppRoutes.userStaffRequests,
      builder: (context, state) => const UserListStaffRequestsPage(),
    ),

    // Send Become Staff Request Page
    GoRoute(
      path: AppRoutes.sendBecomeStaffRequest,
      builder: (context, state) {
        final shopDetails = state.extra! as (String, String);
        return SendStaffRequestPage(shopDetails: shopDetails);
      },
    ),

    // View Shop's Staffs Page
    GoRoute(
      path: AppRoutes.shopStaffs,
      builder: (context, state) {
        final shopId = state.extra! as String;
        return ViewShopStaffsPage(shopId: shopId);
      },
    ),

    // View Staff Requests Sent Page
    GoRoute(
      path: AppRoutes.shopStaffRequestsSent,
      builder: (context, state) {
        final shopId = state.extra! as String;
        return StaffRequestSendListPage(shopId);
      },
    ),

    // Redeem Avail Gift Page by Staff
    GoRoute(
      path: AppRoutes.redeemAvailedGiftByStaff,
      builder: (context, state) {
        final giftData = state.extra! as RedeemGiftBasicData;
        return RedeemUserGiftPage.staff(campaignDetailsUIData: giftData);
      },
    ),
    // Redeem Avail Gift Page by Owner
    GoRoute(
      path: AppRoutes.redeemAvailedGiftByOwner,
      builder: (context, state) {
        final giftData = state.extra! as RedeemGiftBasicData;
        return RedeemUserGiftPage.owner(campaignDetailsUIData: giftData);
      },
    ),

    // Redeem Avail Gift Page by Shared Vendor
    GoRoute(
      path: AppRoutes.redeemAvailedGiftBySharedVendor,
      builder: (context, state) {
        final giftData = state.extra! as RedeemGiftBasicData;
        return RedeemUserGiftPage.sharedVendor(campaignDetailsUIData: giftData);
      },
    ),

    // -- Staff Operations
    // View Staff Shops
    GoRoute(
      path: AppRoutes.staffShops,
      builder: (context, state) {
        final data = state.extra! as (List<String>, String);
        return StaffShopListPage(shopIds: data.$1, staffId: data.$2);
      },
    ),

    // // View Staff Shop Details
    GoRoute(
      path: AppRoutes.staffShopDetails,
      builder: (context, state) {
        final staffShopModel = state.extra! as StaffShopModel;
        return StaffShopDetailPage(staffShopModel: staffShopModel);
      },
    ),

    // View Staff Campaign Details
    GoRoute(
      path: AppRoutes.staffCampaignDetails,
      builder: (context, state) {
        final datas = state.extra! as Map<String, dynamic>;
        return StaffCampaignDetailPage(datas: datas);
      },
    ),

    /// CLUBS ---------
    ///
    /// User Club Details Page

    /// Vendor
    /// Vendor Club List
    GoRoute(
      path: AppRoutes.vendorClubs,
      builder: (context, state) {
        return const VendorClubListPage();
      },
    ),

    // Create a new club by vendor
    GoRoute(
      path: AppRoutes.createClub,
      builder: (context, state) {
        return const CreateClubPage();
      },
    ),

    // Add Users to Club by Owner
    GoRoute(
      path: AppRoutes.addUsersToClubByOwner,
      builder: (context, state) {
        final clubId = state.extra! as String;
        return VendorAddUserToShopPage(shopId: clubId);
      },
    ),

    // Vendor Club Details Page
    GoRoute(
      path: AppRoutes.vendorClubDetails,
      builder: (context, state) {
        final club = state.extra! as ClubModel;
        return VendorClubDetailPage(club: club);
      },
    ),

    // Vendor Club Member Details Page
    GoRoute(
      path: AppRoutes.clubMemberDetails,
      builder: (context, state) {
        final member = state.extra! as ClubMemberVendorDataModel;
        return ClubMemberDetailPage(clubMemberData: member);
      },
    ),

    // /// Vendor Add user to Club
    // GoRoute(
    //   path: AppRoutes.addUsersToClubByOwner,
    //   builder: (context, state) {
    //     return const VendorAddUserToClubPage();
    //   },
    // ),

    // Scan users for loyalty by club owner
    GoRoute(
      path: AppRoutes.scanUsersForLoyaltyByClubOwner,
      builder: (context, state) {
        final shop = state.extra! as ShopModel;
        return VendorScanLoyalityPage(shop: shop);
      },
    ),

    // Scan users for loyalty by shop staff
    GoRoute(
      path: AppRoutes.scanUsersForLoyaltyByShopStaff,
      builder: (context, state) {
        final data = state.extra! as (String?, String);
        return StaffScanLoyalityPage(campaignId: data.$1, shopId: data.$2);
      },
    ),

    /// Shop Extras

    /// Users Shops List Page
    GoRoute(
      path: AppRoutes.userShopDetails,
      builder: (context, state) {
        final shopData = state.extra! as UserFollowingShopModel;
        return UserShopDetailWithStreakPage(shopData: shopData);
      },
    ),

    // Shop Offers List Page
    GoRoute(
      path: AppRoutes.shopOffersList,
      builder: (context, state) {
        final shopId = state.extra! as String;
        return ShopOfferListPage(shopId: shopId);
      },
    ),

    // Add New Shop Offer Page
    GoRoute(
      path: AppRoutes.addNewShopOffer,
      builder: (context, state) {
        final shopId = state.extra! as String;
        return AddNewShopOfferPage(shopId: shopId);
      },
    ),

    /// Shop Offer Details Page
    GoRoute(
      path: AppRoutes.shopOfferDetails,
      builder: (context, state) {
        final data = state.extra! as Map<String, dynamic>;
        final offerId = data['offerId'] as String;
        final shopId = data['shopId'] as String;
        return ShopOfferDetailById(shopOfferId: offerId, shopId: shopId);
      },
    ),

    /// Become a Vendor Paywall used directly by RC
    // GoRoute(
    //   path: AppRoutes.becomeAVendorPaywall,
    //   builder: (context, state) {
    //     return const BecomeAVendorPaywallPage();
    //   },
    // ),

    /// Subscriptions Management
    GoRoute(
      path: AppRoutes.manageSubscriptions,
      builder: (context, state) {
        return const ManageSubscriptionsPage();
      },
    ),

    // Vendor Gift Details Page
    // vendorGiftDetails
    GoRoute(
      path: AppRoutes.vendorGiftDetails,
      builder: (context, state) {
        final gift = state.extra! as GiftModel;
        return VendorSingleGiftDetailView(gift: gift);
      },
    ),

    // Shop Follower details - shopFollowerDetails
    GoRoute(
      path: AppRoutes.shopFollowerDetails,
      builder: (context, state) {
        final data = state.extra! as (ShopFollowerModel, String);
        return ShopFollowerDetailPage(follower: data.$1, shopId: data.$2);
      },
    ),
  ],
);
