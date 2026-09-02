import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_shops/staff_shop_model.dart';
import 'package:prize24_app/features/shop_staffs/presentation/staff_operations/staff_shop_detail/ui/shop_campaigns/shop_campaigns_view.dart';
import 'package:prize24_app/features/shop_staffs/presentation/staff_operations/staff_shop_detail/ui/shop_clubs/shop_clubs_view.dart';

// Design system colors matching the HTML mockup
class _DesignColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [brandStart, brandEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class StaffShopDetailPage extends ConsumerStatefulWidget {
  const StaffShopDetailPage({
    required this.staffShopModel,
    super.key,
  });

  final StaffShopModel staffShopModel;

  @override
  ConsumerState<StaffShopDetailPage> createState() =>
      _StaffShopDetailPageState();
}

class _StaffShopDetailPageState extends ConsumerState<StaffShopDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _DesignColors.slate50,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // Custom AppBar with frosted glass effect
            SliverAppBar(
              pinned: true,
              floating: false,
              backgroundColor: _DesignColors.slate50.withOpacity(0.9),
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: _buildBackButton(),
              title: Text(
                widget.staffShopModel.shopName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: _DesignColors.slate900,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(52),
                child: _buildCustomTabBar(),
              ),
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Campaigns Tab
            ShopCampaignsView(widget.staffShopModel.id),
            // Clubs Tab
            ShopClubsView(
              campaignId: widget.staffShopModel.associatedCampaignId,
              shopId: widget.staffShopModel.id,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: _DesignColors.slate500,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _DesignColors.slate200,
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          // Sliding indicator
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            left: _tabController.index == 0
                ? 0
                : MediaQuery.of(context).size.width / 2,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 2,
              decoration: const BoxDecoration(
                gradient: _DesignColors.brandGradient,
              ),
            ),
          ),
          // Tab buttons
          Row(
            children: [
              Expanded(
                child: _buildTabButton(
                  index: 0,
                  icon: Icons.campaign_rounded,
                  label: 'Campaigns',
                ),
              ),
              Expanded(
                child: _buildTabButton(
                  index: 1,
                  icon: Icons.groups_rounded,
                  label: 'Shop Streaks',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _tabController.index == index;
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? _DesignColors.brandStart
                  : _DesignColors.slate400,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? _DesignColors.brandStart
                    : _DesignColors.slate400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Loading State Widget
Widget buildLoadingState() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: const AlwaysStoppedAnimation<Color>(
                _DesignColors.brandStart,
              ),
              backgroundColor: _DesignColors.slate200,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Loading...',
            style: TextStyle(
              fontSize: 14,
              color: _DesignColors.slate400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

// Error State Widget
Widget buildErrorState(String type, BuildContext context,
    {VoidCallback? onRetry}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Error icon container
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              size: 32,
              color: Colors.red.shade500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading $type',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: _DesignColors.slate900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Retry button
          GestureDetector(
            onTap: onRetry,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _DesignColors.slate200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.refresh_rounded,
                    size: 18,
                    color: _DesignColors.slate800,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _DesignColors.slate800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Empty State Widget
Widget buildEmptyState({
  required IconData icon,
  required String title,
  required String subtitle,
  required BuildContext context,
}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty icon container
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _DesignColors.slate100,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              icon,
              size: 40,
              color: _DesignColors.slate300,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: _DesignColors.slate900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: _DesignColors.slate500,
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
