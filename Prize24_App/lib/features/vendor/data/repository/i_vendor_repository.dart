import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_model.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_request_model.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_sent_request_model.dart';

abstract class IVendorRepository {
  Future<void> becomeAVendor({
    required String userId,
    required String vendorPhoneNumber,
  });

  Future<void> registerAsVendor({required String userId});

  /// Register vendor phone number
  Future<void> registerVendorPhoneNumber({
    required String userId,
    required String vendorPhoneNumber,
  });

  // Edit vendor Profile
  Future<void> editVendorProfile({
    required String userId,
    required String vendorName,
    required String vendorPhoneNumber,
  });

  Future<void> sendVendorFriendRequest({
    /// Target user [vendor] ID to whom the request is sent
    required String receiverId,
  });

  // Future<VendorFriendModel> acceptFriendRequest({
  //   /// Target user [vendor] ID to whom the request is sent
  //   required String requesterVendorId,

  //   /// User {Vendor} ID of the sender
  //   required String userVendorId,

  //   /// Sender's name
  //   required String requesterName,

  //   /// The name of the vendor who is accepting the request
  //   required String acceptingVendorName,
  // });
  Future<VendorFriendModel?> respondToFriendRequest({
    required String friendshipId,
    required String action,
  });

  Future<void> removeFriend({required String friendshipId});

  // List of vendor friends
  Future<PaginatedResult<VendorFriendModel>> getVendorFriends({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  });

  Future<PaginatedResult<VendorFriendRequestModel>> getVendorFriendRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  });

  Future<PaginatedResult<VendorSentRequestModel>> getVendorSentRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  });

  // Cancel a sent friend request
  Future<String?> cancelSentRequest({required String requestId});

  // Future<VendorModel?> getVendor(String vendorId);

  // Future<VendorModel> getVendorByUserId(String userId);
  // Future<List<Vendor>> getAllVendors();
  // Future<void> updateVendor(Vendor vendor);
  // Future<void> deleteVendor(String vendorId);
  // Stream<List<Vendor>> watchAllVendors();
}
