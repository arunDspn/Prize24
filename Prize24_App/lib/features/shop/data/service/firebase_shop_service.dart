import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:prize24_app/features/shop/data/dto/check_in_response_dto.dart';
import 'package:prize24_app/features/shop/data/dto/follower_streak_log_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_activity_log_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_follow_response_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_follower_dto.dart';
import 'package:prize24_app/features/shop/data/dto/shop_offer_dto.dart';
import 'package:prize24_app/features/shop/data/dto/user_following_shop_dto.dart';
import 'package:prize24_app/features/shop/data/service/i_shop_service.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/become_staff_request_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/shop_staff_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_request_send_item_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_shop/staff_shop_dto.dart';
import 'package:prize24_app/utils/app_specific_convertors.dart';

class FirebaseShopService implements IShopService {
  final _firestore = FirebaseFirestore.instance;
  final String _shopCollectionName = 'shops';

  // Staff Collections

  /// Collection name for staff requests.
  final String _staffRequestsCollectionName = 'staffRequests';

  /// Sub Collection name for shop staff -- Shop focused.
  /// `shops/{shopId}/staffs`
  final String _shopStaffCollectionName = 'staffs';

  /// Array name for staff's shops -- User focused.
  /// `users/{userId}/shopsStaffed`
  final String _staffsUserShopsArrayName = 'staffShopIds';

  Logger logger = Logger();

  @override
  Future<ShopDto> addNewShop({required ShopDto shop}) async {
    final updatedShop = shop.copyWith(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final shopRef = _firestore
        .collection(_shopCollectionName)
        .add(updatedShop.toJson());
    final shopId = (await shopRef).id;
    // todo: can use copyWith to avoid creating a new instance
    // After adding the shop, we can fetch it back to return as a ShopDto
    final shopDoc = await _firestore
        .collection(_shopCollectionName)
        .doc(shopId)
        .get();
    if (!shopDoc.exists) {
      throw Exception('Shop not found after creation');
    }

    return ShopDto.fromJson(shopDoc.data()!);
  }

  @override
  Future<void> deleteShop({required String shopId}) async {
    // TODO: implement deleteShop
    throw UnimplementedError();
  }

  @override
  Future<ShopDto> editShop({required ShopDto shop}) async {
    final updatedShop = shop.copyWith(updatedAt: DateTime.now());

    // Update the shop in Firestore
    await _firestore
        .collection(_shopCollectionName)
        .doc(shop.shopId)
        .update(updatedShop.toJson());

    // Fetch the updated shop to return as a ShopDto
    final shopDoc = await _firestore
        .collection(_shopCollectionName)
        .doc(shop.shopId)
        .get();

    if (!shopDoc.exists) {
      throw Exception('Shop not found after update');
    }

    final result = ShopDto.fromJson(shopDoc.data()!);
    return result;
  }

  @override
  Future<ShopDto> getSingleShopDetail({required String shopId}) async {
    final shopDoc = await _firestore
        .collection(_shopCollectionName)
        .doc(shopId)
        .get();

    if (!shopDoc.exists) {
      throw Exception('Shop not found');
    }

    return ShopDto.fromJson(shopDoc.data()!);
  }

  @override
  Future<List<ShopDto>> getShopsByVendorId({
    required String vendorId,
    int page = 1,
    int limit = 10,
  }) async {
    final querySnapshot = await _firestore
        .collection(_shopCollectionName)
        .where('shopOwnerId', isEqualTo: vendorId)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    final shops = <ShopDto>[];

    // Add ID to each ShopDto from the query results locally
    for (final doc in querySnapshot.docs) {
      final shopData = doc.data();
      final shopDto = ShopDto.fromJson(shopData).copyWith(shopId: doc.id);
      shops.add(shopDto.copyWith(shopId: doc.id));
    }

    return shops;
  }

  @override
  Future<(List<BecomeStaffRequestDto>, Object?)> getShopStaffRequestsReceived({
    required String staffUserId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;
    var query = _firestore
        .collection(_staffRequestsCollectionName)
        .where('receiverId', isEqualTo: staffUserId)
        .where('status', isEqualTo: 'pending')
        .orderBy('requestedAt', descending: true)
        .limit(limit);

    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final querySnapshot = await query.get();

    final dtos = querySnapshot.docs
        .map(
          (doc) =>
              BecomeStaffRequestDto.fromJson(doc.data()).copyWith(id: doc.id),
        )
        .toList();

    final lastDoc = querySnapshot.docs.length == limit
        ? querySnapshot.docs.last
        : null;

    return (dtos, lastDoc);
  }

  @override
  Future<List<StaffRequestSendItemDto>> getShopStaffRequestsSent({
    required String shopId,
  }) async {
    final querySnapshot = await _firestore
        .collection(_staffRequestsCollectionName)
        .where('shopId', isEqualTo: shopId)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    final requests = <StaffRequestSendItemDto>[];

    // Add ID to each BecomeStaffRequestDto from the query results locally
    for (final doc in querySnapshot.docs) {
      final requestData = doc.data();
      final requestDto = StaffRequestSendItemDto.fromJson(
        requestData,
      ).copyWith(id: doc.id);
      requests.add(requestDto);
    }

    return requests;
  }

  @override
  Future<(List<ShopStaffDto>, Object?)> getShopStaffs({
    required String shopId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;
    var query = _firestore
        .collection('shops')
        .doc(shopId)
        .collection(_shopStaffCollectionName)
        .orderBy('addedAt', descending: true)
        .limit(limit);

    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final querySnapshot = await query.get();

    if (querySnapshot.docs.isEmpty) {
      return (const <ShopStaffDto>[], null);
    }

    final staffs = querySnapshot.docs
        .map(
          (doc) => ShopStaffDto.fromJson(doc.data()).copyWith(staffId: doc.id),
        )
        .toList();

    final lastDoc = querySnapshot.docs.length == limit
        ? querySnapshot.docs.last
        : null;

    final userIds = staffs.map((s) => s.staffId!).toList();

    // Get all user names in a single query to avoid N+1 problem
    final usersSnapshot = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: userIds)
        .get();

    // Create a lookup map for faster indexing
    final Map<String, int> staffIndices = {};
    for (int i = 0; i < staffs.length; i++) {
      staffIndices[staffs[i].staffId!] = i;
    }

    // Inject that user name into the corresponding staff DTOs
    for (final userDoc in usersSnapshot.docs) {
      final userData = userDoc.data();
      final userName = userData['userName'] as String;
      final userId = userDoc.id;
      final staffIndex = staffIndices[userId];
      if (staffIndex != null) {
        staffs[staffIndex] = staffs[staffIndex].copyWith(staffName: userName);
      }
    }

    return (staffs, lastDoc);
  }

  @override
  Future<void> removeStaffMemberPermanent({
    required String shopId,
    required String staffUserId,
    String reason = '',
  }) {
    // TODO: implement removeStaffMemberPermanent
    throw UnimplementedError();
  }

  @override
  Future<void> respondToStaffRequest({
    required String requestId,
    required String action,
    required String staffUserId,
    required String shopId,
  }) async {
    // Update the staff request document with the response
    await _firestore
        .collection(_staffRequestsCollectionName)
        .doc(requestId)
        .update({'status': action, 'respondedAt': Timestamp.now()});

    if (action != 'accept') {
      // If the request is not accepted, no further action is needed
      return;
    }

    // Create Relationships
    // - `/users/{userId}/**staff_shop_ids`** — ****Array → User centric
    // - `/shops/{shopId}/**staffs**` — Sub collection → Shop centric

    // Add shopId to user's staffed shops array
    await _firestore.collection('users').doc(staffUserId).update({
      _staffsUserShopsArrayName: FieldValue.arrayUnion([shopId]),
    });

    // Get user name from `users` collection by ``staffUserId``
    final userDoc = await _firestore.collection('users').doc(staffUserId).get();
    final userName = userDoc.data()?['userName'] as String;
    final userPhone = userDoc.data()?['phoneNumber'] as String?;

    // Create a sub-collection for staffs within the shop document
    await _firestore
        .collection('shops')
        .doc(shopId)
        .collection(_shopStaffCollectionName)
        .doc(staffUserId)
        .set({
          'staffName': userName,
          'staffPhone': userPhone,
          'addedAt': Timestamp.now(),
        });
  }

  @override
  Future<void> revokeShopStaff({
    required String shopId,
    required String staffUserId,
    String reason = '',
  }) {
    // TODO: implement revokeShopStaff
    throw UnimplementedError();
  }

  @override
  Future<void> sendAddStaffRequest({
    required String shopId,
    required String shopName,
    required String senderName,
    required String receiverId,
  }) async {
    /**
     * {
	"senderName" : "",
	"shopName" : "",
	"requestedAt": "", // Timestamp
	"respondedAt": "",
	"status": "",	// accepted || rejected || pending
	// Lookups
	"receiverId": "", // User's lookup
	"shopId": "" // Sender's lookup
}
     */

    // Before sending a new request, check if there's already a pending or accepted request
    final existingRequestsQuery = await _firestore
        .collection(_staffRequestsCollectionName)
        .where('receiverId', isEqualTo: receiverId)
        .where('shopId', isEqualTo: shopId)
        .where('status', whereIn: ['pending', 'accepted'])
        .get();

    if (existingRequestsQuery.docs.isNotEmpty) {
      final status = existingRequestsQuery.docs.first.data()['status'];
      if (status == 'accepted') {
        throw Exception('This user is already a staff member of this shop.');
      } else {
        throw Exception(
          'A pending request already exists for this staff member.',
        );
      }
    }

    // Get user name from userId -- TODO: Optimize by passing the name directly
    final ref = await _firestore.collection('users').doc(receiverId).get();
    final userName = ref.data()?['userName'] as String;
    // Add a new document to the staffRequests collection
    final staffRequestData = {
      'senderName': senderName,
      'shopName': shopName,
      'requestedAt': Timestamp.now(),
      'respondedAt': null,
      'status': 'pending',
      'receiverId': receiverId,
      'shopId': shopId,
      'receiverName': userName,
    };
    await _firestore
        .collection(_staffRequestsCollectionName)
        .add(staffRequestData);
  }

  @override
  Future<(List<ShopFollowerDto>, Object?)> fetchShopFollowers({
    required String shopId,
    String? userId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;
    // Order by cumulativeStreak descending so top streaks appear first.
    var query = _firestore
        .collection('shops')
        .doc(shopId)
        .collection('followers')
        .orderBy('cumulativeStreak', descending: true)
        .limit(limit);

    // When a specific user is requested, scope the query to that document.
    if (userId != null && userId.isNotEmpty) {
      query = query.where(FieldPath.documentId, isEqualTo: userId);
    }

    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return (const <ShopFollowerDto>[], null);
    }

    // Map each doc; document ID is the userId.
    final data = snapshot.docs
        .map(
          (doc) =>
              ShopFollowerDto.fromJson(doc.data()).copyWith(userId: doc.id),
        )
        .toList();

    // Enrich with user names — only for this page's subset (avoids N+1).
    final userIds = data.map((f) => f.userId).toList();
    final usersSnapshot = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: userIds)
        .get();

    // Create a lookup map for faster indexing
    final Map<String, int> followerIndices = {};
    for (int i = 0; i < data.length; i++) {
      followerIndices[data[i].userId] = i;
    }

    for (final userDoc in usersSnapshot.docs) {
      final userName = userDoc.data()['userName'] as String;
      final idx = followerIndices[userDoc.id];
      if (idx != null) {
        data[idx] = data[idx].copyWith(userName: userName);
      }
    }

    // Fewer than limit → last page.
    final lastDoc = snapshot.docs.length == limit ? snapshot.docs.last : null;

    return (data, lastDoc);
  }

  @override
  Future<CheckInResponseDto> checkInUserToShopByStaff({
    required String shopId,
    required String userId,
    required String staffUserId,
    required String billNumber,
    required double billAmount,
  }) async {
    final callable = FirebaseFunctions.instance.httpsCallable('checkInUser');

    final result = await callable.call<dynamic>({
      'shopId': shopId,
      'userId': userId,
      'billNumber': billNumber,
      'billAmount': billAmount,
    });

    final mapData = CFSpecificConvertors.convertCFMapToStringDynamic(
      result.data,
    );
    return CheckInResponseDto.fromJson(mapData);
  }

  @override
  Future<CheckInResponseDto> checkInUserToShopByVendor({
    required String shopId,
    required String userId,
    required String billNumber,
    required double billAmount,
  }) async {
    final callable = FirebaseFunctions.instance.httpsCallable('checkInUser');

    final response = await callable.call<dynamic>({
      'shopId': shopId,
      'userId': userId,
      'billNumber': billNumber,
      'billAmount': billAmount,
    });

    final mapData = CFSpecificConvertors.convertCFMapToStringDynamic(
      response.data,
    );
    return CheckInResponseDto.fromJson(mapData);
  }

  @override
  Future<ShopFollowResponseDto> followShopByVendor({
    required String shopId,
    required String userId,
  }) async {
    final callable = FirebaseFunctions.instance.httpsCallable(
      'followShopByVendor',
    );

    final response = await callable.call<dynamic>({
      'shopId': shopId,
      'userId': userId,
    });

    final mapData = CFSpecificConvertors.convertCFMapToStringDynamic(
      response.data,
    );
    return ShopFollowResponseDto.fromJson(mapData);
  }

  @override
  Future<ShopFollowResponseDto> followShopByStaff({
    required String shopId,
    required String userId,
  }) async {
    final callable = FirebaseFunctions.instance.httpsCallable(
      'followShopByStaff',
    );

    final response = await callable.call<dynamic>({
      'shopId': shopId,
      'userId': userId,
    });

    final mapData = CFSpecificConvertors.convertCFMapToStringDynamic(
      response.data,
    );
    return ShopFollowResponseDto.fromJson(mapData);
  }

  @override
  Future<List<UserFollowingShopDto>> listUserFollowedShops({
    required String userId,
    int page = 1,
    int limit = 10,
  }) async {
    // path - users/{userId}/shopsFollowing
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('followedShops')
        .get();

    final shopFutures = snapshot.docs.map((doc) async {
      final shop = UserFollowingShopDto.fromJson(
        doc.data(),
      ).copyWith(shopAddress: doc.id);

      // Getting giftCycleDays from shop document
      // path - shops/{shopId}
      // Because giftCycleDays is not stored in user's followedShops subcollection
      final shopDoc = await _firestore
          .collection('shops')
          .doc(shop.shopId)
          .get();

      if (shopDoc.exists) {
        final shopData = shopDoc.data()!;
        final giftCycleDays = shopData['giftCycleDay'] as int?;
        final campaignId = shopData['associatedCampaignId'] as String?;
        return shop.copyWith(
          giftCycleDays: giftCycleDays ?? 0,
          isGiftAvailable: campaignId != null,
        );
      } else {
        logger.w('Shop document not found for shopId: ${shop.shopId}');
        throw Exception('Shop document not found for shopId: ${shop.shopId}');
      }
    }).toList();

    final shops = await Future.wait(shopFutures);
    return shops;
  }

  @override
  Future<void> toggleShopNotification({
    required String shopId,
    required String userId,
    required String userFCMToken,
    required bool enable,
  }) async {
    // Update /users/{userId}/followedShops/{shopId} document's notificationEnabled field
    final shopRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('followedShops')
        .doc(shopId);

    await shopRef.update({'notificationEnabled': enable});

    // Based on enable, Subscribe or Unsubscribe from FCM topic
    if (enable) {
      await FirebaseMessaging.instance.subscribeToTopic(shopId);
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic(shopId);
    }
  }

  @override
  Future<void> unfollowShop({required String shopId}) {
    // TODO: implement unfollowShop
    throw UnimplementedError();
  }

  @override
  Future<void> unfollowShopByUser({
    required String shopId,
    required String userFCMToken,
  }) {
    // TODO: implement unfollowShopByUser
    throw UnimplementedError();
  }

  @override
  Future<(List<FollowerStreakLogDto>, Object?)> viewFollowerStreakLogs({
    required String shopId,
    required String userId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;

    var query = _firestore
        .collection('shops')
        .doc(shopId)
        .collection('activityLogs')
        .where('action', isEqualTo: 'check_in_success')
        .where('customerId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return (const <FollowerStreakLogDto>[], null);
    }

    final dtos = snapshot.docs
        .map((doc) => FollowerStreakLogDto.fromJson(doc.data()))
        .toList();

    final lastDoc = snapshot.docs.length == limit ? snapshot.docs.last : null;

    return (dtos, lastDoc);
  }

  @override
  Future<void> addShopOffer({
    required String shopId,
    required String name,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    // addOfferToShop -- Cloud Function

    try {
      final callable = FirebaseFunctions.instance.httpsCallable(
        'addOfferToShop',
      );
      await callable.call<dynamic>({
        'shopId': shopId,
        'name': name,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
      });
    } catch (e) {
      logger.e('Error adding shop offer: $e');
      rethrow;
    }
  }

  @override
  Future<(List<ShopOfferDto>, Object?)> fetchShopOffers({
    required String shopId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;
    // Build the base query — orderBy is REQUIRED for cursor-based pagination.
    var query = _firestore
        .collection('shops')
        .doc(shopId)
        .collection('offers')
        .orderBy('createdAt', descending: true)
        .limit(limit);

    // Apply cursor only when fetching page 2+.
    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final snapshot = await query.get();

    final dtos = snapshot.docs
        .map(
          (doc) =>
              // Override any stored 'offerId' field with the real document id.
              ShopOfferDto.fromJson(doc.data()).copyWith(id: doc.id),
        )
        .toList();

    // If fewer documents were returned than the limit, we are on the last page.
    final lastDoc = snapshot.docs.length == limit ? snapshot.docs.last : null;

    return (dtos, lastDoc);
  }

  @override
  Future<ShopOfferDto?> fetchShopOfferById({
    required String shopId,
    required String shopOfferId,
  }) async {
    final doc = await _firestore
        .collection('shops')
        .doc(shopId)
        .collection('offers')
        .doc(shopOfferId)
        .get();

    if (!doc.exists) {
      return null;
    }

    return ShopOfferDto.fromJson(doc.data()!);
  }

  @override
  Future<(List<StaffShopDto>, Object?)> getStaffsShops({
    required List<String> shopIds,
    Object? cursor,
    int limit = 20,
  }) async {
    final offset = (cursor as int?) ?? 0;
    final end = (offset + limit).clamp(0, shopIds.length);
    final page = shopIds.sublist(offset, end);

    if (page.isEmpty) return (<StaffShopDto>[], null);

    final snapshot = await _firestore
        .collection('shops')
        .where(FieldPath.documentId, whereIn: page)
        .get();

    final dtos = snapshot.docs
        .map((doc) => StaffShopDto.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();

    final nextOffset = end < shopIds.length ? end : null;
    return (dtos, nextOffset);
  }

  @override
  Future<(List<ShopActivityLogDto>, Object?)> fetchShopActivityLogs({
    required String shopId,
    String? userId,
    Object? cursor,
    int limit = 20,
  }) async {
    // Path - shops/{shopId}/activityLogs
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;

    // Build the base collection reference
    CollectionReference<Map<String, dynamic>> collection = _firestore
        .collection(_shopCollectionName)
        .doc(shopId)
        .collection('activityLogs');

    // Apply userId filter first, before orderBy / limit / cursor so that
    // startAfterDocument uses a cursor that belongs to the same filtered query.
    Query<Map<String, dynamic>> query = userId != null
        ? collection.where('customerId', isEqualTo: userId)
        : collection;

    query = query.orderBy('timestamp', descending: true).limit(limit);

    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return (const <ShopActivityLogDto>[], null);
    }

    final dtos = snapshot.docs.map(ShopActivityLogDto.fromFirestore).toList();

    final lastDoc = snapshot.docs.length == limit ? snapshot.docs.last : null;

    return (dtos, lastDoc);
  }
}
