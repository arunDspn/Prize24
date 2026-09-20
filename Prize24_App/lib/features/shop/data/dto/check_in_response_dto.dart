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
              cumulativeBillSum: data!.cumulativeBillSum,
              milestoneCycleBillSum: data!.milestoneCycleBillSum,
              crossedMilestone: data!.crossedMilestone,
              rewardOpportunity: data!.rewardOpportunity?.toDomain(),
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
    @Default(0) double cumulativeBillSum,
    @Default(0) double milestoneCycleBillSum,
    int? crossedMilestone,
    RewardOpportunityDto? rewardOpportunity,
  }) = _CheckInResponseDataDto;

  factory CheckInResponseDataDto.fromJson(Map<String, dynamic> json) =>
      _$CheckInResponseDataDtoFromJson(json);
}

@freezed
abstract class RewardOpportunityDto with _$RewardOpportunityDto {
  const factory RewardOpportunityDto({
    required String id,
    required String status,
    @Default(<String>[]) List<String> availableSources,
    String? selectedSource,
  }) = _RewardOpportunityDto;

  factory RewardOpportunityDto.fromJson(Map<String, dynamic> json) =>
      _$RewardOpportunityDtoFromJson(json);

  const RewardOpportunityDto._();

  RewardOpportunityModel toDomain() => RewardOpportunityModel(
    id: id,
    status: status,
    availableSources: availableSources,
    selectedSource: selectedSource,
  );
}
