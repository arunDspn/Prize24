import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/data/repository/vendor_repository.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_sent_request_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vendor_sent_requests_controller.g.dart';

const _kSentPageLimit = 20;

class VendorSentRequestsPaginatedState {
  const VendorSentRequestsPaginatedState({
    required this.items,
    this.cursor,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<VendorSentRequestModel> items;
  final Object? cursor;
  final bool hasMore;
  final bool isLoadingMore;

  /// Alias used by the UI list builder.
  List<VendorSentRequestModel> get page => items;

  VendorSentRequestsPaginatedState copyWith({
    List<VendorSentRequestModel>? items,
    Object? cursor,
    bool clearCursor = false,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return VendorSentRequestsPaginatedState(
      items: items ?? this.items,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

/// Controller for managing vendor sent friend requests with real Firestore cursor pagination.
@Riverpod()
class VendorSentRequestsController extends _$VendorSentRequestsController {
  @override
  Future<VendorSentRequestsPaginatedState> build() async {
    final vendorId = ref.read(authControllerProvider).requireValue!.userId;
    final result = await ref
        .read(vendorRepositoryProvider)
        .getVendorSentRequests(vendorId: vendorId, limit: _kSentPageLimit);
    return VendorSentRequestsPaginatedState(
      items: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  /// Load next page of sent requests.
  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final vendorId = ref.read(authControllerProvider).requireValue!.userId;
      final result = await ref
          .read(vendorRepositoryProvider)
          .getVendorSentRequests(
            vendorId: vendorId,
            cursor: current.cursor,
            limit: _kSentPageLimit,
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

  Future<void> cancelSentRequest(VendorSentRequestModel request) async {
    try {
      await ref
          .read(vendorRepositoryProvider)
          .cancelSentRequest(requestId: request.id);
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
