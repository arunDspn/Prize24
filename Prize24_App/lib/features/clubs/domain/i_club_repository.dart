import 'package:prize24_app/features/shop/domain/model/check_in_response_model.dart';
import 'package:prize24_app/features/clubs/domain/models/club_entity.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_user_data_model.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_vendor_data_model.dart';
import 'package:prize24_app/features/clubs/domain/models/club_model.dart';
import 'package:prize24_app/features/clubs/domain/models/staff_club_detail_model.dart';

abstract class IClubRepository {
  Future<ClubModel> createClub({
    required ClubEntity club,
  });

  Future<List<ClubModel>> getVendorsClubs({
    /// User ID of the vendor
    required String vendorId,
  });

  Future<void> updateClub({
    required String clubId,
    String? name,
    String? description,
  });

  Future<void> deleteClub({required String clubId});

  Future<void> addedMembersToClubByOwner({
    required String clubId,
    required String userId,
    // required String vendorId,
    required String clubName,
    required String clubDescription,
    required int giftDayCycle,
  });

  Future<void> leaveClub({
    required String clubId,
    required String userId,
  });

  /// Get clubs of a user
  Future<List<ClubMemberUserDataModel>> getUserClubs({
    required String userId,
  });

  /// Get members of a club
  Future<List<ClubMemberVendorDataModel>> getClubMembers({
    required String clubId,
    required String vendorId,
  });

  /// User check-in to a club
  Future<CheckInResponseModel> userCheckIn({
    required String clubId,
    required String userId,
    required String vendorId,
  });

  /// Get club's by id
  Future<StaffClubDetailModel> getClubById({
    required String clubId,
  });
}
