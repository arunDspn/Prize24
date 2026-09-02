import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';
import 'package:prize24_app/features/shop/presentation/user_shop_detail_with_streak/ui/components/club_gift_history/ui/componets/club_rewards_empty_state.dart';
import 'package:prize24_app/features/shop/presentation/user_shop_detail_with_streak/ui/components/club_gift_history/view_model/club_gifts_history_controller.dart';

/// Color constants matching the HTML design
class _GiftHistoryColors {
  static const Color pageBg = Color(0xFFF8FAFC);
  static const Color pageCard = Color(0xFFFFFFFF);
  static const Color pageSubtle = Color(0xFFE2E8F0);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color brandStart = Color(0xFFEF4444);
  static const Color brandEnd = Color(0xFFF97316);
  static const Color successGreen = Color(0xFF22C55E);
  static const Color successGreenLight = Color(0xFFDCFCE7);
  static const Color warningOrange = Color(0xFFF97316);
  static const Color warningOrangeLight = Color(0xFFFFF7ED);
}

class ShopGiftsHistoryView extends ConsumerWidget {
  const ShopGiftsHistoryView({required this.shopId, super.key});

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clubGiftsHistoryControllerProvider);
    return state.when(
      data: (data) {
        if (data.isEmpty) {
          return const ClubRewardsEmptyState();
        }
        return _ShopGiftList(gifts: data, thisShopId: shopId);
      },
      error: (error, stack) {
        return _ErrorView(error: error.toString());
      },
      loading: () {
        return const _LoadingView();
      },
    );
  }
}

/// Loading view with skeleton animation
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _GiftHistoryColors.brandStart,
                  _GiftHistoryColors.brandEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading gifts...',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: _GiftHistoryColors.textSub,
            ),
          ),
        ],
      ),
    );
  }
}

/// Error view with retry option
class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _GiftHistoryColors.brandStart.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 32,
                color: _GiftHistoryColors.brandStart,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Outfit',
                color: _GiftHistoryColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                color: _GiftHistoryColors.textSub,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopGiftList extends StatelessWidget {
  const _ShopGiftList({
    required this.gifts,
    required this.thisShopId,
  });

  final List<UserGiftModel> gifts;
  final String thisShopId;

  @override
  Widget build(BuildContext context) {
    final filterdShops =
        gifts.where((gift) => gift.streakShopID == thisShopId).toList();
    return Column(
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _GiftHistoryColors.brandStart,
                      _GiftHistoryColors.brandEnd,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gifts Availed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Outfit',
                      color: _GiftHistoryColors.textMain,
                    ),
                  ),
                  Text(
                    '${filterdShops.length} ${filterdShops.length == 1 ? 'gift' : 'gifts'} won',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      color: _GiftHistoryColors.textSub,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filterdShops.length,
            itemBuilder: (context, index) {
              final gift = filterdShops[index];
              return _GiftCard(gift: gift);
            },
          ),
        ),
      ],
    );
  }
}

/// Premium gift card design
class _GiftCard extends StatelessWidget {
  const _GiftCard({required this.gift});
  final UserGiftModel gift;

  @override
  Widget build(BuildContext context) {
    final isRedeemed = gift.isRedeemed ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _GiftHistoryColors.pageCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _GiftHistoryColors.pageSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Gift Icon Container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isRedeemed
                  ? _GiftHistoryColors.successGreenLight
                  : _GiftHistoryColors.warningOrangeLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.card_giftcard,
              color: isRedeemed
                  ? _GiftHistoryColors.successGreen
                  : _GiftHistoryColors.warningOrange,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          // Gift Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gift.giftName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Outfit',
                    color: _GiftHistoryColors.textMain,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: _GiftHistoryColors.textSub.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isRedeemed
                          ? 'Redeemed on ${_formatDate(gift.redeemedAt)}'
                          : 'Availed on ${_formatDate(gift.availedAt)}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: _GiftHistoryColors.textSub,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isRedeemed
                  ? _GiftHistoryColors.successGreenLight
                  : _GiftHistoryColors.warningOrangeLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isRedeemed ? Icons.check_circle : Icons.hourglass_empty,
                  size: 14,
                  color: isRedeemed
                      ? _GiftHistoryColors.successGreen
                      : _GiftHistoryColors.warningOrange,
                ),
                const SizedBox(width: 4),
                Text(
                  isRedeemed ? 'Redeemed' : 'Pending',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    color: isRedeemed
                        ? _GiftHistoryColors.successGreen
                        : _GiftHistoryColors.warningOrange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }
}
