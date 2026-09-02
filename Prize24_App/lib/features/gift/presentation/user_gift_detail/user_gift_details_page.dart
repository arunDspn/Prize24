import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:prize24_app/common_widgets/common_widgets.dart';
import 'package:prize24_app/configs/assets.dart';
import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';

// ============================================================================
// Theme Colors from HTML Design
// ============================================================================
class _GiftDetailsColors {
  // Page colors
  static const Color pageBg = Color(0xFFF8FAFC); // #F8FAFC
  static const Color pageCard = Color(0xFFFFFFFF); // white
  static const Color pageInput = Color(0xFFF1F5F9); // #F1F5F9
  static const Color pageSubtle = Color(0xFFE2E8F0); // #E2E8F0

  // Text colors
  static const Color textMain = Color(0xFF0F172A); // #0F172A
  static const Color textSub = Color(0xFF64748B); // #64748B

  // Brand gradient colors
  static const Color brandStart = Color(0xFFEF4444); // red-500
  static const Color brandEnd = Color(0xFFF97316); // orange-500

  // Status colors
  static const Color greenLight = Color(0xFFDCFCE7); // green-100
  static const Color greenBorder = Color(0xFFBBF7D0); // green-200
  static const Color greenText = Color(0xFF16A34A); // green-600

  static const Color blueLight = Color(0xFFEFF6FF); // blue-50
  static const Color blueBorder = Color(0xFFDBEAFE); // blue-100
  static const Color blueText = Color(0xFF1D4ED8); // blue-700
  static const Color blueIcon = Color(0xFF3B82F6); // blue-500

  static const Color orangeLight = Color(0xFFFFF7ED); // orange-50

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );

  // Shadow configurations
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 30,
      offset: const Offset(0, 10),
      spreadRadius: -10,
    ),
  ];

  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: brandStart.withOpacity(0.4),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];
}

class UserGiftDetailsPage extends StatefulWidget {
  const UserGiftDetailsPage({required this.userGift, super.key});

  final UserGiftModel userGift;

  @override
  State<UserGiftDetailsPage> createState() => _UserGiftDetailsPageState();
}

class _UserGiftDetailsPageState extends State<UserGiftDetailsPage>
    with TickerProviderStateMixin {
  late QrCode qrCode;
  late QrImage qrImage;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _scanLineController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();

    // Scan line animation for QR code
    _scanLineController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scanLineController.dispose();
    super.dispose();
  }

  void _generateQRCode() {
    final qrData = widget.userGift.id;

    qrCode = QrCode.fromData(
      data: qrData,
      errorCorrectLevel: QrErrorCorrectLevel.M,
    );

    qrImage = QrImage(qrCode);
  }

  bool get _isRedeemed => widget.userGift.isRedeemed ?? false;

  String get _statusText {
    if (widget.userGift.isRedeemable) {
      return _isRedeemed ? 'Redeemed' : 'Active';
    } else {
      return 'Received';
    }
  }

  void _showToast(String message, {bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.warning,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
        backgroundColor: isSuccess
            ? _GiftDetailsColors.textMain
            : _GiftDetailsColors.brandStart,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        elevation: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _GiftDetailsColors.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroCard(),
                      const SizedBox(height: 24),
                      _buildDescriptionCard(),
                      const SizedBox(height: 24),
                      if (widget.userGift.isRedeemable) ...[
                        if (!_isRedeemed) ...[
                          _buildQRCodeCard(),
                          const SizedBox(height: 24),
                        ],
                      ] else ...[
                        _buildPayloadCard(),
                        const SizedBox(height: 24),
                      ],
                      if (widget.userGift.supportedShops != null &&
                          widget.userGift.supportedShops!.isNotEmpty) ...[
                        _buildSupportedShopsCard(),
                        const SizedBox(height: 16),
                      ],
                      _buildTimelineCard(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: _GiftDetailsColors.pageSubtle.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Back button
            _buildAppBarButton(
              icon: Icons.arrow_back_ios_new,
              onTap: () => Navigator.of(context).pop(),
            ),
            const Spacer(),
            // Title
            const Text(
              'Gift Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _GiftDetailsColors.textMain,
                letterSpacing: -0.3,
              ),
            ),
            const Spacer(),
            // More button
            // _buildAppBarButton(
            //   icon: Icons.more_horiz,
            //   onTap: () {
            //     // Optional actions
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.5),
            border: Border.all(color: Colors.transparent, width: 1),
          ),
          child: Icon(icon, color: _GiftDetailsColors.textMain, size: 20),
        ),
      ),
    );
  }

  /// Premium Hero Card with Gradient Background
  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: _GiftDetailsColors.brandGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: _GiftDetailsColors.glowShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Pattern overlay
            Positioned.fill(child: CustomPaint(painter: _DotPatternPainter())),
            // Decorative circles
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -32,
              left: -32,
              child: Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.05),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ticket icon with glass panel
                      _buildGlassPanel(
                        child: const Icon(
                          Icons.confirmation_number,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      // Status badge
                      _buildHeroStatusBadge(),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Gift type label
                  Text(
                    'GIFT VOUCHER',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Gift name
                  Text(
                    widget.userGift.giftName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassPanel({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: child,
    );
  }

  Widget _buildHeroStatusBadge() {
    if (widget.userGift.isRedeemable) {
      if (_isRedeemed) {
        // Redeemed - glass panel style
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 14, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'REDEEMED',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      } else {
        // Active - white background with pulse dot
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: _GiftDetailsColors.brandStart,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'ACTIVE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _GiftDetailsColors.brandStart,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      }
    } else {
      // Received - glass panel style
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.card_giftcard, size: 14, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'RECEIVED',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
  }

  /// Description/About Card
  Widget _buildDescriptionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _GiftDetailsColors.pageCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _GiftDetailsColors.pageSubtle.withOpacity(0.6),
          width: 1,
        ),
        boxShadow: _GiftDetailsColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: _GiftDetailsColors.orangeLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: _GiftDetailsColors.brandEnd,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'About this Gift',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _GiftDetailsColors.textMain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            widget.userGift.giftDescription,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: _GiftDetailsColors.textSub,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  /// QR Code Card with Ticket Stub Style
  Widget _buildQRCodeCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _GiftDetailsColors.pageCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _GiftDetailsColors.pageSubtle, width: 1),
        boxShadow: _GiftDetailsColors.cardShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Gradient top edge
          Container(
            height: 6,
            decoration: const BoxDecoration(
              gradient: _GiftDetailsColors.brandGradient,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  'Scan to Redeem',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _GiftDetailsColors.textMain,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'SINGLE USE ONLY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: _GiftDetailsColors.textSub,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),
                // QR Code with corner markers and scan animation
                _buildQRCodeWithEffects(),
                const SizedBox(height: 16),
                // Info pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _GiftDetailsColors.pageBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.visibility,
                        size: 14,
                        color: _GiftDetailsColors.textSub,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Show to cashier',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _GiftDetailsColors.textSub,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeWithEffects() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _GiftDetailsColors.pageCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _GiftDetailsColors.pageSubtle, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // QR Code
          SizedBox(
            width: 192,
            height: 192,
            child: PrettyQrView.data(
              data: widget.userGift.id,
              decoration: const PrettyQrDecoration(
                shape: PrettyQrRoundedSymbol(color: Colors.black),
              ),
            ),
          ),
          // Scan line animation
          SizedBox(
            width: 192,
            height: 192,
            child: AnimatedBuilder(
              animation: _scanLineController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _ScanLinePainter(
                    progress: _scanLineController.value,
                    color: _GiftDetailsColors.brandStart,
                  ),
                );
              },
            ),
          ),
          // Corner markers
          SizedBox(
            width: 192,
            height: 192,
            child: CustomPaint(painter: _CornerMarkersPainter()),
          ),
        ],
      ),
    );
  }

  /// Payload Card for non-redeemable gifts
  Widget _buildPayloadCard() {
    if (widget.userGift.payload == null || widget.userGift.payload!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _GiftDetailsColors.pageCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _GiftDetailsColors.pageSubtle, width: 1),
        boxShadow: _GiftDetailsColors.cardShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: _GiftDetailsColors.blueLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.code,
              color: _GiftDetailsColors.blueIcon,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          // Title
          const Text(
            'Your Code',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _GiftDetailsColors.textMain,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Use this code at checkout to claim your gift.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: _GiftDetailsColors.textSub),
          ),
          const SizedBox(height: 24),
          // Code box with tap to copy
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.userGift.payload!));
              _showToast('Code copied successfully');
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _GiftDetailsColors.pageBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _GiftDetailsColors.pageSubtle,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    widget.userGift.payload!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: _GiftDetailsColors.textMain,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.copy,
                        size: 14,
                        color: _GiftDetailsColors.brandStart,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Tap to Copy',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _GiftDetailsColors.brandStart,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Supported Shops Card
  Widget _buildSupportedShopsCard() {
    if (widget.userGift.supportedShops == null ||
        widget.userGift.supportedShops!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _GiftDetailsColors.pageCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _GiftDetailsColors.pageSubtle, width: 1),
        boxShadow: _GiftDetailsColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          const Row(
            children: [
              Icon(
                Icons.storefront,
                color: _GiftDetailsColors.brandEnd,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Available Locations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _GiftDetailsColors.textMain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Shops list
          ...widget.userGift.supportedShops!.map(
            (shop) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _GiftDetailsColors.orangeLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: _GiftDetailsColors.brandEnd,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _GiftDetailsColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          shop.shopAddress,
                          style: const TextStyle(
                            fontSize: 12,
                            color: _GiftDetailsColors.textSub,
                          ),
                        ),
                        if (shop.shopPhone.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 12,
                                color: _GiftDetailsColors.textSub,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                shop.shopPhone,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: _GiftDetailsColors.textSub,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Timeline Card with vertical line
  Widget _buildTimelineCard() {
    final dateFormat = DateFormat("MMM dd, yyyy 'at' hh:mm a");
    final isRedeemed =
        widget.userGift.isRedeemable && widget.userGift.redeemedAt != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _GiftDetailsColors.pageCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _GiftDetailsColors.pageSubtle, width: 1),
        boxShadow: _GiftDetailsColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          const Row(
            children: [
              Icon(
                Icons.history,
                color: _GiftDetailsColors.brandStart,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _GiftDetailsColors.textMain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Timeline items
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Received node
                _buildTimelineNode(
                  label: 'Received',
                  date: dateFormat.format(widget.userGift.availedAt),
                  color: _GiftDetailsColors.blueIcon,
                  bgColor: _GiftDetailsColors.blueLight,
                  showLine: isRedeemed,
                  icon: null,
                ),
                // Redeemed node (if applicable)
                if (isRedeemed)
                  _buildTimelineNode(
                    label: 'Redeemed',
                    date: dateFormat.format(widget.userGift.redeemedAt!),
                    color: _GiftDetailsColors.greenText,
                    bgColor: _GiftDetailsColors.greenLight,
                    showLine: false,
                    icon: Icons.check,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineNode({
    required String label,
    required String date,
    required Color color,
    required Color bgColor,
    required bool showLine,
    IconData? icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: icon != null
                  ? Icon(icon, size: 10, color: color)
                  : Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 48,
                color: _GiftDetailsColors.pageSubtle,
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: showLine ? 32 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _GiftDetailsColors.textMain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Dot pattern painter for hero card overlay
class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    const spacing = 20.0;
    const dotRadius = 0.5;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Scan line painter for QR code animation
class _ScanLinePainter extends CustomPainter {
  final double progress;
  final Color color;

  _ScanLinePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate opacity based on progress
    double opacity = 1.0;
    if (progress < 0.1) {
      opacity = progress / 0.1;
    } else if (progress > 0.9) {
      opacity = (1 - progress) / 0.1;
    }

    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final y = progress * size.height;
    canvas.drawRect(Rect.fromLTWH(0, y, size.width, 2), paint);
  }

  @override
  bool shouldRepaint(covariant _ScanLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Corner markers painter for QR code
class _CornerMarkersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _GiftDetailsColors.textMain
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const markerSize = 16.0;
    const radius = 4.0;

    // Top-left
    canvas.drawPath(
      Path()
        ..moveTo(0, markerSize)
        ..lineTo(0, radius)
        ..arcToPoint(Offset(radius, 0), radius: const Radius.circular(radius))
        ..lineTo(markerSize, 0),
      paint,
    );

    // Top-right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - markerSize, 0)
        ..lineTo(size.width - radius, 0)
        ..arcToPoint(
          Offset(size.width, radius),
          radius: const Radius.circular(radius),
        )
        ..lineTo(size.width, markerSize),
      paint,
    );

    // Bottom-left
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - markerSize)
        ..lineTo(0, size.height - radius)
        ..arcToPoint(
          Offset(radius, size.height),
          radius: const Radius.circular(radius),
          clockwise: false,
        )
        ..lineTo(markerSize, size.height),
      paint,
    );

    // Bottom-right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - markerSize, size.height)
        ..lineTo(size.width - radius, size.height)
        ..arcToPoint(
          Offset(size.width, size.height - radius),
          radius: const Radius.circular(radius),
          clockwise: false,
        )
        ..lineTo(size.width, size.height - markerSize),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
