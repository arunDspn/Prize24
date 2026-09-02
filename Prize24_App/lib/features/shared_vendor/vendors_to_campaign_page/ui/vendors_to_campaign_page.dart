import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/shared_vendor/vendors_to_campaign_page/ui_model/vendor_to_campaign_uimodel.dart';
import 'package:prize24_app/features/shared_vendor/vendors_to_campaign_page/view_model/list_all_vendors_controller.dart';
import 'package:prize24_app/features/shared_vendor/vendors_to_campaign_page/view_model/vendors_to_campaign_controller.dart';

// Design System Colors
class _Colors {
  static const Color pageBg = Color(0xFFF8FAFC);
  static const Color cardBg = Color(0xFFFFFFFF);
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
  static const Color green50 = Color(0xFFECFDF5);
  static const Color green100 = Color(0xFFD1FAE5);
  static const Color green600 = Color(0xFF059669);
  static const Color green700 = Color(0xFF047857);
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red500 = Color(0xFFEF4444);
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange200 = Color(0xFFFED7AA);
}

class VendorsToCampaignPage extends ConsumerStatefulWidget {
  const VendorsToCampaignPage(
    this.alreadyAddedVendorIds,
    this.campaignId, {
    super.key,
  });

  final List<String> alreadyAddedVendorIds;
  final String campaignId;

  @override
  ConsumerState<VendorsToCampaignPage> createState() =>
      _VendorsToCampaignPageState();
}

class _VendorsToCampaignPageState extends ConsumerState<VendorsToCampaignPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll - 200) {
      ref
          .read(
            listAllVendorsControllerProvider(
              alreadyAddedVendorIds: widget.alreadyAddedVendorIds,
              campaignId: widget.campaignId,
            ).notifier,
          )
          .loadMore();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _showGlobalLoader(BuildContext context, bool show) {
    if (show) {
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: _Colors.slate900.withOpacity(0.2),
        builder: (context) => Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(_Colors.brandStart),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _showSuccessToast(BuildContext context, String message) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Icon(Icons.check_circle, color: Colors.white, size: 18),
    //         const SizedBox(width: 12),
    //         Text(
    //           message,
    //           style: const TextStyle(
    //             fontWeight: FontWeight.w600,
    //             fontSize: 14,
    //           ),
    //         ),
    //       ],
    //     ),
    //     backgroundColor: _Colors.green600,
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //   ),
    // );

    showToastAtTop(context, message, true);
  }

  void _showErrorToast(BuildContext context, String message) {
    showToastAtTop(context, message, false);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Icon(Icons.warning_rounded, color: Colors.white, size: 18),
    //         const SizedBox(width: 12),
    //         Flexible(
    //           child: Text(
    //             message,
    //             style: const TextStyle(
    //               fontWeight: FontWeight.w600,
    //               fontSize: 14,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     backgroundColor: _Colors.red500,
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(vendorsToCampaignControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          Navigator.of(context).pop(); // Close loading dialog if open
          _showErrorToast(
            context,
            'Error adding vendor to campaign. Please try again.',
          );
        },
        loading: () {
          _showGlobalLoader(context, true);
        },
        data: (data) {
          if (data == null) return;
          Navigator.of(context).pop(); // Close loading dialog if open
          ref
              .read(
                listAllVendorsControllerProvider(
                  alreadyAddedVendorIds: widget.alreadyAddedVendorIds,
                  campaignId: widget.campaignId,
                ).notifier,
              )
              .updateVendorStatus(data);
          _showSuccessToast(context, 'Vendor added to campaign successfully');
        },
      );
    });

    final vendorsAsync = ref.watch(
      listAllVendorsControllerProvider(
        alreadyAddedVendorIds: widget.alreadyAddedVendorIds,
        campaignId: widget.campaignId,
      ),
    );

    return Scaffold(
      backgroundColor: _Colors.pageBg,
      body: Column(
        children: [
          // Sticky AppBar
          Container(
            decoration: BoxDecoration(
              color: _Colors.slate50.withOpacity(0.9),
              border: const Border(
                bottom: BorderSide(color: _Colors.slate200, width: 1),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: 64,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    // Back Button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: _Colors.slate500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Title
                    const Text(
                      'Add Vendors to Campaign',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: _Colors.slate900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Search Bar
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            decoration: BoxDecoration(color: _Colors.slate50.withOpacity(0.95)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _Colors.slate200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _Colors.slate900,
                ),
                decoration: InputDecoration(
                  hintText: 'Search by name or phone...',
                  hintStyle: const TextStyle(
                    color: _Colors.slate400,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: Icon(
                      Icons.search_rounded,
                      color: _Colors.slate400,
                      size: 20,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.cancel,
                              color: _Colors.slate400,
                              size: 18,
                            ),
                          ),
                        )
                      : null,
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: vendorsAsync.when(
              data: (paginatedState) {
                final filteredVendors = paginatedState.page(_searchQuery);

                if (filteredVendors.isEmpty && _searchQuery.isNotEmpty) {
                  return _buildEmptyState();
                }

                if (filteredVendors.isEmpty) {
                  return _buildNoVendorsState();
                }

                // hasMore only applies when not searching
                final showFooter =
                    _searchQuery.isEmpty && paginatedState.hasMore;

                return RefreshIndicator(
                  onRefresh: () async {
                    ref
                        .read(
                          listAllVendorsControllerProvider(
                            alreadyAddedVendorIds: widget.alreadyAddedVendorIds,
                            campaignId: widget.campaignId,
                          ).notifier,
                        )
                        .refresh();
                  },
                  color: _Colors.brandStart,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
                    itemCount: filteredVendors.length + (showFooter ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Load-more footer
                      if (index == filteredVendors.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: paginatedState.isLoadingMore
                                ? const CircularProgressIndicator()
                                : const SizedBox.shrink(),
                          ),
                        );
                      }
                      final vendor = filteredVendors[index];
                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 200 + (index * 50)),
                        tween: Tween(begin: 0.0, end: 1.0),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 10 * (1 - value)),
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: _VendorCard(
                          vendor: vendor,
                          onAddToCampaign: () {
                            ref
                                .read(
                                  vendorsToCampaignControllerProvider.notifier,
                                )
                                .addVendor(vendor.vendorId, widget.campaignId);
                          },
                          onRemoveFromCampaign: () {},
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => _buildLoadingState(),
              error: (error, stackTrace) => _buildErrorState(error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _Colors.slate100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar skeleton
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _Colors.slate100,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 120,
                        decoration: BoxDecoration(
                          color: _Colors.slate100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 80,
                        decoration: BoxDecoration(
                          color: _Colors.slate100,
                          borderRadius: BorderRadius.circular(4),
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
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _Colors.red50,
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                size: 32,
                color: _Colors.red500,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load vendors',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: _Colors.slate900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Something went wrong while fetching data.',
              style: TextStyle(fontSize: 14, color: _Colors.slate500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Material(
              color: _Colors.slate900,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  ref.invalidate(vendorsToCampaignControllerProvider);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(
              listAllVendorsControllerProvider(
                alreadyAddedVendorIds: widget.alreadyAddedVendorIds,
                campaignId: widget.campaignId,
              ).notifier,
            )
            .refresh();
      },
      color: _Colors.brandStart,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _Colors.slate100,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      Icons.search_off_rounded,
                      size: 40,
                      color: _Colors.slate400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No vendors found',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: _Colors.slate900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Try searching with different keywords.',
                    style: TextStyle(fontSize: 14, color: _Colors.slate500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoVendorsState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _Colors.slate100,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.storefront_outlined,
                size: 40,
                color: _Colors.slate400,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No vendors available',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: _Colors.slate900,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'There are no vendors to add at this time.',
              style: TextStyle(fontSize: 14, color: _Colors.slate500),
            ),
          ],
        ),
      ),
    );
  }
}

class _VendorCard extends StatelessWidget {
  final VendorToCampaignUimodel vendor;
  final VoidCallback onAddToCampaign;
  final VoidCallback onRemoveFromCampaign;

  const _VendorCard({
    required this.vendor,
    required this.onAddToCampaign,
    required this.onRemoveFromCampaign,
  });

  @override
  Widget build(BuildContext context) {
    final initial = vendor.vendorName.isNotEmpty
        ? vendor.vendorName[0].toUpperCase()
        : 'V';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _Colors.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: -2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Gradient accent bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_Colors.brandStart, _Colors.brandEnd],
                  ),
                ),
              ),
            ),
            // Decorative blur
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _Colors.orange50.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar with gradient background
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [_Colors.brandStart, _Colors.brandEnd],
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: _Colors.brandStart.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            initial,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vendor.vendorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: _Colors.slate900,
                                letterSpacing: -0.3,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 6),
                            if (vendor.vendorPhone.isNotEmpty)
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone_rounded,
                                    size: 14,
                                    color: _Colors.slate400,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    vendor.vendorPhone,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: _Colors.slate500,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 8),
                            // Status Badge
                            _buildStatusBadge(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Action Button
                  if (!vendor.isAlreadyAdded && !vendor.isRequestSent) ...[
                    const SizedBox(height: 16),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onAddToCampaign,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [_Colors.brandStart, _Colors.brandEnd],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: _Colors.brandStart.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add_circle_outline,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Add to Campaign',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    if (vendor.isAlreadyAdded) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _Colors.green50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _Colors.green100, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: _Colors.green600.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check_circle, size: 14, color: _Colors.green700),
            SizedBox(width: 6),
            Text(
              'ADDED',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _Colors.green700,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      );
    } else if (vendor.isRequestSent) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _Colors.orange50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _Colors.orange200, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: _Colors.brandStart.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.pending_outlined, size: 14, color: _Colors.brandStart),
            SizedBox(width: 6),
            Text(
              'REQUEST SENT',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _Colors.brandStart,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _Colors.slate50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _Colors.slate200, width: 1.5),
        ),
        child: const Text(
          'NOT ADDED',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: _Colors.slate500,
            letterSpacing: 0.8,
          ),
        ),
      );
    }
  }
}
