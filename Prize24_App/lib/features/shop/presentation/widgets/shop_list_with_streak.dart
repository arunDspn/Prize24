import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/shop/domain/model/user_following_shop_model.dart';
import 'package:prize24_app/features/shop/presentation/widgets/view_model/user_shop_notification_controller.dart';

import 'package:timeago/timeago.dart' as timeago;

/// Color constants matching the HTML design
class _ShopStreakColors {
  static const Color pageBg = Color(0xFFF8FAFC);
  static const Color pageCard = Color(0xFFFFFFFF);
  static const Color pageSubtle = Color(0xFFE2E8F0);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color brandStart = Color(0xFFEF4444);
  static const Color brandEnd = Color(0xFFF97316);
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange200 = Color(0xFFFED7AA);
}

/// A card widget that displays shop following progress with check-ins
///
/// Shows:
/// - Shop name and address
/// - 7-box progress window with current streak marker
/// - Left dots indicating previous progress (when streak > 7)
/// - Right dot indicating continuation
class ShopListWithStreak extends ConsumerWidget {
  const ShopListWithStreak({
    required this.shopData,
    super.key,
    this.onTap,
  });
  final UserFollowingShopModel shopData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final daysRemainingForPrize = shopData.giftCycleDays -
        (shopData.cumulativeStreak % shopData.giftCycleDays);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _ShopStreakColors.pageCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _ShopStreakColors.pageSubtle,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 10),
              spreadRadius: -10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                // Gradient Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _ShopStreakColors.brandStart,
                        _ShopStreakColors.brandEnd,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _ShopStreakColors.brandEnd.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      shopData.shopName.isNotEmpty
                          ? shopData.shopName[0].toUpperCase()
                          : '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shopData.shopName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Outfit',
                          color: _ShopStreakColors.textMain,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      // Followed time with icon
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            size: 12,
                            color: _ShopStreakColors.textSub.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Followed ${timeago.format(shopData.followedAt, locale: 'en_short')}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              color: _ShopStreakColors.textSub,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Bell Toggle Button
                _BellToggleButton(
                  isEnabled: shopData.notificationEnabled,
                  onTap: () {
                    ref
                        .read(userShopNotificationControllerProvider.notifier)
                        .toggleShopNotification(
                          shopId: shopData.shopId,
                          enable: !shopData.notificationEnabled,
                        );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Streak Context Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Days to Prize Badge
                if (shopData.isGiftAvailable)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _ShopStreakColors.orange50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _ShopStreakColors.orange100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          size: 16,
                          color: _ShopStreakColors.brandEnd,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$daysRemainingForPrize ${daysRemainingForPrize == 1 ? 'DAY' : 'DAYS'} TO PRIZE',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            color: _ShopStreakColors.brandEnd,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _ShopStreakColors.orange50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _ShopStreakColors.orange100),
                    ),
                    child: const Text(
                      'Keep up the good work',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                        color: _ShopStreakColors.brandEnd,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                // Streak Count
                Row(
                  children: [
                    const Text(
                      'Streak: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: _ShopStreakColors.textSub,
                      ),
                    ),
                    Text(
                      '${shopData.cumulativeStreak}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: _ShopStreakColors.textMain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Progress boxes
            ShopStreakProgressBoxes(shopData: shopData),
          ],
        ),
      ),
    );
  }
}

/// Bell toggle button with animation
class _BellToggleButton extends StatelessWidget {
  const _BellToggleButton({
    required this.isEnabled,
    required this.onTap,
  });

  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isEnabled
                    ? Icons.notifications_active
                    : Icons.notifications_off,
                key: ValueKey(isEnabled),
                size: 22,
                color: isEnabled
                    ? _ShopStreakColors.brandStart
                    : _ShopStreakColors.pageSubtle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShopStreakProgressBoxes extends StatelessWidget {
  const ShopStreakProgressBoxes({
    required this.shopData,
    super.key,
  });
  final UserFollowingShopModel shopData;

  @override
  Widget build(BuildContext context) {
    final daysRemainingForPrize = shopData.giftCycleDays -
        (shopData.cumulativeStreak % shopData.giftCycleDays);
    final streakTotal = shopData.cumulativeStreak;

    // Calculate the 7-box window: [streakTotal-1,
    // streakTotal, ..., streakTotal+5]
    final startDay = streakTotal == 0 || streakTotal == 1 ? 1 : streakTotal - 1;
    final boxDays = List.generate(7, (index) => startDay + index);

    // Show left dots if streakTotal > 2
    final showLeftDots = streakTotal > 2;

    // Calculate prize day
    final prizeDay = streakTotal + daysRemainingForPrize;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left dots
          if (showLeftDots) ...[
            _DotIndicator(),
            const SizedBox(width: 4),
            _DotIndicator(),
            const SizedBox(width: 8),
          ],
          // 7 progress boxes
          ...List.generate(7, (index) {
            final dayNumber = boxDays[index];
            final isCompleted = dayNumber > 0 && dayNumber < streakTotal;
            final isCurrentStreak = dayNumber == streakTotal && streakTotal > 0;
            final isPrizeDay = shopData.isGiftAvailable &&
                dayNumber == prizeDay &&
                dayNumber > streakTotal;

            return Padding(
              padding: EdgeInsets.only(right: index < 6 ? 4 : 0),
              child: _ProgressBox(
                isCompleted: isCompleted,
                isCurrentStreak: isCurrentStreak,
                isPrizeDay: isPrizeDay,
                dayNumber: dayNumber,
              ),
            );
          }),
          // Right dots
          const SizedBox(width: 8),
          _DotIndicator(),
          const SizedBox(width: 4),
          _DotIndicator(),
        ],
      ),
    );
  }
}

class _ProgressBox extends StatelessWidget {
  final bool isCompleted;
  final bool isCurrentStreak;
  final bool isPrizeDay;
  final int dayNumber;

  const _ProgressBox({
    required this.isCompleted,
    required this.isCurrentStreak,
    required this.isPrizeDay,
    required this.dayNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Box
        if (isCurrentStreak)
          _CurrentStreakBox(dayNumber: dayNumber)
        else if (isCompleted)
          _CompletedBox(dayNumber: dayNumber)
        else if (isPrizeDay)
          _PrizeBox(dayNumber: dayNumber)
        else
          _FutureBox(dayNumber: dayNumber),
      ],
    );
  }
}

/// Current streak box with gradient and glow animation
class _CurrentStreakBox extends StatefulWidget {
  const _CurrentStreakBox({required this.dayNumber});
  final int dayNumber;

  @override
  State<_CurrentStreakBox> createState() => _CurrentStreakBoxState();
}

class _CurrentStreakBoxState extends State<_CurrentStreakBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _ShopStreakColors.brandStart,
                    _ShopStreakColors.brandEnd,
                  ],
                ),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: _ShopStreakColors.brandEnd.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: _glowAnimation.value,
                  ),
                  BoxShadow(
                    color: _ShopStreakColors.brandStart.withOpacity(0.15),
                    blurRadius: _glowAnimation.value,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 6),
        Text(
          widget.dayNumber > 0 ? widget.dayNumber.toString() : '',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
            color: _ShopStreakColors.brandStart,
          ),
        ),
      ],
    );
  }
}

/// Completed day box
class _CompletedBox extends StatelessWidget {
  const _CompletedBox({required this.dayNumber});
  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _ShopStreakColors.orange100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _ShopStreakColors.orange200),
          ),
          child: const Center(
            child: Icon(
              Icons.check,
              color: _ShopStreakColors.brandEnd,
              size: 18,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          dayNumber > 0 ? dayNumber.toString() : '',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
            color: _ShopStreakColors.brandEnd,
          ),
        ),
      ],
    );
  }
}

/// Future day box (not yet completed)
class _FutureBox extends StatelessWidget {
  const _FutureBox({required this.dayNumber});
  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _ShopStreakColors.pageSubtle),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          dayNumber > 0 ? dayNumber.toString() : '',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
            color: _ShopStreakColors.textSub.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

class _DotIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: _ShopStreakColors.pageSubtle,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Prize day box with gift icon
class _PrizeBox extends StatelessWidget {
  const _PrizeBox({required this.dayNumber});
  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _ShopStreakColors.orange50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _ShopStreakColors.brandEnd, width: 2),
            boxShadow: [
              BoxShadow(
                color: _ShopStreakColors.brandEnd.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.card_giftcard,
              color: _ShopStreakColors.brandEnd,
              size: 18,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          dayNumber > 0 ? dayNumber.toString() : '',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
            color: _ShopStreakColors.brandEnd,
          ),
        ),
      ],
    );
  }
}
