import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/gift/data/repository/gift_repository.dart';
import 'package:prize24_app/features/gift/data/service/i_gift_service.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'i_gift_repository.g.dart';

abstract class IGiftRepository {
  Future<PaginatedResult<UserGiftModel>> fetchUsersAllGifts({
    required String userId,
    Object? cursor,
    int limit = 20,
  });

  /// Fetches all gifts that are under a campaign.
  /// Used to show the list of gifts in the campaign detail page.
  Future<List<GiftModel>> fetchCampaignGifts({
    required String campaignId,
    int? page,
    int? limit,
  });

  Future<GiftModel> redeemGift({
    required String giftId,
    required String userId,
  });

  /// Creates a new gift
  // Future<GiftModel> createGift({
  //   required GiftModel gift,
  // });

  /// Creates a new gift of type AUTO which are non-redeemable
  Future<GiftModel> createAutoNonRedeemableGift({
    required GiftModel gift,
    required List<AutoGiftPayloadModel> autoGiftPayloads,
  });

  /// Creates a new gift of type AUTO which are redeemable
  Future<GiftModel> createAutoRedeemableGift({required GiftModel gift});

  /// Deletes an existing gift createAutoRedeemableGift
  Future<String> deleteAutoRedeemableGift({
    required String campaignId,
    required String giftId,
  });

  /// Edit an existing gift
  Future<GiftModel> editGift({required GiftModel gift});

  /// Creates a new gift of type CODE
  /// Which can be redeemable or non-redeemable
  /// If redeemable, it should have supported shops inside as array
  Future<GiftModel> createCodeGift({
    required GiftModel gift,
    required List<CodeGiftCodeModel> codeGiftCodes,
  });

  /// Updates an existing gift
  Future<GiftModel> updateGift({required GiftModel gift});

  /// Deletes a gift
  Future<void> deleteGift({required String giftId, required String userId});
}

@Riverpod(keepAlive: true)
IGiftRepository giftRepository(Ref ref) {
  return GiftRepository(giftService: ref.read(giftServiceProvider));
}
