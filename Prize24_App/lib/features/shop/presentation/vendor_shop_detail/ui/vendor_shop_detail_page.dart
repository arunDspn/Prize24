import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:prize24_app/features/shop/presentation/shop_followers/ui/shop_followers_page.dart';
import 'package:prize24_app/features/shop/presentation/vendor_scan_loyality/ui/vendor_scan_loyality_page.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Design System Colors
class _DesignColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

class VendorShopDetailsPage extends StatefulWidget {
  const VendorShopDetailsPage({required this.shop, super.key});

  final ShopModel shop;

  @override
  State<VendorShopDetailsPage> createState() => _VendorShopDetailsPageState();
}

class _VendorShopDetailsPageState extends State<VendorShopDetailsPage>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late ShopModel currentShop;

  @override
  void initState() {
    super.initState();
    currentShop = widget.shop;
    _scrollController = ScrollController()..addListener(_onScroll);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  void _onScroll() {
    final isScrolled = _scrollController.offset > 100;
    if (isScrolled != _isScrolled) {
      setState(() => _isScrolled = isScrolled);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _DesignColors.slate50,
      body: Stack(
        children: [
          // Hero Gradient Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 1000,
            child: Container(
              decoration: const BoxDecoration(
                gradient: _DesignColors.brandGradient,
              ),
            ),
          ),

          // Main Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Sticky Navigation
              SliverAppBar(
                pinned: true,
                floating: false,
                elevation: 0,
                backgroundColor: _isScrolled
                    ? Colors.white.withOpacity(0.9)
                    : Colors.transparent,
                surfaceTintColor: Colors.transparent,
                toolbarHeight: 64,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Center(
                    child: _NavButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ),
                title: AnimatedOpacity(
                  opacity: _isScrolled ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: AnimatedSlide(
                    offset: _isScrolled ? Offset.zero : const Offset(0, 0.3),
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      currentShop.shopName.isNotEmpty
                          ? currentShop.shopName
                          : 'Shop Details',
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: _DesignColors.slate900,
                      ),
                    ),
                  ),
                ),
                centerTitle: true,
                actions: [
                  _NavButton(
                    icon: Icons.edit_rounded,
                    onTap: () async {
                      final data = await context.push(
                        AppRoutes.addShop,
                        extra: currentShop,
                      );

                      // if (!mounted) return;

                      if (data is ShopModel) {
                        setState(() {
                          currentShop = data;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  _NavButton(
                    icon: Icons.local_activity_rounded,
                    iconColor: _DesignColors.brandStart,
                    onTap: () {
                      context.push(
                        AppRoutes.shopActivityLog,
                        extra: currentShop.id,
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),

              // Content
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Shop Identity Card
                          _buildShopIdentityCard(),
                          const SizedBox(height: 24),

                          // Quick Actions
                          _buildQuickActionsSection(),
                          const SizedBox(height: 24),

                          // Streak Configuration
                          _buildStreakConfigSection(),
                          const SizedBox(height: 24),

                          // Metadata Section
                          _buildMetadataSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShopIdentityCard() {
    return Container(
      margin: const EdgeInsets.only(top: 48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.none,
      child: Column(
        children: [
          // Gradient accent line at top
          Container(
            height: .1,
            decoration: const BoxDecoration(
              gradient: _DesignColors.brandGradient,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Shop Icon
                Transform.translate(
                  offset: const Offset(0, -48),
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: _DesignColors.slate50,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      size: 40,
                      color: _DesignColors.brandStart,
                    ),
                  ),
                ),

                Transform.translate(
                  offset: const Offset(0, -32),
                  child: Column(
                    children: [
                      // Shop Name
                      Text(
                        currentShop.shopName.isNotEmpty
                            ? currentShop.shopName
                            : 'Shop Name',
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: _DesignColors.slate900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),

                      // Description
                      Text(
                        currentShop.shopDescription?.isNotEmpty == true
                            ? currentShop.shopDescription!
                            : 'No description available',
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: _DesignColors.slate500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),

                      // Info Chips
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _InfoChip(
                            icon: Icons.location_on_rounded,
                            text: currentShop.shopAddress.isNotEmpty
                                ? currentShop.shopAddress
                                : 'No address',
                          ),
                          _InfoChip(
                            icon: Icons.phone_rounded,
                            text: currentShop.shopPhone.isNotEmpty
                                ? currentShop.shopPhone
                                : 'No phone',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.flash_on_rounded,
                color: Colors.amber.shade700,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: _DesignColors.slate900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Actions Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            _QuickActionButton(
              icon: Icons.check_circle_rounded,
              label: 'Check-in User',
              iconBgColor: Colors.orange.shade50,
              iconColor: Colors.orange.shade500,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) =>
                        VendorScanLoyalityPage(shop: currentShop),
                  ),
                );
              },
            ),
            // _QuickActionButton(
            //   icon: Icons.person_add_rounded,
            //   label: 'Add Follower',
            //   iconBgColor: Colors.blue.shade50,
            //   iconColor: Colors.blue.shade500,
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute<void>(
            //         builder: (context) => VendorAddUserToShopPage(
            //           shopId: widget.shop.id!,
            //         ),
            //       ),
            //     );
            //   },
            // ),
            _QuickActionButton(
              icon: Icons.groups_rounded,
              label: 'Manage Staff',
              iconBgColor: Colors.purple.shade50,
              iconColor: Colors.purple.shade500,
              onTap: () {
                context.push(AppRoutes.shopStaffs, extra: currentShop.id);
              },
            ),
            // _QuickActionButton(
            //   icon: Icons.local_offer_rounded,
            //   label: 'Offers',
            //   iconBgColor: Colors.green.shade50,
            //   iconColor: Colors.green.shade500,
            //   onTap: () {
            //     context.push(
            //       AppRoutes.shopOffersList,
            //       extra: widget.shop.id,
            //     );
            //   },
            // ),
            _QuickActionButton(
              icon: Icons.people_rounded,
              label: 'Shop Followers',
              iconBgColor: Colors.teal.shade50,
              iconColor: Colors.teal.shade500,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) =>
                        ShopFollowersPage(shopId: currentShop.id!),
                  ),
                );
              },
            ),
            _QuickActionButton(
              icon: Icons.send_rounded,
              label: 'Staff Requests',
              iconBgColor: Colors.indigo.shade50,
              iconColor: Colors.indigo.shade500,
              onTap: () {
                context.push(
                  AppRoutes.sendBecomeStaffRequest,
                  extra: (currentShop.id, currentShop.shopName),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStreakConfigSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _DesignColors.slate100),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.orange.shade600,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Streak Configuration',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: _DesignColors.slate900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Config Items
          _ConfigRow(
            icon: Icons.sync_rounded,
            label: 'Cycle Day',
            value: '${currentShop.giftCycleDay} days',
          ),
          const SizedBox(height: 16),
          _ConfigRow(
            icon: Icons.trending_up_rounded,
            label: 'Bonus Value',
            value: '${currentShop.bonusIncrementValue} points',
          ),
          const SizedBox(height: 16),
          _ConfigRow(
            icon: Icons.calendar_today_rounded,
            label: 'Required Days',
            value: '${currentShop.bonusIncrementDaysRequired} days',
          ),

          // Divider
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 1,
            color: _DesignColors.slate100,
          ),

          // Followers count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.people_rounded,
                    size: 18,
                    color: _DesignColors.slate500,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Total Followers',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: _DesignColors.slate500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${currentShop.totalFollowers}',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: _DesignColors.brandStart,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _DesignColors.slate100),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.info_rounded,
                  color: Colors.blue.shade600,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Metadata',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: _DesignColors.slate900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Shop ID
          _MetadataField(
            label: 'Shop ID',
            value: currentShop.id ?? 'Not assigned',
          ),
          const SizedBox(height: 16),

          // Owner ID
          _MetadataField(label: 'Owner ID', value: currentShop.shopOwnerId),
          const SizedBox(height: 16),

          // Timestamps
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CREATED',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        letterSpacing: 0.5,
                        color: _DesignColors.slate400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(currentShop.createdAt),
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: _DesignColors.slate700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'UPDATED',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        letterSpacing: 0.5,
                        color: _DesignColors.slate400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(currentShop.updatedAt),
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: _DesignColors.slate700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not available';
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// Navigation Button Component
class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap, this.iconColor});

  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.8),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 20,
            color: iconColor ?? _DesignColors.slate700,
          ),
        ),
      ),
    );
  }
}

// Info Chip Component
class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _DesignColors.slate50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _DesignColors.slate100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: _DesignColors.slate600),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: _DesignColors.slate600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Quick Action Button Component
class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _DesignColors.slate100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: _DesignColors.slate700,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Config Row Component
class _ConfigRow extends StatelessWidget {
  const _ConfigRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: _DesignColors.slate500),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: _DesignColors.slate500,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: _DesignColors.slate800,
          ),
        ),
      ],
    );
  }
}

// Metadata Field Component
class _MetadataField extends StatelessWidget {
  const _MetadataField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontWeight: FontWeight.w700,
            fontSize: 11,
            letterSpacing: 0.5,
            color: _DesignColors.slate400,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _DesignColors.slate50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _DesignColors.slate100),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: _DesignColors.slate600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
