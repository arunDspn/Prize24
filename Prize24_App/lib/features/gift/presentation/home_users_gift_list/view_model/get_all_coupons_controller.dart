import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';
import 'package:prize24_app/features/gift/domain/use_cases/list_user_gift/list_user_gifts_usecase.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_all_coupons_controller.g.dart';

class GetAllCouponsPaginatedState {
  const GetAllCouponsPaginatedState({
    this.items = const [],
    this.cursor,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  final List<UserGiftModel> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  GetAllCouponsPaginatedState copyWith({
    List<UserGiftModel>? items,
    Object? cursor,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return GetAllCouponsPaginatedState(
      items: items ?? this.items,
      cursor: cursor ?? this.cursor,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

/// This controller fetches all redeemed coupons for a user with cursor pagination.
@riverpod
class GetAllCouponsController extends _$GetAllCouponsController {
  static const int _limit = 20;

  @override
  FutureOr<GetAllCouponsPaginatedState> build() async {
    final useCase = ref.read(listUserGiftsUsecaseProvider);
    final userId = (ref.read(authControllerProvider).requireValue!).userId;

    final result = await useCase(userId: userId, limit: _limit);

    return GetAllCouponsPaginatedState(
      items: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  /// Load the next page of coupons.
  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final useCase = ref.read(listUserGiftsUsecaseProvider);
      final userId = (ref.read(authControllerProvider).requireValue!).userId;

      final result = await useCase(
        userId: userId,
        cursor: current.cursor,
        limit: _limit,
      );

      state = AsyncData(
        GetAllCouponsPaginatedState(
          items: [...current.items, ...result.items],
          cursor: result.cursor,
          hasMore: result.hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (e, st) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
      Error.throwWithStackTrace(e, st);
    }
  }

  /// Refresh from the beginning.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
