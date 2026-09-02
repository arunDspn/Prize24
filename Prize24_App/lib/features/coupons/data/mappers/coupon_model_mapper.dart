import 'package:prize24_app/features/coupons/data/dto/coupon_dto.dart';
import 'package:prize24_app/features/coupons/data/dto/price_pool_dto.dart';
import 'package:prize24_app/features/coupons/domain/model/coupon_model.dart';
import 'package:prize24_app/features/coupons/domain/model/price_pool_model.dart';
import 'package:prize24_app/utils/model_mapper_contract.dart';

// class CouponModelMapper implements ModelMapper<CouponModel, CouponDto> {
//   @override
//   CouponModel fromDto(CouponDto dto) {
//     return CouponModel(
//       couponName: dto.couponName,
//       storeName: dto.storeName,
//       description: dto.description,
//       couponCode: dto.couponCode,
//       drawDateTime: dto.drawDateTime,
//       expiryDate: dto.expiryDate,
//       prizePools: dto.prizePools
//           .map((pricePool) => PricePoolModelMapper().fromDto(pricePool))
//           .toList(),
//       shopId: dto.shopId,
//     );
//   }

//   @override
//   CouponDto toDto(CouponModel domainModel) {
//     // TODO: implement toDto
//     throw UnimplementedError();
//   }
// }

// class PricePoolModelMapper
//     implements ModelMapper<PricePoolModel, PricePoolDto> {
//   @override
//   PricePoolModel fromDto(PricePoolDto dto) {
//     return PricePoolModel(
//       prizeName: dto.prizeName,
//       prizeDescription: dto.prizeDescription,
//     );
//   }

//   @override
//   PricePoolDto toDto(PricePoolModel domainModel) {
//     return PricePoolDto(
//       prizeName: domainModel.prizeName,
//       prizeDescription: domainModel.prizeDescription,
//     );
//   }
// }
