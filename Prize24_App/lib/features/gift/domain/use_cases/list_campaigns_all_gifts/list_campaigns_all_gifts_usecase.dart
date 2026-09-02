import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/gift/data/repository/i_gift_repository.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_campaigns_all_gifts_usecase.g.dart';

@riverpod
ListCampaignsAllGiftsUsecase listCampaignsAllGiftsUsecase(Ref ref) {
  final giftRepository = ref.watch(giftRepositoryProvider);
  return ListCampaignsAllGiftsUsecase(giftRepository: giftRepository);
}

/// Use case for fetching all gifts under a given campaign
class ListCampaignsAllGiftsUsecase {
  ListCampaignsAllGiftsUsecase({
    required IGiftRepository giftRepository,
  }) : _giftRepository = giftRepository;

  final IGiftRepository _giftRepository;

  /// Fetches all gifts that belong to a specific campaign
  ///
  /// [campaignId]: The ID of the campaign to fetch gifts for
  /// [page]: Optional page number for pagination (starts from 0)
  /// [limit]: Optional limit for number of gifts per page
  /// Returns a list of [GiftModel] objects for the specified campaign
  /// Throws an exception if the campaign ID is invalid or if the fetch fails
  Future<List<GiftModel>> call({
    required String campaignId,
    int? page,
    int? limit,
  }) async {
    try {
      // Validate campaign ID
      _validateCampaignId(campaignId);

      // Validate pagination parameters if provided
      _validatePaginationParams(page, limit);

      // Fetch campaign gifts from repository
      final gifts = await _giftRepository.fetchCampaignGifts(
        campaignId: campaignId,
        page: page,
        limit: limit,
      );

      return gifts;
    } catch (e) {
      throw Exception('Failed to fetch campaign gifts: $e');
    }
  }

  /// Validates the campaign ID parameter
  void _validateCampaignId(String campaignId) {
    if (campaignId.trim().isEmpty) {
      throw Exception('Campaign ID cannot be empty');
    }

    // Additional validation could be added here (e.g., format validation)
    if (campaignId.length < 3) {
      throw Exception('Campaign ID must be at least 3 characters long');
    }
  }

  /// Validates pagination parameters
  void _validatePaginationParams(int? page, int? limit) {
    if (page != null && page < 0) {
      throw Exception('Page number cannot be negative');
    }

    if (limit != null && limit <= 0) {
      throw Exception('Limit must be greater than 0');
    }

    if (limit != null && limit > 1000) {
      throw Exception('Limit cannot exceed 1000 items per page');
    }
  }
}
