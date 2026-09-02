import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/vendor/data/repository/i_vendor_repository.dart';
import 'package:prize24_app/features/vendor/data/service/i_vendor_service.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_model.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_request_model.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_sent_request_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'vendor_repository.g.dart';

class VendorRepository implements IVendorRepository {
  VendorRepository({required IVendorService vendorService})
    : _vendorService = vendorService;

  final IVendorService _vendorService;

  @override
  Future<void> becomeAVendor({
    required String userId,
    required String? vendorPhoneNumber,
  }) async {
    await _vendorService.becomeAVendor(
      userId: userId,
      vendorPhoneNumber: vendorPhoneNumber,
    );
  }

  @override
  Future<void> editVendorProfile({
    required String userId,
    required String vendorName,
    required String vendorPhoneNumber,
  }) async {
    await _vendorService.editVendorProfile(
      vendorId: userId,
      vendorPhoneNumber: vendorPhoneNumber,
      userName: vendorName,
    );
  }

  // @override
  // Future<VendorFriendModel> acceptFriendRequest({
  //   required String requesterVendorId,
  //   required String userVendorId,
  //   required String requesterName, // Add sender's name as parameter
  //   required String acceptingVendorName, // Add receiver's name as parameter
  // }) async {
  //   final data = await _vendorService.acceptFriendRequest(
  //     requesterVendorId: requesterVendorId,
  //     userVendorId: userVendorId,
  //     requesterName: requesterName,
  //     acceptingVendorName: acceptingVendorName,
  //   );

  //   return data.toModel();
  // }

  // @override
  // Future<void> sendVendorFriendRequest({
  //   required String targetVendorId,
  //   required String userVendorId,
  //   required String senderName,
  // }) async {}

  // @override
  // Future<List<VendorFriendModel>> getVendorFriends(
  //   String vendorId,
  // ) async {
  //   final friendsDtoList = await _vendorService.getVendorFriends(vendorId);
  //   return friendsDtoList.map((dto) => dto.toModel()).toList();
  // }

  // @override
  // Future<List<VendorFriendRequestModel>> getVendorFriendRequests(
  //   String vendorId,
  // ) async {
  //   // TODO: implement getVendorFriendRequests
  //   throw UnimplementedError();
  // }

  @override
  Future<void> removeFriend({required String friendshipId}) async {
    await _vendorService.removeFriend(friendshipId: friendshipId);
  }

  @override
  Future<VendorFriendModel?> respondToFriendRequest({
    required String friendshipId,
    required String action,
  }) async {
    final data = await _vendorService.respondToFriendRequest(
      friendshipId: friendshipId,
      action: action,
    );

    return data?.toModel();
  }

  @override
  Future<PaginatedResult<VendorFriendRequestModel>> getVendorFriendRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, lastDoc) = await _vendorService.getVendorFriendRequests(
      vendorId: vendorId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos.map((dto) => dto.toModel()).toList(),
      cursor: lastDoc,
      hasMore: lastDoc != null,
    );
  }

  @override
  Future<PaginatedResult<VendorFriendModel>> getVendorFriends({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, lastDoc) = await _vendorService.getVendorFriends(
      vendorId: vendorId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos.map((dto) => dto.toModel()).toList(),
      cursor: lastDoc,
      hasMore: lastDoc != null,
    );
  }

  @override
  Future<void> sendVendorFriendRequest({required String receiverId}) async {
    await _vendorService.sendVendorFriendRequest(receiverId: receiverId);
  }

  @override
  Future<PaginatedResult<VendorSentRequestModel>> getVendorSentRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, lastDoc) = await _vendorService.getVendorSentRequests(
      vendorId: vendorId,
      cursor: cursor,
      limit: limit,
    );
    return PaginatedResult(
      items: dtos.map((dto) => dto.toModel()).toList(),
      cursor: lastDoc,
      hasMore: lastDoc != null,
    );
  }

  @override
  Future<void> registerAsVendor({required String userId}) async {
    await _vendorService.registerAsVendor(userId: userId);
  }

  @override
  Future<void> registerVendorPhoneNumber({
    required String userId,
    required String vendorPhoneNumber,
  }) async {
    return _vendorService.registerVendorPhoneNumber(
      userId: userId,
      vendorPhoneNumber: vendorPhoneNumber,
    );
  }

  @override
  Future<String?> cancelSentRequest({required String requestId}) async {
    return _vendorService.cancelSentRequest(requestId: requestId);
  }
}

@Riverpod(keepAlive: true)
IVendorRepository vendorRepository(Ref ref) {
  final service = ref.read(vendorServiveProvider);
  return VendorRepository(vendorService: service);
}
