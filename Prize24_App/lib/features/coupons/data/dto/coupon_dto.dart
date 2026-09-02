import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/coupons/data/dto/price_pool_dto.dart';
part 'coupon_dto.freezed.dart';
part 'coupon_dto.g.dart';

@freezed
abstract class CouponDto with _$CouponDto {
  const factory CouponDto({
    required String couponName,
    required String storeName,
    required String description,
    required String couponCode,
    required DateTime drawDateTime,
    required DateTime expiryDate,
    // required String imageUrl,
    required List<PricePoolDto> prizePools,
    required String shopId,
    String? id,
  }) = _CouponDto;

  factory CouponDto.fromJson(Map<String, dynamic> json) =>
      _$CouponDtoFromJson(json);
}
