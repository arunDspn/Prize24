/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {setGlobalOptions} from "firebase-functions";

// Import our gift redemption functions
export {textAvailPublicFullTextCodeCampaign} from "./campaign_gift/publicCodeGift";
export {textAvailPublicSemiTextAutoCampaign} from "./campaign_gift/publicAutoGift";
export {
  scanAvailPublicPrivateAutoCampaign,
  scanToAvailPublicPrivateAutoCampaignByStaff,
  scanToAvailPublicPrivateAutoCampaignBySharedVendor,
} from "./campaign_gift/scanCampaign";

// Import vendor friendship functions
export {
  sendFriendRequest,
  respondToFriendRequest,
  blockUser,
} from "./vendor_friendship/vendorFriendship";

// Import staff management functions
// export {
//   sendStaffRequest,
//   respondToStaffRequest,
//   revokeStaffAccess,
//   removeStaffMember,
//   getStaffMemberDetails,
// } from "./staffManagement";

// Import campaign share functions
export {
  sendCampaignShareRequest,
  respondToCampaignShareRequest,
} from "./campaign_share/campaignShare";

// Import club management functions
export {
  createClub,
} from "./shop_user_relationship/clubManagement";

// Import shop follow functions
export {
  followShopByVendor,
  followShopByStaff,
  unfollowShop,
  removeFollower,
} from "./shop_user_relationship/shopFollow";

// Import shop check-in and offer functions
export {
  checkInUser,
  addOfferToShop,
} from "./shop_user_relationship/shopCheckIn";

// Import scan to redeem functions
export {
  scanToRedeemByOwner,
  scanToRedeemBySharedVendor,
  scanToRedeemByStaff,
} from "./campaign_gift/scanToRedeem";

// Import auto gift delete function
export {
  deleteAutoRedeemableGift,
} from "./campaign_gift/deleteAutoRedeemableGift";

// Import user account management functions
export {
  deleteAccount,
} from "./user_account/deleteAccount";
export {
  requestAccountDeletion,
  cancelAccountDeletion,
} from "./user_account/accountDeletionRequest";

// Import RevenueCat webhook functions
export {
  revenueCatWebhook,
} from "./webhook/revenuecat";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({maxInstances: 10});

// export const helloWorld2 = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// / We have publicSlug in both campaigns and gifts, you  may standardize that all functions with convention

// / codeGiftCodes yes its stored under  subcollection of a gift

