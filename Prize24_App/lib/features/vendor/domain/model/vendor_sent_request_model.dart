import 'package:freezed_annotation/freezed_annotation.dart';
part 'vendor_sent_request_model.freezed.dart';

@freezed
abstract class VendorSentRequestModel with _$VendorSentRequestModel {
  const factory VendorSentRequestModel({
    required String id,
    required String receiverId,
    required String receiverName,
    required DateTime createdAt,
    required String status, // 'pending', 'accepted', 'declined'
  }) = _VendorSentRequestModel;
}
