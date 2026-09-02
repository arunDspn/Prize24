import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:prize24_app/features/campaign/domain/models/gift_redemption_audit_log_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'list_campaign_redemption_audit_log_controller.g.dart';

class PaginatedAuditLogState {
  const PaginatedAuditLogState({
    required this.items,
    required this.hasMore,
    this.cursor,
    this.isLoadingMore = false,
  });

  final List<GiftRedemptionAuditLogModel> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  PaginatedAuditLogState copyWith({
    List<GiftRedemptionAuditLogModel>? items,
    Object? cursor,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PaginatedAuditLogState(
      items: items ?? this.items,
      cursor: cursor ?? this.cursor,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@riverpod
class ListCampaignRedemptionAuditLogController
    extends _$ListCampaignRedemptionAuditLogController {
  static const int _pageSize = 10;

  @override
  FutureOr<PaginatedAuditLogState> build({required String campaignId}) async {
    final result = await ref
        .read(campaignRepositoryProvider)
        .getCampaignGiftRedemptionAuditLog(
          campaignId: campaignId,
          limit: _pageSize,
        );
    return PaginatedAuditLogState(
      items: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final result = await ref
          .read(campaignRepositoryProvider)
          .getCampaignGiftRedemptionAuditLog(
            campaignId: campaignId,
            cursor: current.cursor,
            limit: _pageSize,
          );
      state = AsyncData(
        PaginatedAuditLogState(
          items: [...current.items, ...result.items],
          cursor: result.cursor,
          hasMore: result.hasMore,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
