import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop/domain/model/shop_offer_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shop_offer_list_controller.g.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

/// Immutable state for the shop-offer list.
///
/// The [cursor] is an opaque [Object?] token. The Presentation layer must not
/// inspect or cast it — simply pass it back to the repository to fetch the
/// next page.
class OfferListState {
  const OfferListState({
    this.items = const [],
    this.cursor,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  /// All offers loaded so far (accumulates across pages).
  final List<ShopOfferModel> items;

  /// Opaque cursor for the next page. `null` when no more pages exist.
  final Object? cursor;

  /// Whether a next page is available.
  final bool hasMore;

  /// `true` while a "fetch more" request is in flight.
  /// Used to show the loading indicator at the bottom of the list.
  final bool isLoadingMore;

  OfferListState copyWith({
    List<ShopOfferModel>? items,
    Object? cursor,
    bool? hasMore,
    bool? isLoadingMore,
    // Set to `true` to explicitly clear the cursor (mark as last page).
    bool clearCursor = false,
  }) {
    return OfferListState(
      items: items ?? this.items,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

@riverpod
class ShopOfferListController extends _$ShopOfferListController {
  /// [build] acts as the "load first page" implementation.
  @override
  Future<OfferListState> build({required String shopId}) async {
    final result = await ref
        .read(shopRepositoryProvider)
        .listShopOffers(shopId: shopId);

    return OfferListState(
      items: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  // ---------------------------------------------------------------------------
  // Public actions
  // ---------------------------------------------------------------------------

  /// Loads the next page and appends its items to [OfferListState.items].
  ///
  /// Safe to call from a scroll-listener — it guards against:
  ///   • concurrent requests ([isLoadingMore] check)
  ///   • fetching past the last page ([hasMore] check)
  Future<void> fetchMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    // Show the spinner at the list bottom without clearing the current items.
    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final result = await ref
          .read(shopRepositoryProvider)
          .listShopOffers(
            shopId: shopId,
            cursor: current.cursor, // opaque black-box token
          );

      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...result.items],
          cursor: result.cursor,
          hasMore: result.hasMore,
          isLoadingMore: false,
          clearCursor: result.cursor == null,
        ),
      );
    } catch (_) {
      // Restore previous state so the user can retry.
      state = AsyncData(current.copyWith(isLoadingMore: false));
      rethrow;
    }
  }

  /// Resets back to page 1 (pull-to-refresh).
  ///
  /// Calling [ref.invalidateSelf] causes Riverpod to re-run [build], which
  /// calls `listShopOffers` with no cursor — i.e. the first page.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future; // wait for build() to settle before releasing the refresh indicator
  }
}
