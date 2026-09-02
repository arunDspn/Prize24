import 'package:freezed_annotation/freezed_annotation.dart';
part 'gift_model.freezed.dart';

@freezed
abstract class GiftModel with _$GiftModel {
  const factory GiftModel({
    required String? id,
    required String name,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String campaignId,
    required String campaignName,
    required int totalQuantity,
    required int remainingQuantity,
    required String giftType, // 'auto' or 'code'
    required bool isRedeemable,
    required String userId, // Creator's user ID

    // For public campaigns only - URL-friendly identifier for the gift
    String? publicgSlug,

    // For CODE type gifts only - contains all the gift codes
    // Sub collection of GiftCodeModel
    // List<GiftCodeModel>? giftCodes,

    // For REDEEMABLE gifts only (both auto and code types)
    // Contains shops where this gift can be redeemed
    // Array of SupportedShopModel
    List<SupportedShopModel>? supportedShops,

    // For NON-REDEEMABLE gifts only (both auto and code types)
    // For auto: contains payloads for each gift quantity
    // For code: contains payloads paired with each code
    // Sub collection of GiftPayloadModel
    // List<GiftPayloadModel>? giftPayloads,
  }) = _GiftModel;

  // Default constructor
  const GiftModel._();

  /// Validates that the gift model has the correct field combinations
  /// based on gift type and redeemability
  // bool get isValid {
  //   switch (giftType.toLowerCase()) {
  //     case 'auto':
  //       if (isRedeemable) {
  //         // Auto + Redeemable: needs shops, no codes or payloads
  //         return supportedShops != null && supportedShops!.isNotEmpty;
  //         //  &&
  //         // giftCodes == null &&
  //         // giftPayloads == null
  //         // ;
  //       } else {
  //         // Auto + Non-redeemable: needs payloads, no codes or shops
  //         return
  //             // giftPayloads != null &&
  //             //     giftPayloads!.isNotEmpty &&
  //             //     giftCodes == null &&
  //             supportedShops == null;
  //       }
  //     case 'code':
  //       if (isRedeemable) {
  //         // Code + Redeemable: needs codes and shops, no payloads
  //         return
  //             // giftCodes != null &&
  //             //     giftCodes!.isNotEmpty &&
  //             supportedShops != null;
  //         // &&
  //         // supportedShops!.isNotEmpty
  //         // &&
  //         // giftPayloads == null;
  //       } else {
  //         // Code + Non-redeemable: needs codes and payloads, no shops
  //         return
  //             // giftCodes != null &&
  //             // giftCodes!.isNotEmpty &&
  //             // giftPayloads != null &&
  //             // giftPayloads!.isNotEmpty &&
  //             supportedShops == null;
  //       }
  //     default:
  //       return false;
  //   }
  // }

  /// Returns a human-readable description of what fields should be populated
  String get expectedFieldsDescription {
    switch (giftType.toLowerCase()) {
      case 'auto':
        if (isRedeemable) {
          return 'Auto + Redeemable: requires supportedShops';
        } else {
          return 'Auto + Non-redeemable: requires giftPayloads';
        }
      case 'code':
        if (isRedeemable) {
          return 'Code + Redeemable: requires giftCodes + supportedShops';
        } else {
          return 'Code + Non-redeemable: requires giftCodes + giftPayloads';
        }
      default:
        return 'Unknown gift type';
    }
  }
}

/// Code sub collection only for CODE type gifts
/// Both redeemable and non-redeemable
/// Code Sub collection inside GiftModel
// @freezed
// abstract class GiftCodeModel with _$GiftCodeModel {
//   const factory GiftCodeModel({
//     required String? id,
//     required String code,
//     required bool isRedeemed,
//     required String? payload,
//     String? redeemedByUserId,
//   }) = _GiftCodeModel;
// }

@freezed
abstract class CodeGiftCodeModel with _$CodeGiftCodeModel {
  const factory CodeGiftCodeModel({
    required String? id,
    required String code,
    required bool isRedeemed,
    required String? payload,
    String? redeemedByUserId,
  }) = _CodeGiftCodeModel;

  /// Converts the CodeGiftCodeModel to a JSON map
}

/// Payload for auto gifts ONLY
/// Used as sub collection inside GiftModel
// @freezed
// abstract class GiftPayloadModel with _$GiftPayloadModel {
//   const factory GiftPayloadModel({
//     required String? id,
//     required String content,
//     // Optional fields
//     DateTime? redeemedAt,
//     String? redeemedByUserId,
//   }) = _GiftPayloadModel;
// }

@freezed
abstract class AutoGiftPayloadModel with _$AutoGiftPayloadModel {
  const factory AutoGiftPayloadModel({
    required String? id,
    required String content,
    // Optional fields
    DateTime? redeemedAt,
    String? redeemedByUserId,
  }) = _AutoGiftPayloadModel;
}

/// Supported shops for redeemable gifts
/// Used as an array inside GiftModel
@freezed
abstract class SupportedShopModel with _$SupportedShopModel {
  const factory SupportedShopModel({
    required String id,
    required String name,
    required String shopAddress,
    required String shopPhone,
    String? shopEmail, // Made optional to match ShopModel
    String? shopWebsite, // Made optional for better compatibility
  }) = _SupportedShopModel;
}
