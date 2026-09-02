// Common types for all gift redemption functions
import {FieldValue, Timestamp} from "firebase-admin/firestore";

export interface Campaign {
    id: string;
    publicSlug: string;
    name: string;
    status: "active" | "inactive" | "expired";
    totalGifts: number;
    totalParticipants: number;
    totalParticipated?: number; // Total attempts/participations (can be > totalParticipants)
    remainingParticipants: number; // Remaining scan attempts available
    remainingGifts: number; // Remaining gifts available for distribution
    endDate?: Timestamp | null; // Optional campaign end date
}

// RevenueCat webhook types
export interface RevenueCatWebhookEvent {
    id?: string;
    type: string;
    app_user_id: string;
    transaction_id?: string;
    original_transaction_id?: string;
    product_id: string;
    purchased_at_ms?: number;
    price: number;
    currency: string;
}

export interface RevenueCatWebhookBody {
    api_version?: string;
    event: RevenueCatWebhookEvent;
}

export interface RevenueCatNormalizedPayment {
    paymentId: string;
    amount: number;
    currency: string;
    productId: string;
    eventDate: Timestamp;
    createdAt: FieldValue;
    provider: "revenuecat";
    eventType: string;
    transactionId: string | null;
    originalTransactionId: string | null;
}

export const REVENUECAT_EVENT_TYPES: ReadonlySet<string> = new Set([
  "INITIAL_PURCHASE",
  "RENEWAL",
]);

export interface Gift {
    id: string;
    publicSlug: string;
    name: string;
    description: string;
    remainingQuantity: number;
    isRedeemable: boolean;
    supportedShops: string[] | null;
}

export interface CodeGiftCode {
    id: string;
    code: string;
    isRedeemed: boolean;
    redeemedByUserId: string | null;
    redeemedAt: Timestamp | null;
    expirationDate?: Timestamp | null; // Optional expiration field
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    payload: any | null;
}

export interface AutoGiftPayload {
    id: string;
    type: string;
    code: string;
    value?: number;
    amount?: number;
    percent?: number;
    currency?: string;
    description: string;
    isRedeemed: boolean;
    redeemedByUserId: string | null;
    redeemedAt: Timestamp | null;
    createdAt: Timestamp;
}

export interface UserGift {
    userId: string;
    giftId: string;
    campaignId: string;
    campaignName: string;
    giftName: string;
    giftDescription: string;
    isRedeemable: boolean;
    isRedeemed: boolean | null;
    redeemedAt: Timestamp | FieldValue | null;
    availedAt: Timestamp | FieldValue;
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    payload: any | null;
    payloadId?: string | null;
    supportedShops: string[] | null;
    redemptionId: string;
    availedViaStreak?: boolean | null;
    streakShopID?: string | null;
}

export interface RedemptionResponse {
    success: true;
    data: {
        giftName: string;
        giftDescription: string;
        isRedeemable: boolean;
        redemptionId: string;
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        payload?: any;
        supportedShops?: string[];
    };
}

export interface ErrorResponse {
    success: false;
    error: {
        code: string;
        message: string;
    };
}

export type FunctionResponse = RedemptionResponse | ErrorResponse;

// Error codes
export const ERROR_CODES = {
  CAMPAIGN_NOT_FOUND: "CAMPAIGN_NOT_FOUND",
  CAMPAIGN_INACTIVE: "CAMPAIGN_INACTIVE",
  CAMPAIGN_EXPIRED: "CAMPAIGN_EXPIRED",
  CAMPAIGN_PARTICIPATION_EXHAUSTED: "CAMPAIGN_PARTICIPATION_EXHAUSTED",
  GIFT_NOT_FOUND: "GIFT_NOT_FOUND",
  CODE_NOT_FOUND: "CODE_NOT_FOUND",
  CODE_ALREADY_REDEEMED: "CODE_ALREADY_REDEEMED",
  CODE_EXPIRED: "CODE_EXPIRED",
  GIFT_UNAVAILABLE: "GIFT_UNAVAILABLE",
  GIFT_QUANTITY_INVALID: "GIFT_QUANTITY_INVALID",
  USER_NOT_FOUND: "USER_NOT_FOUND",
  TRANSACTION_FAILED: "TRANSACTION_FAILED",
  GIFTS_EXHAUSTED: "GIFTS_EXHAUSTED",
  PAYLOADS_EXHAUSTED: "PAYLOADS_EXHAUSTED",
  PAYLOAD_UPDATE_FAILED: "PAYLOAD_UPDATE_FAILED",
  PAYLOAD_STRUCTURE_INVALID: "PAYLOAD_STRUCTURE_INVALID",
  CAMPAIGN_DATA_INCONSISTENT: "CAMPAIGN_DATA_INCONSISTENT",
  DUPLICATE_PARTICIPATION: "DUPLICATE_PARTICIPATION",
  LUCK_FAILED: "LUCK_FAILED",
  VALIDATION_ERROR: "VALIDATION_ERROR",
} as const;

export type ErrorCode = typeof ERROR_CODES[keyof typeof ERROR_CODES];

// Vendor Friendship Types
export interface Friendship {
    requesterId: string;
    requesterName: string;
    requesterProfilePic?: string;
    receiverId: string;
    receiverName: string;
    receiverProfilePic?: string;
    status: "pending" | "accepted" | "declined" | "blocked";
    createdAt: Timestamp;
    updatedAt: Timestamp;
    acceptedAt?: Timestamp;
    participants: string[];
}

export interface FriendshipRequest {
    receiverId: string;
}

export interface FriendshipResponse {
    friendshipId: string;
    action: "accept" | "decline";
}

export interface BlockUserRequest {
    userId: string;
}

export interface FriendshipApiResponse {
    success: boolean;
    message: string;
    data?: any;
    error?: string;
}

// Friendship Error Codes
export const FRIENDSHIP_ERROR_CODES = {
  UNAUTHORIZED: "UNAUTHORIZED",
  FORBIDDEN: "FORBIDDEN",
  NOT_FOUND: "NOT_FOUND",
  ALREADY_EXISTS: "ALREADY_EXISTS",
  INVALID_STATUS: "INVALID_STATUS",
  SELF_REQUEST: "SELF_REQUEST",
  RATE_LIMITED: "RATE_LIMITED",
} as const;

export type FriendshipErrorCode = typeof FRIENDSHIP_ERROR_CODES[keyof typeof FRIENDSHIP_ERROR_CODES];

// Campaign Share Request Types
export interface CampaignShareRequest {
    id: string;
    ownerVendorId: string;
    ownerVendorName: string;
    ownerVendorPhone: string;
    campaignId: string;
    campaignName: string;
    recipientId: string;
    requestedAt: Timestamp;
    status: "pending" | "accepted" | "declined";
    createdAt: Timestamp;
    updatedAt: Timestamp;
    respondedAt?: Timestamp;
    expiresAt: Timestamp; // Request expiration date
}

export interface SendCampaignShareRequest {
    recipientId: string;
    campaignId: string;
}

export interface RespondToCampaignShareRequest {
    requestId: string;
    action: "accept" | "decline";
}

export interface CampaignShareApiResponse {
    success: boolean;
    message: string;
    data?: any;
    error?: string;
}

// Campaign Share Error Codes
export const CAMPAIGN_SHARE_ERROR_CODES = {
  UNAUTHORIZED: "UNAUTHORIZED",
  CAMPAIGN_NOT_FOUND: "CAMPAIGN_NOT_FOUND",
  CAMPAIGN_NOT_OWNED: "CAMPAIGN_NOT_OWNED",
  RECIPIENT_NOT_FOUND: "RECIPIENT_NOT_FOUND",
  RECIPIENT_NOT_VENDOR: "RECIPIENT_NOT_VENDOR",
  REQUEST_ALREADY_EXISTS: "REQUEST_ALREADY_EXISTS",
  REQUEST_NOT_FOUND: "REQUEST_NOT_FOUND",
  REQUEST_EXPIRED: "REQUEST_EXPIRED",
  INVALID_STATUS: "INVALID_STATUS",
  NOT_FRIENDS: "NOT_FRIENDS",
} as const;

export type CampaignShareErrorCode = typeof CAMPAIGN_SHARE_ERROR_CODES[keyof typeof CAMPAIGN_SHARE_ERROR_CODES];

// Staff Management Types
export interface StaffRequest {
    id: string;
    vendorId: string;
    vendorName: string;
    vendorPhone?: string;
    staffUserId: string;
    staffName: string;
    staffEmail: string;
    staffPhone?: string;
    shopId: string;
    shopName: string;
    status: "pending" | "accepted" | "declined" | "expired";
    requestDate: Timestamp;
    respondedAt?: Timestamp;
    joinedAt?: Timestamp;
    expiresAt: Timestamp;
    role: string;
    permissions: string[];
    createdAt: Timestamp;
    updatedAt: Timestamp;
}

export interface ShopStaff {
    shopId: string;
    shopName: string;
    userId: string;
    userName: string;
    userEmail: string;
    userPhone?: string;
    vendorId: string;
    vendorName: string;
    role: string;
    permissions: string[];
    joinedAt: Timestamp;
    status: "active" | "inactive" | "suspended" | "revoked";
    revokedAt?: Timestamp;
    revokedBy?: string;
    revokedReason?: string;
    createdAt: Timestamp;
    updatedAt: Timestamp;
}

export interface SendStaffRequestData {
    staffUserId: string;
    shopId: string;
    role: string;
    permissions: string[];
}

export interface RespondToStaffRequestData {
    requestId: string;
    action: "accept" | "decline";
}

export interface RevokeStaffAccessData {
    shopId: string;
    staffUserId: string;
    reason?: string;
}

export interface RemoveStaffMemberData {
    shopId: string;
    staffUserId: string;
    reason?: string;
}

export interface GetStaffMemberDetailsData {
    staffUserId: string;
    shopId?: string;
}

export interface StaffApiResponse {
    success: boolean;
    message: string;
    data?: any;
    error?: string;
}

// Staff Error Codes
export const STAFF_ERROR_CODES = {
  UNAUTHORIZED: "UNAUTHORIZED",
  SHOP_NOT_FOUND: "SHOP_NOT_FOUND",
  SHOP_NOT_OWNED: "SHOP_NOT_OWNED",
  USER_NOT_FOUND: "USER_NOT_FOUND",
  USER_ALREADY_STAFF: "USER_ALREADY_STAFF",
  PENDING_REQUEST_EXISTS: "PENDING_REQUEST_EXISTS",
  REQUEST_NOT_FOUND: "REQUEST_NOT_FOUND",
  REQUEST_EXPIRED: "REQUEST_EXPIRED",
  INVALID_STATUS: "INVALID_STATUS",
  INVALID_ROLE: "INVALID_ROLE",
  INVALID_PERMISSIONS: "INVALID_PERMISSIONS",
  STAFF_NOT_FOUND: "STAFF_NOT_FOUND",
  STAFF_NOT_ACTIVE: "STAFF_NOT_ACTIVE",
  CANNOT_REVOKE_SELF: "CANNOT_REVOKE_SELF",
  CANNOT_REMOVE_SELF: "CANNOT_REMOVE_SELF",
  SHOP_INACTIVE: "SHOP_INACTIVE",
  NOT_AUTHORIZED: "NOT_AUTHORIZED",
  RATE_LIMITED: "RATE_LIMITED",
} as const;

export type StaffErrorCode = typeof STAFF_ERROR_CODES[keyof typeof STAFF_ERROR_CODES];

// Club Management Types
export interface Club {
    vendorId: string;
    name: string;
    description: string;
    giftDay: number;
    campaignId: string;
    campaignName: string;
    campaignDescription: string;
    multiplierRule?: {
        daysRequired: number;
        bonusIncrement: number;
    } | null;
    totalMembers: number;
    totalActiveMembers: number;
    status: "active" | "inactive" | "paused" | "archived";
    createdAt: Timestamp;
    updatedAt: Timestamp;
    lastGiftDistributedAt?: Timestamp | null;
}

export interface CreateClubData {
    name: string;
    description: string;
    giftDay: number;
    attachedCampaignId: string;
    multiplierStreakDaysRequired?: number;
    bonusIncrement?: number;
}

export interface ClubApiResponse {
    success: boolean;
    message: string;
    data?: any;
    error?: string;
}

// Club Error Codes
export const CLUB_ERROR_CODES = {
  UNAUTHORIZED: "UNAUTHORIZED",
  PERMISSION_DENIED: "PERMISSION_DENIED",
  NOT_A_VENDOR: "NOT_A_VENDOR",
  INVALID_ARGUMENT: "INVALID_ARGUMENT",
  CAMPAIGN_NOT_FOUND: "CAMPAIGN_NOT_FOUND",
  CAMPAIGN_INACTIVE: "CAMPAIGN_INACTIVE",
  NOT_CAMPAIGN_OWNER: "NOT_CAMPAIGN_OWNER",
  INVALID_GIFT_DAY: "INVALID_GIFT_DAY",
  CLUB_NOT_FOUND: "CLUB_NOT_FOUND",
  NO_SHOPS_FOUND: "NO_SHOPS_FOUND",
  NO_SHOPS_AVAILABLE: "NO_SHOPS_AVAILABLE",
  INTERNAL_ERROR: "INTERNAL_ERROR",
} as const;

export type ClubErrorCode = typeof CLUB_ERROR_CODES[keyof typeof CLUB_ERROR_CODES];

// Shop Follow Types
export interface ShopFollower {
    userId: string;
    userName: string;
    userProfilePic: string | null;
    notificationEnabled: boolean;

    // Streak Data
    cumulativeStreak: number; // Total check-ins (never decreases)
    consecutiveDays: number; // Current consecutive check-in streak
    lastCheckInDate: Timestamp | null; // Last check-in timestamp
    lastGiftDayStreak: number | null; // Cumulative streak at last gift
    lastBonusDate: Timestamp | null; // Last time bonus was applied

    followedAt: Timestamp;
    createdAt: Timestamp;
    updatedAt: Timestamp;
}

export interface UserFollowingShop {
    shopId: string;
    shopName: string;
    shopDescription: string;
    shopAddress: string;
    shopPhone: string;
    notificationEnabled: boolean;

    // User's streak info (read-only copy for quick access)
    cumulativeStreak: number;
    consecutiveDays: number;
    lastCheckInDate: Timestamp | null;

    followedAt: Timestamp;
    updatedAt: Timestamp;
}

export interface ShopData {
    shopId: string;
    shopOwnerId: string;
    shopName: string;
    shopDescription: string;
    shopAddress: string;
    shopPhone: string;
    shopStatus: "active" | "inactive" | "deleted";

    // Streak & Gift Configuration
    associatedCampaignId: string | null;
    campaignName?: string;
    giftDayCycle: number | null;

    // Multiplier Bonus Rule
    bonusIncrementDaysRequired: number | null;
    bonusIncrementValue: number | null;

    // Counters
    totalFollowers: number;

    // Metadata
    createdAt: Timestamp;
    updatedAt: Timestamp;
}

export interface ShopOffer {
    offerId: string;
    name: string;
    description: string;
    startDate: Timestamp;
    endDate: Timestamp;
    status: "active" | "expired" | "inactive";
    createdBy: string;
    createdAt: Timestamp;
    updatedAt: Timestamp;
}

export interface FollowShopByVendorRequest {
    userId: string;
    shopId: string;
}

export interface FollowShopByStaffRequest {
    userId: string;
    shopId: string;
}

export interface UnfollowShopRequest {
    shopId: string;
}

export interface RemoveFollowerRequest {
    shopId: string;
    userId: string;
    reason?: string;
}

export interface CheckInUserRequest {
    userId: string;
    shopId: string;
}

export interface AddOfferRequest {
    shopId: string;
    name: string;
    description: string;
    startDate: string; // ISO date string
    endDate: string; // ISO date string
}

export interface CheckInResponse {
    success: boolean;
    message: string;
    data?: {
        cumulativeStreak: number;
        consecutiveDays: number;
        bonusApplied: boolean;
        isGiftDay: boolean;
        isNewUser: boolean;
        wasAutoFollowed: boolean;
        giftInfo?: {
            campaignId: string;
            campaignName: string;
            message: string;
        };
    };
    error?: string;
}

export interface ShopFollowApiResponse {
    success: boolean;
    message: string;
    data?: any;
    error?: string;
}

// Shop Follow Error Codes
export const SHOP_FOLLOW_ERROR_CODES = {
  UNAUTHORIZED: "UNAUTHORIZED",
  SHOP_NOT_FOUND: "SHOP_NOT_FOUND",
  SHOP_INACTIVE: "SHOP_INACTIVE",
  ALREADY_FOLLOWING: "ALREADY_FOLLOWING",
  NOT_FOLLOWING: "NOT_FOLLOWING",
  USER_NOT_FOUND: "USER_NOT_FOUND",
  FCM_SUBSCRIPTION_FAILED: "FCM_SUBSCRIPTION_FAILED",
  FCM_UNSUBSCRIPTION_FAILED: "FCM_UNSUBSCRIPTION_FAILED",
  TRANSACTION_FAILED: "TRANSACTION_FAILED",
  INVALID_FCM_TOKEN: "INVALID_FCM_TOKEN",
  FCM_TOKEN_NOT_FOUND: "FCM_TOKEN_NOT_FOUND",
  STAFF_NOT_FOUND: "STAFF_NOT_FOUND",
  STAFF_NOT_ACTIVE: "STAFF_NOT_ACTIVE",
  NOT_SHOP_OWNER: "NOT_SHOP_OWNER",
  ALREADY_CHECKED_IN_TODAY: "ALREADY_CHECKED_IN_TODAY",
  OFFER_INVALID_DATES: "OFFER_INVALID_DATES",
  SCANNER_NOT_AUTHORIZED: "SCANNER_NOT_AUTHORIZED",
} as const;

export type ShopFollowErrorCode = typeof SHOP_FOLLOW_ERROR_CODES[keyof typeof SHOP_FOLLOW_ERROR_CODES];

// User Account Management Types
export interface DeleteAccountResponse {
    success: boolean;
    message: string;
}

// Account Error Codes
export const ACCOUNT_ERROR_CODES = {
  UNAUTHORIZED: "UNAUTHORIZED",
  USER_NOT_FOUND: "USER_NOT_FOUND",
  DELETION_FAILED: "DELETION_FAILED",
  REQUEST_FAILED: "REQUEST_FAILED",
  CANCEL_FAILED: "CANCEL_FAILED",
} as const;

export type AccountErrorCode = typeof ACCOUNT_ERROR_CODES[keyof typeof ACCOUNT_ERROR_CODES];

// Soft-delete account deletion request types
export type AccountDeletionStatus = "pending" | "processing" | "completed" | "cancelled";

export interface AccountDeletionRequest {
    userId: string;
    requestedAt: Timestamp | FieldValue;
    status: AccountDeletionStatus;
    processedAt: Timestamp | FieldValue | null;
    processedBy: string | null;
    reason: string | null;
}

export interface RequestAccountDeletionResponse {
    success: boolean;
}

export interface CancelAccountDeletionResponse {
    success: boolean;
}

