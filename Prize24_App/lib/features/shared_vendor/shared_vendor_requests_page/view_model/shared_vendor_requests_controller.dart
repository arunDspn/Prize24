import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_sharing_request_model.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shared_vendor_requests_controller.g.dart';

const _kPageLimit = 20;

class SharedVendorRequestsPaginatedState {
  const SharedVendorRequestsPaginatedState({
    required this.items,
    this.cursor,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  final List<CampaignSharingRequestModel> items;

  /// Opaque Firestore cursor — do NOT inspect outside the Data layer.
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  /// Alias kept so the existing UI needs no changes.
  List<CampaignSharingRequestModel> get page => items;

  SharedVendorRequestsPaginatedState copyWith({
    List<CampaignSharingRequestModel>? items,
    Object? cursor,
    bool? hasMore,
    bool? isLoadingMore,
    bool clearCursor = false,
  }) {
    return SharedVendorRequestsPaginatedState(
      items: items ?? this.items,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@riverpod
class SharedVendorRequestsController extends _$SharedVendorRequestsController {
  @override
  FutureOr<SharedVendorRequestsPaginatedState> build() async {
    final vendorId = ref.read(authControllerProvider).requireValue!.userId;
    final result = await ref
        .read(campaignRepositoryProvider)
        .listCampaignSharingRequests(vendorId: vendorId, limit: _kPageLimit);
    return SharedVendorRequestsPaginatedState(
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
      final vendorId = ref.read(authControllerProvider).requireValue!.userId;
      final result = await ref
          .read(campaignRepositoryProvider)
          .listCampaignSharingRequests(
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
    } catch (_) {
      // Restore state without loading flag so user can retry.
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  void updateRequestState(String requestId, String action) {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        items: current.items.where((r) => r.id != requestId).toList(),
      ),
    );
  }
}
