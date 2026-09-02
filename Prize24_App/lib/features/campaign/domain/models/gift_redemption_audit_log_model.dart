import 'package:freezed_annotation/freezed_annotation.dart';
part 'gift_redemption_audit_log_model.freezed.dart';

@freezed
abstract class GiftRedemptionAuditLogModel with _$GiftRedemptionAuditLogModel {
  const factory GiftRedemptionAuditLogModel({
    required String action,
    required String redeemedBy,
    required String redeemerRole,
    required String functionName,
    required bool success,
    required DateTime timestamp,
    String? giftId,
    String? customerId,
    String? shopId,
    String? errorCode,
    String? errorMessage,
    String? phoneNumber,
  }) = _GiftRedemptionAuditLogModel;
}
