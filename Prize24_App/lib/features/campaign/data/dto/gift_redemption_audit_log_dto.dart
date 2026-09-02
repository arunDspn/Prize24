import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/campaign/domain/models/gift_redemption_audit_log_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'gift_redemption_audit_log_dto.freezed.dart';
part 'gift_redemption_audit_log_dto.g.dart';

@freezed
abstract class GiftRedemptionAuditLogDto with _$GiftRedemptionAuditLogDto {
  const factory GiftRedemptionAuditLogDto({
    required String action,
    required String redeemedBy,
    required String redeemerRole,
    required String functionName,
    required bool success,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp timestamp,
    String? giftId,
    String? customerId,
    String? shopId,
    String? errorCode,
    String? errorMessage,
    String? phoneNumber,
  }) = _GiftRedemptionAuditLogDto;

  // Private constructor for freezed
  const GiftRedemptionAuditLogDto._();

  // To Json
  factory GiftRedemptionAuditLogDto.fromJson(Map<String, dynamic> json) =>
      _$GiftRedemptionAuditLogDtoFromJson(json);

  // To Model
  GiftRedemptionAuditLogModel toModel() {
    return GiftRedemptionAuditLogModel(
      action: action,
      redeemedBy: redeemedBy,
      redeemerRole: redeemerRole,
      functionName: functionName,
      success: success,
      timestamp: timestamp.toDate(),
      giftId: giftId,
      customerId: customerId,
      shopId: shopId,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }
}
