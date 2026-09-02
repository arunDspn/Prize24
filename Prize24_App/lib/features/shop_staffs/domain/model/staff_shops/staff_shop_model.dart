import 'package:freezed_annotation/freezed_annotation.dart';
part 'staff_shop_model.freezed.dart';

@freezed
abstract class StaffShopModel with _$StaffShopModel {
  const factory StaffShopModel({
    /// Shop ID
    required String id,

    /// Shop Name
    required String shopName,

    /// Associated Club ID (if any)
    String? associatedCampaignId,
  }) = _StaffShopModel;
}
