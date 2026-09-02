import 'package:prize24_app/features/clubs/data/repository/club_repository.dart';
import 'package:prize24_app/features/clubs/domain/models/club_entity.dart';
import 'package:prize24_app/features/clubs/domain/models/club_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_club_controller.g.dart';

@riverpod
class CreateClubController extends _$CreateClubController {
  @override
  FutureOr<ClubModel?> build() {
    return null;
  }

  Future<void> createClub(ClubEntity club) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final result =
          await ref.read(clubRepositoryProviderProvider).createClub(club: club);

      return result;
    });
  }
}
