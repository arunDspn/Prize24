import 'package:freezed_annotation/freezed_annotation.dart';
part 'club_model.freezed.dart';

@freezed
abstract class ClubModel with _$ClubModel {
  const factory ClubModel({
    required String id,
    required String name,
    required String description,
    required int giftDay,
    required String campaignId,
    required String campaignName,
    required String campaignDescription,
    required DateTime createdAt,
    required DateTime updatedAt,
    // required List<ClubShopListModel> shops,
    required int totalMembers,
    MultiplierRuleModel? multipierStreak,
  }) = _ClubModel;
}

@freezed
abstract class MultiplierRuleModel with _$MultiplierRuleModel {
  const factory MultiplierRuleModel({
    required int bonusIncrement,
    required int daysRequired,
  }) = _MultiplierRuleModel;
}

@freezed
abstract class ClubShopListModel with _$ClubShopListModel {
  const factory ClubShopListModel({
    required String shopId,
    required String shopName,
    required String shopAddress,
    required String phoneNumber,
  }) = _ClubShopListModel;
}
