// dart format width=120
import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_activity_log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_campaign_activity_log_controller.g.dart';

// ---------------------------------------------------------------------------
// Paginated state
// ---------------------------------------------------------------------------

class PaginatedActivityLogState {
  const PaginatedActivityLogState({
    required this.items,
    required this.hasMore,
    this.cursor,
    this.isLoadingMore = false,
  });

  final List<CampaignActivityLogEntry> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  PaginatedActivityLogState copyWith({
    List<CampaignActivityLogEntry>? items,
    Object? cursor,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PaginatedActivityLogState(
      items: items ?? this.items,
      cursor: cursor ?? this.cursor,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

// ---------------------------------------------------------------------------
// Controller
// ---------------------------------------------------------------------------

@riverpod
class ListCampaignActivityLogController extends _$ListCampaignActivityLogController {
  static const int _pageSize = 20;

  /// Active user-ID filter. `null` means "show all logs".
  String? _filterUserId;

  @override
  FutureOr<PaginatedActivityLogState> build({required String campaignId}) async {
    final result = await ref
        .read(campaignRepositoryProvider)
        .getCampaignActivityLogs(campaignId: campaignId, userId: _filterUserId, limit: _pageSize);
    return PaginatedActivityLogState(items: result.items, cursor: result.cursor, hasMore: result.hasMore);
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final result = await ref
          .read(campaignRepositoryProvider)
          .getCampaignActivityLogs(
            campaignId: campaignId,
            userId: _filterUserId,
            cursor: current.cursor,
            limit: _pageSize,
          );
      state = AsyncData(
        PaginatedActivityLogState(
          items: [...current.items, ...result.items],
          cursor: result.cursor,
          hasMore: result.hasMore,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  /// Filters the log by [userId].
  ///
  /// Pass `null` to clear the filter and load all entries again.
  Future<void> search(String? userId) async {
    _filterUserId = userId;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(campaignRepositoryProvider)
          .getCampaignActivityLogs(campaignId: campaignId, userId: _filterUserId, limit: _pageSize);
      return PaginatedActivityLogState(items: result.items, cursor: result.cursor, hasMore: result.hasMore);
    });
  }

  /// Refreshes while keeping the current user-ID filter intact.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(campaignRepositoryProvider)
          .getCampaignActivityLogs(campaignId: campaignId, userId: _filterUserId, limit: _pageSize);
      return PaginatedActivityLogState(items: result.items, cursor: result.cursor, hasMore: result.hasMore);
    });
  }

  /// Exposes the currently active filter value (read-only).
  String? get filterUserId => _filterUserId;
}
