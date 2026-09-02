import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/features/campaign/data/dto/campaign_activity_log_dto.dart';
import 'package:prize24_app/features/campaign/data/dto/campaign_dto.dart';
import 'package:prize24_app/features/campaign/data/dto/campaign_shared_vendor_dto.dart';
import 'package:prize24_app/features/campaign/data/dto/campaign_sharing_request_dto.dart';
import 'package:prize24_app/features/campaign/data/dto/gift_redemption_audit_log_dto.dart';
import 'package:prize24_app/features/campaign/data/services/i_campaign_services.dart';

class FirebaseCampaignService implements ICampaignService {
  /// Collection name for campaigns
  /// This is used to store the campaigns created by vendors
  final String _collectionName = 'campaigns';

  // campaignShareRequest
  final String _campaignShareRequest = 'campaignShareRequest';

  /// Subcollection name for shared vendors in each campaign
  /// This is used to store the vendors that are shared with the campaign
  final String _sharedVendors = 'sharedVendors';
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> deleteCampaign({required String campaignId}) async {
    final campaignDoc = _firestore.collection(_collectionName).doc(campaignId);
    await campaignDoc.delete();
  }

  @override
  Future<CampaignDto> addCampaign({required CampaignDto campaign}) async {
    final campaignDoc = _firestore.collection(_collectionName).doc();
    await campaignDoc.set(campaign.toJson());
    return campaign.copyWith(id: campaignDoc.id);
  }

  @override
  Future<void> editCampaign({
    required String campaignId,
    required String? name,
    required String? description,
    required int? totalParticipants,
    required int? totalGifts,
  }) async {
    final campaignDoc = _firestore.collection(_collectionName).doc(campaignId);

    // Get current campaign data
    final campaignSnapshot = await campaignDoc.get();
    if (!campaignSnapshot.exists) {
      throw Exception('Campaign not found');
    }
    final currentData = CampaignDto.fromJson(campaignSnapshot.data()!);

    final updates = <String, dynamic>{};

    if (totalParticipants != null &&
        currentData.totalParticipants != totalParticipants) {
      // Calculate participated count
      final participated =
          currentData.totalParticipants - currentData.remainingParticipants;

      // Validate that new total is not less than already participated
      if (totalParticipants < participated) {
        throw Exception(
          'Cannot set total participants ($totalParticipants) lower than already participated count ($participated)',
        );
      }

      // Calculate updated remaining participants
      final updatedRemainingParticipants = totalParticipants - participated;
      updates['remainingParticipants'] = updatedRemainingParticipants;
    }

    if (totalGifts != null && currentData.totalGifts != totalGifts) {
      // Calculate claimed gifts count
      final claimedGifts = currentData.totalGifts - currentData.remainingGifts;

      // Validate that new total is not less than already claimed
      if (totalGifts < claimedGifts) {
        throw Exception(
          'Cannot set total gifts ($totalGifts) lower than already claimed gifts count ($claimedGifts)',
        );
      }

      // Calculate updated remaining gifts
      final updatedRemainingGifts = totalGifts - claimedGifts;
      updates['remainingGifts'] = updatedRemainingGifts;
    }

    if (name != null) updates['name'] = name;
    if (description != null) updates['description'] = description;
    if (totalParticipants != null) {
      updates['totalParticipants'] = totalParticipants;
    }
    if (totalGifts != null) updates['totalGifts'] = totalGifts;

    await campaignDoc.update(updates);
  }

  @override
  Future<void> addVendorsToCampaign({
    required String campaignId,
    required List<String> recipientIds,
  }) async {
    // We have subcollection for vendors in each campaign
    final campaignDoc = _firestore.collection(_collectionName).doc(campaignId);
    final vendorsCollection = campaignDoc.collection(_sharedVendors);
    for (final recipientId in recipientIds) {
      await vendorsCollection.doc(recipientId).set({'vendorId': recipientId});
    }
  }

  @override
  Future<List<CampaignSharedVendorDto>> listSharedVendorsOfCampaign({
    required String campaignId,
  }) async {
    final campaignDoc = _firestore.collection(_collectionName).doc(campaignId);
    final vendorsCollection = campaignDoc.collection(_sharedVendors);

    final sharedVendorsSnapshot = await vendorsCollection.get();
    final sharedVendors = sharedVendorsSnapshot.docs
        .map((doc) => CampaignSharedVendorDto.fromJson(doc.data()))
        .toList();

    return sharedVendors;
  }

  @override
  Future<List<CampaignDto>> listVendorAllCampaigns({
    required String userId,
    // Todo: Workaround for shared campaigns
    required String vendorName,
    required String vendorPhone,
  }) async {
    final campaignsSnapshot = await _firestore
        .collection(_collectionName)
        .where('vendorId', isEqualTo: userId)
        .get();

    final sharedCampaignsSnapshot = await _firestore
        .collection(_collectionName)
        .where(
          'sharedVendors',
          arrayContains: {
            'id': userId,
            'name': vendorName,
            'phone': vendorPhone,
          },
        )
        .get();

    final ownCampaigns = campaignsSnapshot.docs.map(
      (doc) => CampaignDto.fromJson(doc.data()).copyWith(id: doc.id),
    );

    final sharedCampaigns = sharedCampaignsSnapshot.docs.map(
      (doc) => CampaignDto.fromJson(doc.data()).copyWith(id: doc.id),
    );

    return [...ownCampaigns, ...sharedCampaigns].toList();
  }

  @override
  Future<void> scanCampaignForGifts({
    required String campaignId,
    required String userId,
  }) {
    // TODO: implement scanCampaignForGifts
    throw UnimplementedError();
  }

  @override
  Future<void> addVendorToCampaign({
    required String recipientId,
    required String campaignId,
  }) async {
    // Call Cloud function - sendCampaignShareRequest
    await FirebaseFunctions.instance
        .httpsCallable('sendCampaignShareRequest')
        .call<dynamic>({'recipientId': recipientId, 'campaignId': campaignId});
  }

  @override
  Future<void> respondToSharedCampaignRequest({
    required String requestId,
    required String action,
  }) async {
    await FirebaseFunctions.instance
        .httpsCallable('respondToCampaignShareRequest')
        .call<dynamic>({'requestId': requestId, 'action': action});
    // throw UnimplementedError();
  }

  @override
  Future<(List<CampaignSharingRequestDto>, Object?)>
  listCampaignSharingRequests({
    required String vendorId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;
    var query = _firestore
        .collection(_campaignShareRequest)
        .where('recipientId', isEqualTo: vendorId)
        .where('status', isEqualTo: 'pending')
        .orderBy('requestedAt', descending: true)
        .limit(limit);

    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final snapshot = await query.get();

    final dtos = snapshot.docs
        .map(
          (doc) => CampaignSharingRequestDto.fromJson(
            doc.data(),
          ).copyWith(id: doc.id),
        )
        .toList();

    final lastDoc = snapshot.docs.length == limit ? snapshot.docs.last : null;

    return (dtos, lastDoc);
  }

  @override
  Future<bool> isCampaignPublicSlugAvailable({
    required String publicSlug,
  }) async {
    // Check if any campaign has the same public slug -- publicSlug in campaigns
    final snapshot = await _firestore
        .collection(_collectionName)
        .where('publicSlug', isEqualTo: publicSlug)
        .get();
    return snapshot.docs.isEmpty;
  }

  @override
  Future<List<String>> listUserIdsOfAlreadySendRequest({
    required String campaignId,
  }) async {
    // Get requests from campaignShareRequest collection
    // where campaignId == campaignId and status == pending
    final snapshot = await _firestore
        .collection(_campaignShareRequest)
        .where('campaignId', isEqualTo: campaignId)
        .where('status', isEqualTo: 'pending')
        .get();

    return snapshot.docs
        .map((doc) => doc.data()['recipientId'] as String)
        .toList();
  }

  @override
  Future<(List<GiftRedemptionAuditLogDto>, Object?)>
  getCampaignGiftRedemptionAuditLog({
    required String campaignId,
    Object? cursor,
    int limit = 10,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot?;

    var query = _firestore
        .collection(_collectionName)
        .doc(campaignId)
        .collection('redemptionLogs')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) {
      return (<GiftRedemptionAuditLogDto>[], null);
    }

    final dtos = snapshot.docs
        .map((doc) => GiftRedemptionAuditLogDto.fromJson(doc.data()))
        .toList();

    final nextCursor = snapshot.docs.length < limit ? null : snapshot.docs.last;
    return (dtos, nextCursor);
  }

  @override
  Future<(List<CampaignActivityLogDto>, Object?)> getCampaignActivityLog({
    required String campaignId,
    String? userId,
    Object? cursor,
    int limit = 10,
  }) async {
    // campaigns/{campaignId}/activityLogs
    final firestoreCursor = cursor as DocumentSnapshot<Map<String, dynamic>>?;

    // Apply userId filter BEFORE orderBy / limit / cursor so that
    // startAfterDocument uses a cursor belonging to the same filtered query.
    final CollectionReference<Map<String, dynamic>> collection = _firestore
        .collection(_collectionName)
        .doc(campaignId)
        .collection('activityLogs');

    Query<Map<String, dynamic>> query = userId != null
        ? collection.where('customerId', isEqualTo: userId)
        : collection;

    query = query.orderBy('timestamp', descending: true).limit(limit);

    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) {
      return (const <CampaignActivityLogDto>[], null);
    }

    final dtos = snapshot.docs
        .map(CampaignActivityLogDto.fromFirestore)
        .toList();

    final lastDoc = snapshot.docs.length == limit ? snapshot.docs.last : null;
    return (dtos, lastDoc);
  }

  @override
  Future<CampaignDto> getSingleCampaginById({
    required String campaignId,
  }) async {
    final campaignDoc = _firestore.collection(_collectionName).doc(campaignId);
    final campaignSnapshot = await campaignDoc.get();
    if (!campaignSnapshot.exists) {
      throw Exception('Campaign not found');
    }
    return CampaignDto.fromJson(
      campaignSnapshot.data()!,
    ).copyWith(id: campaignId);
  }
}
