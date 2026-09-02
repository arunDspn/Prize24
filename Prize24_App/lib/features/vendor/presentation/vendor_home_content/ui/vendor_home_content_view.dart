import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/global_controller/subscription/subscription_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/vendors_campaign_list_view.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_shop_list/vendors_shop_list_view.dart';
import 'package:prize24_app/routing/app_routes.dart';

/// Real Home Page for Vendors
/// This page is the entry point for vendors to manage their shops, coupons,
/// and audience.
class VendorHomeContentView extends ConsumerWidget {
  const VendorHomeContentView({
    required this.vendorId,
    super.key,
  });

  /// The user ID of the vendor.
  /// If this is null, the set vendor should be used.
  /// If this is not null, the vendor details will be
  /// fetched based on this vendor ID.
  final String? vendorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userID = ref.watch(authControllerProvider).requireValue!.userId;
    // if (vendorId != null) {
    //   // If vendorId is provided, fetch vendor details by vendorId
    //   // ref
    //   //     .read(usersVendorDetailsControllerProvider.notifier)
    //   //     .getDetailsByVendorId(vendorId: vendorId!);

    //   Future.delayed(
    //     const Duration(milliseconds: 500),
    //     () {
    //       // This is to ensure that the vendor details are fetched
    //       // before the UI is built.
    //       // ref
    //       //     .read(usersVendorDetailsControllerProvider.notifier)
    //       //     .getDetailsByVendorId(
    //       //       vendorId: vendorId!,
    //       //     );
    //     },
    //   );
    // } else {
    //   // If vendorId is not provided, fetch vendor details by userId
    //   // Then it will use the set vendor in the controller
    // }

    final subscriptionState = ref.watch(subscriptionControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: subscriptionState.when(
        data: (data) {
          if (data == null) {
            return const SubscriptionExpiresReSubscribeView();
          } else {
            return Column(
              children: [
                // Tab View contains Tab for Shops and Campaigns
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            // Premium Pill-Shaped Tab Selector
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              child: _PremiumTabSelector(
                                tabController: DefaultTabController.of(context),
                                onTabChanged: (index) {
                                  DefaultTabController.of(context)
                                      .animateTo(index);
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  const VendorsShopList(),
                                  VendorsCampaignsList(userID),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('Error, Please try again'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class SubscriptionExpiresReSubscribeView extends StatelessWidget {
  const SubscriptionExpiresReSubscribeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8FAFC),
            theme.colorScheme.primary.withOpacity(0.05),
            const Color(0xFFFFF7ED),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Expired Icon with Warning Badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary,
                          const Color(0xFFFFB143),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFF8FAFC),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEF4444).withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.schedule_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Expired Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFEF4444).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 18,
                      color: Color(0xFFEF4444),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'SUBSCRIPTION EXPIRED',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: const Color(0xFFEF4444),
                        fontWeight: FontWeight.bold,
                        //  fontFamily: 'Gilroy',
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                'Renew Your Subscription',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                  //// //  fontFamily: 'Gilroy',
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                'Your vendor subscription has expired.\nRenew now to continue managing your business.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ////  fontFamily: 'Gilroy',
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Locked Features Info Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Currently Locked Features',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                              //  fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _LockedFeatureItem(
                      icon: Icons.storefront_rounded,
                      title: 'Shop Management',
                      theme: theme,
                    ),
                    const SizedBox(height: 12),
                    _LockedFeatureItem(
                      icon: Icons.campaign_rounded,
                      title: 'Marketing Campaigns',
                      theme: theme,
                    ),
                    const SizedBox(height: 12),
                    _LockedFeatureItem(
                      icon: Icons.analytics_rounded,
                      title: 'Performance Analytics',
                      theme: theme,
                    ),
                    const SizedBox(height: 12),
                    _LockedFeatureItem(
                      icon: Icons.people_outline_rounded,
                      title: 'Customer Insights',
                      theme: theme,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Urgent Renewal CTA Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary,
                      const Color(0xFFFFB143),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      context.push(AppRoutes.manageSubscriptions);
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Renew Subscription Now',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              //  fontFamily: 'Gilroy',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Secondary Action
              TextButton.icon(
                onPressed: () {
                  context.push(AppRoutes.manageSubscriptions);
                },
                icon: Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                label: Text(
                  'View all subscription plans',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    //  fontFamily: 'Gilroy',
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
}

/// Locked feature item widget
class _LockedFeatureItem extends StatelessWidget {
  const _LockedFeatureItem({
    required this.icon,
    required this.title,
    required this.theme,
  });

  final IconData icon;
  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: theme.colorScheme.onSurface.withOpacity(0.4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              //  fontFamily: 'Gilroy',
            ),
          ),
        ),
        Icon(
          Icons.lock_rounded,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.3),
        ),
      ],
    );
  }
}

class _ShopInfoSection extends ConsumerStatefulWidget {
  const _ShopInfoSection();

  @override
  ConsumerState<_ShopInfoSection> createState() => _ShopInfoSectionState();
}

class _ShopInfoSectionState extends ConsumerState<_ShopInfoSection> {
  @override
  Widget build(BuildContext context) {
    // final vendorState = ref.watch(usersVendorDetailsControllerProvider);
    // final user = ref.watch(authControllerProvider).requireValue!;

    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * .2,
      child: const Placeholder(),
      // child: vendorState.when(
      //   data: (data) {
      //     if (data == null) {
      //       return const Center(child: Text('No shop found'));
      //     }
      //     return Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Center(
      //           child: Stack(
      //             alignment: Alignment.bottomRight,
      //             children: [
      //               CircleAvatar(
      //                 radius: 55,
      //                 backgroundColor: Colors.white,
      //                 child: CircleAvatar(
      //                   radius: 50,
      //                   backgroundColor: Colors.deepOrangeAccent,
      //                   child: Text(
      //                     user.userName[0].toUpperCase(),
      //                     style: const TextStyle(
      //                       color: Colors.black,
      //                       fontSize: 50,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               IconButton(
      //                 icon: const CircleAvatar(
      //                   radius: 15,
      //                   backgroundColor: Colors.black,
      //                   child: Icon(
      //                     Icons.border_color,
      //                     color: Colors.white,
      //                     size: 18,
      //                   ),
      //                 ),
      //                 onPressed: () {
      //                   context.push(
      //                     AppRoutes.editVendorProfile,
      //                     extra: data,
      //                   );
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //         Text(
      //           user.userName,
      //           style: const TextStyle(
      //             color: Colors.white,
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         Text(
      //           data.vendorPhone,
      //           style: const TextStyle(
      //             color: Colors.grey,
      //            //  fontFamily: 'Gilroy',
      //             fontSize: 16,
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      //   error: (error, stackTrace) {
      //     return Text(error.toString());
      //   },
      //   loading: () {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }
}

/// Premium glassmorphic pill-shaped tab selector with sliding gradient indicator.
/// Matches the HTML design with elastic animation, red-to-orange gradient, and glass effect.
class _PremiumTabSelector extends StatefulWidget {
  const _PremiumTabSelector({
    required this.tabController,
    required this.onTabChanged,
  });

  final TabController tabController;
  final void Function(int index) onTabChanged;

  @override
  State<_PremiumTabSelector> createState() => _PremiumTabSelectorState();
}

class _PremiumTabSelectorState extends State<_PremiumTabSelector> {
  late int _selectedIndex;

  // Brand colors from HTML
  static const Color brandStart = Color(0xFFEF4444); // Red
  static const Color brandEnd = Color(0xFFF97316); // Orange
  // static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.tabController.index;
    widget.tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (mounted && widget.tabController.index != _selectedIndex) {
      setState(() {
        _selectedIndex = widget.tabController.index;
      });
    }
  }

  void _onTabTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTabChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2687).withOpacity(0.07),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = (constraints.maxWidth - 12) / 2;
          return Stack(
            children: [
              // Sliding Gradient Indicator
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                left: _selectedIndex == 0 ? 0 : tabWidth + 12,
                top: 0,
                bottom: 0,
                width: tabWidth,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [brandStart, brandEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: brandEnd.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                        spreadRadius: -5,
                      ),
                    ],
                  ),
                ),
              ),
              // Tab Buttons Row
              Row(
                children: [
                  // Shops Tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onTabTap(0),
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.storefront_rounded,
                              size: 20,
                              color:
                                  _selectedIndex == 0 ? Colors.white : textSub,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Shops',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _selectedIndex == 0
                                    ? Colors.white
                                    : textSub,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Campaigns Tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onTabTap(1),
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.campaign_rounded,
                              size: 20,
                              color:
                                  _selectedIndex == 1 ? Colors.white : textSub,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Campaigns',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _selectedIndex == 1
                                    ? Colors.white
                                    : textSub,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
