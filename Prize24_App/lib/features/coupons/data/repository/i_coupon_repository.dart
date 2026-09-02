// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:prize24_app/features/coupons/data/repository/coupon_repository.dart';
// import 'package:prize24_app/features/coupons/data/service/i_coupon_service.dart';
// import 'package:prize24_app/features/coupons/domain/model/coupon_model.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'i_coupon_repository.g.dart';

// abstract class ICouponRepository {
//   Future<CouponModel> createCoupon({
//     required String userId,
//     required String couponCode,
//     required double discountAmount,
//     required DateTime expiryDate,
//   });

//   // Edit coupon details
//   Future<void> editCoupon({
//     required String userId,
//     required String couponId,
//     required String couponCode,
//     required double discountAmount,
//     required DateTime expiryDate,
//   });

//   Future<List<CouponModel>> getUsersRedemedCoupons({
//     required String userId,
//   });

//   // Future<Coupon?> getCoupon(String couponId);
//   // Future<List<Coupon>> getAllCoupons();
//   // Future<void> updateCoupon(Coupon coupon);
//   // Future<void> deleteCoupon(String couponId);
//   // Stream<List<Coupon>> watchAllCoupons();
// }

// @Riverpod(keepAlive: true)
// ICouponRepository couponRepository(Ref ref) {
//   final couponService = ref.read(couponServiceProvider);
//   return CouponRepository(
//     couponService: couponService,
//   );
// }
