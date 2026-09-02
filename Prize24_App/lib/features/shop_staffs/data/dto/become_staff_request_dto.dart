import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/become_staff_request_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'become_staff_request_dto.freezed.dart';
part 'become_staff_request_dto.g.dart';

/**
 * 
receiverId "npYL2NMZoue1CyO1cQvZmqRTvMI3"
(string)
receiverName "Max Payne"
(string)
requestedAt 25 November 2025 at 09:59:36 UTC+5:30
(timestamp)
respondedAt null
(null)
senderName "Arun Das"
(string)
shopId "DXnzWHZlOzHG10GCWycP"
(string)
shopName "CD and Cassette"
(string)
status "pending" 
 */

@freezed
abstract class BecomeStaffRequestDto with _$BecomeStaffRequestDto {
  const factory BecomeStaffRequestDto({
    required String shopId,
    required String shopName,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp requestedAt,

    /// Request Id
    @Default('') String id,
  }) = _BecomeStaffRequestDto;

  factory BecomeStaffRequestDto.fromJson(Map<String, dynamic> json) =>
      _$BecomeStaffRequestDtoFromJson(json);

  // Private constructor
  const BecomeStaffRequestDto._();

  // To Domain Model
  BecomeStaffRequestModel toDomain() {
    return BecomeStaffRequestModel(
      id: id,
      shopId: shopId,
      shopName: shopName,
      requestedAt: requestedAt.toDate(),
    );
  }
}
