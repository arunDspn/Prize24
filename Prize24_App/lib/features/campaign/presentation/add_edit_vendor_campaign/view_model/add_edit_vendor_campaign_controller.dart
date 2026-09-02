import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/campaign/domain/use_cases/create_campaign/create_campaign_usecase.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_edit_vendor_campaign_controller.g.dart';

@riverpod
class AddEditVendorCampaignController
    extends _$AddEditVendorCampaignController {
  @override
  FutureOr<CampaignModel?> build() async {
    return null;
  }

  /// Adds a new campaign with the provided details.
  Future<void> addCampaign({
    required String title,
    required String description,
    required int totalParticipants,
    required int totalGifts,
    required CampaignVisibility visibility,
    required GiftType allowedGiftType,
    String? publicSlug,
  }) async {
    final vendorId = (ref.read(authControllerProvider).requireValue!).userId;
    final vendorName =
        (ref.read(authControllerProvider).requireValue!).userName;
    final campaign = CampaignModel(
      name: title,
      description: description,
      totalParticipants: totalParticipants,
      // totalParticipated: totalParticipants,
      remainingParticipants: totalParticipants,
      totalGifts: totalGifts,
      remainingGifts: totalGifts,
      visibility: visibility,
      allowedGiftType: allowedGiftType,
      vendorId: vendorId,
      vendorName: vendorName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      publicSlug: visibility == CampaignVisibility.public ? publicSlug : null,
      status: CampaignStatus.active,
      sharedVendors: [],
      totalAvailed: 0,
      totalRedeemed: 0,
    );

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // Call the use case to create the campaign
      final createCampaignUsecase = ref.watch(createCampaignUsecaseProvider);
      final createdCampaign = await createCampaignUsecase(campaign: campaign);
      await ref
          .read(analyticsServiceProvider)
          .logEntityManagement(
            action: EntityAction.add,
            entityType: EntityType.campaign,
            entityId: createdCampaign.id ?? '',
          );
      return createdCampaign;
    });
  }

  // Editing an existing campaign
  Future<void> editCampaign({
    required String id,
    required String title,
    required String description,
    required int totalParticipants,
    required int totalGifts,
    required CampaignModel existingCampaign,
  }) async {
    // final campaign = CampaignModel(
    //   id: id,
    //   title: title,
    //   description: description,
    //   totalParticipants: totalParticipants,
    //   totalGifts: totalGifts,
    //   visibility: CampaignVisibility.public, // Default visibility
    //   allowedGiftType: GiftType.physical, // Default gift type
    //   vendorId: vendorId,
    //   vendorName: vendorName,
    //   createdAt: DateTime.now(),
    //   updatedAt: DateTime.now(),
    // );

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(campaignRepositoryProvider)
          .editCampaign(
            campaignId: id,
            title: title,
            description: description,
            totalParticipants: totalParticipants,
            totalGifts: totalGifts,
          );
      await ref
          .read(analyticsServiceProvider)
          .logEntityManagement(
            action: EntityAction.edit,
            entityType: EntityType.campaign,
            entityId: id,
          );

      return existingCampaign.copyWith(
        name: title,
        description: description,
        totalParticipants: totalParticipants,
        remainingParticipants:
            existingCampaign.remainingParticipants +
            (totalParticipants - existingCampaign.totalParticipants),
        totalGifts: totalGifts,
        remainingGifts:
            existingCampaign.remainingGifts +
            (totalGifts - existingCampaign.totalGifts),
        updatedAt: DateTime.now(),
      );
    });
  }
}
