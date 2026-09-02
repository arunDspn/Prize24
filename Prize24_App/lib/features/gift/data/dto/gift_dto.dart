import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
part 'gift_dto.freezed.dart';
part 'gift_dto.g.dart';

@freezed
abstract class GiftDto with _$GiftDto {
  const factory GiftDto({
    /// Name of the gift
    required String name,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,

    /// Campaign ID to which this gift belongs
    required String campaignId,
    required String campaignName,

    /// Total quantity of the gift available
    required int totalQuantity,

    /// Remaining quantity of the gift available
    required int remainingQuantity,

    /// Gift type -> 'auto' or 'code'
    required String giftType,
    required bool isRedeemable,
    required String userId,

    /// Unique identifier for the gift
    @JsonKey(includeIfNull: false) String? id,

    /// For public campaigns only - URL-friendly identifier for the gift
    String? publicSlug,

    /// User ID of the creator of the gift
    // required String userId,

    // Conditional fields based on gift type and redeemability:

    // For CODE type gifts only - contains all the gift codes
    // List<GiftCode>? codegiftCodes,

    // For REDEEMABLE gifts only (both auto and code types)
    // Contains shops where this gift can be redeemed
    List<SupportedShopDto>? supportedShops,

    // For NON-REDEEMABLE gifts only (both auto and code types)
    // For auto: contains payloads for each gift quantity
    // For code: contains payloads paired with each code
    // List<GiftPayload>? autoGiftPayloads,
  }) = _GiftDto;

  // default private constructor
  const GiftDto._();

  factory GiftDto.fromJson(Map<String, dynamic> json) =>
      _$GiftDtoFromJson(json);

  /// Converts to a Map that's safe for Firestore storage
  /// This recursively converts all nested objects to Maps
  Map<String, dynamic> toFirestoreJson() {
    final json = toJson();

    // Convert nested objects to Maps for Firestore compatibility
    return {
      ...json,
      // if (giftCodes != null)
      //   'giftCodes': giftCodes!.map((code) => code.toJson()).toList(),
      if (supportedShops != null)
        'supportedShops': supportedShops!.map((shop) => shop.toJson()).toList(),
      // if (giftPayloads != null)
      //   'giftPayloads':
      //       giftPayloads!.map((payload) => payload.toJson()).toList(),
    };
  }

  factory GiftDto.fromDomainModel(GiftModel model) {
    return GiftDto(
      id: model.id,
      name: model.name,
      description: model.description,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      campaignId: model.campaignId,
      campaignName: model.campaignName,
      totalQuantity: model.totalQuantity,
      remainingQuantity: model.remainingQuantity,
      giftType: model.giftType,
      isRedeemable: model.isRedeemable,
      publicSlug: model.publicgSlug,
      userId: model.userId,
      // userId: model.
      // codegiftCodes: model.giftCodes
      //     ?.map(
      //       (code) => GiftCode(
      //         id: code.id,
      //         code: code.code,
      //         isRedeemed: code.isRedeemed,
      //         redeemedByUserId: code.redeemedByUserId,
      //         payload: code.payload,
      //       ),
      //     )
      //     .toList(),
      supportedShops: model.supportedShops
          ?.map(
            (shop) => SupportedShopDto(
              id: shop.id,
              name: shop.name,
              shopAddress: shop.shopAddress,
              shopPhone: shop.shopPhone,
              shopEmail: shop.shopEmail,
              shopWebsite: shop.shopWebsite,
            ),
          )
          .toList(),
      // autoGiftPayloads: model.giftPayloads
      //     ?.map(
      //       (payload) => GiftPayload(
      //         id: payload.id,
      //         content: payload.content,
      //         redeemedAt: payload.redeemedAt,
      //         redeemedByUserId: payload.redeemedByUserId,
      //       ),
      //     )
      //     .toList(),
    );
  }

  // Default constructor for creating a GiftDto from a GiftModel

  /// Converts this DTO to a domain model
  /// Note: You'll need to import the domain model to use this
  GiftModel toDomainModel() {
    return GiftModel(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      campaignId: campaignId,
      campaignName: campaignName,
      totalQuantity: totalQuantity,
      remainingQuantity: remainingQuantity,
      giftType: giftType,
      isRedeemable: isRedeemable,
      publicgSlug: publicSlug,
      userId: userId,
      // giftCodes: codegiftCodes
      //     ?.map(
      //       (code) => GiftCodeModel(
      //         id: code.id,
      //         code: code.code,
      //         isRedeemed: code.isRedeemed,
      //         redeemedByUserId: code.redeemedByUserId,
      //         payload: code.payload,
      //       ),
      //     )
      //     .toList(),
      supportedShops: supportedShops
          ?.map(
            (shop) => SupportedShopModel(
              id: shop.id,
              name: shop.name,
              shopAddress: shop.shopAddress,
              shopPhone: shop.shopPhone,
              shopEmail: shop.shopEmail,
              shopWebsite: shop.shopWebsite,
            ),
          )
          .toList(),
      // giftPayloads: autoGiftPayloads
      //     ?.map(
      //       (payload) => GiftPayloadModel(
      //         id: payload.id,
      //         content: payload.content,
      //         redeemedAt: payload.redeemedAt,
      //         redeemedByUserId: payload.redeemedByUserId,
      //       ),
      //     )
      //     .toList(),
    );

    // From DOmain Model to DTO
  }
}

/// Used in CODE gift
// @freezed
// abstract class GiftCode with _$GiftCode {
//   const factory GiftCode({
//     @JsonKey(includeIfNull: false) required String? id,
//     required String code,
//     @JsonKey(includeIfNull: false) required String? payload,
//     required bool isRedeemed,
//     String? redeemedByUserId,
//   }) = _GiftCode;

//   factory GiftCode.fromJson(Map<String, dynamic> json) =>
//       _$GiftCodeFromJson(json);
// }

@freezed
abstract class CodeGiftCodeDto with _$CodeGiftCodeDto {
  const factory CodeGiftCodeDto({
    @JsonKey(includeIfNull: false) required String? id,
    required String code,
    @JsonKey(includeIfNull: false) required String? payload,
    required bool isRedeemed,
    String? redeemedByUserId,
  }) = _CodeGiftCodeDto;

  factory CodeGiftCodeDto.fromJson(Map<String, dynamic> json) =>
      _$CodeGiftCodeDtoFromJson(json);

  // private default constructor
  const CodeGiftCodeDto._();

  factory CodeGiftCodeDto.fromDomainModel(CodeGiftCodeModel model) {
    return CodeGiftCodeDto(
      id: model.id,
      code: model.code,
      payload: model.payload,
      isRedeemed: model.isRedeemed,
      redeemedByUserId: model.redeemedByUserId,
    );
  }

  // From Domain Model to DTO
  CodeGiftCodeModel toDomainModel() {
    return CodeGiftCodeModel(
      id: id,
      code: code,
      payload: payload,
      isRedeemed: isRedeemed,
      redeemedByUserId: redeemedByUserId,
    );
  }
}

@freezed
abstract class AutoGiftPayloadDto with _$AutoGiftPayloadDto {
  const factory AutoGiftPayloadDto({
    @JsonKey(includeIfNull: false) required String? id,
    required String content,
    // Optional fields
    DateTime? redeemedAt,
    String? redeemedByUserId,
  }) = _AutoGiftPayloadDto;
  factory AutoGiftPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$AutoGiftPayloadDtoFromJson(json);

  // Private default constructor
  const AutoGiftPayloadDto._();

  factory AutoGiftPayloadDto.fromDomainModel(AutoGiftPayloadModel model) {
    return AutoGiftPayloadDto(
      id: model.id,
      content: model.content,
      redeemedAt: model.redeemedAt,
      redeemedByUserId: model.redeemedByUserId,
    );
  }

  // From Domain Model to DTO
  AutoGiftPayloadModel toDomainModel() {
    return AutoGiftPayloadModel(
      id: id,
      content: content,
      redeemedAt: redeemedAt,
      redeemedByUserId: redeemedByUserId,
    );
  }
}

// /// Used in AUTO gift with isRedeemable = false
// @freezed
// abstract class GiftPayload with _$GiftPayload {
//   const factory GiftPayload({
//     @JsonKey(includeIfNull: false) required String? id,
//     required String content,
//     // Optional fields
//     DateTime? redeemedAt,
//     String? redeemedByUserId,
//   }) = _GiftPayload;

//   factory GiftPayload.fromJson(Map<String, dynamic> json) =>
//       _$GiftPayloadFromJson(json);

//   // Default private constructor
//   const GiftPayload._();

//   // /// Converts to a Map that's safe for Firestore storage
//   // Map<String, dynamic> toFirestoreJson() {
//   //   return {
//   //     'id': id,
//   //     'content': content,
//   //     'redeemedAt': redeemedAt?.toIso8601String(),
//   //     'redeemedByUserId': redeemedByUserId,
//   //   };
//   // }
// }

// @freezed
// abstract class SupportedShop with _$SupportedShop {
//   const factory SupportedShop({
//     required String id,
//     required String name,
//     required String shopAddress,
//     required String shopPhone,
//     String? shopEmail, // Made optional to match domain model
//     String? shopWebsite, // Made optional to match domain model
//   }) = _SupportedShop;

//   factory SupportedShop.fromJson(Map<String, dynamic> json) =>
//       _$SupportedShopFromJson(json);
// }

// @freezed
// abstract class SupportedShopModel with _$SupportedShopModel {
//   const factory SupportedShopModel({
//     required String id,
//     required String name,
//     required String shopAddress,
//     required String shopPhone,
//     String? shopEmail, // Made optional to match domain model
//     String? shopWebsite, // Made optional to match domain model
//   }) = _SupportedShopModel;

//   factory SupportedShopModel.fromJson(Map<String, dynamic> json) =>
//       _$SupportedShopModelFromJson(json);
// }

@freezed
abstract class SupportedShopDto with _$SupportedShopDto {
  const factory SupportedShopDto({
    required String id,
    required String name,
    required String shopAddress,
    required String shopPhone,
    String? shopEmail, // Made optional to match domain model
    String? shopWebsite, // Made optional to match domain model
  }) = _SupportedShopDto;

  factory SupportedShopDto.fromJson(Map<String, dynamic> json) =>
      _$SupportedShopDtoFromJson(json);

  // Default private constructor
  const SupportedShopDto._();

  factory SupportedShopDto.fromDomainModel(SupportedShopModel model) {
    return SupportedShopDto(
      id: model.id,
      name: model.name,
      shopAddress: model.shopAddress,
      shopPhone: model.shopPhone,
      shopEmail: model.shopEmail,
      shopWebsite: model.shopWebsite,
    );
  }

  // From Domain Model to DTO
  SupportedShopModel toDomainModel() {
    return SupportedShopModel(
      id: id,
      name: name,
      shopAddress: shopAddress,
      shopPhone: shopPhone,
      shopEmail: shopEmail,
      shopWebsite: shopWebsite,
    );
  }
}
