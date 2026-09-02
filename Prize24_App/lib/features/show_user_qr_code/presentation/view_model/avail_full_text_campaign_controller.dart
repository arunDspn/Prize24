import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/app/app.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'avail_full_text_campaign_controller.g.dart';

@riverpod
class AvailFullTextCampaignController
    extends _$AvailFullTextCampaignController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> availCampaign({
    required String campaignSlug,
    required String giftSlug,
    required String code,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final userId = (ref.read(authControllerProvider).requireValue!).userId;
      final result = await FirebaseFunctions.instance
          .httpsCallable('textAvailPublicFullTextCodeCampaign')
          .call(
        {
          'userId': userId,
          'campaignSlug': campaignSlug,
          'giftSlug': giftSlug,
          'code': code,
        },
      );
      // !userId || !campaignSlug || !giftSlug || !code

      return result.data as String? ?? 'Campaign availed successfully';
    });
  }
}
