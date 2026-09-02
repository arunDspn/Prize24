import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/features/shop/data/dto/check_in_response_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/club_entity_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/club_member_user_data_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/club_member_vendor_data_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/club_model_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/staff_club_detail_dto.dart';
import 'package:prize24_app/features/clubs/data/service/i_club_service.dart';
import 'package:prize24_app/features/clubs/domain/exceptions/exceptions.dart';

class FirebaseClubService implements IClubService {
  final _firestore = FirebaseFirestore.instance;

  /// Vendors collection reference
  /// Data will save in the following path:
  /// `users/{vendorId}/clubs/{clubId}`
  final _vendorClubCollection = 'clubs';

  final _userMembershipCollection = 'clubMemberships';

  /// Create a new club for a vendor
  @override
  Future<ClubModelDto> createClub({required ClubEntityDto club}) async {
    final data =
        await FirebaseFunctions.instance.httpsCallable('createClub').call({
      'name': club.name,
      'description': club.description,
      'giftDay': club.giftDay,
      'attachedCampaignId': club.attachedCampaignId,
      if (club.multipierStreakDaysRequired != null)
        'multiplierStreakDaysRequired': club.multipierStreakDaysRequired,
      if (club.multipierStreakDaysRequired != null)
        'bonusIncrement': club.bonusIncrement,
    });

    // Convert Map<Object?, Object?> to Map<String, dynamic> (recursively)
    final Map<String, dynamic> stringData =
        convertMapToStringDynamic(data.data);

    return ClubModelDto.fromJson(stringData).copyWith(
      // Ensure the ID is set correctly
      id: stringData['id'] as String? ?? '',
    );
  }

  /// Recursively converts a Map with Object keys to Map<String, dynamic>
  Map<String, dynamic> convertMapToStringDynamic(Object? data) {
    if (data is Map) {
      return Map<String, dynamic>.fromEntries(
        data.entries.map((entry) {
          final key = entry.key.toString();
          final value = entry.value;

          if (value is Map) {
            return MapEntry(key, convertMapToStringDynamic(value));
          } else if (value is List) {
            return MapEntry(key, _convertListItems(value));
          } else {
            return MapEntry(key, value);
          }
        }),
      );
    }
    return {}; // Return empty map as fallback
  }

  /// Helper method to process list items
  List<dynamic> _convertListItems(List<dynamic> items) {
    return items.map((item) {
      if (item is Map) {
        return convertMapToStringDynamic(item);
      } else if (item is List) {
        return _convertListItems(item);
      } else {
        return item;
      }
    }).toList();
  }

  @override
  Future<List<ClubModelDto>> getVendorsClubs({
    required String vendorId,
  }) async {
    final data = await _firestore
        .collection('clubs')
        .where('vendorId', isEqualTo: vendorId)
        .get();

    return data.docs
        .map((doc) => ClubModelDto.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  @override
  Future<void> addMemberToClubByOwner({
    required String clubId,
    required String userId,
    // required String vendorId,
    required String clubName,
    required String clubDescription,
    required int giftDayCycle,
  }) async {
    // Get user details from users collection
    final userDoc = await _firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      throw UserNotFoundException(userId: userId);
    }

    // Check if user is already a member of the club
    final existingMembership = await _firestore
        .collection('clubs')
        .doc(clubId)
        .collection('participants')
        .doc(userId)
        .get();

    if (existingMembership.exists) {
      throw UserAlreadyMemberException(userId: userId, clubId: clubId);
    }

    // Create document in `users/{vendorId}/clubs/{clubId}/users/{userId}` path
    final clubUserRef = _firestore
        .collection('clubs')
        .doc(clubId)
        .collection('participants')
        .doc(userId);

    /// With content of
    /**
     * . Contents
		1. `streakTotal` set to 0
		2. `consecutiveDays` = 0
		3. `lastCheckInDate` NULL
		4. `lastBonusDate` NULL
		5. `joinedAt` - Timestamp now
		6. `userName` -> User Name
		7. `userId` -> User ID
     */

    await clubUserRef.set({
      'streakTotal': 0,
      'consecutiveDays': 0,
      'lastCheckInDate': null,
      'lastBonusDate': null,
      'joinedAt': FieldValue.serverTimestamp(),
      'userName': userDoc.data()?['userName'] ?? 'Unknown',
      'userId': userId,
      'clubName': clubName,
      'clubDescription': clubDescription,
    });

    // Create document in `users/{userId}/clubs/{clubId}` path
    // With content of
    /**
     * 1. `streakTotal` set to 0
		2. `consecutiveDays` = 0
		3. `lastCheckInDate` NULL
		4. `lastBonusDate` NULL
		5. `clubName`
		6. `clubDescription`
     */
    await _firestore
        .collection('users')
        .doc(userId)
        .collection(_userMembershipCollection)
        .doc(clubId)
        .set({
      'streakTotal': 0,
      'consecutiveDays': 0,
      'lastCheckInDate': null,
      'lastBonusDate': null,
      'lastGiftDate': null,
      'giftDayCycle': giftDayCycle,
      'clubName': clubName,
      'clubDescription': clubDescription,
    });
  }

  @override
  Future<List<ClubMemberVendorDataDto>> getClubUsers({
    required String clubId,
    required String vendorId,
  }) async {
    final data = await _firestore
        .collection('users')
        .doc(vendorId)
        .collection(_vendorClubCollection)
        .doc(clubId)
        .collection('participants')
        .get();

    return data.docs
        .map((doc) => ClubMemberVendorDataDto.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<ClubMemberUserDataDto>> getUserClubs({
    required String userId,
  }) async {
    final data = await _firestore
        .collection('users')
        .doc(userId)
        .collection(_userMembershipCollection)
        .get();

    return data.docs
        .map(
          (doc) => ClubMemberUserDataDto.fromJson(doc.data())
              .copyWith(clubId: doc.id),
        )
        .toList();
  }

  @override
  Future<void> removeUserFromClub({
    required String clubId,
    required String userId,
    required String vendorId,
  }) async {
    // Remove from `users/{vendorId}/clubs/{clubId}/users/{userId}`
    final clubUserRef = _firestore
        .collection('users')
        .doc(vendorId)
        .collection(_vendorClubCollection)
        .doc(clubId)
        .collection('users')
        .doc(userId);

    await clubUserRef.delete();

    // Remove from `users/{userId}/clubs/{clubId}`
    final userClubRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('clubs')
        .doc(clubId);

    await userClubRef.delete();
  }

  @override
  Future<CheckInResponseDto> userCheckIn({
    required String clubId,
    required String userId,
    required String vendorId,
  }) async {
    throw UnimplementedError(
      'userCheckIn is not implemented yet',
    );
    //   // Get membership document reference from
    //   final membershipRef = await _firestore
    //       .collection('clubs')
    //       .doc(clubId)
    //       .collection('participants')
    //       .doc(userId)
    //       .get();

    //   // New Values Needs to be set
    //   int newStreakTotal = 0;
    //   int newConsecutiveDays = 0;
    //   bool giftDay = false;
    //   String? giftStatus;

    //   if (!membershipRef.exists) {
    //     throw MembershipNotFoundException(
    //       userId: userId,
    //       clubId: clubId,
    //       vendorId: vendorId,
    //     );
    //   }

    //   final membershipDataVendorCentric =
    //       ClubMemberVendorDataDto.fromJson(membershipRef.data()!);

    //   final today = DateTime.now().toUtc();
    //   final DateTime lastCheckIn =
    //       membershipDataVendorCentric.lastCheckInDate?.toDate() ??
    //           DateTime.fromMillisecondsSinceEpoch(0).toUtc();

    //   // If last check-in is today, no action needed
    //   if (lastCheckIn.year == today.year &&
    //       lastCheckIn.month == today.month &&
    //       lastCheckIn.day == today.day) {
    //     return CheckInResponseDto(
    //       newStreakTotal: membershipDataVendorCentric.streakTotal,
    //       consecutiveDays: membershipDataVendorCentric.consecutiveDays,
    //       giftDay: false,
    //       giftStatus: 'Already checked in today',
    //     );
    //   }

    //   // Check if last check-in was yesterday
    //   final isConsecutive = lastCheckIn.year == today.year &&
    //       lastCheckIn.month == today.month &&
    //       lastCheckIn.day == today.day - 1;

    //   if (isConsecutive) {
    //     newConsecutiveDays = membershipDataVendorCentric.consecutiveDays + 1;
    //   } else {
    //     newConsecutiveDays = 1;
    //   }

    //   // Calculate increment
    //   int increment = 1;
    //   if (newConsecutiveDays == 3) {
    //     increment = 2;
    //     newConsecutiveDays = 0; // reset after bonus
    //   }

    //   // Update streak total
    //   final oldStreak = membershipDataVendorCentric.streakTotal;
    //   newStreakTotal = oldStreak + increment;

    //   // Update the membership document
    //   await membershipRef.reference.update({
    //     'streakTotal': newStreakTotal,
    //     'consecutiveDays': newConsecutiveDays,
    //     'lastCheckInDate': Timestamp.fromDate(today),
    //   });

    //   // Also update the user's club membership document
    //   final userClubRef = _firestore
    //       .collection('users')
    //       .doc(userId)
    //       .collection(_userMembershipCollection)
    //       .doc(clubId);

    //   await userClubRef.update({
    //     'streakTotal': newStreakTotal,
    //     'consecutiveDays': newConsecutiveDays,
    //     'lastCheckInDate': Timestamp.fromDate(today),
    //   });

    //   // Check if user crossed milestones (e.g., 7, 14, 21...)
    //   if (newStreakTotal % 7 == 0) {
    //     // // Grant gift to user
    //     // await FirebaseFunctions.instance.httpsCallable('grantGift').call({
    //     //   'userId': userId,
    //     //   'streakMilestone': newStreakTotal,
    //     // });
    //     giftDay = true;
    //     giftStatus = 'Gift granted for reaching $newStreakTotal streak!';
    //   }

    //   // if gift day, update lastGiftDate in user's club membership document
    //   if (giftDay) {
    //     await userClubRef.update({
    //       'lastGiftDate': Timestamp.fromDate(today),
    //     });
    //   }

    //   return CheckInResponseDto(
    //     newStreakTotal: newStreakTotal,
    //     consecutiveDays: newConsecutiveDays,
    //     giftDay: giftDay,
    //     giftStatus: giftStatus,
    //   );

    //   /**
    //    *   const today = getCurrentDateUTC();
    // const lastCheckIn = user.last_check_in_date;

    // // Detect consecutive days
    // const isConsecutive = isNextDay(lastCheckIn, today);

    // if (isConsecutive) {
    //   user.consecutive_days += 1;
    // } else {
    //   user.consecutive_days = 1;
    // }

    // // Calculate increment
    // let increment = 1;
    // if (user.consecutive_days === 3) {
    //   increment = 2;
    //   user.consecutive_days = 0; // reset after bonus
    // }

    // const oldStreak = user.streak_total;
    // const newStreak = oldStreak + increment;
    // user.streak_total = newStreak;
    // user.last_check_in_date = today;

    // // Check crossed milestones (e.g., 7, 14, 21...)
    // for (let i = oldStreak + 1; i <= newStreak; i++) {
    //   if (i % 7 === 0) {
    //     grantGift(user, i);
    //   }
    // }
    //    */
  }

  @override
  Future<void> changeUserClub({
    required String oldClubId,
    required String newClubId,
    required String vendorId,
    required String memberId,
  }) async {
    throw UnimplementedError();
    // Use a transaction to ensure atomicity
    await _firestore.runTransaction((transaction) async {
      // Vendor-centric references
      final oldMembershipRef = _firestore
          .collection('users')
          .doc(vendorId)
          .collection(_vendorClubCollection)
          .doc(oldClubId)
          .collection('users')
          .doc(memberId);

      final newMembershipRef = _firestore
          .collection('users')
          .doc(vendorId)
          .collection(_vendorClubCollection)
          .doc(newClubId)
          .collection('users')
          .doc(memberId);

      // User-centric references
      final userOldClubRef = _firestore
          .collection('users')
          .doc(memberId)
          .collection(_userMembershipCollection)
          .doc(oldClubId);

      final userNewClubRef = _firestore
          .collection('users')
          .doc(memberId)
          .collection(_userMembershipCollection)
          .doc(newClubId);

      // Read all data first (transactions require all reads before writes)
      final oldMembershipDoc = await transaction.get(oldMembershipRef);
      final userOldClubDoc = await transaction.get(userOldClubRef);

      // Validate existence
      if (!oldMembershipDoc.exists) {
        throw MembershipNotFoundException(
          userId: memberId,
          clubId: oldClubId,
          vendorId: vendorId,
        );
      }

      if (!userOldClubDoc.exists) {
        throw UserClubMembershipNotFoundException(
          userId: memberId,
          clubId: oldClubId,
        );
      }

      // Parse data
      final oldMembershipData =
          ClubMemberVendorDataDto.fromJson(oldMembershipDoc.data()!);
      final userOldClubData =
          ClubMemberUserDataDto.fromJson(userOldClubDoc.data()!);

      // Perform all writes atomically
      transaction
        ..set(newMembershipRef, oldMembershipData.toJson())
        ..delete(oldMembershipRef)
        ..set(userNewClubRef, userOldClubData.toJson())
        ..delete(userOldClubRef);
    });
  }

  @override
  Future<StaffClubDetailDto> getClubsById({
    required String clubId,
  }) async {
    final snapshot = await _firestore.collection('clubs').doc(clubId).get();

    if (!snapshot.exists) {
      throw ClubNotFoundException(clubId: clubId);
    }

    final data = snapshot.data();
    if (data == null) {
      throw ClubNotFoundException(clubId: clubId);
    }

    return StaffClubDetailDto.fromJson(data).copyWith(id: snapshot.id);
  }
}
