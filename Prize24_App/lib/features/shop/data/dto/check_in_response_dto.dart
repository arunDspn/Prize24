import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop/domain/model/check_in_response_model.dart';
part 'check_in_response_dto.freezed.dart';
part 'check_in_response_dto.g.dart';

/**
 * export interface CheckInResponse {
    success: boolean;
    message: string;
    data?: {
        cumulativeStreak: number;
        consecutiveDays: number;
        bonusApplied: boolean;
        isGiftDay: boolean;
        giftInfo?: {
            campaignId: string;
            campaignName: string;
            message: string;
        };
    };
    error?: string;
}
 */

@freezed
abstract class CheckInResponseDto with _$CheckInResponseDto {
  const factory CheckInResponseDto({
    required bool success,
    required String message,
    // Error field
    String? error,
    // Data fields
    CheckInResponseDataDto? data,
  }) = _CheckInResponseDto;

  factory CheckInResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CheckInResponseDtoFromJson(json);

  // Private constructor
  const CheckInResponseDto._();

  // Convert to domain model
  CheckInResponseModel toDomain() {
    return CheckInResponseModel(
      success: success,
      message: message,
      error: error,
      data: data != null
          ? CheckInRepsponseDataModel(
              cumulativeStreak: data!.cumulativeStreak,
              consecutiveDays: data!.consecutiveDays,
              bonusApplied: data!.bonusApplied,
              isGiftDay: data!.isGiftDay,
              isNewUser: data!.isNewUser,
            )
          : null,
    );
  }
}

@freezed
abstract class CheckInResponseDataDto with _$CheckInResponseDataDto {
  const factory CheckInResponseDataDto({
    required int cumulativeStreak,
    required int consecutiveDays,
    required bool bonusApplied,
    required bool isGiftDay,
    required bool isNewUser,
  }) = _CheckInResponseDataDto;

  factory CheckInResponseDataDto.fromJson(Map<String, dynamic> json) =>
      _$CheckInResponseDataDtoFromJson(json);
}
