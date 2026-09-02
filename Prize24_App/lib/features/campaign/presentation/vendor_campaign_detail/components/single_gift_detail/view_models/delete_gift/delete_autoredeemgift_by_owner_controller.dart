import 'package:prize24_app/features/gift/data/repository/i_gift_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_autoredeemgift_by_owner_controller.g.dart';

@riverpod
class DeleteAutoredeemgiftByOwnerController
    extends _$DeleteAutoredeemgiftByOwnerController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<String?> deleteAutoRedeemableGiftByOwner({
    required String campaignId,
    required String giftId,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(giftRepositoryProvider)
          .deleteAutoRedeemableGift(campaignId: campaignId, giftId: giftId);
    });
    return state.value;
  }
}
