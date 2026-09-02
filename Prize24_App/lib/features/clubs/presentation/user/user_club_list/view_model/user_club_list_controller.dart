import 'package:prize24_app/features/clubs/data/repository/club_repository.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_user_data_model.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_club_list_controller.g.dart';

@riverpod
class UserClubListController extends _$UserClubListController {
  @override
  FutureOr<List<ClubMemberUserDataModel>> build() {
    final userId = ref.read(authControllerProvider).requireValue!.userId;
    final data =
        ref.read(clubRepositoryProviderProvider).getUserClubs(userId: userId);

    return data;
  }
}
