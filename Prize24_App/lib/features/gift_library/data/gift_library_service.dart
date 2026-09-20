import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/gift_library/domain/gift_library_models.dart';
import 'package:prize24_app/utils/app_specific_convertors.dart';

final giftLibraryServiceProvider = Provider<GiftLibraryService>((ref) {
  return GiftLibraryService();
});

class GiftLibraryService {
  GiftLibraryService({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _functions = functions ?? FirebaseFunctions.instance;

  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  CollectionReference<Map<String, dynamic>> get _libraries =>
      _firestore.collection('giftLibraries');

  Future<List<GiftLibraryModel>> listOwnedLibraries(
    String ownerVendorId,
  ) async {
    final snapshot = await _libraries
        .where('ownerVendorId', isEqualTo: ownerVendorId)
        .get();
    final libraries = snapshot.docs.map(GiftLibraryModel.fromFirestore).toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return libraries;
  }

  Future<GiftLibraryModel> createLibrary({
    required String ownerVendorId,
    required String name,
    required String description,
  }) async {
    final now = Timestamp.now();
    final reference = await _libraries.add({
      'ownerVendorId': ownerVendorId,
      'name': name.trim(),
      'description': description.trim(),
      'status': 'active',
      'createdAt': now,
      'updatedAt': now,
    });
    return GiftLibraryModel.fromFirestore(await reference.get());
  }

  Future<void> updateLibrary({
    required String libraryId,
    required String name,
    required String description,
  }) {
    return _libraries.doc(libraryId).update({
      'name': name.trim(),
      'description': description.trim(),
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> archiveLibrary(String libraryId) async {
    await _functions.httpsCallable('archiveGiftLibrary').call<dynamic>({
      'giftLibraryId': libraryId,
    });
  }

  Future<GiftLibraryUsage> getLibraryUsage(String libraryId) async {
    final response = await _functions
        .httpsCallable('getGiftLibraryUsage')
        .call<dynamic>({'giftLibraryId': libraryId});
    return GiftLibraryUsage.fromMap(
      CFSpecificConvertors.convertCFMapToStringDynamic(response.data),
    );
  }

  Future<List<LibraryGiftModel>> listGifts(String libraryId) async {
    final snapshot = await _libraries.doc(libraryId).collection('gifts').get();
    final gifts = snapshot.docs.map(LibraryGiftModel.fromFirestore).toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return gifts;
  }

  Future<LibraryGiftModel> createGift({
    required String libraryId,
    required String name,
    required String description,
  }) async {
    final now = Timestamp.now();
    final reference = await _libraries.doc(libraryId).collection('gifts').add({
      'name': name.trim(),
      'description': description.trim(),
      'status': 'active',
      'createdAt': now,
      'updatedAt': now,
    });
    return LibraryGiftModel.fromFirestore(await reference.get());
  }

  Future<void> updateGift({
    required String libraryId,
    required String giftId,
    required String name,
    required String description,
  }) {
    return _libraries.doc(libraryId).collection('gifts').doc(giftId).update({
      'name': name.trim(),
      'description': description.trim(),
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> archiveGift({
    required String libraryId,
    required String giftId,
  }) {
    return _libraries.doc(libraryId).collection('gifts').doc(giftId).update({
      'status': 'archived',
      'updatedAt': Timestamp.now(),
    });
  }

  Future<AttachedGiftLibraryModel> getAttachedLibrary(
    String shopId, {
    String? opportunityId,
    String? followerUserId,
  }) async {
    final result = await _functions
        .httpsCallable('getAttachedGiftLibrary')
        .call<dynamic>({
          'shopId': shopId,
          if (opportunityId != null) 'opportunityId': opportunityId,
          if (followerUserId != null) 'followerUserId': followerUserId,
        });
    final data = CFSpecificConvertors.convertCFMapToStringDynamic(result.data);
    final libraryData = data['library'];
    final giftsData = data['gifts'] as List<dynamic>? ?? const [];
    return AttachedGiftLibraryModel(
      library: libraryData is Map
          ? GiftLibraryModel.fromMap(
              CFSpecificConvertors.convertCFMapToStringDynamic(libraryData),
            )
          : null,
      gifts: giftsData
          .map(CFSpecificConvertors.convertCFMapToStringDynamic)
          .map(LibraryGiftModel.fromMap)
          .toList(),
    );
  }

  Future<List<RewardOpportunityListItem>> listPendingRewards(
    String shopId,
  ) async {
    final snapshot = await _firestore
        .collection('shops')
        .doc(shopId)
        .collection('rewardOpportunities')
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map(RewardOpportunityListItem.fromFirestore).toList();
  }

  Future<RewardResolutionResult> resolveReward({
    required String shopId,
    required String userId,
    required String opportunityId,
    required String source,
    String? giftId,
  }) async {
    final result = await _functions
        .httpsCallable('resolveShopReward')
        .call<dynamic>({
          'shopId': shopId,
          'userId': userId,
          'opportunityId': opportunityId,
          'source': source,
          if (giftId != null) 'giftId': giftId,
        });
    return RewardResolutionResult.fromMap(
      CFSpecificConvertors.convertCFMapToStringDynamic(result.data),
    );
  }

  Future<RewardResolutionResult> assignManualGift({
    required String shopId,
    required String userId,
    required String giftId,
    required String requestId,
  }) async {
    final result = await _functions
        .httpsCallable('assignManualLibraryGift')
        .call<dynamic>({
          'shopId': shopId,
          'userId': userId,
          'giftId': giftId,
          'requestId': requestId,
        });
    return RewardResolutionResult.fromMap(
      CFSpecificConvertors.convertCFMapToStringDynamic(result.data),
    );
  }

  Future<void> redeemShopGift({
    required String shopId,
    required String userGiftId,
  }) async {
    await _functions.httpsCallable('redeemShopGift').call<dynamic>({
      'shopId': shopId,
      'userGiftId': userGiftId,
    });
  }
}
