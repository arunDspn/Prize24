import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'vendors_to_campaign_controller.g.dart';

@Riverpod()
class VendorsToCampaignController extends _$VendorsToCampaignController {
  @override
  Future<String?> build() async {
    // // mock data
    // await Future.delayed(const Duration(seconds: 1));
    // return List.generate(10, (index) {
    //   return VendorToCampaignUimodel(
    //     vendorId: 'vendor_$index',
    //     vendorName: 'Vendor $index',
    //     vendorPhone: '123-456-789$index',
    //     isAlreadyAdded: index % 2 == 0,
    //   );
    // });
    return null;
  }

  // Accept a vendor to the campaign
  Future<void> addVendor(String vendorId, String campaignId) async {
    state = const AsyncValue.loading();

    // Guard

    state = await AsyncValue.guard(() async {
      await ref
          .read(campaignRepositoryProvider)
          .shareCampaignToVendor(campaignId: campaignId, recipientId: vendorId);

      // // Update the vendor's status
      // final updatedVendors = currentState.map((vendor) {
      //   if (vendor.vendorId == vendorId) {
      //     return vendor.copyWith(isAlreadyAdded: true);
      //   }
      //   return vendor;
      // }).toList();

      return vendorId;
    });
  }

  // // Reject a vendor from the campaign
  // Future<void> rejectVendor(String vendorId) async {
  //   final currentState = state.value;
  //   if (currentState == null) return;

  //   state = const AsyncValue.loading();

  //   try {
  //     // Simulate API call
  //     await Future<void>.delayed(const Duration(milliseconds: 500));

  //     // Update the vendor's status
  //     final updatedVendors = currentState.map((vendor) {
  //       if (vendor.vendorId == vendorId) {
  //         return vendor.copyWith(isAlreadyAdded: false);
  //       }
  //       return vendor;
  //     }).toList();

  //     state = AsyncValue.data(updatedVendors);
  //   } catch (error, stackTrace) {
  //     state = AsyncValue.error(error, stackTrace);
  //   }
  // }
}
