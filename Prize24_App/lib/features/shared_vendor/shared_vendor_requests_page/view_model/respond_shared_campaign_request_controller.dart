import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'respond_shared_campaign_request_controller.g.dart';

@riverpod
class RespondSharedCampaignRequestController
    extends _$RespondSharedCampaignRequestController {
  @override
  FutureOr<(String?, String?)> build() {
    return (null, null);
  }

  Future<void> respondToRequest(String requestId, String action) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await ref.read(campaignRepositoryProvider).respondToSharedCampaignRequest(
            requestId: requestId,
            action: action,
          );

      return (requestId, action);
    });
  }
}
