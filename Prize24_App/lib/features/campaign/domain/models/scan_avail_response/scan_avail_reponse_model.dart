import 'package:freezed_annotation/freezed_annotation.dart';
part 'scan_avail_reponse_model.freezed.dart';
part 'scan_avail_reponse_model.g.dart';

@freezed
abstract class ScanAvailReponseModel with _$ScanAvailReponseModel {
  const factory ScanAvailReponseModel({
    required bool success,
    ScanAvailReponseErrorModel? error,
    ScanAvailResponseDataModel? data,
  }) = _ScanAvailReponseModel;

  factory ScanAvailReponseModel.fromJson(Map<String, dynamic> json) =>
      _$ScanAvailReponseModelFromJson(json);
}

@freezed
abstract class ScanAvailReponseErrorModel with _$ScanAvailReponseErrorModel {
  const factory ScanAvailReponseErrorModel({
    required String code,
    required String message,
  }) = _ScanAvailReponseErrorModel;

  factory ScanAvailReponseErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ScanAvailReponseErrorModelFromJson(json);
}

@freezed
abstract class ScanAvailResponseDataModel with _$ScanAvailResponseDataModel {
  const factory ScanAvailResponseDataModel({
    required bool isRedeemable,
    required String giftName,
    required String giftDescription,
    required String redemptionId,
  }) = _ScanAvailResponseDataModel;

  factory ScanAvailResponseDataModel.fromJson(Map<String, dynamic> json) =>
      _$ScanAvailResponseDataModelFromJson(json);
}
