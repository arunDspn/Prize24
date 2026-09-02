import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/campaign/data/dto/campaign_dto.dart';
import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:prize24_app/features/campaign/data/services/i_campaign_services.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_activity_log.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_sharing_request_model.dart';
import 'package:prize24_app/features/campaign/domain/models/gift_redemption_audit_log_model.dart';

class CampaginRepository implements ICampaignRepository {
  CampaginRepository({required ICampaignService campaignService})
    : _campaignService = campaignService;

  final ICampaignService _campaignService;

  @override
  Future<CampaignModel> addCampaign({required CampaignModel campaign}) async {
    try {
      final dto = await _campaignService.addCampaign(
        campaign: CampaignDto.fromModel(campaign),
      );
      return dto.toModel();
    } on Exception catch (e) {
      // Handle any specific errors or rethrow
      throw Exception('Failed to add campaign: $e');
    }
  }

  @override
  Future<void> deleteCampaign({required String campaignId}) async {
    try {
      await _campaignService.deleteCampaign(campaignId: campaignId);
    } on Exception catch (e) {
      // Handle any specific errors or rethrow
      throw Exception('Failed to delete campaign: $e');
    }
  }

  @override
  Future<void> editCampaign({
    required String campaignId,
    required String? title,
    required String? description,
    required int? totalParticipants,
    required int? totalGifts,
  }) async {
    try {
      await _campaignService.editCampaign(
        campaignId: campaignId,
        name: title,
        description: description,
        totalParticipants: totalParticipants,
        totalGifts: totalGifts,
      );
    } catch (e) {
      // Handle any specific errors or rethrow
      throw Exception('Failed to edit campaign: $e');
    }
  }

  @override
  Future<List<CampaignModel>> listVendorsAllCampaigns({
    required String userId,

    // Todo: Workaround for shared campaigns
    required String vendorName,
    required String vendorPhone,
  }) async {
    try {
      final dtos = await _campaignService.listVendorAllCampaigns(
        userId: userId,
        vendorName: vendorName,
        vendorPhone: vendorPhone,
      );
      return dtos.map((dto) => dto.toModel()).toList();
    } catch (e) {
      // Handle any specific errors or rethrow
      throw Exception('Failed to list vendor campaigns: $e');
    }
  }

  @override
  Future<void> scanCustomerQrCode({
    required String userId,
    required String campaignId,
  }) async {
    try {
      await _campaignService.scanCampaignForGifts(
        userId: userId,
        campaignId: campaignId,
      );
    } catch (e) {
      // Handle any specific errors or rethrow
      throw Exception('Failed to scan customer QR code: $e');
    }
  }

  @override
  Future<void> shareCampaignToVendors({
    required List<String> recipientIds,
    required String campaignId,
  }) async {
    // try {
    //   await _campaignService.addVendorsToCampaign(
    //     campaignId: campaignId,
    //     vendorIds: recipientIds,
    //   );
    // } catch (e) {
    //   // Handle any specific errors or rethrow
    //   throw Exception('Failed to add shared vendor to campaign: $e');
    // }
    throw UnimplementedError();
  }

  @override
  Future<PaginatedResult<CampaignSharingRequestModel>>
  listCampaignSharingRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  }) async {
    try {
      final (dtos, lastDoc) = await _campaignService
          .listCampaignSharingRequests(
            vendorId: vendorId,
            cursor: cursor,
            limit: limit,
          );
      return PaginatedResult(
        items: dtos.map((dto) => dto.toModel()).toList(),
        cursor: lastDoc,
        hasMore: lastDoc != null,
      );
    } catch (e) {
      throw Exception('Failed to list campaign sharing requests: $e');
    }
  }

  @override
  Future<void> respondToSharedCampaignRequest({
    required String requestId,
    required String action,
  }) async {
    try {
      await _campaignService.respondToSharedCampaignRequest(
        requestId: requestId,
        action: action,
      );
    } catch (e) {
      // Handle any specific errors or rethrow
      throw Exception('Failed to respond to shared campaign request: $e');
    }
  }

  @override
  Future<void> shareCampaignToVendor({
    required String recipientId,
    required String campaignId,
  }) async {
    try {
      await _campaignService.addVendorToCampaign(
        recipientId: recipientId,
        campaignId: campaignId,
      );
    } catch (e) {
      // Handle any specific errors or rethrow
      throw Exception('Failed to share campaign to vendor: $e');
    }
  }

  @override
  Future<bool> isCampaignPublicSlugAvailable({
    required String publicSlug,
  }) async {
    return _campaignService.isCampaignPublicSlugAvailable(
      publicSlug: publicSlug,
    );
  }

  @override
  Future<List<String>> listUserIdsOfAlreadySendRequest({
    required String campaignId,
  }) async {
    return _campaignService.listUserIdsOfAlreadySendRequest(
      campaignId: campaignId,
    );
  }

  @override
  Future<PaginatedResult<GiftRedemptionAuditLogModel>>
  getCampaignGiftRedemptionAuditLog({
    required String campaignId,
    Object? cursor,
    int limit = 10,
  }) async {
    final (dtos, nextCursor) = await _campaignService
        .getCampaignGiftRedemptionAuditLog(
          campaignId: campaignId,
          cursor: cursor,
          limit: limit,
        );
    final models = dtos.map((dto) => dto.toModel()).toList();
    return PaginatedResult(
      items: models,
      cursor: nextCursor,
      hasMore: nextCursor != null,
    );
  }

  @override
  Future<PaginatedResult<CampaignActivityLogEntry>> getCampaignActivityLogs({
    required String campaignId,
    String? userId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, nextCursor) = await _campaignService.getCampaignActivityLog(
      campaignId: campaignId,
      userId: userId,
      cursor: cursor,
      limit: limit,
    );
    final models = dtos
        .map(
          (dto) => dto.toEntry(
            timestampConverter: (ts) =>
                ts is DateTime ? ts : (ts as Timestamp).toDate(),
          ),
        )
        .toList();
    return PaginatedResult(
      items: models,
      cursor: nextCursor,
      hasMore: nextCursor != null,
    );
  }

  @override
  Future<CampaignModel> getSingleCampaginById({
    required String campaignId,
  }) async {
    final dtos = await _campaignService.getSingleCampaginById(
      campaignId: campaignId,
    );
    return dtos.toModel();
  }
}
