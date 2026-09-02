import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/app/app.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'avail_semi_text_campaign_controller.g.dart';

@riverpod
class AvailSemiTextCampaignController
    extends _$AvailSemiTextCampaignController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  // Add any additional methods or properties needed for this controller

  Future<void> availCampaign(String campaignSlug) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // 10 sec
      // await Future.delayed(const Duration(seconds: 10));
      final userId = (ref.read(authControllerProvider).requireValue!).userId;
      final result = await FirebaseFunctions.instance
          .httpsCallable('textAvailPublicSemiTextAutoCampaign')
          .call({
        'userId': userId,
        'campaignSlug': campaignSlug,
      });

      // Logic to avail the campaign using the provided slug
      // This could involve making an API call or interacting with a repository
      // For example:
      // return await campaignRepository.availCampaign(campaignSlug);
      return result.data as String? ?? 'Campaign availed successfully';
    });
  }
}
