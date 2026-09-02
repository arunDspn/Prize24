import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/global_controller/subscription/subscription_controller.dart';
import 'package:prize24_app/features/shop/presentation/vendor_shop_detail/ui/vendor_shop_detail_page1.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_shop_list/view_model/vendor_shop_list_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Design System Colors from HTML
class _VendorShopColors {
  // Slate palette
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Brand gradient colors
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);

  // Orange accent
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange400 = Color(0xFFFB923C);

  // Red for errors
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red500 = Color(0xFFEF4444);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

class VendorsShopList extends ConsumerWidget {
  const VendorsShopList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendorShopListState = ref.watch(vendorShopListControllerProvider);
    final user = ref.watch(authControllerProvider).requireValue;

    final subscriptionState =
        ref.watch(subscriptionControllerProvider).requireValue;

    return Scaffold(
      backgroundColor: _VendorShopColors.slate50,
      floatingActionButton: vendorShopListState.maybeWhen(
        data: (shops) {
          final maxShopsAllowed = subscriptionState?.maxShops ?? 0;
          if (shops.length < maxShopsAllowed) {
            // if (true) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 75),
              child: _AnimatedSlideUp(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: _VendorShopColors.brandGradient,
                    boxShadow: [
                      BoxShadow(
                        color: _VendorShopColors.brandStart.withOpacity(0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                        spreadRadius: -10,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () {
                        context.push(AppRoutes.addShop);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: const Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Add Shop',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.white,
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
          return null;
        },
        orElse: () => null,
      ),
      body: vendorShopListState.when(
        data: (shops) {
          if (shops.isEmpty) {
            return _AnimatedSlideUp(
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
                        decoration: BoxDecoration(
                          color: _VendorShopColors.orange50,
                          borderRadius: BorderRadius.circular(48),
                          border: Border.all(
                            color: _VendorShopColors.orange100,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.storefront_outlined,
                          size: 48,
                          color: _VendorShopColors.orange400,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'No Shops Yet',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'PlusJakartaSans',
                          color: _VendorShopColors.slate900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "You haven't added any shops yet.\nTap the + button below to create your first shop.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: _VendorShopColors.slate500,
                            fontFamily: 'PlusJakartaSans',
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              // Header with count
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                  child: Text(
                    '${shops.length} SHOP${shops.length != 1 ? 'S' : ''}',
                    style: const TextStyle(
                      color: _VendorShopColors.slate500,
                      fontSize: 12,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              // Shops List
              SliverList.builder(
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  final shop = shops[index];
                  return _AnimatedSlideUp(
                    delay: Duration(milliseconds: 50 * index),
                    child: _ShopCard(
                      shopName: shop.shopName,
                      shopDescription: shop.shopDescription,
                      shopAddress: shop.shopAddress,
                      shopPhone: shop.shopPhone,
                      onTap: () {
                        context.push(
                          AppRoutes.shopDetails,
                          extra: shop,
                        );

                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return VendorShopDetailsPage1(shop: shop);
                        //   },
                        // ));
                      },
                    ),
                  );
                },
              ),

              // Bottom spacing for FAB
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Error icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _VendorShopColors.red50,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Icon(
                      Icons.error_rounded,
                      size: 32,
                      color: _VendorShopColors.red500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to load shops',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans',
                      color: _VendorShopColors.slate800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Something went wrong.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: _VendorShopColors.slate500,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Retry button
                  Container(
                    decoration: BoxDecoration(
                      color: _VendorShopColors.slate900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          final _ =
                              ref.refresh(vendorShopListControllerProvider);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          child: Text(
                            'Retry',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Loading header
                const Padding(
                  padding: EdgeInsets.only(bottom: 16, top: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'LOADING...',
                      style: TextStyle(
                        color: _VendorShopColors.slate500,
                        fontSize: 12,
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                // Skeleton items
                _ShopCardSkeleton(),
                const SizedBox(height: 16),
                _ShopCardSkeleton(),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Shop Card Widget matching HTML template design
class _ShopCard extends StatefulWidget {
  final String shopName;
  final String? shopDescription;
  final String shopAddress;
  final String shopPhone;
  final VoidCallback onTap;

  const _ShopCard({
    required this.shopName,
    this.shopDescription,
    required this.shopAddress,
    required this.shopPhone,
    required this.onTap,
  });

  @override
  State<_ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<_ShopCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.99 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _VendorShopColors.slate100,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                  spreadRadius: -2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Left gradient accent bar (visible on hover in web, always subtle on mobile)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 4,
                      decoration: BoxDecoration(
                        gradient: _VendorShopColors.brandGradient,
                      ),
                    ),
                  ),
                  // Card content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon box
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: _VendorShopColors.orange50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _VendorShopColors.orange100,
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.storefront_rounded,
                            size: 26,
                            color: _VendorShopColors.brandEnd,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title row with arrow
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.shopName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'PlusJakartaSans',
                                        color: _VendorShopColors.slate900,
                                        height: 1.3,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    size: 22,
                                    color: _VendorShopColors.slate300,
                                  ),
                                ],
                              ),
                              // Description
                              if (widget.shopDescription != null &&
                                  widget.shopDescription!.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  widget.shopDescription!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: _VendorShopColors.slate500,
                                    fontFamily: 'PlusJakartaSans',
                                    height: 1.4,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              const SizedBox(height: 12),
                              // Metadata badges
                              Wrap(
                                spacing: 12,
                                runSpacing: 8,
                                children: [
                                  // Location badge
                                  _MetadataBadge(
                                    icon: Icons.location_on_rounded,
                                    text: widget.shopAddress,
                                    maxWidth: 120,
                                  ),
                                  // Phone badge
                                  _MetadataBadge(
                                    icon: Icons.phone_rounded,
                                    text: widget.shopPhone,
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
            ),
          ),
        ),
      ),
    );
  }
}

/// Metadata badge widget for address/phone
class _MetadataBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? maxWidth;

  const _MetadataBadge({
    required this.icon,
    required this.text,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _VendorShopColors.slate50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _VendorShopColors.slate100,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: _VendorShopColors.slate400,
          ),
          const SizedBox(width: 6),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _VendorShopColors.slate500,
                fontFamily: 'PlusJakartaSans',
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

/// Skeleton loading card
class _ShopCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _VendorShopColors.slate100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon skeleton
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _VendorShopColors.slate100,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 16),
          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Container(
                  height: 16,
                  width: 120,
                  decoration: BoxDecoration(
                    color: _VendorShopColors.slate100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 200,
                  decoration: BoxDecoration(
                    color: _VendorShopColors.slate100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 150,
                  decoration: BoxDecoration(
                    color: _VendorShopColors.slate100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated slide-up widget
class _AnimatedSlideUp extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _AnimatedSlideUp({
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<_AnimatedSlideUp> createState() => _AnimatedSlideUpState();
}

class _AnimatedSlideUpState extends State<_AnimatedSlideUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: widget.child,
      ),
    );
  }
}
