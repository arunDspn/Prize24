import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_shops/staff_shop_model.dart';
part 'staff_shop_dto.freezed.dart';
part 'staff_shop_dto.g.dart';

@freezed
abstract class StaffShopDto with _$StaffShopDto {
  const factory StaffShopDto({
    required String shopName,
    // Shop ID
    String? id,
    String? associatedCampaignId,
  }) = _StaffShopDto;

  factory StaffShopDto.fromJson(Map<String, dynamic> json) =>
      _$StaffShopDtoFromJson(json);

  // Private const constructor
  const StaffShopDto._();

  // Convert DTO to domain model
  StaffShopModel toDomain() {
    return StaffShopModel(
      id: id!,
      shopName: shopName,
      associatedCampaignId: associatedCampaignId,
    );
  }
}
