import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';
import 'package:prize24_app/features/gift/presentation/home_users_gift_list/view_model/get_all_coupons_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'club_gifts_history_controller.g.dart';

@riverpod
class ClubGiftsHistoryController extends _$ClubGiftsHistoryController {
  @override
  Future<List<UserGiftModel>> build() async {
    final userRedeemedGifts = await ref.read(
      getAllCouponsControllerProvider.future,
    );
    return userRedeemedGifts.items.where((element) {
      return !element.availedViaClub;
    }).toList();
  }
}
