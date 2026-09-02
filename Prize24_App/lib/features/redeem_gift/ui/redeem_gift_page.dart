import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prize24_app/features/redeem_gift/view_model/redeem_gift_controller.dart';

// === Design System Colors ===
class _AppColors {
  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate300 = Color(0xFFCBD5E1);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate600 = Color(0xFF475569);
  static const slate700 = Color(0xFF334155);
  static const slate800 = Color(0xFF1E293B);
  static const slate900 = Color(0xFF0F172A);
  static const brandStart = Color(0xFFFF5F6D);
  static const brandEnd = Color(0xFFFFC371);
  static const blue50 = Color(0xFFEFF6FF);
  static const blue100 = Color(0xFFDBEAFE);
  static const blue500 = Color(0xFF3B82F6);
  static const blue700 = Color(0xFF1D4ED8);
  static const orange50 = Color(0xFFFFF7ED);
  static const orange100 = Color(0xFFFFEDD5);
  static const orange500 = Color(0xFFF97316);
  static const green100 = Color(0xFFDCFCE7);
  static const green600 = Color(0xFF16A34A);
  static const red100 = Color(0xFFFEE2E2);
  static const red600 = Color(0xFFDC2626);
  static const yellow50 = Color(0xFFFEFCE8);
  static const yellow200 = Color(0xFFFEF08A);
  static const yellow600 = Color(0xFFCA8A04);

  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

class RedeemGiftBasicData {
  RedeemGiftBasicData({
    required this.campaignId,
    this.shopId,
    this.campaignName,
  });

  RedeemGiftBasicData.forOwner({required this.campaignId, this.campaignName})
    : shopId = null;

  RedeemGiftBasicData.forSharedVendor({
    required this.campaignId,
    this.campaignName,
  }) : shopId = null;

  RedeemGiftBasicData.forStaff({
    required this.campaignId,
    required this.shopId,
    this.campaignName,
  });

  final String campaignId;
  final String? shopId;
  final String? campaignName;
}

enum RedeemerType { owner, sharedVendor, staff }

class RedeemUserGiftPage extends ConsumerStatefulWidget {
  const RedeemUserGiftPage.owner({
    required this.campaignDetailsUIData,
    super.key,
  }) : redeemerType = RedeemerType.owner;

  const RedeemUserGiftPage.sharedVendor({
    required this.campaignDetailsUIData,
    super.key,
  }) : redeemerType = RedeemerType.sharedVendor;

  const RedeemUserGiftPage.staff({
    required this.campaignDetailsUIData,
    super.key,
  }) : redeemerType = RedeemerType.staff;

  final RedeemerType redeemerType;
  final RedeemGiftBasicData campaignDetailsUIData;

  @override
  ConsumerState<RedeemUserGiftPage> createState() => _RedeemUserGiftState();
}

class _RedeemUserGiftState extends ConsumerState<RedeemUserGiftPage>
    with SingleTickerProviderStateMixin {
  MobileScannerController? controller;
  bool hasScanned = false;
  bool isFlashOn = false;
  late AnimationController _laserController;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    _laserController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controller?.dispose();
    _laserController.dispose();
    super.dispose();
  }

  void _handleScannedCode(String scannedCode) {
    final controller = ref.read(redeemGiftControllerProvider.notifier);
    switch (widget.redeemerType) {
      case RedeemerType.owner:
        controller.handleScannedCodeAsOwner(
          giftId: scannedCode,
          campaignId: widget.campaignDetailsUIData.campaignId,
        );
        break;
      case RedeemerType.sharedVendor:
        controller.handleScannedCodeAsSharedVendor(
          userGiftId: scannedCode,
          campaignId: widget.campaignDetailsUIData.campaignId,
        );
        break;
      case RedeemerType.staff:
        if (widget.campaignDetailsUIData.shopId == null) {
          throw Exception('ShopId is required for staff redeemer type');
        }
        controller.handleScannedCodeAsStaff(
          userId: scannedCode,
          campaignId: widget.campaignDetailsUIData.campaignId,
          shopId: widget.campaignDetailsUIData.shopId!,
        );
        break;
    }
  }

  void _showScanResultDialog(String scannedCode) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: _AppColors.slate900.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, anim1, anim2, child) {
        return BackdropFilter(
          filter: ColorFilter.mode(
            Colors.black.withOpacity(0.1 * anim1.value),
            BlendMode.srcOver,
          ),
          child: Transform.scale(
            scale: 0.95 + (0.05 * anim1.value),
            child: Opacity(
              opacity: anim1.value,
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.all(24),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _AppColors.slate100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.qr_code,
                        color: _AppColors.slate500,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'QR Code Detected',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _AppColors.slate900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Do you want to proceed with this user?',
                      style: TextStyle(
                        fontSize: 14,
                        color: _AppColors.slate500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _AppColors.slate50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _AppColors.slate200),
                      ),
                      child: Text(
                        scannedCode,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _AppColors.slate700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _buildOutlineButton(
                            'Cancel',
                            onTap: () {
                              Navigator.of(context).pop();
                              setState(() => hasScanned = false);
                              this.controller?.start();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildGradientButton(
                            'Continue',
                            onTap: () {
                              Navigator.of(context).pop();
                              _handleScannedCode(scannedCode);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLoadingDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: _AppColors.slate900.withOpacity(0.4),
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
          filter: ColorFilter.mode(
            Colors.black.withOpacity(0.1),
            BlendMode.srcOver,
          ),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: const AlwaysStoppedAnimation(
                          _AppColors.brandStart,
                        ),
                        backgroundColor: _AppColors.slate200,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Processing...',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _AppColors.slate700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showResultDialog({required bool isSuccess, required String message}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: _AppColors.slate900.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * anim1.value),
          child: Opacity(
            opacity: anim1.value,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              contentPadding: const EdgeInsets.all(24),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: isSuccess
                          ? _AppColors.green100
                          : _AppColors.red100,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Icon(
                      isSuccess ? Icons.check_circle : Icons.warning,
                      color: isSuccess
                          ? _AppColors.green600
                          : _AppColors.red600,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isSuccess ? 'Success' : 'Error',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _AppColors.slate900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _AppColors.slate600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: _buildDarkButton(
                      'Scan Another',
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() => hasScanned = false);
                        controller?.start();
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: _buildOutlineButton(
                      'Exit',
                      onTap: () {
                        final navigator = Navigator.of(context);
                        navigator.pop();
                        navigator.pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOutlineButton(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _AppColors.slate200),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _AppColors.slate600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          gradient: _AppColors.brandGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: _AppColors.brandStart.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDarkButton(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: _AppColors.slate900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(redeemGiftControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          Navigator.of(context, rootNavigator: true).pop();
          _showResultDialog(
            isSuccess: true,
            message: 'User scanned and gift redeemed successfully!',
          );
          setState(() => hasScanned = false);
          controller?.start();
        },
        loading: () => _showLoadingDialog(),
        error: (error, stack) {
          Navigator.of(context, rootNavigator: true).pop();
          setState(() => hasScanned = false);
          controller?.start();
          if (error is! FirebaseFunctionsException) {
            _showResultDialog(
              isSuccess: false,
              message: 'Error redeeming gift. Please try again.',
            );
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error redeeming gift: ${error.message}'),
              backgroundColor: _AppColors.red600,
            ),
          );
        },
      );
    });

    final roleName = switch (widget.redeemerType) {
      RedeemerType.owner => 'Owner',
      RedeemerType.sharedVendor => 'Shared Vendor',
      RedeemerType.staff => 'Staff',
    };

    return Scaffold(
      backgroundColor: _AppColors.slate50,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: _AppColors.slate50.withOpacity(0.9),
                border: const Border(
                  bottom: BorderSide(color: _AppColors.slate200),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: _AppColors.slate500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Redeem Gift',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _AppColors.slate900,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _AppColors.orange50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _AppColors.orange100),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: _AppColors.orange500,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          roleName,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _AppColors.slate700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Campaign Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _AppColors.slate100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: _AppColors.brandGradient,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: _AppColors.brandStart.withOpacity(0.3),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.card_giftcard,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'CAMPAIGN',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: _AppColors.slate400,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.campaignDetailsUIData.campaignName ??
                                      'N/A',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: _AppColors.slate900,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'ID: ${widget.campaignDetailsUIData.campaignId}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: _AppColors.slate500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Instructions
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _AppColors.blue50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _AppColors.blue100),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info,
                            color: _AppColors.blue500,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              "Position the user's QR code within the frame below to scan automatically.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _AppColors.blue700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Scanner Viewport
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _AppColors.slate900,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: _AppColors.slate800,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Stack(
                            children: [
                              MobileScanner(
                                controller: controller,
                                onDetect: (BarcodeCapture capture) {
                                  if (!hasScanned &&
                                      capture.barcodes.isNotEmpty) {
                                    final code =
                                        capture.barcodes.first.rawValue;
                                    if (code != null) {
                                      hasScanned = true;
                                      controller?.stop();
                                      _showScanResultDialog(code);
                                    }
                                  }
                                },
                              ),
                              Container(color: Colors.black.withOpacity(0.4)),
                              // Reticle
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        _buildCorner(Alignment.topLeft),
                                        _buildCorner(Alignment.topRight),
                                        _buildCorner(Alignment.bottomLeft),
                                        _buildCorner(Alignment.bottomRight),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Laser Line
                              AnimatedBuilder(
                                animation: _laserController,
                                builder: (context, child) {
                                  final top =
                                      32 +
                                      (_laserController.value *
                                          (MediaQuery.of(context).size.height *
                                              0.35));
                                  return Positioned(
                                    top: top,
                                    left: 40,
                                    right: 40,
                                    child: Opacity(
                                      opacity:
                                          (_laserController.value < 0.1 ||
                                              _laserController.value > 0.9)
                                          ? _laserController.value < 0.1
                                                ? _laserController.value * 10
                                                : (1 - _laserController.value) *
                                                      10
                                          : 1,
                                      child: Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: _AppColors.brandStart,
                                          borderRadius: BorderRadius.circular(
                                            1,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: _AppColors.brandStart,
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                            ),
                                            BoxShadow(
                                              color: _AppColors.brandStart,
                                              blurRadius: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Controls
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller?.toggleTorch();
                              setState(() => isFlashOn = !isFlashOn);
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: isFlashOn
                                    ? _AppColors.yellow50
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isFlashOn
                                      ? _AppColors.yellow200
                                      : _AppColors.slate200,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isFlashOn
                                        ? Icons.flash_on
                                        : Icons.flash_off,
                                    size: 18,
                                    color: isFlashOn
                                        ? _AppColors.yellow600
                                        : _AppColors.slate600,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    isFlashOn ? 'Flash On' : 'Flash Off',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: isFlashOn
                                          ? _AppColors.yellow600
                                          : _AppColors.slate600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                hasScanned = false;
                                isFlashOn = false;
                              });
                              controller?.start();
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: _AppColors.slate900,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: _AppColors.slate200,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Reset',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }

  Widget _buildCorner(Alignment alignment) {
    final isTop =
        alignment == Alignment.topLeft || alignment == Alignment.topRight;
    final isLeft =
        alignment == Alignment.topLeft || alignment == Alignment.bottomLeft;
    return Positioned(
      top: isTop ? 0 : null,
      bottom: !isTop ? 0 : null,
      left: isLeft ? 0 : null,
      right: !isLeft ? 0 : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border(
            top: isTop
                ? const BorderSide(color: _AppColors.brandStart, width: 4)
                : BorderSide.none,
            bottom: !isTop
                ? const BorderSide(color: _AppColors.brandStart, width: 4)
                : BorderSide.none,
            left: isLeft
                ? const BorderSide(color: _AppColors.brandStart, width: 4)
                : BorderSide.none,
            right: !isLeft
                ? const BorderSide(color: _AppColors.brandStart, width: 4)
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topLeft: alignment == Alignment.topLeft
                ? const Radius.circular(12)
                : Radius.zero,
            topRight: alignment == Alignment.topRight
                ? const Radius.circular(12)
                : Radius.zero,
            bottomLeft: alignment == Alignment.bottomLeft
                ? const Radius.circular(12)
                : Radius.zero,
            bottomRight: alignment == Alignment.bottomRight
                ? const Radius.circular(12)
                : Radius.zero,
          ),
        ),
      ),
    );
  }
}
