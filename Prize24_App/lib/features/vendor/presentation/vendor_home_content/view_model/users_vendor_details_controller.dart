// import 'package:prize24_app/features/vendor/data/repository/vendor_repository.dart';
// import 'package:prize24_app/features/vendor/domain/model/vendor_model.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'users_vendor_details_controller.g.dart';

// @Riverpod(keepAlive: true)
// class UsersVendorDetailsController extends _$UsersVendorDetailsController {
//   @override
//   FutureOr<VendorModel?> build() {
//     return null;
//   }

//   // Inject vendor directly

//   /// Sets the vendor details directly into the state.
//   /// This is useful when you already have the vendor data
//   /// and want to update the state without fetching it again.
//   void setVendor(VendorModel vendor) {
//     state = AsyncValue.data(vendor);
//   }

//   /// Fetches vendor details by user ID.
//   /// This method is used to load vendor details based on the user ID.
//   Future<void> getDetailsByUserId({
//     required String userId,
//   }) async {
//     state = const AsyncValue.loading();

//     // state = await AsyncValue.guard(() async {
//     //   return ref
//     //       .read(vendorRepositoryProvider).getVendor(vendorId)

//     // });
//   }

//   /// Fetches vendor details by vendor ID.
//   /// This method is used to load vendor details based on the vendor ID.
//   Future<void> getDetailsByVendorId({
//     required String vendorId,
//   }) async {
//     state = const AsyncValue.loading();

//     state = await AsyncValue.guard(() async {
//       return ref.read(vendorRepositoryProvider).getVendor(vendorId);
//     });
//   }
// }
