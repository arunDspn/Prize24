import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/campaign_card.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/empty_state_widget.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/enhanced_fab.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/vendors_campaign_list_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_shop_list/view_model/vendor_shop_list_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

class VendorsCampaignsList extends ConsumerStatefulWidget {
  const VendorsCampaignsList(this.vendorId, {super.key});

  final String vendorId;

  @override
  ConsumerState<VendorsCampaignsList> createState() =>
      _VendorsCampaignsListState();
}

class _VendorsCampaignsListState extends ConsumerState<VendorsCampaignsList> {
  String _searchQuery = '';
  List<CampaignModel> _filteredCampaigns = [];

  // State for segmented button
  String _selectedCampaignType = 'All';

  void _filterCampaigns(List<CampaignModel> campaigns) {
    var filteredByType = campaigns;

    // Filter by campaign type based on segmented button
    if (_selectedCampaignType == 'Owned') {
      filteredByType = campaigns
          .where((campaign) => campaign.vendorId == widget.vendorId)
          .toList();
    } else if (_selectedCampaignType == 'Shared') {
      filteredByType = campaigns
          .where(
            (campaign) => campaign.sharedVendors
                .map((e) => e.vendorId)
                .contains(widget.vendorId),
          )
          .toList();
    }
    // If 'All' is selected, keep all campaigns

    // Then filter by search query
    if (_searchQuery.isEmpty) {
      _filteredCampaigns = filteredByType;
    } else {
      _filteredCampaigns = filteredByType.where((campaign) {
        return campaign.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            campaign.vendorName.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            campaign.description.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final vendorCampaignListState = ref.watch(
      vendorsCampaignListControllerProvider,
    );
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // appBar: const CampaignListAppBar(),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 75),
        child: AddCampaignFAB(),
      ),
      body: vendorCampaignListState.when(
        data: (campaigns) {
          _filterCampaigns(campaigns);

          return RefreshIndicator(
            onRefresh: () async {
              final _ = ref.refresh(vendorsCampaignListControllerProvider);
            },
            backgroundColor: theme.colorScheme.surface,
            color: theme.colorScheme.primary,
            child: CustomScrollView(
              slivers: [
                // // Search Bar
                // if (campaigns.isNotEmpty)
                //   SliverToBoxAdapter(
                //     child: CampaignSearchBar(
                //       onSearchChanged: (query) {
                //         setState(() {
                //           _searchQuery = query;
                //         });
                //       },
                //       onFilterTap: () {
                //         _showFilterBottomSheet(context);
                //       },
                //     ),
                //   ),

                // Segmented button for campaign type filtering
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9), // slate100
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0), // slate200
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: ['All', 'Shared', 'Owned'].map((type) {
                          final isSelected = _selectedCampaignType == type;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCampaignType = type;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFFFF5F6D), // brandStart
                                            Color(0xFFFFC371), // brandEnd
                                          ],
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: const Color(
                                              0xFFFF5F6D,
                                            ).withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF64748B), // slate500
                                      fontSize: 14,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                // Header with count
                if (_filteredCampaigns.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${_filteredCampaigns.length} Campaign${_filteredCampaigns.length != 1 ? 's' : ''}',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                              fontSize: 14,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (_searchQuery.isNotEmpty) ...[
                            Text(
                              ' for "$_searchQuery"',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 14,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                // Campaigns List or Empty State
                if (_filteredCampaigns.isEmpty)
                  SliverFillRemaining(
                    child: _searchQuery.isNotEmpty
                        ? _buildNoSearchResults()
                        : GestureDetector(
                            onTap: () {
                              context.push(AppRoutes.addVendorCampaign);
                            },
                            child: const EmptyStateWidget(),
                          ),
                  )
                else
                  SliverList.builder(
                    itemCount: _filteredCampaigns.length,
                    itemBuilder: (context, index) {
                      final campaign = _filteredCampaigns[index];
                      return CampaignCard(campaign: campaign);
                    },
                  ),

                // Bottom spacing for FAB
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return _buildErrorState(ref);
        },
        loading: _buildLoadingState,
      ),
    );
  }

  Widget _buildNoSearchResults() {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No campaigns found',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search terms',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 14,
                fontFamily: 'Gilroy',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(WidgetRef ref) {
    final theme = Theme.of(context);

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
                color: theme.colorScheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: theme.colorScheme.error.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.error_outline,
                size: 40,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Something went wrong',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please try again or contact support',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 14,
                fontFamily: 'Gilroy',
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    final _ = ref.refresh(vendorShopListControllerProvider);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.refresh,
                          color: theme.colorScheme.onPrimary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Retry',
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gilroy',
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
      ),
    );
  }

  Widget _buildLoadingState() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading campaigns...',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontFamily: 'Gilroy',
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Campaigns',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Filters coming soon...',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 16,
                fontFamily: 'Gilroy',
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
