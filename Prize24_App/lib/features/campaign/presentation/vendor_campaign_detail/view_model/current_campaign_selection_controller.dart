import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_campaign_selection_controller.g.dart';

@Riverpod(keepAlive: true)
class CurrentCampaignSelectionController
    extends _$CurrentCampaignSelectionController {
  @override
  FutureOr<CampaignModel?> build() {
    return null;
  }

  Future<void> selectCampaign(CampaignModel campaign) async {
    state = AsyncValue.data(campaign);
  }

  Future<void> clearSelection() async {
    state = const AsyncValue.data(null);
  }

  // Update the selected campaign's totalGiftsAdded field
  Future<void> updateTotalGiftsAdded(int newTotalGiftsAdded) async {
    final currentCampaign = state.value;
    if (currentCampaign != null) {
      final updatedCampaign = currentCampaign.copyWith(
        totalGiftsAdded: newTotalGiftsAdded,
      );
      state = AsyncValue.data(updatedCampaign);
    }
  }

  // Reload the current Campaign from firebase
  Future<void> reloadCurrentCampaignFromSource() async {
    if (state.value == null) return;

    final campaignID = state.value!.id;
    if (campaignID == null) return;
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final updatedCampaign = ref
          .read(campaignRepositoryProvider)
          .getSingleCampaginById(campaignId: campaignID);
      return updatedCampaign;
    });
  }
}
