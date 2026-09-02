import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/shop_activity_log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shop_activity_log_list_controller.g.dart';

class PaginatedShopActivityLogState {
  const PaginatedShopActivityLogState({
    required this.items,
    required this.hasMore,
    this.cursor,
    this.isLoadingMore = false,
  });

  final List<ShopActivityLogEntry> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  PaginatedShopActivityLogState copyWith({
    List<ShopActivityLogEntry>? items,
    Object? cursor,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PaginatedShopActivityLogState(
      items: items ?? this.items,
      cursor: cursor ?? this.cursor,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@riverpod
class ShopActivityLogListController extends _$ShopActivityLogListController {
  static const int _pageSize = 20;

  /// Active user-ID filter. `null` means "show all logs".
  String? _filterUserId;

  @override
  FutureOr<PaginatedShopActivityLogState> build({
    required String shopId,
  }) async {
    final result = await ref
        .read(shopRepositoryProvider)
        .getShopActivityLogs(
          shopId: shopId,
          userId: _filterUserId,
          limit: _pageSize,
        );
    return PaginatedShopActivityLogState(
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
          .getShopActivityLogs(
            shopId: shopId,
            userId: _filterUserId,
            cursor: current.cursor,
            limit: _pageSize,
          );
      state = AsyncData(
        PaginatedShopActivityLogState(
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
          .read(shopRepositoryProvider)
          .getShopActivityLogs(
            shopId: shopId,
            userId: _filterUserId,
            limit: _pageSize,
          );
      return PaginatedShopActivityLogState(
        items: result.items,
        cursor: result.cursor,
        hasMore: result.hasMore,
      );
    });
  }

  /// Refreshes while keeping the current user-ID filter intact.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(shopRepositoryProvider)
          .getShopActivityLogs(
            shopId: shopId,
            userId: _filterUserId,
            limit: _pageSize,
          );
      return PaginatedShopActivityLogState(
        items: result.items,
        cursor: result.cursor,
        hasMore: result.hasMore,
      );
    });
  }

  /// Exposes the currently active filter value (read-only).
  String? get filterUserId => _filterUserId;
}
