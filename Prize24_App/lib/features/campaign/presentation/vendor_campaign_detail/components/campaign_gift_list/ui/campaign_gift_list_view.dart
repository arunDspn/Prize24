import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/campaign_gift_list/view_model/campaign_gift_list_controller.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/single_gift_detail/ui/vendor_single_gift_detail_view.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Design System Colors from HTML
class _GiftListColors {
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
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange500 = Color(0xFFF97316);
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red500 = Color(0xFFEF4444);
}

class CampaignGiftListView extends ConsumerWidget {
  const CampaignGiftListView(this.campaignId, this.onGiftDelete, {super.key});

  final String campaignId;
  final void Function(int) onGiftDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final giftsListState = ref.watch(
      campaignGiftListControllerProvider(campaignId: campaignId),
    );

    return giftsListState.when(
      data: (gifts) {
        if (gifts.isEmpty) {
          return _buildEmptyState(ref);
        }
        return _buildGiftList(context, gifts, onGiftDelete);
      },
      loading: _buildLoadingState,
      error: (error, stack) => _buildErrorState(error, ref),
    );
  }

  // Loading State - Skeleton Items
  Widget _buildLoadingState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(),
        const SizedBox(height: 16),
        // Skeleton Items
        _buildSkeletonItem(),
        const SizedBox(height: 12),
        _buildSkeletonItem(),
      ],
    );
  }

  Widget _buildSkeletonItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _GiftListColors.slate100),
      ),
      child: Row(
        children: [
          // Icon Skeleton
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _GiftListColors.slate100,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          // Text Skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: 100,
                  decoration: BoxDecoration(
                    color: _GiftListColors.slate100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 160,
                  decoration: BoxDecoration(
                    color: _GiftListColors.slate100,
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

  // Empty State
  Widget _buildEmptyState(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _GiftListColors.slate200,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Container
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: _GiftListColors.slate50,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  size: 32,
                  color: _GiftListColors.slate400,
                ),
              ),
              const SizedBox(height: 16),
              // Title
              const Text(
                'No Gifts Available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _GiftListColors.slate900,
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              const Text(
                'There are no gifts linked to this campaign yet.',
                style: TextStyle(fontSize: 14, color: _GiftListColors.slate500),
              ),
              const SizedBox(height: 24),
              // Refresh Button
              GestureDetector(
                onTap: () {
                  // Invalidate controller to refetch gifts
                  ref.invalidate(
                    campaignGiftListControllerProvider(campaignId: campaignId),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _GiftListColors.slate200),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 16,
                        color: _GiftListColors.slate600,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Refresh',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _GiftListColors.slate600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Error State
  Widget _buildErrorState(Object error, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Error Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _GiftListColors.red50,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(
                  Icons.error,
                  size: 24,
                  color: _GiftListColors.red500,
                ),
              ),
              const SizedBox(height: 12),
              // Title
              const Text(
                'Failed to load gifts',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _GiftListColors.slate800,
                ),
              ),
              const SizedBox(height: 4),
              // Error message
              Text(
                error.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: _GiftListColors.slate500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Try Again
              GestureDetector(
                onTap: () {
                  ref.invalidate(
                    campaignGiftListControllerProvider(campaignId: campaignId),
                  );
                },
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _GiftListColors.brandStart,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Header Section
  Widget _buildHeader() {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [_GiftListColors.brandStart, _GiftListColors.brandEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Icon(Icons.card_giftcard, size: 20, color: Colors.white),
        ),
        const SizedBox(width: 8),
        const Text(
          'Gifts for this Campaign',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _GiftListColors.slate900,
          ),
        ),
      ],
    );
  }

  Widget _buildGiftList(
    BuildContext context,
    List<GiftModel> gifts,
    void Function(int) onGiftDelete,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: gifts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final gift = gifts[index];
            return _GiftItemCard(
              gift: gift,
              animationDelay: Duration(milliseconds: index * 50),
              onTap: () async {
                final value = await context.push(
                  AppRoutes.vendorGiftDetails,
                  extra: gift,
                );

                if (value is int) {
                  onGiftDelete(value);
                }
              },
            );
          },
        ),
      ],
    );
  }
}

// Gift Item Card with animation
class _GiftItemCard extends StatefulWidget {
  const _GiftItemCard({
    required this.gift,
    required this.onTap,
    this.animationDelay = Duration.zero,
  });

  final GiftModel gift;
  final VoidCallback onTap;
  final Duration animationDelay;

  @override
  State<_GiftItemCard> createState() => _GiftItemCardState();
}

class _GiftItemCardState extends State<_GiftItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.animationDelay, () {
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
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: widget.onTap,
          child: AnimatedScale(
            scale: _isPressed ? 0.99 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isPressed
                      ? _GiftListColors.brandStart.withValues(alpha: 0.3)
                      : _GiftListColors.slate100,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isPressed
                        ? Colors.black.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.02),
                    blurRadius: _isPressed ? 20 : 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Icon Container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _GiftListColors.orange50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _GiftListColors.orange100),
                    ),
                    child: AnimatedScale(
                      scale: _isPressed ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.card_giftcard,
                        size: 24,
                        color: _GiftListColors.orange500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.gift.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: _GiftListColors.slate900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.gift.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: _GiftListColors.slate500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Action Icon
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _isPressed
                          ? _GiftListColors.orange50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: _isPressed
                          ? _GiftListColors.brandStart
                          : _GiftListColors.slate300,
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
