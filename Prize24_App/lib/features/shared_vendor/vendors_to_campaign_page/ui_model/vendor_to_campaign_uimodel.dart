import 'package:freezed_annotation/freezed_annotation.dart';
part 'vendor_to_campaign_uimodel.freezed.dart';

@freezed
abstract class VendorToCampaignUimodel with _$VendorToCampaignUimodel {
  const factory VendorToCampaignUimodel({
    required String vendorId,
    required String vendorName,
    required String vendorPhone,
    required bool isAlreadyAdded,
    required bool isRequestSent,
  }) = _VendorToCampaignUimodel;
}
