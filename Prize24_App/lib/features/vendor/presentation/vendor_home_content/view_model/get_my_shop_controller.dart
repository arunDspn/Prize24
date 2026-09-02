// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'get_my_shop_controller.g.dart';

// @Riverpod(keepAlive: true)
// class GetMyShopController extends _$GetMyShopController {
//   @override
//   FutureOr<ShopModel?> build() {
//     return null;
//   }

//   Future<void> getDetails({
//     required String userId,
//   }) async {
//     state = const AsyncValue.loading();

//     state = await AsyncValue.guard(() async {
//       return ref
//           .read(vendorRepositoryProvider)
//           .loadMyShopDetails(userId: userId);
//     });
//   }

//   void injectShopDetails(ShopModel shopModel) {
//     state = AsyncValue.data(shopModel);
//   }
// }
