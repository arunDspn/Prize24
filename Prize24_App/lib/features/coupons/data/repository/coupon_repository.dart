// import 'package:prize24_app/features/coupons/data/mappers/coupon_model_mapper.dart';
// import 'package:prize24_app/features/coupons/data/repository/i_coupon_repository.dart';
// import 'package:prize24_app/features/coupons/data/service/i_coupon_service.dart';
// import 'package:prize24_app/features/coupons/domain/model/coupon_model.dart';

// class CouponRepository implements ICouponRepository {
//   CouponRepository({
//     required ICouponService couponService,
//   }) : _couponService = couponService;

//   final ICouponService _couponService;
//   @override
//   Future<void> editCoupon({
//     required String userId,
//     required String couponId,
//     required String couponCode,
//     required double discountAmount,
//     required DateTime expiryDate,
//   }) {
//     // TODO: implement editCoupon
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<CouponModel>> getUsersRedemedCoupons({
//     required String userId,
//   }) async {
//     final coupons = await _couponService.getUsersRedemedCoupons(userId: userId);
//     return coupons
//         .map((coupon) => CouponModelMapper().fromDto(coupon))
//         .toList();
//   }

//   @override
//   Future<CouponModel> createCoupon({
//     required String userId,
//     required String couponCode,
//     required double discountAmount,
//     required DateTime expiryDate,
//   }) {
//     // TODO: implement createCoupon
//     throw UnimplementedError();
//   }
// }
