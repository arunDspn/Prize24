import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'public_slug_availabilty_controller.g.dart';

@riverpod
class PublicSlugAvailabiltyController
    extends _$PublicSlugAvailabiltyController {
  @override
  FutureOr<bool?> build() {
    return null;
  }

  /// Checks if the provided public slug is available.
  Future<void> checkSlugAvailability({required String slug}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final availability = await ref
          .watch(campaignRepositoryProvider)
          .isCampaignPublicSlugAvailable(publicSlug: slug);

      return availability;
    });
  }
}
