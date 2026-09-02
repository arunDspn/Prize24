import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/follower_streak_log_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_streak_log_controller.g.dart';

class PaginatedStreakLogState {
  const PaginatedStreakLogState({
    required this.items,
    required this.hasMore,
    this.cursor,
    this.isLoadingMore = false,
  });

  final List<FollowerStreakLogModel> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  PaginatedStreakLogState copyWith({
    List<FollowerStreakLogModel>? items,
    Object? cursor,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PaginatedStreakLogState(
      items: items ?? this.items,
      cursor: cursor ?? this.cursor,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@riverpod
class UserStreakLogController extends _$UserStreakLogController {
  static const int _pageSize = 20;

  @override
  FutureOr<PaginatedStreakLogState> build({
    required String shopId,
    required String userId,
  }) async {
    final result = await ref
        .read(shopRepositoryProvider)
        .viewFollowerStreakLogs(
          shopId: shopId,
          userId: userId,
          limit: _pageSize,
        );
    return PaginatedStreakLogState(
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
          .read(shopRepositoryProvider)
          .viewFollowerStreakLogs(
            shopId: shopId,
            userId: userId,
            cursor: current.cursor,
            limit: _pageSize,
          );
      state = AsyncData(
        PaginatedStreakLogState(
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
