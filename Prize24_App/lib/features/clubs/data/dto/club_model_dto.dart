import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/clubs/domain/models/club_model.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_request_send_item_dto.dart';
import 'package:prize24_app/utils/firebase_helper.dart';

part 'club_model_dto.freezed.dart';
part 'club_model_dto.g.dart';

@freezed
abstract class ClubModelDto with _$ClubModelDto {
  const factory ClubModelDto({
    required String name,
    required String description,
    required int giftDay,
    @JsonKey(name: 'campaignId') required String attachedCampaignId,
    required String campaignName,
    required String campaignDescription,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp createdAt,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp updatedAt,
    // @JsonKey(name: 'shopList') required List<ClubShopListDto> shops,
    required int totalMembers,
    String? id,
    MultiplierRuleDto? multipierStreak,
  }) = _ClubModelDto;

  const ClubModelDto._();

  factory ClubModelDto.fromJson(Map<String, dynamic> json) =>
      _$ClubModelDtoFromJson(json);

  /// Convert DTO to domain model
  ClubModel toDomain() {
    return ClubModel(
      id: id ?? '',
      name: name,
      description: description,
      giftDay: giftDay,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
      campaignName: campaignName,
      campaignDescription: campaignDescription,
      // shops: shops
      //     .map((shopDto) => ClubShopListModel(
      //           shopId: shopDto.shopId,
      //           shopName: shopDto.shopName,
      //           shopAddress: shopDto.shopAddress,
      //           phoneNumber: shopDto.phoneNumber,
      //         ))
      //     .toList(),
      totalMembers: totalMembers,
      multipierStreak: multipierStreak != null
          ? MultiplierRuleModel(
              bonusIncrement: multipierStreak!.bonusIncrement,
              daysRequired: multipierStreak!.daysRequired,
            )
          : null,
      campaignId: attachedCampaignId,
    );
  }

  // /// Create DTO from domain model
  // factory ClubModelDto.fromDomain(ClubModel model) {
  //   return ClubModelDto(
  //     id: model.id,
  //     name: model.name,
  //     description: model.description,
  //     giftDay: model.giftDay,
  //     attachedCampaignId: model.attachedCampaignId,
  //     createdAt: model.createdAt,
  //     updatedAt: model.updatedAt,
  //     multipierStreak: model.multipierStreak,
  //   );
  // }
}

@freezed
abstract class MultiplierRuleDto with _$MultiplierRuleDto {
  const factory MultiplierRuleDto({
    required int bonusIncrement,
    required int daysRequired,
  }) = _MultiplierRuleDto;

  factory MultiplierRuleDto.fromJson(Map<String, dynamic> json) =>
      _$MultiplierRuleDtoFromJson(json);
}

@freezed
abstract class ClubShopListDto with _$ClubShopListDto {
  const factory ClubShopListDto({
    required String shopId,
    required String shopName,
    @JsonKey(name: 'address') required String shopAddress,
    required String phoneNumber,
  }) = _ClubShopListDto;

  factory ClubShopListDto.fromJson(Map<String, dynamic> json) =>
      _$ClubShopListDtoFromJson(json);
}
