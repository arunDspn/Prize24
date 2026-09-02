import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';

import 'package:prize24_app/features/shop/presentation/view_shop_staff/view_model/view_shop_staffs_controller.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/shop_staff_model.dart';

// Design System Colors (from HTML)
class _ShopStaffColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color errorRedLight = Color(0xFFFEF2F2);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

class ViewShopStaffsPage extends ConsumerStatefulWidget {
  const ViewShopStaffsPage({required this.shopId, super.key, this.shopName});

  final String shopId;
  final String? shopName;

  @override
  ConsumerState<ViewShopStaffsPage> createState() => _ViewShopStaffsPageState();
}

class _ViewShopStaffsPageState extends ConsumerState<ViewShopStaffsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll - 200) {
      ref
          .read(
            viewShopStaffsControllerProvider(shopId: widget.shopId).notifier,
          )
          .loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffsState = ref.watch(
      viewShopStaffsControllerProvider(shopId: widget.shopId),
    );

    return Scaffold(
      backgroundColor: _ShopStaffColors.slate50,
      body: Column(
        children: [
          // Custom AppBar with frosted glass effect
          _buildAppBar(context),
          // Main Content
          Expanded(
            child: RefreshIndicator(
              backgroundColor: Colors.white,
              color: _ShopStaffColors.brandStart,
              onRefresh: () async {
                await ref
                    .read(
                      viewShopStaffsControllerProvider(
                        shopId: widget.shopId,
                      ).notifier,
                    )
                    .refresh();
              },
              child: staffsState.when(
                data: (paginatedState) =>
                    _buildStaffsList(context, paginatedState),
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
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: _ShopStaffColors.slate50.withOpacity(0.9),
            border: const Border(
              bottom: BorderSide(color: _ShopStaffColors.slate200, width: 1),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 64,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Back button
                    _buildIconButton(
                      icon: Icons.chevron_left_rounded,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 12),
                    // Title section
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Shop Staff',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _ShopStaffColors.slate900,
                              height: 1.2,
                            ),
                          ),
                          if (widget.shopName != null)
                            Text(
                              widget.shopName!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: _ShopStaffColors.slate500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    // Add staff button (commented out as per original)
                    // _buildIconButton(
                    //   icon: Icons.person_add_outlined,
                    //   onPressed: _showAddStaffDialog,
                    //   iconColor: _ShopStaffColors.brandStart,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Icon(
            icon,
            size: 24,
            color: iconColor ?? _ShopStaffColors.slate500,
          ),
        ),
      ),
    );
  }

  Widget _buildStaffsList(
    BuildContext context,
    ViewShopStaffsPaginatedState paginatedState,
  ) {
    final staffs = paginatedState.staffs;
    if (staffs.isEmpty) {
      return _buildEmptyView(context);
    }

    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${staffs.length} MEMBER${staffs.length != 1 ? 'S' : ''}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _ShopStaffColors.slate500,
                    letterSpacing: 0.5,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await ref
                        .read(
                          viewShopStaffsControllerProvider(
                            shopId: widget.shopId,
                          ).notifier,
                        )
                        .refresh();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        size: 14,
                        color: _ShopStaffColors.brandStart,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Refresh',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _ShopStaffColors.brandStart,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Load-more footer
                if (index == staffs.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: paginatedState.isLoadingMore
                          ? const CircularProgressIndicator()
                          : const SizedBox.shrink(),
                    ),
                  );
                }
                final staff = staffs[index];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 300 + (index * 50)),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 10 * (1 - value)),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: _buildStaffCard(context, staff),
                );
              },
              childCount:
                  staffs.length + (paginatedState.isLoadingMore ? 1 : 0),
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
      ],
    );
  }

  Widget _buildStaffCard(BuildContext context, ShopStaffModel staff) {
    final initial = staff.staffName.isNotEmpty
        ? staff.staffName[0].toUpperCase()
        : '?';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _ShopStaffColors.slate100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Navigation logic preserved - currently no action
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    // Gradient Avatar
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: _ShopStaffColors.brandGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _ShopStaffColors.brandStart.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          initial,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Staff info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staff.staffName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _ShopStaffColors.slate900,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (staff.staffPhone != null &&
                              staff.staffPhone!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.phone_rounded,
                                    size: 12,
                                    color: _ShopStaffColors.slate400,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    staff.staffPhone!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: _ShopStaffColors.slate500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Arrow icon
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: _ShopStaffColors.slate300,
                    ),
                  ],
                ),
                // Joined date footer
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    padding: const EdgeInsets.only(top: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: _ShopStaffColors.slate50,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: _ShopStaffColors.slate400,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'JOINED ',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _ShopStaffColors.slate400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy').format(staff.addedAt),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _ShopStaffColors.slate500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Empty state icon
                    Container(
                      width: 96,
                      height: 96,
                      decoration: const BoxDecoration(
                        color: _ShopStaffColors.slate100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.groups_rounded,
                        size: 48,
                        color: _ShopStaffColors.slate400,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'No Staff Members',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _ShopStaffColors.slate900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Start building your team by adding staff members to your shop.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _ShopStaffColors.slate500,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Add Staff button with gradient
                    // Uncomment if needed
                    // _buildGradientButton(
                    //   onPressed: _showAddStaffDialog,
                    //   icon: Icons.add_rounded,
                    //   label: 'Add Staff',
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LOADING...',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _ShopStaffColors.slate500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Skeleton cards
        ...List.generate(3, (index) => _buildSkeletonCard()),
      ],
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _ShopStaffColors.slate100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        children: [
          // Skeleton avatar
          _buildShimmer(width: 48, height: 48, borderRadius: 24),
          const SizedBox(width: 16),
          // Skeleton text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmer(width: 120, height: 16, borderRadius: 4),
                const SizedBox(height: 8),
                _buildShimmer(width: 80, height: 12, borderRadius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer({
    required double width,
    required double height,
    required double borderRadius,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 0.7),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: _ShopStaffColors.slate100.withOpacity(value),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        );
      },
    );
  }

  Widget _buildErrorView(BuildContext context, String error) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Error icon
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: _ShopStaffColors.errorRedLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.error_rounded,
                        size: 32,
                        color: _ShopStaffColors.errorRed,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Failed to load staff',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _ShopStaffColors.slate800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Connection error or server issue.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: _ShopStaffColors.slate500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Retry button
                    Container(
                      decoration: BoxDecoration(
                        color: _ShopStaffColors.slate900,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            await ref
                                .read(
                                  viewShopStaffsControllerProvider(
                                    shopId: widget.shopId,
                                  ).notifier,
                                )
                                .refresh();
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Text(
                              'Retry',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: _ShopStaffColors.brandStart),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: _ShopStaffColors.slate500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _ShopStaffColors.slate800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddStaffDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Add Staff Member',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _ShopStaffColors.slate900,
          ),
        ),
        content: const Text(
          'This feature will allow you to invite new staff members to join your shop.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: _ShopStaffColors.slate600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _ShopStaffColors.slate500,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: _ShopStaffColors.brandGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Navigate to add staff page
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: const Text('Add staff feature coming soon!'),
                  //     backgroundColor: _ShopStaffColors.slate800,
                  //     behavior: SnackBarBehavior.floating,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  // );
                  showToastAtTop(
                    context,
                    'Add staff feature coming soon!',
                    false,
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    'Add Staff',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
