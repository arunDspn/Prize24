import 'package:prize24_app/features/clubs/data/repository/club_repository.dart';
import 'package:prize24_app/features/clubs/domain/models/staff_club_detail_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shop_club_controller.g.dart';

@riverpod
class ShopClubController extends _$ShopClubController {
  @override
  FutureOr<StaffClubDetailModel?> build({
    required String? clubId,
  }) {
    if (clubId == null) {
      return null;
    }
    return ref.read(clubRepositoryProviderProvider).getClubById(clubId: clubId);
  }
}
