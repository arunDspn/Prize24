import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/vendor/data/dto/vendor_friend_frequest_dto.dart';
import 'package:prize24_app/features/vendor/data/dto/vendor_friends_dto.dart';
import 'package:prize24_app/features/vendor/data/dto/vendor_sent_request_dto.dart';
import 'package:prize24_app/features/vendor/data/service/firebase_vendor_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'i_vendor_service.g.dart';

abstract class IVendorService {
  Future<void> becomeAVendor({
    required String userId,
    required String? vendorPhoneNumber,
  });

  Future<void> editVendorProfile({
    required String? vendorPhoneNumber,
    required String? userName,
    required String vendorId,
  });

  /// Register as vendor
  Future<void> registerAsVendor({required String userId});

  /// Register vendor phone number
  Future<void> registerVendorPhoneNumber({
    required String userId,
    required String vendorPhoneNumber,
  });

  // Future<VendorDto> getUserVendorProfile(String vendorId);

  /// Gets the vendor profile by user ID.
  // Future<VendorDto> getVendorByUserId(String userId);

  /// Gets the vendor profile by vendor ID.
  // Future<VendorDto> getVendorByVendorId(String vendorId);

  // Friends management methods
  Future<void> sendVendorFriendRequest({
    /// Target user [vendor] ID to whom the request is sent
    required String receiverId,
  });

  Future<VendorFriendsDto?> respondToFriendRequest({
    required String friendshipId,
    required String action,
  });

  Future<void> removeFriend({required String friendshipId});

  Future<(List<VendorFriendsDto>, Object?)> getVendorFriends({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  });

  /// Get all friend requests for a vendor
  Future<(List<VendorFriendFrequestDto>, Object?)> getVendorFriendRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  });

  Future<(List<VendorSentRequestDto>, Object?)> getVendorSentRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  });

  // Cancel a sent friend request
  Future<String?> cancelSentRequest({required String requestId});
}

@Riverpod(keepAlive: true)
IVendorService vendorServive(Ref ref) {
  return FirebaseVendorService();
}
