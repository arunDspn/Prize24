import 'package:freezed_annotation/freezed_annotation.dart';
part 'subscription_state.freezed.dart';

@freezed
abstract class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState({
    required int maxShops,
    required int maxCampaigns,
    required int maxUserFollowing,
    required int coinBalance,
    required String rcEntitlementName,
  }) = _SubscriptionState;
}
