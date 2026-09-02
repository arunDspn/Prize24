import 'package:flutter/material.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_user_data_model.dart';

/// A card widget that displays club membership progress with check-ins and gift tracking
///
/// Shows:
/// - Club name and description
/// - 7-box progress window with current streak marker
/// - Gift icon at gift day position (if within visible range)
/// - Left dots indicating previous progress (when streak > 7)
/// - Right dot indicating continuation
class ClubProgressCard extends StatelessWidget {
  const ClubProgressCard({
    required this.clubData,
    super.key,
    this.onTap,
  });
  final ClubMemberUserDataModel clubData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.05),
          //     blurRadius: 10,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Club name only
            Row(
              children: [
                // Logo Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2752E7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.card_giftcard,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clubData.clubName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy',
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    // Club description
                    Text(
                      clubData.clubDescription,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy',
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Progress boxes
            ClubStreakProgressBoxes(clubData: clubData),
          ],
        ),
      ),
    );
  }
}

class ClubStreakProgressBoxes extends StatelessWidget {
  const ClubStreakProgressBoxes({required this.clubData});
  final ClubMemberUserDataModel clubData;

  @override
  Widget build(BuildContext context) {
    final streakTotal = clubData.streakTotal;
    final giftDayCycle = clubData.giftDayCycle;
    final lastGiftDate = clubData.lastGiftDate;

    // Calculate the 7-box window: [streakTotal-1, streakTotal, ..., streakTotal+5]
    final startDay = streakTotal == 0 || streakTotal == 1 ? 1 : streakTotal - 1;
    final endDay = streakTotal + 5;
    final boxDays = List.generate(7, (index) => startDay + index);

    // Calculate next gift day position
    int nextGiftDay;
    if (lastGiftDate == null) {
      // First gift cycle - gift appears at giftDayCycle day
      nextGiftDay = giftDayCycle;
    } else {
      // Find the actual gift day number in the streak
      // We need to find which gift day falls in our range
      int currentGiftCycle = (streakTotal / giftDayCycle).floor();
      nextGiftDay = (currentGiftCycle + 1) * giftDayCycle;

      // If the next calculated gift day is less than or equal to streakTotal,
      // it means we've already passed it, so calculate the one after
      if (nextGiftDay <= streakTotal) {
        nextGiftDay = (currentGiftCycle + 2) * giftDayCycle;
      }
    }

    // Check if gift day is within visible range
    final showGift = nextGiftDay >= startDay && nextGiftDay <= endDay;
    final giftBoxIndex = showGift ? nextGiftDay - startDay : -1;

    // Show left dots if streakTotal > 7
    final showLeftDots = streakTotal > 7;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left dots
        if (showLeftDots) ...[
          _DotIndicator(),
          // const SizedBox(width: 10),
          _DotIndicator(),
          // const SizedBox(width: 10),
        ],
        // 7 progress boxes
        ...List.generate(7, (index) {
          final dayNumber = boxDays[index];
          final isCompleted = dayNumber > 0 && dayNumber < streakTotal;
          final isCurrentStreak = dayNumber == streakTotal && streakTotal > 0;
          final hasGift = index == giftBoxIndex;

          return [
            // if (index > 0) const SizedBox(width: 6),
            _ProgressBox(
              isCompleted: isCompleted,
              isCurrentStreak: isCurrentStreak,
              hasGift: hasGift,
              dayNumber: dayNumber,
            ),
          ];
        }).expand((element) => element),
        // Right dot
        // const SizedBox(width: 10),
        _DotIndicator(),
        // const SizedBox(width: 10),
        _DotIndicator(),
      ],
    );
  }
}

class _ProgressBox extends StatelessWidget {
  final bool isCompleted;
  final bool isCurrentStreak;
  final bool hasGift;
  final int dayNumber;

  const _ProgressBox({
    required this.isCompleted,
    required this.isCurrentStreak,
    required this.hasGift,
    required this.dayNumber,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF2752E7);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Arrow marker above current streak
        SizedBox(
          height: 20,
          child: isCurrentStreak
              ? Icon(
                  Icons.arrow_drop_down,
                  color: primaryColor,
                  size: 24,
                )
              : null,
        ),
        // Box
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCompleted || isCurrentStreak
                ? primaryColor
                : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: hasGift
                ? Icon(
                    Icons.card_giftcard,
                    color: isCompleted || isCurrentStreak
                        ? Colors.white
                        : primaryColor,
                    size: 18,
                  )
                : isCompleted || isCurrentStreak
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 20,
                        weight: 700,
                      )
                    : null,
          ),
        ),
        const SizedBox(height: 6),
        // Day number
        Text(
          dayNumber > 0 ? dayNumber.toString() : '',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            fontFamily: 'Gilroy',
            color: isCompleted || isCurrentStreak
                ? primaryColor
                : const Color(0xFF9E9E9E),
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
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFFBDBDBD),
        shape: BoxShape.circle,
      ),
    );
  }
}
