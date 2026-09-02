import 'package:freezed_annotation/freezed_annotation.dart';
part 'become_staff_request_model.freezed.dart';

@freezed
abstract class BecomeStaffRequestModel with _$BecomeStaffRequestModel {
  const factory BecomeStaffRequestModel({
    required String id,
    required String shopId,
    required String shopName,
    required DateTime requestedAt,
  }) = _BecomeStaffRequestModel;
}
