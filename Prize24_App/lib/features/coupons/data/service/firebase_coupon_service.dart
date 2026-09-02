import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prize24_app/features/coupons/data/dto/coupon_dto.dart';
import 'package:prize24_app/features/coupons/data/service/i_coupon_service.dart';

class FirebaseCouponService implements ICouponService {
  final _fireStore = FirebaseFirestore.instance;
  final _couponsCollectionName = 'coupons';
  final _usersCollectionName = 'users';
  final _redemedCouponsCollectionName = 'redemptions';
  @override
  Future<void> editCoupon({
    required String userId,
    required String couponId,
    required String couponCode,
    required double discountAmount,
    required DateTime expiryDate,
  }) {
    // TODO: implement editCoupon
    throw UnimplementedError();
  }

  @override
  Future<List<CouponDto>> getUsersRedemedCoupons({
    required String userId,
  }) async {
    // final userDoc =
    //     await _fireStore.collection(_usersCollectionName).doc(userId).get();

    // if (!userDoc.exists) {
    //   throw Exception('User not found');
    // }

    final redemptionsSnapshot = await _fireStore
        .collection(_redemedCouponsCollectionName)
        .where('userId', isEqualTo: userId)
        .get();

    return redemptionsSnapshot.docs
        .map((doc) => CouponDto.fromJson(doc.data()))
        .toList();
  }
}
