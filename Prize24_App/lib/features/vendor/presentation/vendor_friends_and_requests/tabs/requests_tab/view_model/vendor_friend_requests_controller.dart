import 'package:prize24_app/core/services/analytics/analytics_events.dart';
import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/data/repository/vendor_repository.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_request_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vendor_friend_requests_controller.g.dart';

const _kPageLimit = 20;

class VendorFriendRequestsPaginatedState {
  const VendorFriendRequestsPaginatedState({
    required this.items,
    this.cursor,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<VendorFriendRequestModel> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  /// Alias used by the UI list builder.
  List<VendorFriendRequestModel> get page => items;

  VendorFriendRequestsPaginatedState copyWith({
    List<VendorFriendRequestModel>? items,
    Object? cursor,
    bool clearCursor = false,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return VendorFriendRequestsPaginatedState(
      items: items ?? this.items,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

/// Controller for managing vendor friend requests with real Firestore cursor pagination.
@Riverpod()
class VendorFriendRequestsController extends _$VendorFriendRequestsController {
  @override
  Future<VendorFriendRequestsPaginatedState> build() async {
    final vendorId = ref.read(authControllerProvider).requireValue!.userId;
    final result = await ref
        .read(vendorRepositoryProvider)
        .getVendorFriendRequests(vendorId: vendorId, limit: _kPageLimit);
    return VendorFriendRequestsPaginatedState(
      items: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  /// Load next page of received requests.
  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final vendorId = ref.read(authControllerProvider).requireValue!.userId;
      final result = await ref
          .read(vendorRepositoryProvider)
          .getVendorFriendRequests(
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

  Future<void> acceptRequest(VendorFriendRequestModel request) async {
    try {
      await ref
          .read(vendorRepositoryProvider)
          .respondToFriendRequest(friendshipId: request.id, action: 'accept');
      await ref
          .read(analyticsServiceProvider)
          .logRequestResponse(
            requestType: RequestType.friend,
            action: RequestResponseAction.accept,
          );
      final current = state.asData?.value;
      if (current == null) return;
      state = AsyncData(
        current.copyWith(
          items: current.items.where((r) => r.id != request.id).toList(),
        ),
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> declineRequest(VendorFriendRequestModel request) async {
    try {
      await ref
          .read(vendorRepositoryProvider)
          .respondToFriendRequest(friendshipId: request.id, action: 'decline');
      await ref
          .read(analyticsServiceProvider)
          .logRequestResponse(
            requestType: RequestType.friend,
            action: RequestResponseAction.decline,
          );
      final current = state.asData?.value;
      if (current == null) return;
      state = AsyncData(
        current.copyWith(
          items: current.items.where((r) => r.id != request.id).toList(),
        ),
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
