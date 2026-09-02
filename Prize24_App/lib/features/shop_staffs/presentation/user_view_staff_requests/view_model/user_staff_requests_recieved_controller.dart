import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/become_staff_request_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_staff_requests_recieved_controller.g.dart';

const _kPageLimit = 20;

class StaffRequestsPaginatedState {
  const StaffRequestsPaginatedState({
    required this.items,
    this.cursor,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  final List<BecomeStaffRequestModel> items;

  /// Opaque Firestore cursor — do NOT inspect outside the Data layer.
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  /// Alias kept for UI compatibility.
  List<BecomeStaffRequestModel> get page => items;

  StaffRequestsPaginatedState copyWith({
    List<BecomeStaffRequestModel>? items,
    Object? cursor,
    bool? hasMore,
    bool? isLoadingMore,
    bool clearCursor = false,
  }) {
    return StaffRequestsPaginatedState(
      items: items ?? this.items,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@riverpod
class UserStaffRequestsRecievedController
    extends _$UserStaffRequestsRecievedController {
  @override
  FutureOr<StaffRequestsPaginatedState> build() async {
    final userId = ref.watch(authControllerProvider).requireValue!.userId;
    final result = await ref
        .read(shopRepositoryProvider)
        .getShopStaffRequestsReceived(staffUserId: userId, limit: _kPageLimit);
    return StaffRequestsPaginatedState(
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
      final userId = ref.read(authControllerProvider).requireValue!.userId;
      final result = await ref
          .read(shopRepositoryProvider)
          .getShopStaffRequestsReceived(
            staffUserId: userId,
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
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  // Locally remove accepted/declined request without refetching
  void removeRequestFromState(String requestId) {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        items: current.items.where((r) => r.id != requestId).toList(),
      ),
    );
  }
}
