import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_campaign_usecase.g.dart';

@riverpod
CreateCampaignUsecase createCampaignUsecase(Ref ref) {
  final campaignRepository = ref.watch(campaignRepositoryProvider);
  return CreateCampaignUsecase(campaignRepository: campaignRepository);
}

/// Use case for creating a new campaign
class CreateCampaignUsecase {
  CreateCampaignUsecase({
    required ICampaignRepository campaignRepository,
  }) : _campaignRepository = campaignRepository;

  final ICampaignRepository _campaignRepository;

  /// Creates a new campaign with validation
  ///
  /// [campaign]: The campaign model containing all required information
  /// Returns the created [CampaignModel] with generated ID
  /// Throws an exception if validation fails or creation fails
  Future<CampaignModel> call({
    required CampaignModel campaign,
  }) async {
    try {
      // Validation
      _validateCampaign(campaign);

      // Call repository to add campaign
      final createdCampaign = await _campaignRepository.addCampaign(
        campaign: campaign,
      );

      return createdCampaign;
    } catch (e) {
      throw Exception('Failed to create campaign: $e');
    }
  }

  /// Validates the campaign model before creation
  void _validateCampaign(CampaignModel campaign) {
    if (campaign.name.trim().isEmpty) {
      throw Exception('Campaign title cannot be empty');
    }

    if (campaign.description.trim().isEmpty) {
      throw Exception('Campaign description cannot be empty');
    }

    if (campaign.vendorId.trim().isEmpty) {
      throw Exception('Vendor ID cannot be empty');
    }

    if (campaign.vendorName.trim().isEmpty) {
      throw Exception('Vendor name cannot be empty');
    }

    if (campaign.totalParticipants <= 0) {
      throw Exception('Total participants must be greater than 0');
    }

    if (campaign.totalGifts <= 0) {
      throw Exception('Total gifts must be greater than 0');
    }

    if (campaign.totalGifts > campaign.totalParticipants) {
      throw Exception('Total gifts cannot exceed total participants');
    }

    // Validate public slug for public campaigns
    if (campaign.visibility == CampaignVisibility.public) {
      if (campaign.publicSlug == null || campaign.publicSlug!.trim().isEmpty) {
        throw Exception('Public slug is required for public campaigns');
      }

      final slug = campaign.publicSlug!.trim();
      if (!RegExp(r'^[a-z0-9-]+$').hasMatch(slug)) {
        throw Exception(
            'Public slug can only contain lowercase letters, numbers, and hyphens');
      }

      if (slug.startsWith('-') || slug.endsWith('-')) {
        throw Exception('Public slug cannot start or end with a hyphen');
      }

      if (slug.contains('--')) {
        throw Exception('Public slug cannot contain consecutive hyphens');
      }

      if (slug.length < 3) {
        throw Exception('Public slug must be at least 3 characters long');
      }

      if (slug.length > 50) {
        throw Exception('Public slug must be at most 50 characters long');
      }
    }
  }
}
