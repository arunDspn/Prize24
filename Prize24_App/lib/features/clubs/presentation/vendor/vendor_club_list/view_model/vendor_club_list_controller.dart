import 'package:prize24_app/features/clubs/data/repository/club_repository.dart';
import 'package:prize24_app/features/clubs/domain/models/club_model.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'vendor_club_list_controller.g.dart';

@riverpod
class VendorClubListController extends _$VendorClubListController {
  @override
  FutureOr<List<ClubModel>> build() async {
    final user = ref.read(authControllerProvider).requireValue!;
    final data = await ref
        .read(clubRepositoryProviderProvider)
        .getVendorsClubs(vendorId: user.userId);
    return data;
  }
}
