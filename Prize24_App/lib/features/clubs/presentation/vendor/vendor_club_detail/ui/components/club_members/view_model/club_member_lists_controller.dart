import 'package:prize24_app/features/clubs/data/repository/club_repository.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_vendor_data_model.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'club_member_lists_controller.g.dart';

@riverpod
class ClubMemberListsController extends _$ClubMemberListsController {
  @override
  FutureOr<List<ClubMemberVendorDataModel>> build({
    required String clubId,
  }) {
    final vendor = ref.read(authControllerProvider).requireValue!;
    final members = ref.read(clubRepositoryProviderProvider).getClubMembers(
          clubId: clubId,
          vendorId: vendor.userId,
        );
    return members;
  }
}
