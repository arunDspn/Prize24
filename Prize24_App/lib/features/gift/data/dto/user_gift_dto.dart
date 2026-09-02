import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/gift/data/dto/gift_dto.dart';
import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';
part 'user_gift_dto.freezed.dart';

@freezed
abstract class UserGiftDto with _$UserGiftDto {
  const factory UserGiftDto({
    required String? id,
    required String userId,
    required String giftId,
    required String giftName,
    required String giftDescription,
    required bool isRedeemable,
    required bool? isRedeemed,
    @JsonKey(defaultValue: false) bool? availedViaClub,

    // If is Redeemable is false,
    // Availed at is same as redeemed at
    required DateTime availedAt,

    // If is Redeemable is true,
    // Redeemed at will be null before redemption
    DateTime? redeemedAt,

    // If is Redeemable is true,
    List<SupportedShopDto>? supportedShops,
    // If is Redeemable is false,
    String? payload,
    bool? availedViaStreak,
    String? streakShopID,
  }) = _UserGiftDto;

  factory UserGiftDto.fromJson(Map<String, dynamic> json) {
    return UserGiftDto(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      giftId: json['giftId'] as String,
      giftName: json['giftName'] as String,
      giftDescription: json['giftDescription'] as String,
      isRedeemable: json['isRedeemable'] as bool,
      isRedeemed: json['isRedeemed'] as bool?,
      redeemedAt: _timestampFromJson(json['redeemedAt']),
      supportedShops: (json['supportedShops'] as List<dynamic>?)
          ?.map((e) => SupportedShopDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      payload: json['payload'] as String?,
      availedAt: _timestampFromJson(json['availedAt'])!,

      availedViaStreak: json['availedViaStreak'] as bool?,
      streakShopID: json['streakShopID'] as String?,

      // payload: '',
    );
  }

  // Defaullt private constructor
  const UserGiftDto._();

  /// Custom toJson method to handle timestamp conversion
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'giftId': giftId,
      'giftName': giftName,
      'giftDescription': giftDescription,
      'isRedeemable': isRedeemable,
      'isRedeemed': isRedeemed,
      'redeemedAt': _timestampToJson(redeemedAt),
      'supportedShops': supportedShops?.map((e) => e.toJson()).toList(),
      'payload': payload,
      'availedViaStreak': availedViaStreak,
      'streakShopID': streakShopID,
    };
  }

  /// Converts the UserGiftDto to a UserGiftModel.
  UserGiftModel toDomainModel() {
    return UserGiftModel(
      id: id ?? '',
      userId: userId,
      giftId: giftId,
      giftName: giftName,
      giftDescription: giftDescription,
      isRedeemable: isRedeemable,
      isRedeemed: isRedeemed,
      // availedAt: availedAt ?? DateTime.now(), // Default to now if null
      availedAt: availedAt ?? DateTime.now(), // Default to now if null
      redeemedAt: redeemedAt,
      supportedShops:
          supportedShops?.map((shop) => shop.toDomainModel()).toList(),
      // supportedShops: [],
      payload: payload,
      availedViaClub: availedViaClub ?? false,
      availedViaStreak: availedViaStreak,
      streakShopID: streakShopID,
    );
  }
}

// Helper functions for timestamp conversion
DateTime? _timestampFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Timestamp) {
    return json.toDate();
  }
  if (json is String) {
    return DateTime.parse(json);
  }
  return null;
}

dynamic _timestampToJson(DateTime? dateTime) {
  if (dateTime == null) return null;
  return dateTime.toIso8601String();
}
