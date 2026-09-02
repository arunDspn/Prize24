import 'package:freezed_annotation/freezed_annotation.dart';
part 'vendor_friend_model.freezed.dart';

@freezed
abstract class VendorFriendModel with _$VendorFriendModel {
  const factory VendorFriendModel({
    required String id,
    required String userId,
    required String vendorName,
  }) = _VendorFriendModel;
}
