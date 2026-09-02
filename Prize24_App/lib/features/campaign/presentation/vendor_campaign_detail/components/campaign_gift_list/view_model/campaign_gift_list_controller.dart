import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/gift/domain/use_cases/list_campaigns_all_gifts/list_campaigns_all_gifts_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'campaign_gift_list_controller.g.dart';

@riverpod
class CampaignGiftListController extends _$CampaignGiftListController {
  @override
  FutureOr<List<GiftModel>> build({
    required String campaignId,
  }) async {
    // Fetch gifts for the given campaign ID
    return await ref.read(listCampaignsAllGiftsUsecaseProvider).call(
          campaignId: campaignId,
        );
  }
}
