import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/redeem_gift/ui/redeem_gift_page.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Design system colors matching the HTML mockup
class _StreakColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate900 = Color(0xFF0F172A);
}

// todo: rename file to shop_streaks_view.dart
class ShopClubsView extends ConsumerStatefulWidget {
  const ShopClubsView({
    required this.shopId,
    this.campaignId,
    super.key,
  });

  final String? campaignId;
  final String shopId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShopClubsViewState();
}

class _ShopClubsViewState extends ConsumerState<ShopClubsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _StreakColors.slate50,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Scan Loyalty Action Card
              _ActionCard(
                icon: Icons.qr_code_scanner_rounded,
                title: 'Scan Loyalty',
                subtitle: 'Scan customer QR code to record visit',
                gradientColors: const [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                onTap: () {
                  context.push(
                    AppRoutes.scanUsersForLoyaltyByShopStaff,
                    extra: (widget.campaignId, widget.shopId),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Redeem Gift Action Card
              _ActionCard(
                icon: Icons.qr_code_scanner_rounded,
                title: 'Redeem Gift',
                subtitle: widget.campaignId == null
                    ? "Shop doesn't have an active gift campaign"
                    : 'Scan customer QR code to redeem gift',
                gradientColors: const [Color(0xFF667EEA), Color(0xFF764BA2)],
                enabled: widget.campaignId != null,
                onTap: () {
                  final data = RedeemGiftBasicData.forStaff(
                    campaignId: widget.campaignId!,
                    shopId: widget.shopId,
                    campaignName: '',
                  );
                  context.push(
                    AppRoutes.redeemAvailedGiftByStaff,
                    extra: data,
                  );
                },
              ),
              const SizedBox(height: 16),
              // Info Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _StreakColors.slate100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: _StreakColors.slate100,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(
                        Icons.groups_rounded,
                        size: 32,
                        color: _StreakColors.slate400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Shop Streaks',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: _StreakColors.slate900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Track customer loyalty streaks and reward your most dedicated visitors.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: _StreakColors.slate500,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatefulWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  final bool enabled;

  @override
  State<_ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<_ActionCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:
          widget.enabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp:
          widget.enabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel:
          widget.enabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: widget.enabled
              ? LinearGradient(
                  colors: widget.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    _StreakColors.slate400,
                    _StreakColors.slate500,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: widget.enabled
              ? [
                  BoxShadow(
                    color: widget.gradientColors.first
                        .withOpacity(_isPressed ? 0.4 : 0.3),
                    blurRadius: _isPressed ? 24 : 20,
                    offset: const Offset(0, 8),
                    spreadRadius: _isPressed ? 2 : 0,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(widget.enabled ? 0.2 : 0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                widget.icon,
                size: 28,
                color: widget.enabled
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(width: 16),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: widget.enabled
                          ? Colors.white
                          : Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.enabled
                          ? Colors.white.withOpacity(0.85)
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            // Arrow icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(widget.enabled ? 0.2 : 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: widget.enabled
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
