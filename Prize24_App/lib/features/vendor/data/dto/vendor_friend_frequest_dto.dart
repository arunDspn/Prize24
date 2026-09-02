import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_request_model.dart';
part 'vendor_friend_frequest_dto.freezed.dart';
part 'vendor_friend_frequest_dto.g.dart';

/**
 * 
 *           {
            'userId': userVendorId,
            'userName': acceptingVendorName,
            'friendId': requesterVendorId,
            'friendName': requesterName,
            'createdAt': FieldValue.serverTimestamp(),
          })
 */

@freezed
abstract class VendorFriendFrequestDto with _$VendorFriendFrequestDto {
  const factory VendorFriendFrequestDto({
    required String id,
    required String vendorId,
    required String vendorName,
    required DateTime createdAt,
  }) = _VendorFriendFrequestDto;

  /// Converts the model to a DTO.
  factory VendorFriendFrequestDto.fromModel(VendorFriendFrequestDto model) {
    return VendorFriendFrequestDto(
      id: model.id,
      vendorId: model.vendorId,
      vendorName: model.vendorName,
      createdAt: model.createdAt,
    );
  }

  factory VendorFriendFrequestDto.fromJson(Map<String, dynamic> json) =>
      _$VendorFriendFrequestDtoFromJson(json);

  // Default private constructor
  const VendorFriendFrequestDto._();

  /// Converts the DTO to a model.
  VendorFriendRequestModel toModel() {
    return VendorFriendRequestModel(
      id: id,
      vendorId: vendorId,
      vendorName: vendorName,
      createdAt: createdAt,
    );
  }
}
