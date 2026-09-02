import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/clubs/data/dto/club_entity_dto.dart';
import 'package:prize24_app/features/clubs/data/service/i_club_service.dart';
import 'package:prize24_app/features/clubs/domain/i_club_repository.dart';
import 'package:prize24_app/features/shop/domain/model/check_in_response_model.dart';
import 'package:prize24_app/features/clubs/domain/models/club_entity.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_user_data_model.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_vendor_data_model.dart';
import 'package:prize24_app/features/clubs/domain/models/club_model.dart';
import 'package:prize24_app/features/clubs/domain/models/staff_club_detail_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'club_repository.g.dart';

class ClubRepository implements IClubRepository {
  ClubRepository(this._clubService);

  final IClubService _clubService;
  @override
  Future<ClubModel> createClub({
    required ClubEntity club,
  }) async {
    final clubDto = ClubEntityDto.fromDomain(club);
    final createdClub = await _clubService.createClub(club: clubDto);
    return createdClub.toDomain();
  }

  @override
  Future<void> deleteClub({required String clubId}) {
    // TODO: implement deleteClub
    throw UnimplementedError();
  }

  @override
  Future<List<ClubMemberVendorDataModel>> getClubMembers({
    required String clubId,
    required String vendorId,
  }) async {
    final members = await _clubService.getClubUsers(
      clubId: clubId,
      vendorId: vendorId,
    );
    return members.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<ClubMemberUserDataModel>> getUserClubs({
    required String userId,
  }) async {
    final clubs = await _clubService.getUserClubs(userId: userId);
    return clubs.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> addedMembersToClubByOwner({
    required String clubId,
    required String userId,
    // required String vendorId,
    required String clubName,
    required String clubDescription,
    required int giftDayCycle,
  }) async {
    await _clubService.addMemberToClubByOwner(
      clubId: clubId,
      userId: userId,
      // vendorId: vendorId,
      clubName: clubName,
      clubDescription: clubDescription,
      giftDayCycle: giftDayCycle,
    );
  }

  @override
  Future<void> leaveClub({required String clubId, required String userId}) {
    // TODO: implement leaveClub
    throw UnimplementedError();
  }

  @override
  Future<void> updateClub({
    required String clubId,
    String? name,
    String? description,
  }) {
    // TODO: implement updateClub
    throw UnimplementedError();
  }

  @override
  Future<List<ClubModel>> getVendorsClubs({
    required String vendorId,
  }) async {
    final clubs = await _clubService.getVendorsClubs(vendorId: vendorId);
    return clubs.map((e) => e.toDomain()).toList();
  }

  @override
  Future<CheckInResponseModel> userCheckIn({
    required String clubId,
    required String userId,
    required String vendorId,
  }) async {
    final response = await _clubService.userCheckIn(
      clubId: clubId,
      userId: userId,
      vendorId: vendorId,
    );
    return response.toDomain();
  }

  @override
  Future<StaffClubDetailModel> getClubById({required String clubId}) async {
    final response = await _clubService.getClubsById(clubId: clubId);
    return response.toDomain();
  }
}

// Riverpod Provider
@Riverpod(keepAlive: true)
IClubRepository clubRepositoryProvider(Ref ref) {
  return ClubRepository(ref.read(clubServiceProvider));
}
