import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/shop/data/dto/check_in_response_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/club_entity_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/club_member_user_data_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/club_member_vendor_data_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/club_model_dto.dart';
import 'package:prize24_app/features/clubs/data/dto/staff_club_detail_dto.dart';
import 'package:prize24_app/features/clubs/data/service/firebase_club_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'i_club_service.g.dart';

abstract class IClubService {
  Future<ClubModelDto> createClub({
    required ClubEntityDto club,
  });

  Future<List<ClubModelDto>> getVendorsClubs({
    required String vendorId,
  });

  Future<void> addMemberToClubByOwner({
    required String clubId,
    required String userId,
    // required String vendorId,
    required String clubName,
    required String clubDescription,
    required int giftDayCycle,
  });

  Future<void> removeUserFromClub({
    required String clubId,
    required String userId,
    required String vendorId,
  });

  Future<List<ClubMemberUserDataDto>> getUserClubs({
    required String userId,
  });

  // Get users of a club
  Future<List<ClubMemberVendorDataDto>> getClubUsers({
    required String clubId,
    required String vendorId,
  });

  // // Get Users Club List with Club Details
  // Future<List<ClubMemberUserDataDto>> getUserClubsWithDetails({
  //   required String userId,
  // });

  Future<CheckInResponseDto> userCheckIn({
    required String clubId,
    required String userId,
    required String vendorId,
  });

  /// Upgrade or Downgrade existing users in club to new club

  Future<void> changeUserClub({
    required String oldClubId,
    required String newClubId,
    required String vendorId,
    required String memberId,
  });

  /// Get clubs by shop
  Future<StaffClubDetailDto> getClubsById({
    required String clubId,
  });
}

// Riverpod Provider
@Riverpod(keepAlive: true)
IClubService clubService(Ref ref) {
  return FirebaseClubService();
}
