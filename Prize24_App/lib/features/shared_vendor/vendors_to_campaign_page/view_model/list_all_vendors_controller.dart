import 'package:prize24_app/features/campaign/data/repository/i_campain_repository.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shared_vendor/vendors_to_campaign_page/ui_model/vendor_to_campaign_uimodel.dart';
import 'package:prize24_app/features/vendor/data/repository/vendor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_all_vendors_controller.g.dart';

const _kPageLimit = 20;

class VendorListPaginatedState {
  const VendorListPaginatedState({
    required this.allVendors,
    this.currentLimit = _kPageLimit,
    this.isLoadingMore = false,
  });

  /// Full list — used for search filtering
  final List<VendorToCampaignUimodel> allVendors;

  /// How many items are currently visible (grows on loadMore)
  final int currentLimit;

  final bool isLoadingMore;

  bool get hasMore => currentLimit < allVendors.length;

  /// Returns the paginated (and optionally filtered) slice.
  List<VendorToCampaignUimodel> page(String searchQuery) {
    var list = allVendors;
    if (searchQuery.isNotEmpty) {
      list = list
          .where(
            (v) =>
                v.vendorName.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ||
                v.vendorPhone.contains(searchQuery),
          )
          .toList();
    }
    list.sort((a, b) => a.vendorName.compareTo(b.vendorName));
    // When searching, show all matching results; otherwise respect the window
    if (searchQuery.isNotEmpty) return list;
    return list.take(currentLimit).toList();
  }

  VendorListPaginatedState copyWith({
    List<VendorToCampaignUimodel>? allVendors,
    int? currentLimit,
    bool? isLoadingMore,
  }) {
    return VendorListPaginatedState(
      allVendors: allVendors ?? this.allVendors,
      currentLimit: currentLimit ?? this.currentLimit,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@Riverpod()
class ListAllVendorsController extends _$ListAllVendorsController {
  @override
  FutureOr<VendorListPaginatedState> build({
    required List<String> alreadyAddedVendorIds,
    required String campaignId,
  }) async {
    final vendorId = ref.read(authControllerProvider).requireValue!.userId;

    final vendorRepository = ref.read(vendorRepositoryProvider);
    final friends = await vendorRepository.getVendorFriends(vendorId: vendorId);

    final alreadySentRequestUserIds = await ref
        .read(campaignRepositoryProvider)
        .listUserIdsOfAlreadySendRequest(campaignId: campaignId);

    final allVendors = friends.items
        .map(
          (friend) => VendorToCampaignUimodel(
            vendorId: friend.userId,
            vendorName: friend.vendorName,
            vendorPhone: '',
            isAlreadyAdded: alreadyAddedVendorIds.contains(friend.userId),
            isRequestSent: alreadySentRequestUserIds.contains(friend.userId),
          ),
        )
        .toList();

    return VendorListPaginatedState(allVendors: allVendors);
  }

  void loadMore() {
    final current = state.asData?.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncData(
      current.copyWith(currentLimit: current.currentLimit + _kPageLimit),
    );
  }

  Future<void> updateVendorStatus(String vendorId) async {
    final current = state.asData?.value;
    if (current == null) return;

    final updatedVendors = current.allVendors.map((vendor) {
      if (vendor.vendorId == vendorId) {
        return vendor.copyWith(isRequestSent: true);
      }
      return vendor;
    }).toList();

    state = AsyncData(current.copyWith(allVendors: updatedVendors));
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
