import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/common_widgets/common_widgets.dart';
import 'package:prize24_app/configs/theme_config.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';

class VendorShopDetailsPage1 extends StatefulWidget {
  const VendorShopDetailsPage1({
    required this.shop,
    super.key,
  });

  final ShopModel shop;

  @override
  State<VendorShopDetailsPage1> createState() => _VendorShopDetailsPage1State();
}

class _VendorShopDetailsPage1State extends State<VendorShopDetailsPage1>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title
                  const Text(
                    'Shops',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF111111),
                      height: 1.45,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                  child: Column(
                    children: [
                      // Shop Info Section
                      Row(
                        children: [
                          // Shop Icon
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF7931A),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.store,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Shop Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Shop Name
                                Text(
                                  widget.shop.shopName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF0A0B0D),
                                    height: 1.45,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // Followers and Offers
                                Row(
                                  children: [
                                    const Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF0D4A80),
                                        height: 1.4,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'Followers',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF707070),
                                        height: 1.4,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Dot separator
                                    Container(
                                      width: 6.44,
                                      height: 6.44,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF707070),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    const Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF0D4A80),
                                        height: 1.4,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'Offers',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF707070),
                                        height: 1.4,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // QR Code Button
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.qr_code_scanner,
                              size: 32,
                              color: Color(0xFF111111),
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Tabs
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                          // Todo: Make it in theme ccontextonfig
                          controller: _tabController,
                          labelColor: ThemeConfig.primaryColor,
                          unselectedLabelColor: Colors.black,
                          indicatorColor: ThemeConfig.primaryColor,
                          enableFeedback: true,
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          dividerHeight: 0,
                          indicator: UnderlineTabIndicator(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: ThemeConfig.primaryColor,
                              width: 4,
                            ),
                            // insets: EdgeInsets.symmetric(horizontal: 40),
                          ),
                          tabs: const [
                            Tab(text: 'Offers'),
                            Tab(text: 'Staffs'),
                            Tab(text: 'Manage'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tab Content - Empty State
                      _buildEmptyOffersState(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyOffersState() {
    return Column(
      children: [
        // Illustration
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Image.network(
            'https://www.figma.com/api/mcp/asset/ae1d3a37-0cab-4d3a-82a1-9c545881ac83',
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              // Fallback if image fails to load
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.local_offer_outlined,
                  size: 80,
                  color: Color(0xFF707070),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        // Empty State Title
        const Text(
          'Your shop has no\noffers right now.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Color(0xFF111111),
            height: 1.45,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 8),

        // Empty State Description
        const Text(
          'Create an offer to boost\nvisibility and sales.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF707070),
            height: 1.4,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 24),

        // Action Buttons
        Column(
          children: [
            // Create New Offer Button (Secondary)
            AppSecondaryButton(
              text: 'Create New Offer',
              onPressed: () {},
              size: ButtonSize.large,
              width: double.infinity,
              borderColor: const Color(0xFFCFCFCF),
              textColor: const Color(0xFF111111),
              backgroundColor: Colors.white,
              borderWidth: 1,
            ),
            const SizedBox(height: 12),

            // Check-in Users Button (Primary)
            AppPrimaryButton(
              text: 'Check-in Users',
              onPressed: () {},
              size: ButtonSize.large,
              width: double.infinity,
              icon: Icons.qr_code_scanner,
              iconPosition: ButtonIconPosition.left,
              backgroundColor: ThemeConfig.primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
