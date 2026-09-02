import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/gift/data/dto/gift_analytics_dto.dart';
import 'package:prize24_app/features/gift/data/dto/gift_dto.dart';
import 'package:prize24_app/features/gift/data/dto/user_gift_dto.dart';
import 'package:prize24_app/features/gift/data/service/firebase_gift_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'i_gift_service.g.dart';

abstract class IGiftService {
  /// Fetches all gifts that availed by the user.
  /// Used to show the list of gifts in the user Home.
  Future<(List<UserGiftDto>, Object?)> fetchUsersAllGifts({
    required String userId,
    Object? cursor,
    int limit = 20,
  });

  /// Fetches all gifts that are under a campaign.
  /// Used to show the list of gifts in the campaign detail page.
  Future<List<GiftDto>> fetchCampaignGifts({
    required String campaignId,
    int? page,
    int? limit,
  });

  /// Used by vendor to redeem a availed gift for a user.
  Future<void> redeemGift({
    required String availedgiftId,
    required String userId,
  });

  /// Used by vendor to create a gifts for a campaign.
  /// This is used to create a gift that can be redeemed by users.
  // Future<GiftDto> createGift({
  // required String userId,

  // /// Gift type -> Auto Gift, Code Gift
  // required String giftType,
  // required bool isRedeemable,
  // required String campaignId,

  // /// Only required for Code Gift.
  // List<GiftCode>? giftCodes,

  // /// Only required for Redeemable Gift.
  // List<SupportedShop>? supportedShops,

  // /// Only required for Non Redeemable Gift.
  // List<GiftPayload>? giftPayloads,

  //   required GiftDto giftDto,
  // });

  /// Creates a new gift of type AUTO which are non-redeemable
  Future<GiftDto> createAutoNonRedeemableGift({
    required GiftDto giftDto,
    required List<AutoGiftPayloadDto> autoGiftPayloadDtos,
  });

  /// Creates a new gift of type AUTO which are redeemable
  Future<GiftDto> createAutoRedeemableGift({required GiftDto giftDto});

  /// Deletes an existing gift createAutoRedeemableGift
  Future<String> deleteAutoRedeemableGift({
    required String campaignId,
    required String giftId,
  });

  /// Edit an existing gift
  Future<GiftDto> editGift({required GiftDto giftDto});

  /// Creates a new gift of type CODE
  /// Which can be redeemable or non-redeemable
  /// If redeemable, it should have supported shops inside as array
  Future<GiftDto> createCodeGift({
    required GiftDto giftDto,
    required List<CodeGiftCodeDto> codeGiftCodes,
  });

  Future<GiftAnalyticsDto> getGiftAnalytics({required String giftId});
}

@Riverpod(keepAlive: true)
IGiftService giftService(Ref ref) {
  return FirebaseGiftService();
}
