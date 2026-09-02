import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_campaign/staff_campaign_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/dto/staff_shop/staff_shop_dto.dart';
import 'package:prize24_app/features/shop_staffs/data/service/i_staff_service.dart';

class FirebaseStaffService implements IStaffService {
  final String staffCollection = 'shopStaff';
  final String campaignCollection = 'campaigns';
  final String shopCollection = 'shops';

  // Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<StaffShopDto>> getShopsForStaff(
    String staffId, {
    int page = 1,
    int limit = 10,
  }) async {
    throw UnimplementedError('getShopsForStaff is not implemented yet.');
    // final querySnapshot = await _firestore
    //     .collection(staffCollection)
    //     .where('userId', isEqualTo: staffId)
    //     .get();

    // final shopIds =
    //     querySnapshot.docs.map((doc) => doc['shopId'] as String).toList();

    // // Fetch shop details for each shopId
    // final shopsQuery = await _firestore
    //     .collection(shopCollection)
    //     .where(FieldPath.documentId, whereIn: shopIds)
    //     .get();

    // return shopsQuery.docs.map(
    //   (doc) {
    //     final data = doc.data();
    //     return StaffShopDto(
    //       id: doc.id,
    //       name: data['shopName'] as String,
    //       associatedClub: data['associatedClub'] as String?,
    //     );
    //   },
    // ).toList();

    // return querySnapshot.docs
    //     .map(
    //       (doc) => StaffShopDto(
    //         id: doc['shopId'] as String,
    //         name: doc['shopName'] as String,
    //       ),
    //     )
    //     .toList();
  }

  @override
  Future<(List<StaffCampaignDto>, Object?)> getCampaignsForShop(
    String shopId, {
    Object? cursor,
    int limit = 20,
  }) async {
    final offset = (cursor as int?) ?? 0;

    // Fetch the shop doc to get the supportedCampaigns list
    final shopDoc = await _firestore
        .collection(shopCollection)
        .doc(shopId)
        .get();
    if (!shopDoc.exists) {
      throw Exception('Shop not found');
    }

    final supportedCampaigns = List<String>.from(
      shopDoc.data()?['supportedCampaigns'] as List? ?? [],
    );

    if (supportedCampaigns.isEmpty) return (<StaffCampaignDto>[], null);

    final end = (offset + limit).clamp(0, supportedCampaigns.length);
    final page = supportedCampaigns.sublist(offset, end);

    if (page.isEmpty) return (<StaffCampaignDto>[], null);

    final campaignQuery = await _firestore
        .collection(campaignCollection)
        .where(FieldPath.documentId, whereIn: page)
        .get();

    final dtos = campaignQuery.docs
        .map(
          (doc) => StaffCampaignDto(
            id: doc.id,
            name: doc['name'] as String,
            description: doc['description'] as String,
            visibility: doc['visibility'] as String,
            giftType: doc['allowedGiftType'] as String,
            totalGifts: (doc['totalGifts'] as int?) ?? 0,
            remainingGifts: (doc['remainingGifts'] as int?) ?? 0,
            totalParticipants: (doc['totalParticipants'] as int?) ?? 0,
            totalGiftsAdded: (doc['totalGiftsAdded'] as int?) ?? 0,
          ),
        )
        .toList();

    final nextOffset = end < supportedCampaigns.length ? end : null;
    return (dtos, nextOffset);
  }

  @override
  Future<void> availGiftByStaff({
    required String campaignId,
    required String shopId,
  }) {
    // TODO: implement availGiftByStaff with Firebase API calls
    throw UnimplementedError();
  }

  @override
  Future<void> redeemGiftByStaff({
    required String giftId,
    required String shopId,
    required String campaignId,
  }) {
    // TODO: implement redeemGiftByStaff with Firebase API calls
    throw UnimplementedError();
  }
}
