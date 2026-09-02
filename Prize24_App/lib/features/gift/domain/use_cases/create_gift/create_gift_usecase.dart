import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/gift/data/repository/i_gift_repository.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_gift_usecase.g.dart';

@riverpod
CreateGiftUsecase createGiftUsecase(Ref ref) {
  final giftRepository = ref.watch(giftRepositoryProvider);
  return CreateGiftUsecase(giftRepository: giftRepository);
}

@riverpod
Future<GiftModel> createAutoRedeemableGift(
  Ref ref, {
  required GiftModel gift,
}) {
  final usecase = ref.read(createGiftUsecaseProvider);
  return usecase.createAutoRedeemableGift(gift: gift);
}

@riverpod
Future<GiftModel> createAutoNonRedeemableGift(
  Ref ref, {
  required GiftModel gift,
  required List<AutoGiftPayloadModel> autoGiftPayloads,
}) {
  final usecase = ref.read(createGiftUsecaseProvider);
  return usecase.createAutoNonRedeemableGift(
    gift: gift,
    autoGiftPayloads: autoGiftPayloads,
  );
}

@riverpod
Future<GiftModel> createCodeGift(
  Ref ref, {
  required GiftModel gift,
  required List<CodeGiftCodeModel> codeGiftCodes,
}) {
  final usecase = ref.read(createGiftUsecaseProvider);
  return usecase.createCodeGift(
    gift: gift,
    codeGiftCodes: codeGiftCodes,
  );
}

/// Use case for creating a new gift
class CreateGiftUsecase {
  CreateGiftUsecase({
    required IGiftRepository giftRepository,
  }) : _giftRepository = giftRepository;

  final IGiftRepository _giftRepository;

  /// Creates a new auto redeemable gift with validation
  ///
  /// [gift]: The gift model containing all required information
  /// Returns the created [GiftModel] with generated ID
  /// Throws an exception if validation fails or creation fails
  Future<GiftModel> createAutoRedeemableGift({
    required GiftModel gift,
  }) async {
    try {
      // Validation
      _validateGift(gift);
      _validateAutoRedeemableGift(gift);

      // Set creation timestamps
      final giftWithTimestamps = gift.copyWith(
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        remainingQuantity: gift.totalQuantity, // Initially same as total
      );

      // Call repository to create auto redeemable gift
      final createdGift = await _giftRepository.createAutoRedeemableGift(
        gift: giftWithTimestamps,
      );

      return createdGift;
    } catch (e) {
      throw Exception('Failed to create auto redeemable gift: $e');
    }
  }

  /// Creates a new auto non-redeemable gift with validation
  ///
  /// [gift]: The gift model containing all required information
  /// [autoGiftPayloads]: List of payloads for the auto gift
  /// Returns the created [GiftModel] with generated ID
  /// Throws an exception if validation fails or creation fails
  Future<GiftModel> createAutoNonRedeemableGift({
    required GiftModel gift,
    required List<AutoGiftPayloadModel> autoGiftPayloads,
  }) async {
    try {
      // Validation
      _validateGift(gift);
      _validateAutoNonRedeemableGift(gift);

      if (autoGiftPayloads.length != gift.totalQuantity) {
        throw Exception(
            'Number of payloads must match total quantity for auto gifts');
      }

      // Validate each payload
      for (int i = 0; i < autoGiftPayloads.length; i++) {
        final payload = autoGiftPayloads[i];
        if (payload.content.trim().isEmpty) {
          throw Exception('Payload ${i + 1} content cannot be empty');
        }
        if (payload.content.length < 10) {
          throw Exception(
              'Payload ${i + 1} must be at least 10 characters long');
        }
      }

      // Set creation timestamps
      final giftWithTimestamps = gift.copyWith(
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        remainingQuantity: gift.totalQuantity, // Initially same as total
      );

      // Call repository to create auto non-redeemable gift
      final createdGift = await _giftRepository.createAutoNonRedeemableGift(
        gift: giftWithTimestamps,
        autoGiftPayloads: autoGiftPayloads,
      );

      return createdGift;
    } catch (e) {
      throw Exception('Failed to create auto non-redeemable gift: $e');
    }
  }

  /// Creates a new code gift (redeemable or non-redeemable) with validation
  ///
  /// [gift]: The gift model containing all required information
  /// [codeGiftCodes]: List of codes for the code gift
  /// Returns the created [GiftModel] with generated ID
  /// Throws an exception if validation fails or creation fails
  Future<GiftModel> createCodeGift({
    required GiftModel gift,
    required List<CodeGiftCodeModel> codeGiftCodes,
  }) async {
    try {
      // Validation
      _validateGift(gift);

      if (gift.isRedeemable) {
        _validateCodeRedeemableGift(gift);
      } else {
        _validateCodeNonRedeemableGift(gift);
      }

      if (codeGiftCodes.length != gift.totalQuantity) {
        throw Exception('Total quantity must match number of gift codes');
      }

      // Validate codes
      _validateGiftCodes(codeGiftCodes);

      // Set creation timestamps
      final giftWithTimestamps = gift.copyWith(
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        remainingQuantity: gift.totalQuantity, // Initially same as total
      );

      // Call repository to create code gift
      final createdGift = await _giftRepository.createCodeGift(
        gift: giftWithTimestamps,
        codeGiftCodes: codeGiftCodes,
      );

      return createdGift;
    } catch (e) {
      throw Exception('Failed to create code gift: $e');
    }
  }

  /// Legacy method for backward compatibility
  /// Automatically routes to appropriate creation method based on gift type and redeemability
  @Deprecated('Use specific creation methods instead')
  Future<GiftModel> call({
    required GiftModel gift,
  }) async {
    throw Exception(
        'Legacy createGift method is deprecated. Use specific methods: '
        'createAutoRedeemableGift, createAutoNonRedeemableGift, or createCodeGift');
  }

  /// Validates the gift model before creation
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

    if (gift.campaignName.trim().isEmpty) {
      throw Exception('Campaign name cannot be empty');
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
  }

  void _validateAutoRedeemableGift(GiftModel gift) {
    if (gift.supportedShops == null || gift.supportedShops!.isEmpty) {
      throw Exception(
          'Auto redeemable gifts must have at least one supported shop');
    }

    // Validate each shop
    for (final shop in gift.supportedShops!) {
      if (shop.name.trim().isEmpty) {
        throw Exception('Shop name cannot be empty');
      }
      if (shop.shopAddress.trim().isEmpty) {
        throw Exception('Shop address cannot be empty');
      }
      if (shop.shopPhone.trim().isEmpty) {
        throw Exception('Shop phone cannot be empty');
      }
    }
  }

  void _validateAutoNonRedeemableGift(GiftModel gift) {
    // For auto non-redeemable gifts, we expect payloads to be passed separately
    // So we just validate that the gift is set up correctly for auto non-redeemable
    if (gift.supportedShops != null && gift.supportedShops!.isNotEmpty) {
      throw Exception(
          'Auto non-redeemable gifts should not have supported shops');
    }
  }

  void _validateCodeRedeemableGift(GiftModel gift) {
    if (gift.supportedShops == null || gift.supportedShops!.isEmpty) {
      throw Exception(
          'Code redeemable gifts must have at least one supported shop');
    }

    // Validate each shop
    for (final shop in gift.supportedShops!) {
      if (shop.name.trim().isEmpty) {
        throw Exception('Shop name cannot be empty');
      }
      if (shop.shopAddress.trim().isEmpty) {
        throw Exception('Shop address cannot be empty');
      }
      if (shop.shopPhone.trim().isEmpty) {
        throw Exception('Shop phone cannot be empty');
      }
    }
  }

  void _validateCodeNonRedeemableGift(GiftModel gift) {
    // For code non-redeemable gifts, we expect codes to be passed separately
    // So we just validate that the gift is set up correctly for code non-redeemable
    if (gift.supportedShops != null && gift.supportedShops!.isNotEmpty) {
      throw Exception(
          'Code non-redeemable gifts should not have supported shops');
    }
  }

  void _validateGiftCodes(List<CodeGiftCodeModel> codes) {
    final Set<String> uniqueCodes = {};

    for (int i = 0; i < codes.length; i++) {
      final code = codes[i];

      if (code.code.trim().isEmpty) {
        throw Exception('Gift code ${i + 1} cannot be empty');
      }

      if (uniqueCodes.contains(code.code)) {
        throw Exception('Duplicate gift code found: ${code.code}');
      }

      uniqueCodes.add(code.code);
    }
  }
}
