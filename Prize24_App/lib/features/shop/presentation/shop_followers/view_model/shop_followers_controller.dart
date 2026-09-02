import 'package:prize24_app/features/happy_hours/domain/model/shop_follower_model.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shop_followers_controller.g.dart';

const _kPageLimit = 20;

class ShopFollowersPaginatedState {
  const ShopFollowersPaginatedState({
    this.followers = const [],
    this.cursor,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.filterUserId,
  });

  final List<ShopFollowerModel> followers;

  /// Opaque Firestore cursor token. Pass back to the repo to fetch the next
  /// page. `null` means first page or no more pages.
  final Object? cursor;
  final bool isLoadingMore;
  final bool hasMore;

  /// When non-null the list is filtered to this single user ID.
  final String? filterUserId;

  ShopFollowersPaginatedState copyWith({
    List<ShopFollowerModel>? followers,
    Object? cursor,
    bool? isLoadingMore,
    bool? hasMore,
    bool clearCursor = false,
    String? filterUserId,
    bool clearFilterUserId = false,
  }) {
    return ShopFollowersPaginatedState(
      followers: followers ?? this.followers,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      filterUserId: clearFilterUserId
          ? null
          : (filterUserId ?? this.filterUserId),
    );
  }
}

@riverpod
class ShopFollowersController extends _$ShopFollowersController {
  @override
  FutureOr<ShopFollowersPaginatedState> build({required String shopId}) async {
    final result = await ref
        .read(shopRepositoryProvider)
        .fetchShopFollowers(shopId: shopId, limit: _kPageLimit);

    return ShopFollowersPaginatedState(
      followers: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final result = await ref
          .read(shopRepositoryProvider)
          .fetchShopFollowers(
            shopId: shopId,
            userId: current.filterUserId,
            cursor: current.cursor, // opaque black-box token
            limit: _kPageLimit,
          );

      state = AsyncData(
        current.copyWith(
          followers: [...current.followers, ...result.items],
          cursor: result.cursor,
          hasMore: result.hasMore,
          isLoadingMore: false,
          clearCursor: result.cursor == null,
        ),
      );
    } catch (_) {
      // Restore prior state with loading flag cleared so user can retry.
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  /// Resets the list and re-fetches filtered by [userId].
  /// Pass `null` to clear the filter and load all followers.
  Future<void> searchByUserId(String? userId) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(shopRepositoryProvider)
          .fetchShopFollowers(
            shopId: shopId,
            userId: userId?.isNotEmpty == true ? userId : null,
            limit: _kPageLimit,
          );
      state = AsyncData(
        ShopFollowersPaginatedState(
          followers: result.items,
          cursor: result.cursor,
          hasMore: result.hasMore,
          filterUserId: userId?.isNotEmpty == true ? userId : null,
        ),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refresh() async {
    final currentFilter = state.asData?.value.filterUserId;
    await searchByUserId(currentFilter);
  }
}
