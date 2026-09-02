import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/features/gift/data/dto/gift_analytics_dto.dart';
import 'package:prize24_app/features/gift/data/dto/gift_dto.dart';
import 'package:prize24_app/features/gift/data/dto/user_gift_dto.dart';
import 'package:prize24_app/features/gift/data/service/i_gift_service.dart';

class FirebaseGiftService implements IGiftService {
  final _firestore = FirebaseFirestore.instance;

  final String _campaignsCollection = 'campaigns';

  /// Sub collection name for gifts inside campaigns collection.
  final String _giftsSubCollection = 'gifts';

  final String _userGiftsCollection = 'user_gifts';

  @override
  Future<void> redeemGift({
    required String availedgiftId,
    required String userId,
  }) async {
    // Change the is Redeemed field in the gift document to true
    // in the _userGiftsCollection collection.

    // Get the gift document from the _userGiftsCollection manin collection by avaikedgiftId
    final giftDoc = _firestore
        .collection(_userGiftsCollection)
        .doc(availedgiftId);

    // Update the gift document to set isRedeemed to true
    await giftDoc.update({'isRedeemed': true, 'redeemedByUserId': userId});
  }

  @override
  Future<GiftAnalyticsDto> getGiftAnalytics({required String giftId}) async {
    // Fetch the gift document from the Firestore
    final giftDoc = _firestore
        .collection(_campaignsCollection)
        .doc(giftId)
        .collection(_giftsSubCollection)
        .doc(giftId);

    final snapshot = await giftDoc.get();
    if (!snapshot.exists) {
      throw Exception('Gift not found');
    }

    final data = snapshot.data()!;
    return GiftAnalyticsDto.fromJson(data);
  }

  // @override
  // Future<GiftDto> createGift({
  //   required GiftDto giftDto,
  // }) async {
  //   // Will create a new gift document in the Firestore as subcollection
  //   // under the specified campaign.

  //   try {
  //     // Gift Type is AUTO and isRedeemable is FALSE
  //     if (giftDto.giftType == GiftType.auto.name &&
  //         giftDto.isRedeemable == false) {
  //       final campaignDoc =
  //           _firestore.collection(_campaignsCollection).doc(giftDto.campaignId);

  //       final giftDoc = campaignDoc.collection(_giftsSubCollection).doc();
  //       final newGift = giftDto.copyWith(
  //         createdAt: DateTime.now(),
  //         updatedAt: DateTime.now(),
  //         autoGiftPayloads: null,
  //       );

  //       // Set the gift document with the new gift data
  //       await giftDoc.set(newGift.toFirestoreJson());

  //       // Create a sub collection inside gift document and set payloads as data
  //       if (giftDto.autoGiftPayloads != null) {
  //         for (final payload in giftDto.autoGiftPayloads!) {
  //           await giftDoc.collection('autoGiftPayloads').add(payload.toJson());
  //         }
  //       }

  //       await giftDoc.set(newGift.toFirestoreJson());
  //       return newGift.copyWith(id: giftDoc.id);
  //     }

  //     // Gift Type is AUTO and isRedeemable is TRUE
  //     if (giftDto.giftType == GiftType.auto.name &&
  //         giftDto.isRedeemable == true) {
  //       final campaignDoc =
  //           _firestore.collection(_campaignsCollection).doc(giftDto.campaignId);
  //       final giftDoc = campaignDoc.collection(_giftsSubCollection).doc();
  //       final newGift = giftDto.copyWith(
  //         createdAt: DateTime.now(),
  //         updatedAt: DateTime.now(),
  //       );
  //       await giftDoc.set(newGift.toFirestoreJson());
  //       return newGift.copyWith(id: giftDoc.id);
  //     }

  //     // Gift Type is CODE and isRedeemable is TRUE
  //     if (giftDto.giftType == GiftType.code.name &&
  //         giftDto.isRedeemable == true) {
  //       final campaignDoc =
  //           _firestore.collection(_campaignsCollection).doc(giftDto.campaignId);
  //       final giftDoc = campaignDoc.collection(_giftsSubCollection).doc();
  //       final newGift = giftDto.copyWith(
  //         createdAt: DateTime.now(),
  //         updatedAt: DateTime.now(),
  //       );
  //       await giftDoc.set(newGift.toFirestoreJson());

  //       // Create a sub collection inside gift document and set codes as data
  //       if (giftDto.codegiftCodes != null) {
  //         for (final code in giftDto.codegiftCodes!) {
  //           await giftDoc.collection('codeGiftCodes').add(code.toJson());
  //         }
  //       }

  //       return newGift.copyWith(id: giftDoc.id);
  //     }

  //     // Gift Type is CODE and isRedeemable is FALSE
  //     if (giftDto.giftType == GiftType.code.name &&
  //         giftDto.isRedeemable == false) {
  //       final campaignDoc =
  //           _firestore.collection(_campaignsCollection).doc(giftDto.campaignId);
  //       final giftDoc = campaignDoc.collection(_giftsSubCollection).doc();
  //       final newGift = giftDto.copyWith(
  //         createdAt: DateTime.now(),
  //         updatedAt: DateTime.now(),
  //       );
  //       await giftDoc.set(newGift.toFirestoreJson());

  //       // Create a sub collection inside gift document and set payloads as data
  //       if (giftDto.codegiftCodes != null) {
  //         for (final payload in giftDto.codegiftCodes!) {
  //           await giftDoc.collection('codeGiftCodes').add(payload.toJson());
  //         }
  //       }

  //       return newGift.copyWith(id: giftDoc.id);
  //     }
  //     throw Exception('Invalid gift type or redeemable status');
  //   } catch (e) {
  //     // TODO
  //     rethrow;
  //   }
  // }

  @override
  Future<(List<UserGiftDto>, Object?)> fetchUsersAllGifts({
    required String userId,
    Object? cursor,
    int limit = 20,
  }) async {
    final firestoreCursor = cursor as DocumentSnapshot?;

    var query = _firestore
        .collection(_userGiftsCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('availedAt', descending: true)
        .limit(limit);

    if (firestoreCursor != null) {
      query = query.startAfterDocument(firestoreCursor);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) {
      return (<UserGiftDto>[], null);
    }

    final dtos = snapshot.docs
        .map((doc) => UserGiftDto.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();

    final nextCursor = snapshot.docs.length < limit ? null : snapshot.docs.last;
    return (dtos, nextCursor);
  }

  @override
  Future<List<GiftDto>> fetchCampaignGifts({
    required String campaignId,
    int? page,
    int? limit,
  }) async {
    // Fetch all gifts that are under a campaign.
    final query = _firestore
        .collection(_campaignsCollection)
        .doc(campaignId)
        .collection(_giftsSubCollection);

    // Dont care pagination for now, just return all gifts
    // No Pagination for now, just return all gifts
    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) {
      return [];
    }
    log(snapshot.docs.toString());
    return snapshot.docs
        .map((doc) => GiftDto.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  @override
  Future<GiftDto> createAutoNonRedeemableGift({
    required GiftDto giftDto,
    required List<AutoGiftPayloadDto> autoGiftPayloadDtos,
  }) async {
    // final campaignDoc =
    //     _firestore.collection(_campaignsCollection).doc(giftDto.campaignId);

    // final giftDoc = campaignDoc.collection(_giftsSubCollection).doc();
    // final newGift = giftDto.copyWith(
    //   createdAt: DateTime.now(),
    //   updatedAt: DateTime.now(),
    // );

    // // Set the gift document with the new gift data
    // await giftDoc.set(newGift.toFirestoreJson());

    // // Create a sub collection inside gift document and set payloads as data
    // for (final payload in autoGiftPayloadDtos) {
    //   await giftDoc.collection('autoGiftPayloads').add(payload.toJson());
    // }

    // return newGift.copyWith(id: giftDoc.id);

    throw UnimplementedError();
  }

  @override
  Future<GiftDto> createAutoRedeemableGift({required GiftDto giftDto}) async {
    final batch = _firestore.batch();

    final campaignDoc = _firestore
        .collection(_campaignsCollection)
        .doc(giftDto.campaignId);

    // Limit the number of gifts per campaign to 10.
    // Read only up to 10 docs; if we get 10 back, the cap has been reached.
    final existingGiftsSnapshot = await campaignDoc
        .collection(_giftsSubCollection)
        .limit(10)
        .get();
    if (existingGiftsSnapshot.docs.length >= 10) {
      throw Exception('Cannot add more than 10 gifts to a campaign');
    }

    final giftDoc = campaignDoc.collection(_giftsSubCollection).doc();

    final newGift = giftDto.copyWith(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final supportedShopsId = giftDto.supportedShops!.map((e) => e.id).toList();

    final campaignId = giftDto.campaignId;

    // Add campaignId to all supported shops
    for (final shopId in supportedShopsId) {
      final shopDoc = _firestore.collection('shops').doc(shopId);
      batch.update(shopDoc, {
        'supportedCampaigns': FieldValue.arrayUnion([campaignId]),
      });
    }

    // Set the gift document with the new gift data
    batch
      ..set(giftDoc, newGift.toFirestoreJson())
      // Update totalGiftsAdded and remainingGifts fields in campaign document
      ..update(campaignDoc, {
        'totalGiftsAdded': FieldValue.increment(giftDto.totalQuantity),
        'remainingGifts': FieldValue.increment(-giftDto.totalQuantity),
      });

    await batch.commit();

    return newGift.copyWith(id: giftDoc.id);
  }

  @override
  Future<GiftDto> createCodeGift({
    required GiftDto giftDto,
    required List<CodeGiftCodeDto> codeGiftCodes,
  }) async {
    // final campaignDoc =
    //     _firestore.collection(_campaignsCollection).doc(giftDto.campaignId);
    // final giftDoc = campaignDoc.collection(_giftsSubCollection).doc();
    // final newGift = giftDto.copyWith(
    //   createdAt: DateTime.now(),
    //   updatedAt: DateTime.now(),
    // );
    // await giftDoc.set(newGift.toFirestoreJson());

    // // Create a sub collection inside gift document and set payloads as data
    // for (final payload in codeGiftCodes) {
    //   await giftDoc.collection('codeGiftCodes').add(payload.toJson());
    // }

    // return newGift.copyWith(id: giftDoc.id);

    throw UnimplementedError();
  }

  @override
  Future<GiftDto> editGift({required GiftDto giftDto}) async {
    final giftDoc = _firestore
        .collection(_campaignsCollection)
        .doc(giftDto.campaignId)
        .collection(_giftsSubCollection)
        .doc(giftDto.id);

    // Get this gifts's current data from firestore to check if the campaignId or supportedShops have been changed. If changed, we need to update the supportedCampaigns field in shops collection accordingly.
    // Get current gift's totalQuantity in this gift from firestore
    final snapshot = await giftDoc.get();
    if (!snapshot.exists) {
      throw Exception('Gift not found');
    }
    final previousGift = GiftDto.fromJson(snapshot.data()!);

    final batch = _firestore.batch();

    batch.update(giftDoc, giftDto.toFirestoreJson());

    if (previousGift.totalQuantity != giftDto.totalQuantity) {
      // Update totalGiftsAdded field in campaign document to total quantity of gifts added
      final campaignDoc = _firestore
          .collection(_campaignsCollection)
          .doc(giftDto.campaignId);
      // totalGiftsAdded - Will effect
      batch.update(campaignDoc, {
        'totalGiftsAdded': FieldValue.increment(
          giftDto.totalQuantity - previousGift.totalQuantity,
        ),
      });
    }

    // Handle supportedShops changes
    if (giftDto.supportedShops != null) {
      // Get previous shop IDs
      final previousShopIds =
          previousGift.supportedShops?.map((shop) => shop.id).toSet() ??
          <String>{};

      // Get new shop IDs
      final newShopIds = giftDto.supportedShops!.map((shop) => shop.id).toSet();

      // Find newly added shops (in new but not in previous)
      final addedShopIds = newShopIds.difference(previousShopIds);

      // Find removed shops (in previous but not in new)
      final removedShopIds = previousShopIds.difference(newShopIds);

      // Add campaignId to newly added shops
      for (final shopId in addedShopIds) {
        final shopDoc = _firestore.collection('shops').doc(shopId);
        batch.update(shopDoc, {
          'supportedCampaigns': FieldValue.arrayUnion([giftDto.campaignId]),
        });
      }

      // Remove campaignId from removed shops
      for (final shopId in removedShopIds) {
        final shopDoc = _firestore.collection('shops').doc(shopId);
        batch.update(shopDoc, {
          'supportedCampaigns': FieldValue.arrayRemove([giftDto.campaignId]),
        });
      }
    }

    await batch.commit();

    return giftDto.copyWith(id: giftDoc.id);
  }

  @override
  Future<String> deleteAutoRedeemableGift({
    required String campaignId,
    required String giftId,
  }) async {
    try {
      final callable = FirebaseFunctions.instance.httpsCallable(
        'deleteAutoRedeemableGift',
      );

      final result = await callable.call(<String, dynamic>{
        'campaignId': campaignId,
        'giftId': giftId,
      });

      final data = result.data as Map<String, dynamic>? ?? {};
      final success = data['success'] == true;
      final responseData =
          (data['data'] as Map?)?.cast<String, dynamic>() ?? {};

      if (!success) {
        throw Exception('Function returned success=false');
      }

      final added = responseData['addedToTotalGiftsAdded'];
      logger.d(
        'Gift deleted successfully. Added back to totalGiftsAdded: $added',
      );

      return giftId;
    } on FirebaseFunctionsException catch (e) {
      logger
        ..e('Callable error code: ${e.code}')
        ..e('Callable error message: ${e.message}')
        ..e('Callable error details: ${e.details}');
      rethrow;
    } catch (e) {
      logger.e('Unexpected error: $e');
      rethrow;
    }
  }
}
