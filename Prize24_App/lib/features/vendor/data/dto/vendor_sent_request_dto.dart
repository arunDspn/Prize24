import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_sent_request_model.dart';
part 'vendor_sent_request_dto.freezed.dart';
part 'vendor_sent_request_dto.g.dart';

@freezed
abstract class VendorSentRequestDto with _$VendorSentRequestDto {
  const factory VendorSentRequestDto({
    required String id,
    required String receiverId,
    required String receiverName,
    required DateTime createdAt,
    required String status, // 'pending', 'accepted', 'declined'
  }) = _VendorSentRequestDto;

  factory VendorSentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$VendorSentRequestDtoFromJson(json);

  // Private Constructor const
  const VendorSentRequestDto._();

  // To Domain
  factory VendorSentRequestDto.fromModel(VendorSentRequestModel model) {
    return VendorSentRequestDto(
      id: model.id,
      receiverId: model.receiverId,
      receiverName: model.receiverName,
      createdAt: model.createdAt,
      status: model.status,
    );
  }

  // From Domain
  VendorSentRequestModel toModel() {
    return VendorSentRequestModel(
      id: id,
      receiverId: receiverId,
      receiverName: receiverName,
      createdAt: createdAt,
      status: status,
    );
  }
}
