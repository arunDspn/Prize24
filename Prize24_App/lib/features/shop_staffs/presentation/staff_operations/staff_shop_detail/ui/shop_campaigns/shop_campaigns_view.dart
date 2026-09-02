import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_campaigns/staff_campaign_model.dart';
import 'package:prize24_app/features/shop_staffs/presentation/staff_operations/staff_shop_detail/ui/staff_shop_detail_page.dart';
import 'package:prize24_app/features/shop_staffs/presentation/staff_operations/staff_shop_detail/ui/shop_campaigns/view_model/staff_shop_list_campaign_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Design system colors matching the HTML mockup
class _CampaignColors {
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
  static const Color green50 = Color(0xFFECFDF5);
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green600 = Color(0xFF16A34A);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [brandStart, brandEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class ShopCampaignsView extends ConsumerStatefulWidget {
  const ShopCampaignsView(this.shopId, {super.key});

  final String shopId;

  @override
  ConsumerState<ShopCampaignsView> createState() => _ShopCampaignsViewState();
}

class _ShopCampaignsViewState extends ConsumerState<ShopCampaignsView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(
            staffShopListCampaignControllerProvider(
              shopId: widget.shopId,
            ).notifier,
          )
          .loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffShopList = ref.watch(
      staffShopListCampaignControllerProvider(shopId: widget.shopId),
    );

    return RefreshIndicator(
      color: _CampaignColors.brandStart,
      onRefresh: () => ref
          .read(
            staffShopListCampaignControllerProvider(
              shopId: widget.shopId,
            ).notifier,
          )
          .refresh(),
      child: staffShopList.when(
        data: (paginatedState) {
          if (paginatedState.items.isEmpty && !paginatedState.isLoadingMore) {
            return buildEmptyState(
              icon: Icons.campaign_outlined,
              title: 'No Campaigns',
              subtitle: 'There are no active campaigns for this shop.',
              context: context,
            );
          }
          return _buildCampaignsList(
            paginatedState.page,
            paginatedState.isLoadingMore,
          );
        },
        loading: buildLoadingState,
        error: (error, stack) => buildErrorState('campaigns', context),
      ),
    );
  }

  Widget _buildCampaignsList(
    List<StaffCampaignModel> campaigns,
    bool isLoadingMore,
  ) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: campaigns.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == campaigns.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _CampaignColors.brandStart,
                ),
              ),
            ),
          );
        }
        final campaign = campaigns[index];
        return _CampaignCard(
          campaign: campaign,
          shopId: widget.shopId,
          animationDelay: Duration(milliseconds: 50 * index),
        );
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.icon, required this.label, this.value});

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: _CampaignColors.slate400),
        const SizedBox(width: 4),
        if (value != null) ...[
          Text(
            value!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _CampaignColors.slate900,
            ),
          ),
          const SizedBox(width: 4),
        ],
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _CampaignColors.slate400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: _CampaignColors.slate400.withOpacity(0.3),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

class _CampaignCard extends StatefulWidget {
  const _CampaignCard({
    required this.campaign,
    required this.shopId,
    required this.animationDelay,
  });

  final StaffCampaignModel campaign;
  final String shopId;
  final Duration animationDelay;

  @override
  State<_CampaignCard> createState() => _CampaignCardState();
}

class _CampaignCardState extends State<_CampaignCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(opacity: _fadeAnimation.value, child: child),
        );
      },
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () {
          context.push(
            AppRoutes.staffCampaignDetails,
            extra: {'campaign': widget.campaign, 'shopId': widget.shopId},
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()..scale(_isPressed ? 0.99 : 1.0),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isPressed
                  ? _CampaignColors.brandStart.withOpacity(0.2)
                  : _CampaignColors.slate100,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isPressed
                    ? _CampaignColors.brandStart.withOpacity(0.12)
                    : Colors.black.withOpacity(0.05),
                blurRadius: _isPressed ? 24 : 20,
                offset: const Offset(0, 4),
                spreadRadius: _isPressed ? 2 : -2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Gradient left border
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 4,
                    decoration: const BoxDecoration(
                      gradient: _CampaignColors.brandGradient,
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Campaign name
                          Expanded(
                            child: Text(
                              widget.campaign.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: _CampaignColors.slate900,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _CampaignColors.green50,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: _CampaignColors.green100,
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'ACTIVE',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _CampaignColors.green600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Description
                      Text(
                        widget.campaign.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: _CampaignColors.slate500,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      // Stats row
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          // Participants
                          _StatItem(
                            icon: Icons.gif_box_outlined,
                            value: '${widget.campaign.totalGiftsAdded}',
                            label: 'Total Gifts Added',
                          ),
                          // _StatDivider(),
                          // // Gifts
                          // _StatItem(
                          //   icon: Icons.card_giftcard_rounded,
                          //   value: '${widget.campaign.totalGifts}',
                          //   label: 'Gifts',
                          // ),
                          _StatDivider(),
                          // Gift type
                          _StatItem(
                            icon: Icons.redeem_rounded,
                            label: widget.campaign.giftType,
                          ),
                        ],
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
}
