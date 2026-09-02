import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/core/constants.dart';
part 'subscription_metadata_model.freezed.dart';
part 'subscription_metadata_model.g.dart';

@freezed
abstract class SubscriptionMetadata with _$SubscriptionMetadata {
  const factory SubscriptionMetadata({
    required int maxShops,
    required int maxCampaigns,
    required int maxUsers,
  }) = _SubscriptionMetadata;

  factory SubscriptionMetadata.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionMetadataFromJson(json);
}
