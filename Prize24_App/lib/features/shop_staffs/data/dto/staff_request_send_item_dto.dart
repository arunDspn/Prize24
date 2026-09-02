import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_request_send_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'staff_request_send_item_dto.freezed.dart';
part 'staff_request_send_item_dto.g.dart';

@freezed
abstract class StaffRequestSendItemDto with _$StaffRequestSendItemDto {
  /**
   * 
receiverId "J57AHXvdL1j18fDRdE4J"
(string)
requestedAt "2025-11-24T16:06:40.674336"
(string)
respondedAt null
(null)
senderName "Max Payne"
(string)
shopId "UbI9bUrS0jDhRkiZ9rBk"
(string)
shopName "asdsadsa"
(string)
status "pending" 
   */
  const factory StaffRequestSendItemDto({
    required String? id,
    required String receiverName,
    required String shopId,
    required String receiverId,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp requestedAt,
    @JsonKey(
      fromJson: FirebaseHelper.nullableTimestampFromJson,
      toJson: FirebaseHelper.nullableTimestampToJson,
    )
    required Timestamp? respondedAt,
    required String status,
  }) = _StaffRequestSendItemDto;

  factory StaffRequestSendItemDto.fromJson(Map<String, dynamic> json) =>
      _$StaffRequestSendItemDtoFromJson(json);

  // Private constructor
  const StaffRequestSendItemDto._();

  /// Converts DTO to Model
  StaffRequestSendModel toModel() {
    return StaffRequestSendModel(
      id: id!,
      receiverName: receiverName,
      requestedAt: requestedAt.toDate(),
      respondedAt: respondedAt?.toDate(),
      status: StaffRequestStatus.fromString(status),
      shopId: shopId,
      receiverId: receiverId,
    );
  }
}

// // Helper functions for Timestamp conversion
// Timestamp timestampFromJson(dynamic json) {
//   if (json is Timestamp) {
//     return json;
//   }
//   if (json is Map<String, dynamic>) {
//     return Timestamp(
//       (json['_seconds'] as num?)?.toInt() ?? 0,
//       (json['_nanoseconds'] as num?)?.toInt() ?? 0,
//     );
//   }
//   if (json is int) {
//     return Timestamp.fromMillisecondsSinceEpoch(json);
//   }
//   throw ArgumentError('Cannot convert $json to Timestamp');
// }

// dynamic timestampToJson(Timestamp timestamp) {
//   return {
//     '_seconds': timestamp.seconds,
//     '_nanoseconds': timestamp.nanoseconds,
//   };
// }

// dynamic nullableTimestampToJson(Timestamp? timestamp) {
//   if (timestamp == null) {
//     return null;
//   }
//   return {
//     '_seconds': timestamp.seconds,
//     '_nanoseconds': timestamp.nanoseconds,
//   };
// }

// // Helper functions for nullable Timestamp conversion
// Timestamp? nullableTimestampFromJson(dynamic json) {
//   if (json == null) {
//     return null;
//   }
//   if (json is Timestamp) {
//     return json;
//   }
//   if (json is Map<String, dynamic>) {
//     return Timestamp(
//       (json['_seconds'] as num?)?.toInt() ?? 0,
//       (json['_nanoseconds'] as num?)?.toInt() ?? 0,
//     );
//   }
//   if (json is int) {
//     return Timestamp.fromMillisecondsSinceEpoch(json);
//   }
//   throw ArgumentError('Cannot convert $json to Timestamp');
// }

// dynamic nullableTimestampToJson(Timestamp? timestamp) {
//   if (timestamp == null) {
//     return null;
//   }
//   return {
//     '_seconds': timestamp.seconds,
//     '_nanoseconds': timestamp.nanoseconds,
//   };
// }
