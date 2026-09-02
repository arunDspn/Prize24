import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop/domain/model/shop_offer_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'shop_offer_dto.freezed.dart';
part 'shop_offer_dto.g.dart';

@freezed
abstract class ShopOfferDto with _$ShopOfferDto {
  const factory ShopOfferDto({
    @JsonKey(name: 'offerId') required String id,
    required String name,
    required String description,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp startDate,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp endDate,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp createdAt,
  }) = _ShopOfferDto;

  factory ShopOfferDto.fromJson(Map<String, dynamic> json) =>
      _$ShopOfferDtoFromJson(json);

  /// Private const constructor
  const ShopOfferDto._();

  /// Converts DTO to Domain Model
  ShopOfferModel toDomain() {
    return ShopOfferModel(
      id: id,
      name: name,
      description: description,
      startDate: startDate.toDate(),
      endDate: endDate.toDate(),
      createdAt: createdAt.toDate(),
    );
  }
}
