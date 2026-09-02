import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/coupons/data/dto/coupon_dto.dart';
import 'package:prize24_app/features/coupons/data/service/firebase_coupon_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'i_coupon_service.g.dart';

abstract class ICouponService {
  Future<void> editCoupon({
    required String userId,
    required String couponId,
    required String couponCode,
    required double discountAmount,
    required DateTime expiryDate,
  });

  Future<List<CouponDto>> getUsersRedemedCoupons({
    required String userId,
  });
}

@Riverpod(keepAlive: true)
ICouponService couponService(Ref ref) {
  return FirebaseCouponService();
}
