import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_friends_and_requests/tabs/friends_tab/friends_tab_view.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_friends_and_requests/tabs/requests_tab/requests_tab_view.dart';

import 'package:prize24_app/routing/app_routes.dart';

/// Page for vendors to view their friends and manage friend requests
/// Contains two tabs: Friends and Requests
class VendorFriendsAndRequestsPage extends ConsumerStatefulWidget {
  const VendorFriendsAndRequestsPage({super.key});

  @override
  ConsumerState<VendorFriendsAndRequestsPage> createState() =>
      _VendorFriendsAndRequestsPageState();
}

class _VendorFriendsAndRequestsPageState
    extends ConsumerState<VendorFriendsAndRequestsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Design system colors from HTML
  static const Color _pageBg = Color(0xFFF8FAFC); // slate-50
  static const Color _cardBg = Color(0xFFFFFFFF);
  static const Color _inputBg = Color(0xFFF1F5F9); // slate-100
  static const Color _textMain = Color(0xFF1E293B); // slate-800
  static const Color _textSub = Color(0xFF64748B); // slate-500
  static const Color _brandStart = Color(0xFFEF4444); // red-500
  static const Color _brandEnd = Color(0xFFF97316); // orange-500

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: BoxDecoration(
            color: _cardBg.withOpacity(0.95),
            border: const Border(bottom: BorderSide(color: _inputBg, width: 1)),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top row with back button, title and action button
                SizedBox(
                  height: 56,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        // Back button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => context.pop(),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: _textMain,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Title
                        const Expanded(
                          child: Text(
                            'Friends & Requests',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _textMain,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        // Add friend button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              context.push(AppRoutes.vendorSendFriendRequest);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [_brandStart, _brandEnd],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _brandStart.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Tab bar - fills remaining space so indicator is at bottom
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildTab(
                          icon: Icons.people_outline,
                          label: 'Friends',
                          isSelected: _tabController.index == 0,
                          onTap: () => _tabController.animateTo(0),
                        ),
                        _buildTab(
                          icon: Icons.person_add_alt_1_outlined,
                          label: 'Requests',
                          isSelected: _tabController.index == 1,
                          onTap: () => _tabController.animateTo(1),
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
      body: TabBarView(
        controller: _tabController,
        children: const [FriendsTabView(), RequestsTabView()],
      ),
    );
  }

  Widget _buildTab({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: isSelected ? _brandStart : _textSub,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected ? _brandStart : _textSub,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            // Indicator line at exact bottom
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              decoration: BoxDecoration(
                color: isSelected ? _brandStart : Colors.transparent,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
