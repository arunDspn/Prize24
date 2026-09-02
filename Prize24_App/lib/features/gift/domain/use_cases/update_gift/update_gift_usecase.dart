import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/gift/data/repository/i_gift_repository.dart';
import 'package:prize24_app/features/gift/data/repository/gift_repository.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_gift_usecase.g.dart';

@riverpod
UpdateGiftUsecase updateGiftUsecase(Ref ref) {
  final giftRepository = ref.watch(giftRepositoryProvider);
  return UpdateGiftUsecase(giftRepository: giftRepository);
}

/// Use case for updating an existing gift
class UpdateGiftUsecase {
  UpdateGiftUsecase({
    required IGiftRepository giftRepository,
  }) : _giftRepository = giftRepository;

  final IGiftRepository _giftRepository;

  /// Updates an existing gift with validation
  ///
  /// [gift]: The gift model containing updated information
  /// Returns the updated [GiftModel]
  /// Throws an exception if validation fails or update fails
  Future<GiftModel> call({
    required GiftModel gift,
  }) async {
    try {
      // Validation
      _validateGift(gift);

      // Ensure ID exists for update
      if (gift.id == null || gift.id!.trim().isEmpty) {
        throw Exception('Gift ID is required for update');
      }

      // Set update timestamp
      final giftWithTimestamp = gift.copyWith(
        updatedAt: DateTime.now(),
      );

      // Call repository to update gift
      final updatedGift = await _giftRepository.updateGift(
        gift: giftWithTimestamp,
      );

      return updatedGift;
    } catch (e) {
      throw Exception('Failed to update gift: $e');
    }
  }

  /// Validates the gift model before update
  void _validateGift(GiftModel gift) {
    // Basic field validation
    if (gift.name.trim().isEmpty) {
      throw Exception('Gift name cannot be empty');
    }

    if (gift.name.length > 100) {
      throw Exception('Gift name cannot exceed 100 characters');
    }

    if (gift.description.trim().isEmpty) {
      throw Exception('Gift description cannot be empty');
    }

    if (gift.description.length > 500) {
      throw Exception('Gift description cannot exceed 500 characters');
    }

    if (gift.campaignId.trim().isEmpty) {
      throw Exception('Campaign ID cannot be empty');
    }

    if (gift.totalQuantity <= 0) {
      throw Exception('Total quantity must be greater than 0');
    }

    if (gift.totalQuantity > 10000) {
      throw Exception('Total quantity cannot exceed 10,000');
    }

    // Gift type validation
    if (!['auto', 'code'].contains(gift.giftType.toLowerCase())) {
      throw Exception('Gift type must be either "auto" or "code"');
    }

    // Use the model's validation method
    // if (!gift.isValid) {
    //   throw Exception(
    //       'Invalid gift configuration: ${gift.expectedFieldsDescription}');
    // }

    // Validate remaining quantity doesn't exceed total
    if (gift.remainingQuantity > gift.totalQuantity) {
      throw Exception('Remaining quantity cannot exceed total quantity');
    }

    if (gift.remainingQuantity < 0) {
      throw Exception('Remaining quantity cannot be negative');
    }
  }
}
