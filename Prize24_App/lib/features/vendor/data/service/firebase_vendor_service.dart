import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/features/vendor/data/dto/vendor_friend_frequest_dto.dart';
import 'package:prize24_app/features/vendor/data/dto/vendor_friends_dto.dart';
import 'package:prize24_app/features/vendor/data/dto/vendor_sent_request_dto.dart';
import 'package:prize24_app/features/vendor/data/service/i_vendor_service.dart';

class FirebaseVendorService implements IVendorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final String _vendorCollectionName = 'vendors';

  final String _usersCollectionName = 'users';

  final String _vendorFriendshipCollectionName = 'vendorFriendships';

  // Collection for requests
  // final String _vendorRequestsCollectionName = 'vendorFriendshipRequests';

  @override
  Future<void> becomeAVendor({
    required String userId,
    required String? vendorPhoneNumber,
  }) async {
    // Update 'user' collection in firebase with isVendor field to true
    await _firestore.collection(_usersCollectionName).doc(userId).update({
      'isVendor': true,
    });
  }

  @override
  Future<void> editVendorProfile({
    required String vendorId,
    required String? vendorPhoneNumber,
    required String? userName,
  }) async {
    // Update the vendor's phone number in the vendor collection
    await _firestore.collection(_usersCollectionName).doc(vendorId).update({
      'vendorPhoneNumber': vendorPhoneNumber,
      'userName': userName,
    });
  }

  // @override
  // Future<void> sendVendorFriendRequest({required String receiverId}) async {
  //   // Create a friend request document with sender's name
  //   await _firestore.collection(_vendorRequestsCollectionName).add({
  //     'senderId': userVendorId,
  //     'senderName': senderName,
  //     'receiverId': targetVendorId,
  //     'status': 'pending',
  //     'createdAt': FieldValue.serverTimestamp(),
  //   });
  // }

  // @override
  // Future<VendorFriendsDto> acceptFriendRequest({
  //   required String requesterVendorId,
  //   required String userVendorId,
  //   required String requesterName, // Add sender's name as parameter
  //   required String acceptingVendorName, // Add receiver's name as parameter
  // }) async {
  //   final batch = _firestore.batch();

  //   // 1. Update the friend request status
  //   final requestQuery = await _firestore
  //       .collection(_vendorRequestsCollectionName)
  //       .where('senderId', isEqualTo: requesterVendorId)
  //       .where('receiverId', isEqualTo: userVendorId)
  //       .where('status', isEqualTo: 'pending')
  //       .limit(1)
  //       .get();

  //   if (requestQuery.docs.isNotEmpty) {
  //     batch.update(requestQuery.docs.first.reference, {'status': 'accepted'});
  //   }

  //   // 2. Create TWO friendship documents with names
  //   batch
  //     ..set(
  //         _firestore
  //             .collection(_vendorFriendshipCollectionName)
  //             .doc('${userVendorId}_$requesterVendorId'),
  //         {
  //           'userId': userVendorId,
  //           'userName': acceptingVendorName,
  //           'friendId': requesterVendorId,
  //           'friendName': requesterName,
  //           'createdAt': FieldValue.serverTimestamp(),
  //         })
  //     ..set(
  //         _firestore
  //             .collection(_vendorFriendshipCollectionName)
  //             .doc('${requesterVendorId}_$userVendorId'),
  //         {
  //           'userId': requesterVendorId,
  //           'userName': requesterName,
  //           'friendId': userVendorId,
  //           'friendName': acceptingVendorName,
  //           'createdAt': FieldValue.serverTimestamp(),
  //         });

  //   await batch.commit();

  //   // Return a DTO for the requested vendors friendship
  //   return VendorFriendsDto(
  //     id: '${userVendorId}_$requesterVendorId',
  //     userId: requesterVendorId,
  //     vendorName: requesterName,
  //   );
  // }

  @override
  Future<(List<VendorFriendsDto>, Object?)> getVendorFriends({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;

    var query = _firestore
        .collection(_vendorFriendshipCollectionName)
        .where('participants', arrayContains: vendorId)
        .where('status', isEqualTo: 'accepted')
        .orderBy('acceptedAt', descending: true)
        .limit(limit);

    if (firestoreCursor != null)
      query = query.startAfterDocument(firestoreCursor);

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) return (<VendorFriendsDto>[], null);

    final lastDoc = snapshot.docs.last;

    final data = snapshot.docs.map((doc) {
      final d = doc.data();
      // Determine the friend's ID and name based on the current vendorId
      final friendId = (d['receiverId'] == vendorId)
          ? d['requesterId'] as String
          : d['receiverId'] as String;
      final friendName = (d['receiverId'] == vendorId)
          ? d['requesterName'] as String
          : d['receiverName'] as String;
      return VendorFriendsDto(
        id: doc.id,
        userId: friendId,
        vendorName: friendName,
      );
    }).toList();

    final userIds = data.map((f) => f.userId).toList();

    // Get all user names in a single query to avoid N+1 problem
    final usersSnapshot = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: userIds)
        .get();

    // Inject the real userName from the `users` collection
    final userMap = {
      for (final doc in usersSnapshot.docs)
        doc.id: doc.data()['userName'] as String,
    };

    for (int i = 0; i < data.length; i++) {
      final userName = userMap[data[i].userId];
      if (userName != null) {
        data[i] = data[i].copyWith(vendorName: userName);
      }
    }

    return (data, lastDoc);
  }

  @override
  Future<(List<VendorFriendFrequestDto>, Object?)> getVendorFriendRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;

    var query = _firestore
        .collection(_vendorFriendshipCollectionName)
        .where('receiverId', isEqualTo: vendorId)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (firestoreCursor != null)
      query = query.startAfterDocument(firestoreCursor);

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) return (<VendorFriendFrequestDto>[], null);

    final lastDoc = snapshot.docs.last;

    return (
      snapshot.docs.map((doc) {
        final data = doc.data();
        return VendorFriendFrequestDto(
          id: doc.id,
          vendorId: data['requesterId'] as String,
          vendorName: data['requesterName'] as String,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        );
      }).toList(),
      lastDoc,
    );
  }

  @override
  Future<void> removeFriend({required String friendshipId}) async {
    /*
   // Direct delete operation - secured by Firestore rules
const removeFriend = async (friendshipId) => {
  try {
    await db.collection('friendships').doc(friendshipId).delete();
    console.log('Friend removed successfully');
  } catch (error) {
    console.error('Error removing friend:', error);
    // Handle permission denied or other errors
  }
};
   */

    await _firestore
        .collection(_vendorFriendshipCollectionName)
        .doc(friendshipId)
        .delete();
  }

  @override
  Future<VendorFriendsDto?> respondToFriendRequest({
    required String friendshipId,
    required String action,
  }) async {
    // Call the cloud function - respondToFriendRequest
    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable('respondToFriendRequest');

    await callable.call<dynamic>({
      'friendshipId': friendshipId,
      'action': action,
    });

    return null;
  }

  @override
  Future<void> sendVendorFriendRequest({required String receiverId}) async {
    // Call the cloud function - sendFriendRequest
    try {
      final functions = FirebaseFunctions.instance;
      await functions.httpsCallable('sendFriendRequest').call<dynamic>({
        'receiverId': receiverId,
      });
    } catch (e) {
      // TODO
      print(e.toString());
      rethrow;
    }

    // final result = await FirebaseFunctions.instance
    //                         .httpsCallable(
    //                             'textAvailPublicFullTextCodeCampaign')
    //                         .call(
    //                       {
    //                         'userId': 'JINQFsMJW9Ta5qAhmRSmnw8lhh02',
    //                         'campaignSlug': 'computer-codes-give-away',
    //                         // 'giftSlug': 'get-avg-antivirus',
    //                         'giftSlug': 'get-xboxforme',
    //                         'code': 'kobayasi',
    //                       },
    //                     );
  }

  @override
  Future<(List<VendorSentRequestDto>, Object?)> getVendorSentRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;

    var query = _firestore
        .collection(_vendorFriendshipCollectionName)
        .where('requesterId', isEqualTo: vendorId)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (firestoreCursor != null)
      query = query.startAfterDocument(firestoreCursor);

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) return (<VendorSentRequestDto>[], null);

    final lastDoc = snapshot.docs.last;

    return (
      snapshot.docs.map((doc) {
        final data = doc.data();
        return VendorSentRequestDto(
          id: doc.id,
          receiverId: data['receiverId'] as String,
          receiverName: data['receiverName'] as String,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          status: data['status'] as String,
        );
      }).toList(),
      lastDoc,
    );
  }

  @override
  Future<void> registerAsVendor({required String userId}) async {
    await _firestore.collection(_usersCollectionName).doc(userId).update({
      'isVendor': true,
    });
  }

  @override
  Future<void> registerVendorPhoneNumber({
    required String userId,
    required String vendorPhoneNumber,
  }) async {
    await _firestore.collection(_usersCollectionName).doc(userId).update({
      'vendorPhoneNumber': vendorPhoneNumber,
    });
  }

  @override
  Future<String?> cancelSentRequest({required String requestId}) async {
    await _firestore
        .collection(_vendorFriendshipCollectionName)
        .doc(requestId)
        .delete();

    return requestId;
  }
}
