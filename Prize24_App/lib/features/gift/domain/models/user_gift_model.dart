import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
part 'user_gift_model.freezed.dart';

@freezed
abstract class UserGiftModel with _$UserGiftModel {
  const factory UserGiftModel({
    required String id,
    required String userId,
    required String giftId,
    required String giftName,
    required String giftDescription,
    required bool isRedeemable,
    required bool? isRedeemed,
    required bool availedViaClub,

    // If is Redeemable is false,
    // Availed at is same as redeemed at
    required DateTime availedAt,

    // If is Redeemable is true,
    // Redeemed at will be null before redemption
    DateTime? redeemedAt,

    // If is Redeemable is true,
    List<SupportedShopModel>? supportedShops,
    // If is Redeemable is false,
    String? payload,
    bool? availedViaStreak,
    String? streakShopID,
  }) = _UserGiftModel;
}
