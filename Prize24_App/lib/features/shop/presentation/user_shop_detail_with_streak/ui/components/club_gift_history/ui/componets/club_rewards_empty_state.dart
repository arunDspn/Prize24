import 'package:flutter/material.dart';
import 'package:prize24_app/configs/theme_config.dart';

/// Color constants matching the HTML design
class _EmptyStateColors {
  static const Color pageBg = Color(0xFFF8FAFC);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color brandStart = Color(0xFFEF4444);
  static const Color brandEnd = Color(0xFFF97316);
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
}

/// Empty state widget shown when user hasn't unlocked any rewards yet
///
/// Displays:
/// - Gift box illustration
/// - Encouraging message to continue streak
/// - Description text explaining how to unlock rewards
class ClubRewardsEmptyState extends StatelessWidget {
  const ClubRewardsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Gradient gift box container
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _EmptyStateColors.orange50,
                  _EmptyStateColors.orange100,
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: _EmptyStateColors.brandEnd.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Subtle gradient ring
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _EmptyStateColors.brandStart.withOpacity(0.1),
                        _EmptyStateColors.brandEnd.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
                // Gift icon
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _EmptyStateColors.brandStart,
                      _EmptyStateColors.brandEnd,
                    ],
                  ).createShader(bounds),
                  child: const Icon(
                    Icons.card_giftcard,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          // Main heading
          Text(
            'Keep going to unlock\nyour first reward',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'Outfit',
              color: _EmptyStateColors.textMain,
              height: 1.3,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          // Description text
          Text(
            'You haven\'t unlocked any rewards from this vendor.\nContinue your streak to win big rewards and surprises!',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
              color: _EmptyStateColors.textSub,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          // Motivational badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: _EmptyStateColors.orange50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _EmptyStateColors.orange100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department,
                  size: 18,
                  color: _EmptyStateColors.brandEnd,
                ),
                const SizedBox(width: 8),
                Text(
                  'Keep your streak alive!',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    color: _EmptyStateColors.brandEnd,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
