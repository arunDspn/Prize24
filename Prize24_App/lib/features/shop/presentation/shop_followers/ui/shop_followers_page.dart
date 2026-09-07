import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/common_widgets/phone_number_link.dart';
import 'package:prize24_app/features/shop/presentation/shop_followers/view_model/shop_followers_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Design Colors from HTML
class _DesignColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
  static const Color green500 = Color(0xFF22C55E);
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red500 = Color(0xFFEF4444);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

class ShopFollowersPage extends ConsumerStatefulWidget {
  const ShopFollowersPage({required this.shopId, super.key});

  final String shopId;

  @override
  ConsumerState<ShopFollowersPage> createState() => _ShopFollowersPageState();
}

class _ShopFollowersPageState extends ConsumerState<ShopFollowersPage> {
  final _scrollController = ScrollController();
  final _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll - 200) {
      ref
          .read(shopFollowersControllerProvider(shopId: widget.shopId).notifier)
          .loadMore();
    }
  }

  void _triggerSearch() {
    final userId = _userIdController.text.trim();
    ref
        .read(shopFollowersControllerProvider(shopId: widget.shopId).notifier)
        .searchByUserId(userId.isEmpty ? null : userId);
  }

  void _clearSearch() {
    _userIdController.clear();
    ref
        .read(shopFollowersControllerProvider(shopId: widget.shopId).notifier)
        .searchByUserId(null);
  }

  String _getInitials(String name) {
    return name
        .split(' ')
        .map((n) => n.isNotEmpty ? n[0] : '')
        .take(2)
        .join()
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      shopFollowersControllerProvider(shopId: widget.shopId),
    );

    final filterUserId = state.asData?.value.filterUserId;

    return Scaffold(
      backgroundColor: _DesignColors.slate50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          decoration: BoxDecoration(
            color: _DesignColors.slate50.withOpacity(0.9),
            border: const Border(
              bottom: BorderSide(color: _DesignColors.slate200, width: 1),
            ),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ColorFilter.mode(
                Colors.white.withOpacity(0.1),
                BlendMode.srcOver,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.chevron_left,
                                  size: 24,
                                  color: _DesignColors.slate500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Title
                          const Text(
                            'Shop Followers',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _DesignColors.slate900,
                            ),
                          ),
                        ],
                      ),
                      // Refresh Button
                      GestureDetector(
                        onTap: () => ref
                            .read(
                              shopFollowersControllerProvider(
                                shopId: widget.shopId,
                              ).notifier,
                            )
                            .refresh(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.refresh,
                              size: 22,
                              color: _DesignColors.slate500,
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Search Bar ─────────────────────────────────────────────
          _buildSearchBar(filterUserId),
          // ── Content ────────────────────────────────────────────────
          Expanded(
            child: state.when(
              data: (paginatedState) {
                final followers = paginatedState.followers;
                if (followers.isEmpty) {
                  // Empty State
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Header Section
                        _buildHeaderSection('0 Followers'),
                        const SizedBox(height: 16),
                        // Empty Card
                        Expanded(
                          child: Center(
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: 1),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0, 10 * (1 - value)),
                                  child: Opacity(opacity: value, child: child),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 80,
                                  horizontal: 32,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: _DesignColors.slate200,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _DesignColors.slate50,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.person_add_outlined,
                                          size: 40,
                                          color: _DesignColors.slate300,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      paginatedState.filterUserId != null
                                          ? 'User not found'
                                          : 'No followers yet',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: _DesignColors.slate900,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      paginatedState.filterUserId != null
                                          ? 'No follower matched the given user ID.'
                                          : 'Start sharing your shop to gain followers\nand grow your community.',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: _DesignColors.slate500,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Data List
                return RefreshIndicator(
                  onRefresh: () => ref
                      .read(
                        shopFollowersControllerProvider(
                          shopId: widget.shopId,
                        ).notifier,
                      )
                      .refresh(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        // Header Section
                        _buildHeaderSection(
                          '${followers.length} ${followers.length == 1 ? 'Follower' : 'Followers'}',
                        ),
                        const SizedBox(height: 16),
                        // Follower List
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.only(bottom: 40),
                            itemCount:
                                followers.length +
                                (paginatedState.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              // Load-more footer
                              if (index == followers.length) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 24,
                                  ),
                                  child: Center(
                                    child: paginatedState.isLoadingMore
                                        ? const CircularProgressIndicator()
                                        : const SizedBox.shrink(),
                                  ),
                                );
                              }
                              final follower = followers[index];
                              final phoneNumber = follower.userPhoneNumber
                                  ?.trim();
                              return TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: Duration(
                                  milliseconds: 300 + (index * 50),
                                ),
                                curve: Curves.easeOut,
                                builder: (context, value, child) {
                                  return Transform.translate(
                                    offset: Offset(0, 10 * (1 - value)),
                                    child: Opacity(
                                      opacity: value,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.push(
                                        AppRoutes.shopFollowerDetails,
                                        extra: (follower, widget.shopId),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: _DesignColors.slate100,
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.05,
                                            ),
                                            blurRadius: 20,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          // Gradient Avatar
                                          Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient:
                                                  _DesignColors.brandGradient,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: _DesignColors
                                                      .brandStart
                                                      .withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                _getInitials(follower.userName),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          // Info
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  follower.userName,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        _DesignColors.slate900,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                if (phoneNumber != null &&
                                                    phoneNumber.isNotEmpty) ...[
                                                  const SizedBox(height: 4),
                                                  PhoneNumberLink(
                                                    key: ValueKey(
                                                      'follower-phone-${follower.userId}',
                                                    ),
                                                    phoneNumber: phoneNumber,
                                                    iconColor:
                                                        _DesignColors.slate500,
                                                    iconSize: 14,
                                                    textStyle: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: _DesignColors
                                                          .slate500,
                                                    ),
                                                  ),
                                                ],
                                                // Row(
                                                //   children: [
                                                //     Container(
                                                //       width: 6,
                                                //       height: 6,
                                                //       decoration:
                                                //           const BoxDecoration(
                                                //             shape:
                                                //                 BoxShape.circle,
                                                //             color: _DesignColors
                                                //                 .green500,
                                                //           ),
                                                //     ),
                                                //     const SizedBox(width: 6),
                                                //     // const Text(
                                                //     //   'Active Follower',
                                                //     //   style: TextStyle(
                                                //     //     fontSize: 12,
                                                //     //     fontWeight:
                                                //     //         FontWeight.w500,
                                                //     //     color: _DesignColors
                                                //     //         .slate500,
                                                //     //   ),
                                                //     // ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                          // Streak Badge
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFF7ED),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.local_fire_department,
                                                  size: 14,
                                                  color: Color(0xFFF97316),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${follower.cumulativeStreak}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFFF97316),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          // Arrow Icon
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.chevron_right,
                                                size: 20,
                                                color: _DesignColors.slate300,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: _buildLoadingState,
              error: (error, stack) {
                return _buildErrorState(context, ref, error);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(String? activeFilterUserId) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      color: _DesignColors.slate50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: activeFilterUserId != null
                          ? _DesignColors.brandStart
                          : _DesignColors.slate200,
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    controller: _userIdController,
                    style: const TextStyle(
                      fontSize: 14,
                      color: _DesignColors.slate900,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search by User ID…',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: _DesignColors.slate300,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 18,
                        color: _DesignColors.slate500,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _triggerSearch(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Search button
              GestureDetector(
                onTap: _triggerSearch,
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: _DesignColors.brandGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: _DesignColors.brandStart.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Fetch',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Active filter chip
          if (activeFilterUserId != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _DesignColors.brandStart.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _DesignColors.brandStart.withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.filter_alt,
                        size: 12,
                        color: _DesignColors.brandStart,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Filtered: $activeFilterUserId',
                        style: const TextStyle(
                          fontSize: 12,
                          color: _DesignColors.brandStart,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _clearSearch,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _DesignColors.slate100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.close,
                          size: 12,
                          color: _DesignColors.slate500,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 12,
                            color: _DesignColors.slate500,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeaderSection(String countText) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: _DesignColors.slate100,
          ),
          child: const Center(
            child: Icon(
              Icons.people,
              size: 18,
              color: _DesignColors.brandStart,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          countText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _DesignColors.slate900,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          _buildHeaderSection('Loading...'),
          const SizedBox(height: 16),
          // Skeleton Items
          for (int i = 0; i < 4; i++) ...[
            _buildSkeletonCard(),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DesignColors.slate100, width: 1),
      ),
      child: Row(
        children: [
          // Avatar Skeleton
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _DesignColors.slate100,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _DesignColors.slate100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 100,
                  decoration: BoxDecoration(
                    color: _DesignColors.slate100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: Opacity(opacity: value, child: child),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _DesignColors.red50,
                ),
                child: const Center(
                  child: Icon(
                    Icons.error,
                    size: 32,
                    color: _DesignColors.red500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Error loading followers',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _DesignColors.slate800,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Something went wrong while fetching data.',
                style: TextStyle(fontSize: 12, color: _DesignColors.slate500),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => ref
                    .read(
                      shopFollowersControllerProvider(
                        shopId: widget.shopId,
                      ).notifier,
                    )
                    .refresh(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: _DesignColors.slate900,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
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
}
