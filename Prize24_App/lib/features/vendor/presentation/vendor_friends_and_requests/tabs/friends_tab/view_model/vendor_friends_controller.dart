import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/data/repository/vendor_repository.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vendor_friends_controller.g.dart';

const _kPageLimit = 20;

class VendorFriendsPaginatedState {
  const VendorFriendsPaginatedState({
    required this.items,
    this.cursor,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<VendorFriendModel> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  /// Alias used by the UI list builder.
  List<VendorFriendModel> get page => items;

  VendorFriendsPaginatedState copyWith({
    List<VendorFriendModel>? items,
    Object? cursor,
    bool clearCursor = false,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return VendorFriendsPaginatedState(
      items: items ?? this.items,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

/// Controller for managing vendor friends with real Firestore cursor pagination.
@Riverpod()
class VendorFriendsController extends _$VendorFriendsController {
  @override
  Future<VendorFriendsPaginatedState> build() async {
    final vendorId = ref.read(authControllerProvider).requireValue!.userId;
    final result = await ref
        .read(vendorRepositoryProvider)
        .getVendorFriends(vendorId: vendorId, limit: _kPageLimit);
    return VendorFriendsPaginatedState(
      items: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  /// Load next page of friends.
  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final vendorId = ref.read(authControllerProvider).requireValue!.userId;
      final result = await ref
          .read(vendorRepositoryProvider)
          .getVendorFriends(
            vendorId: vendorId,
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

  /// Remove a friend from the in-memory list (and Firestore).
  Future<void> removeFriend(VendorFriendModel friend) async {
    try {
      await ref
          .read(vendorRepositoryProvider)
          .removeFriend(friendshipId: friend.id);

      final current = state.asData?.value;
      if (current == null) return;
      state = AsyncData(
        current.copyWith(
          items: current.items.where((f) => f.id != friend.id).toList(),
        ),
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
