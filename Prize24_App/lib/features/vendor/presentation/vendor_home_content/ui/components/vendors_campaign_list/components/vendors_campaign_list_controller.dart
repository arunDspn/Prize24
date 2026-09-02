import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/campaign/domain/use_cases/list_vendor_campaigns/list_vendor_campaigns_usecase.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'vendors_campaign_list_controller.g.dart';

@Riverpod()
class VendorsCampaignListController extends _$VendorsCampaignListController {
  @override
  FutureOr<List<CampaignModel>> build() async {
    // Usecase
    final usecase = ref.read(listVendorCampaignsUsecaseProvider);

    final user = ref.read(authControllerProvider).requireValue!;

    // Call usecase to get the list of campaigns
    final campaigns = await usecase.call(
      userId: user.userId,
      vendorName: user.userName,
      vendorPhone: user.userPhoneNumber ?? '',
    );

    // Map campaigns to a list of shop names (or any other property you need)
    return campaigns;
  }

  // Update remaining gift count of a given campaign ID locally
  void updateGiftCount(String campaignId, int giftCount) {
    final currentList = state.value;
    if (currentList == null) {
      return;
    }
    state = const AsyncLoading();

    final newData = currentList.map((campaign) {
      if (campaign.id == campaignId) {
        return campaign.copyWith(
          totalGiftsAdded: campaign.totalGiftsAdded - giftCount,
        );
      }
      return campaign;
    }).toList();

    state = AsyncData(newData);
  }
}
