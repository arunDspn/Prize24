import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/core/constants.dart';
part 'staff_request_send_model.freezed.dart';

@freezed

/// Model representing a staff request sent by a vendor to a user.
/// Includes details about the staff user, request status, and timestamps.
///
/// Used by Vendor to track requests sent to potential staff members.
abstract class StaffRequestSendModel with _$StaffRequestSendModel {
  const factory StaffRequestSendModel({
    required String id,
    required String receiverName,
    required DateTime requestedAt,
    required DateTime? respondedAt,
    required StaffRequestStatus status,
    required String shopId,
    required String receiverId,
  }) = _StaffRequestSendModel;
}
