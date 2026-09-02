import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_shops/staff_shop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'staff_shop_list_controller.g.dart';

const _kPageLimit = 20;

class StaffShopListPaginatedState {
  const StaffShopListPaginatedState({
    required this.items,
    this.cursor,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<StaffShopModel> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  /// Alias used by the UI list builder.
  List<StaffShopModel> get page => items;

  StaffShopListPaginatedState copyWith({
    List<StaffShopModel>? items,
    Object? cursor,
    bool clearCursor = false,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return StaffShopListPaginatedState(
      items: items ?? this.items,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@riverpod
class StaffShopListController extends _$StaffShopListController {
  @override
  FutureOr<StaffShopListPaginatedState> build({
    required List<String> shopIds,
  }) async {
    if (shopIds.isEmpty) {
      return const StaffShopListPaginatedState(items: [], hasMore: false);
    }
    final result = await ref
        .read(shopRepositoryProvider)
        .getStaffsShops(shopIds: shopIds, limit: _kPageLimit);
    return StaffShopListPaginatedState(
      items: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  /// Load next page of shops.
  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final result = await ref
          .read(shopRepositoryProvider)
          .getStaffsShops(
            shopIds: shopIds,
            cursor: current.cursor,
            limit: _kPageLimit,
          );
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...result.items],
          cursor: result.cursor,
          hasMore: result.hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (e, stack) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
      Error.throwWithStackTrace(e, stack);
    }
  }

  /// Pull-to-refresh: reset to first page.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
