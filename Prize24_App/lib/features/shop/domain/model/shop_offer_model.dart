import 'package:freezed_annotation/freezed_annotation.dart';
part 'shop_offer_model.freezed.dart';

@freezed
abstract class ShopOfferModel with _$ShopOfferModel {
  const factory ShopOfferModel({
    required String id,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime createdAt,
  }) = _ShopOfferModel;
}
