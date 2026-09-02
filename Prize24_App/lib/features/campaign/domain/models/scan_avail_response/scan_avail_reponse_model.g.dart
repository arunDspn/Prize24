// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_avail_reponse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScanAvailReponseModel _$ScanAvailReponseModelFromJson(
  Map<String, dynamic> json,
) => _ScanAvailReponseModel(
  success: json['success'] as bool,
  error: json['error'] == null
      ? null
      : ScanAvailReponseErrorModel.fromJson(
          json['error'] as Map<String, dynamic>,
        ),
  data: json['data'] == null
      ? null
      : ScanAvailResponseDataModel.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ScanAvailReponseModelToJson(
  _ScanAvailReponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'error': instance.error,
  'data': instance.data,
};

_ScanAvailReponseErrorModel _$ScanAvailReponseErrorModelFromJson(
  Map<String, dynamic> json,
) => _ScanAvailReponseErrorModel(
  code: json['code'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$ScanAvailReponseErrorModelToJson(
  _ScanAvailReponseErrorModel instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};

_ScanAvailResponseDataModel _$ScanAvailResponseDataModelFromJson(
  Map<String, dynamic> json,
) => _ScanAvailResponseDataModel(
  isRedeemable: json['isRedeemable'] as bool,
  giftName: json['giftName'] as String,
  giftDescription: json['giftDescription'] as String,
  redemptionId: json['redemptionId'] as String,
);

Map<String, dynamic> _$ScanAvailResponseDataModelToJson(
  _ScanAvailResponseDataModel instance,
) => <String, dynamic>{
  'isRedeemable': instance.isRedeemable,
  'giftName': instance.giftName,
  'giftDescription': instance.giftDescription,
  'redemptionId': instance.redemptionId,
};
