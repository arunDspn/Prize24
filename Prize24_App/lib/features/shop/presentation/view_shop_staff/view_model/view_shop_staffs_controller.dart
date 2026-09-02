import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/shop_staff_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'view_shop_staffs_controller.g.dart';

const _kPageLimit = 20;

class ViewShopStaffsPaginatedState {
  const ViewShopStaffsPaginatedState({
    this.staffs = const [],
    this.cursor,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  final List<ShopStaffModel> staffs;

  /// Opaque Firestore cursor — do NOT inspect outside the Data layer.
  final Object? cursor;
  final bool isLoadingMore;
  final bool hasMore;

  ViewShopStaffsPaginatedState copyWith({
    List<ShopStaffModel>? staffs,
    Object? cursor,
    bool? isLoadingMore,
    bool? hasMore,
    bool clearCursor = false,
  }) {
    return ViewShopStaffsPaginatedState(
      staffs: staffs ?? this.staffs,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

@riverpod
class ViewShopStaffsController extends _$ViewShopStaffsController {
  @override
  FutureOr<ViewShopStaffsPaginatedState> build({required String shopId}) async {
    final result = await ref
        .read(shopRepositoryProvider)
        .getShopStaffs(shopId: shopId, limit: _kPageLimit);
    return ViewShopStaffsPaginatedState(
      staffs: result.items,
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
          .getShopStaffs(
            shopId: shopId,
            cursor: current.cursor,
            limit: _kPageLimit,
          );
      state = AsyncData(
        current.copyWith(
          staffs: [...current.staffs, ...result.items],
          cursor: result.cursor,
          hasMore: result.hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      // Restore prior state with loading flag cleared so user can retry.
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  /// Refreshes the staff list back to page 1
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
