import 'package:freezed_annotation/freezed_annotation.dart';
part 'vendor_friend_request_model.freezed.dart';

@freezed
abstract class VendorFriendRequestModel with _$VendorFriendRequestModel {
  const factory VendorFriendRequestModel({
    required String id,
    required String vendorId,
    required String vendorName,
    required DateTime createdAt,
  }) = _VendorFriendRequestModel;
}
