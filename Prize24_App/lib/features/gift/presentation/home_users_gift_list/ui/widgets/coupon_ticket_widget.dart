import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';
import 'package:prize24_app/routing/app_routes.dart';
import 'package:prize24_app/utils/date_convertors.dart';

/// Theme colors matching the HTML design
class _ThemeColors {
  // Page colors
  static const Color pageBg = Color(0xFFF8FAFC); // slate-50
  static const Color pageCard = Color(0xFFFFFFFF); // white
  static const Color pageInput = Color(0xFFF1F5F9); // slate-100
  static const Color pageSubtle = Color(0xFFE2E8F0); // slate-200
  static const Color stubBg = Color(0xFFFAFAFA); // slightly off-white

  // Text colors
  static const Color textMain = Color(0xFF1E293B); // slate-800
  static const Color textSub = Color(0xFF64748B); // slate-500
  static const Color textMuted = Color(0xFF94A3B8); // slate-400

  // Brand colors
  static const Color brandStart = Color(0xFFEF4444); // red-500
  static const Color brandEnd = Color(0xFFF97316); // orange-500
  static const Color brandBgLight = Color(0xFFFEF2F2); // red-50
}

class CouponTicketCard extends StatelessWidget {
  const CouponTicketCard({
    required this.gift,
    super.key,
  });

  final UserGiftModel gift;

  @override
  Widget build(BuildContext context) {
    final isRedeemed = gift.isRedeemed == true;

    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.coupon, extra: gift);
      },
      child: ColorFiltered(
        colorFilter: isRedeemed
            ? const ColorFilter.matrix(<double>[
                0.2126, 0.7152, 0.0722, 0, 0, // Red
                0.2126, 0.7152, 0.0722, 0, 0, // Green
                0.2126, 0.7152, 0.0722, 0, 0, // Blue
                0, 0, 0, 0.6, 0, // Alpha
              ])
            : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: _ThemeColors.pageCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _ThemeColors.pageInput),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              // Main Content Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Brand badge
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isRedeemed
                                  ? _ThemeColors.pageInput
                                  : _ThemeColors.brandBgLight,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isRedeemed
                                  ? Icon(
                                      Icons.store_rounded,
                                      size: 12,
                                      color: _ThemeColors.textMuted,
                                    )
                                  : ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        colors: [
                                          _ThemeColors.brandStart,
                                          _ThemeColors.brandEnd,
                                        ],
                                      ).createShader(bounds),
                                      child: const Icon(
                                        Icons.store_rounded,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _getShopName().toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: _ThemeColors.textMuted,
                                letterSpacing: 1.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      // Title and description
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gift.giftName.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: isRedeemed
                                  ? _ThemeColors.textMuted
                                  : _ThemeColors.textMain,
                              height: 1,
                              letterSpacing: -0.3,
                              decoration: isRedeemed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isRedeemed
                                ? _getRedeemedDescription()
                                : gift.giftDescription,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isRedeemed
                                  ? _ThemeColors.textMuted
                                  : _ThemeColors.textSub,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      // Meta info pills
                      Row(
                        children: [
                          if (isRedeemed) ...[
                            Text(
                              _getDateText(),
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: _ThemeColors.textMuted,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ] else ...[
                            _buildMetaPill(
                              Icons.calendar_today_outlined,
                              'Rec: ${formatDate1(gift.availedAt)}',
                            ),
                            const SizedBox(width: 12),
                            _buildMetaPill(
                              Icons.info_outline,
                              _getMetaInfo(),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Vertical Divider with Notches
              _TicketDivider(),

              // Stub/Action Section
              Container(
                width: 100,
                color: _ThemeColors.stubBg,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isRedeemed) ...[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _ThemeColors.pageSubtle,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: 20,
                            color: _ThemeColors.textMuted.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'USED',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: _ThemeColors.textMuted,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ] else ...[
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _ThemeColors.brandStart,
                              _ThemeColors.brandEnd,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _ThemeColors.brandEnd.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'REDEEM',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: _ThemeColors.textMuted,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaPill(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 10,
          color: _ThemeColors.textMuted,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: _ThemeColors.textMuted,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  String _getShopName() {
    if (gift.isRedeemable &&
        gift.supportedShops != null &&
        gift.supportedShops!.isNotEmpty) {
      if (gift.supportedShops!.length == 1) {
        return gift.supportedShops!.first.name;
      }
      return '${gift.supportedShops!.length} Shops';
    }
    return 'Gift';
  }

  String _getDateText() {
    if (gift.isRedeemed == true && gift.redeemedAt != null) {
      return 'Used on ${formatDate1(gift.redeemedAt!)}';
    }
    return 'Rec: ${formatDate1(gift.availedAt)}';
  }

  String _getMetaInfo() {
    // Return a meaningful meta info, e.g., shop count or condition
    if (gift.supportedShops != null && gift.supportedShops!.length > 1) {
      return '${gift.supportedShops!.length} Shops';
    }
    return 'View Details';
  }

  String _getRedeemedDescription() {
    if (gift.supportedShops != null && gift.supportedShops!.isNotEmpty) {
      return 'Claimed at ${gift.supportedShops!.first.name}';
    }
    return 'Claimed';
  }
}

/// Custom ticket divider with notched edges
class _TicketDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background
          Container(
            width: 24,
            color: _ThemeColors.pageCard,
          ),

          // Dashed line in center
          Positioned.fill(
            child: Center(
              child: CustomPaint(
                size: const Size(2, double.infinity),
                painter: _DashedLinePainter(),
              ),
            ),
          ),

          // Top notch
          Positioned(
            top: -10,
            left: 2,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _ThemeColors.pageBg,
                shape: BoxShape.circle,
                border: Border.all(color: _ThemeColors.pageInput),
              ),
            ),
          ),

          // Bottom notch
          Positioned(
            bottom: -10,
            left: 2,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _ThemeColors.pageBg,
                shape: BoxShape.circle,
                border: Border.all(color: _ThemeColors.pageInput),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for dashed vertical line
class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _ThemeColors.pageSubtle
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashHeight = 6.0;
    const dashSpace = 4.0;

    double startY = 15; // Start after top notch
    final endY = size.height - 15; // End before bottom notch

    while (startY < endY) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, (startY + dashHeight).clamp(0, endY)),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
