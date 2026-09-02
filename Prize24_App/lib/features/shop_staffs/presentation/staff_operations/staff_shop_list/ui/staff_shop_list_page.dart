import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_shops/staff_shop_model.dart';
import 'package:prize24_app/features/shop_staffs/presentation/staff_operations/staff_shop_list/view_model/staff_shop_list_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Design System Colors based on HTML theme
class _DesignColors {
  static const Color pageBg = Color(0xFFF8FAFC); // slate-50
  static const Color pageCard = Color(0xFFFFFFFF); // white
  static const Color pageInput = Color(0xFFF1F5F9); // slate-100
  static const Color textMain = Color(0xFF1E293B); // slate-800
  static const Color textSub = Color(0xFF64748B); // slate-500
  static const Color brandStart = Color(0xFFEF4444); // red-500
}

class StaffShopListPage extends ConsumerStatefulWidget {
  const StaffShopListPage({
    required this.shopIds,
    required this.staffId,
    super.key,
    this.staffName,
  });

  final String staffId;
  final String? staffName;
  final List<String> shopIds;

  @override
  ConsumerState<StaffShopListPage> createState() => _StaffShopListPageState();
}

class _StaffShopListPageState extends ConsumerState<StaffShopListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(
            staffShopListControllerProvider(shopIds: widget.shopIds).notifier,
          )
          .loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffShopsAsync = ref.watch(
      staffShopListControllerProvider(shopIds: widget.shopIds),
    );

    return Scaffold(
      backgroundColor: _DesignColors.pageBg,
      body: Column(
        children: [
          // Custom AppBar
          _buildAppBar(context),
          // Main Content
          Expanded(
            child: RefreshIndicator(
              backgroundColor: _DesignColors.pageCard,
              color: _DesignColors.brandStart,
              onRefresh: () => ref
                  .read(
                    staffShopListControllerProvider(
                      shopIds: widget.shopIds,
                    ).notifier,
                  )
                  .refresh(),
              child: staffShopsAsync.when(
                data: (paginatedState) => _buildShopsList(
                  context,
                  paginatedState.page,
                  paginatedState.isLoadingMore,
                ),
                loading: () => _buildLoadingView(context),
                error: (error, stack) =>
                    _buildErrorView(context, error.toString()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _DesignColors.pageCard.withOpacity(0.8),
        border: const Border(
          bottom: BorderSide(color: _DesignColors.pageInput, width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: _DesignColors.textSub,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Title Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Shop List',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _DesignColors.textMain,
                        letterSpacing: -0.5,
                      ),
                    ),
                    if (widget.staffName != null)
                      Text(
                        'Staff: ${widget.staffName}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _DesignColors.textSub,
                          letterSpacing: 0.5,
                        ),
                      ),
                  ],
                ),
              ),
              // Refresh Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    ref
                        .read(
                          staffShopListControllerProvider(
                            shopIds: widget.shopIds,
                          ).notifier,
                        )
                        .refresh();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: _DesignColors.textSub,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShopsList(
    BuildContext context,
    List<StaffShopModel> shops,
    bool isLoadingMore,
  ) {
    if (shops.isEmpty && !isLoadingMore) {
      return _buildEmptyView(context);
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: shops.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == shops.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _DesignColors.brandStart,
                ),
              ),
            ),
          );
        }
        final shop = shops[index];
        return _buildShopCard(context, shop);
      },
    );
  }

  Widget _buildShopCard(BuildContext context, StaffShopModel shop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _DesignColors.pageCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DesignColors.pageInput, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _onShopTap(context, shop),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Shop Icon with brand gradient background
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _DesignColors.brandStart.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.storefront_rounded,
                    color: _DesignColors.brandStart,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Shop Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.shopName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _DesignColors.textMain,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Shop ID: ${shop.id}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: _DesignColors.textSub,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Arrow Icon
                Icon(
                  Icons.chevron_right_rounded,
                  color: _DesignColors.textSub.withOpacity(0.4),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: const AlwaysStoppedAnimation<Color>(
                _DesignColors.brandStart,
              ),
              backgroundColor: _DesignColors.brandStart.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Loading shops...',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _DesignColors.textSub,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String error) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: _DesignColors.brandStart,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error Loading Shops',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _DesignColors.textMain,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Try Again Button
            GestureDetector(
              onTap: () {
                ref
                    .read(
                      staffShopListControllerProvider(
                        shopIds: widget.shopIds,
                      ).notifier,
                    )
                    .refresh();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: _DesignColors.textMain,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty State Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _DesignColors.pageInput,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                Icons.storefront_rounded,
                size: 36,
                color: _DesignColors.textSub.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Shops Found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _DesignColors.textMain,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'This staff member is not associated with any shops yet.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _DesignColors.textSub,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onShopTap(BuildContext context, StaffShopModel shop) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return StaffShopDetailPage(
    //         staffShopModel: shop,
    //       );
    //     },
    //   ),
    // );
    context.push(AppRoutes.staffShopDetails, extra: shop);
  }
}
