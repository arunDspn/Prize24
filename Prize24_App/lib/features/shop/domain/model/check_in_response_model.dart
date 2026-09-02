import 'package:freezed_annotation/freezed_annotation.dart';
part 'check_in_response_model.freezed.dart';

@freezed
abstract class CheckInResponseModel with _$CheckInResponseModel {
  const factory CheckInResponseModel({
    required bool success,
    required String message,
    // Error field
    String? error,
    // Data fields
    CheckInRepsponseDataModel? data,
  }) = _CheckInResponseModel;
}

@freezed
abstract class CheckInRepsponseDataModel with _$CheckInRepsponseDataModel {
  const factory CheckInRepsponseDataModel({
    required int cumulativeStreak,
    required int consecutiveDays,
    required bool bonusApplied,
    required bool isGiftDay,
    required bool isNewUser,
  }) = _CheckInRepsponseDataModel;
}
