import 'package:prize24_app/features/campaign/data/dto/campaign_activity_log_dto.dart';
import 'package:prize24_app/features/campaign/data/dto/campaign_dto.dart';
import 'package:prize24_app/features/campaign/data/dto/campaign_shared_vendor_dto.dart';
import 'package:prize24_app/features/campaign/data/dto/campaign_sharing_request_dto.dart';
import 'package:prize24_app/features/campaign/data/dto/gift_redemption_audit_log_dto.dart';
import 'package:prize24_app/features/campaign/data/services/firebase_campaign_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'i_campaign_services.g.dart';

abstract class ICampaignService {
  Future<CampaignDto> addCampaign({required CampaignDto campaign});

  // Edit
  Future<void> editCampaign({
    required String campaignId,
    required String? name,
    required String? description,
    required int? totalParticipants,
    required int? totalGifts,
  });

  // Delete
  Future<void> deleteCampaign({required String campaignId});

  /// Used to scan customers QR code to get the gifts
  /// Can be only used by the vendor and staffs under the shop
  Future<void> scanCampaignForGifts({
    required String campaignId,
    required String userId,
  });

  /// List all campaigns for a specific vendor
  Future<List<CampaignDto>> listVendorAllCampaigns({
    /// Vendor ID
    required String userId,

    // Todo: Workaround for shared campaigns
    required String vendorName,
    required String vendorPhone,
  });

  /// Get Single Campaigns by Campaign ID
  Future<CampaignDto> getSingleCampaginById({required String campaignId});

  /// Share Campaign -------------------

  ///
  Future<void> addVendorsToCampaign({
    required String campaignId,
    required List<String> recipientIds,
  });

  /// Add Single Vendor to Campaign
  /// Used when a vendor accepts a shared campaign request
  Future<void> addVendorToCampaign({
    required String recipientId,
    required String campaignId,
  });

  /// Respond to a shared campaign request
  Future<void> respondToSharedCampaignRequest({
    required String requestId,
    required String action,
  });

  Future<List<CampaignSharedVendorDto>> listSharedVendorsOfCampaign({
    required String campaignId,
  });

  /// List Campaign Sharing Requests
  /// Used by Vendor to list all incoming sharing requests
  Future<(List<CampaignSharingRequestDto>, Object?)>
  listCampaignSharingRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  });

  // Get IDS of user's to whom the campaign share request is already sent
  Future<List<String>> listUserIdsOfAlreadySendRequest({
    required String campaignId,
  });

  /// Check if campaign public slug is available
  Future<bool> isCampaignPublicSlugAvailable({required String publicSlug});

  /// Audit log for campaign Gift Redemption
  Future<(List<GiftRedemptionAuditLogDto>, Object?)>
  getCampaignGiftRedemptionAuditLog({
    required String campaignId,
    Object? cursor,
    int limit = 10,
  });

  /// Get Activity log for campaign.
  /// When [userId] is provided, results are scoped to logs for that customer.
  Future<(List<CampaignActivityLogDto>, Object?)> getCampaignActivityLog({
    required String campaignId,
    String? userId,
    Object? cursor,
    int limit = 10,
  });
}

@Riverpod(keepAlive: true)
ICampaignService couponService(Ref ref) {
  return FirebaseCampaignService();
}
