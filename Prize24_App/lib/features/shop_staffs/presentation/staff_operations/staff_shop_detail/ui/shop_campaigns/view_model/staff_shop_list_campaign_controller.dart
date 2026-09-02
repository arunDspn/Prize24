import 'package:prize24_app/features/shop_staffs/data/repository/i_staff_repository.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_campaigns/staff_campaign_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'staff_shop_list_campaign_controller.g.dart';

const _kPageLimit = 20;

class StaffShopCampaignPaginatedState {
  const StaffShopCampaignPaginatedState({
    required this.items,
    this.cursor,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<StaffCampaignModel> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  /// Alias used by the UI list builder.
  List<StaffCampaignModel> get page => items;

  StaffShopCampaignPaginatedState copyWith({
    List<StaffCampaignModel>? items,
    Object? cursor,
    bool clearCursor = false,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return StaffShopCampaignPaginatedState(
      items: items ?? this.items,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@riverpod
class StaffShopListCampaignController
    extends _$StaffShopListCampaignController {
  @override
  FutureOr<StaffShopCampaignPaginatedState> build({
    required String shopId,
  }) async {
    final result = await ref
        .read(staffRepositoryProviderProvider)
        .getCampaignsForShop(shopId, limit: _kPageLimit);
    return StaffShopCampaignPaginatedState(
      items: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  /// Load next page of campaigns.
  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final result = await ref
          .read(staffRepositoryProviderProvider)
          .getCampaignsForShop(
            shopId,
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
