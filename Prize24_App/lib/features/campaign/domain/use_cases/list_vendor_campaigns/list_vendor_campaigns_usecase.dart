import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'list_vendor_campaigns_usecase.g.dart';

@riverpod
ListVendorCampaignsUsecase listVendorCampaignsUsecase(Ref ref) {
  final campaignRepository = ref.watch(campaignRepositoryProvider);
  return ListVendorCampaignsUsecase(campaignRepository: campaignRepository);
}

/// Use case for listing all campaigns of a vendor's shop
class ListVendorCampaignsUsecase {
  ListVendorCampaignsUsecase({
    required ICampaignRepository campaignRepository,
  }) : _campaignRepository = campaignRepository;

  final ICampaignRepository _campaignRepository;

  /// Lists all campaigns for a vendor's shop with validation
  ///
  /// [userId]: The vendor's user ID to fetch campaigns for
  /// Returns a list of [CampaignModel] containing all campaigns for the vendor
  /// This includes campaigns owned by the vendor and campaigns shared with them
  /// Throws an exception if validation fails or fetching fails
  Future<List<CampaignModel>> call({
    required String userId,
    // Todo: Workaround for shared campaigns
    required String vendorName,
    required String vendorPhone,
  }) async {
    try {
      // Validation
      _validateUserId(userId);

      // Call repository to get vendor's campaigns
      final campaigns = await _campaignRepository.listVendorsAllCampaigns(
        userId: userId,
        vendorName: vendorName,
        vendorPhone: vendorPhone,
      );

      return campaigns;
    } catch (e) {
      throw Exception('Failed to list vendor campaigns: $e');
    }
  }

  /// Validates the user ID before fetching campaigns
  void _validateUserId(String userId) {
    if (userId.trim().isEmpty) {
      throw Exception('User ID cannot be empty');
    }
  }
}
