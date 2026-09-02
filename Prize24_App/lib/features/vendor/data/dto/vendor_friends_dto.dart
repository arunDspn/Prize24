import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_model.dart';

part 'vendor_friends_dto.freezed.dart';
part 'vendor_friends_dto.g.dart';

@freezed
abstract class VendorFriendsDto with _$VendorFriendsDto {
  const factory VendorFriendsDto({
    required String id,
    required String userId,
    required String vendorName,
  }) = _VendorFriendsDto;

  /// Converts the model to a DTO.
  factory VendorFriendsDto.fromModel(VendorFriendsDto model) {
    return VendorFriendsDto(
      id: model.id,
      userId: model.userId,
      vendorName: model.vendorName,
    );
  }

  factory VendorFriendsDto.fromJson(Map<String, dynamic> json) =>
      _$VendorFriendsDtoFromJson(json);

  // Default private constructor
  const VendorFriendsDto._();

  /// Converts the DTO to a model.
  VendorFriendModel toModel() {
    return VendorFriendModel(
      id: id,
      userId: userId,
      vendorName: vendorName,
    );
  }
}
