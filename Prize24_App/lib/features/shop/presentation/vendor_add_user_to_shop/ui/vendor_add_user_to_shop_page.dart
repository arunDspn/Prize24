import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/shop/presentation/vendor_add_user_to_shop/view_model/add_users_to_club_by_vendor_controller.dart';

/// Design colors matching the HTML theme
class _DesignColors {
  // Page colors
  static const Color pageBg = Color(0xFFF8FAFC); // slate-50
  static const Color pageCard = Color(0xFFFFFFFF); // white
  static const Color pageInput = Color(0xFFF1F5F9); // slate-100
  static const Color pageSubtle = Color(0xFFE2E8F0); // slate-200

  // Text colors
  static const Color textMain = Color(0xFF1E293B); // slate-800
  static const Color textSub = Color(0xFF64748B); // slate-500
  static const Color textAccent = Color(0xFF0F172A); // slate-900

  // Brand gradient colors
  static const Color brandStart = Color(0xFFEF4444); // red-500
  static const Color brandEnd = Color(0xFFF97316); // orange-500

  // Success colors (green)
  static const Color successBg = Color(0xFFECFDF5); // green-50
  static const Color successBorder = Color(0xFFBBF7D0); // green-200
  static const Color successIcon = Color(0xFF16A34A); // green-600
  static const Color successText = Color(0xFF166534); // green-800
  static const Color successTextLight = Color(0xFF15803D); // green-700

  // Error colors (red)
  static const Color errorBg = Color(0xFFFEF2F2); // red-50
  static const Color errorBorder = Color(0xFFFECACA); // red-200
  static const Color errorIcon = Color(0xFFEF4444); // red-500
  static const Color errorText = Color(0xFFB91C1C); // red-700

  // Info colors (blue)
  static const Color infoBg = Color(0xFFEFF6FF); // blue-50
  static const Color infoBorder = Color(0xFFDBEAFE); // blue-100
  static const Color infoIcon = Color(0xFF3B82F6); // blue-500
  static const Color infoText = Color(0xFF1D4ED8); // blue-700

  static const Gradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

class VendorAddUserToShopPage extends ConsumerStatefulWidget {
  const VendorAddUserToShopPage({
    required this.shopId,
    super.key,
  });

  final String shopId;

  @override
  ConsumerState<VendorAddUserToShopPage> createState() =>
      _VendorAddUserToClubPageState();
}

class _VendorAddUserToClubPageState
    extends ConsumerState<VendorAddUserToShopPage> {
  MobileScannerController cameraController = MobileScannerController();

  /// Holds the scanned QR code value
  String? scannedCode;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final code = barcode.rawValue;
      if (code != null) {
        // Stop the scanner to prevent multiple reads
        cameraController.stop();
        // Handle the scanned QR code
        setState(() {
          scannedCode = code;
        });
        _showScannedDialog(code);
        break;
      }
    }
  }

  void _showScannedDialog(String code) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _DesignColors.pageCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Add User to Shop',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _DesignColors.textMain,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add this user to the shop?',
                style: TextStyle(
                  fontSize: 15,
                  color: _DesignColors.textSub,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _DesignColors.pageInput,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      color: _DesignColors.textSub,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        code,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _DesignColors.textMain,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _DesignColors.textSub,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                cameraController.start(); // Restart scanner
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: _DesignColors.brandGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.of(context).pop();
                    // Add user to club using the controller
                    ref
                        .read(addUsersToClubByVendorControllerProvider.notifier)
                        .addUserToShop(
                          shopId: widget.shopId,
                          userId: code,
                        );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'Add User',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      addUsersToClubByVendorControllerProvider,
      (previous, next) {
        next.maybeWhen(
          error: (error, stackTrace) {
            Navigator.of(context).pop(); // Close loading dialog
            _showToast(context, 'Error adding user to shop', false);
          },
          data: (_) {
            Navigator.of(context).pop();
            _showToast(context, 'User added to shop successfully!', true);
          },
          loading: () {
            // Show loading indicator in dialog
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: _DesignColors.pageCard,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  content: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: _DesignColors.brandGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Adding user...',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: _DesignColors.textMain,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          orElse: () {},
        );
      },
    );
    return Scaffold(
      backgroundColor: _DesignColors.pageBg,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Instruction Text
              const Text(
                "Point your camera at the user's QR code to add them to the shop",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _DesignColors.textMain,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Scanner Viewport
              Expanded(
                child: _buildQrScanner(),
              ),

              const SizedBox(height: 16),

              // Scanned Result Card
              if (scannedCode != null && scannedCode!.isNotEmpty)
                _buildScannedResultCard(),

              // Footer Actions
              _buildFooterActions(context),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: _DesignColors.pageCard.withOpacity(0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: const Text(
        'Add User to Shop',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _DesignColors.textMain,
          letterSpacing: -0.3,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => cameraController.toggleTorch(),
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _DesignColors.pageInput,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.flash_on,
              color: _DesignColors.textSub,
              size: 20,
            ),
          ),
        ),
        IconButton(
          onPressed: () => cameraController.switchCamera(),
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _DesignColors.pageInput,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.cameraswitch,
              color: _DesignColors.textSub,
              size: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.close,
              color: _DesignColors.textSub,
              size: 24,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: _DesignColors.pageInput,
        ),
      ),
    );
  }

  Widget _buildQrScanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Actual QR Scanner
          Positioned.fill(
            child: MobileScanner(
              controller: cameraController,
              onDetect: _onDetect,
            ),
          ),

          // Corner Markers Overlay
          Positioned(
            top: 32,
            left: 32,
            right: 32,
            bottom: 32,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  // Top Left Corner
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _buildCornerMarker(
                      borderTop: true,
                      borderLeft: true,
                    ),
                  ),
                  // Top Right Corner
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _buildCornerMarker(
                      borderTop: true,
                      borderRight: true,
                    ),
                  ),
                  // Bottom Left Corner
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: _buildCornerMarker(
                      borderBottom: true,
                      borderLeft: true,
                    ),
                  ),
                  // Bottom Right Corner
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _buildCornerMarker(
                      borderBottom: true,
                      borderRight: true,
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

  Widget _buildCornerMarker({
    bool borderTop = false,
    bool borderBottom = false,
    bool borderLeft = false,
    bool borderRight = false,
  }) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          top: borderTop
              ? const BorderSide(color: _DesignColors.brandStart, width: 4)
              : BorderSide.none,
          bottom: borderBottom
              ? const BorderSide(color: _DesignColors.brandStart, width: 4)
              : BorderSide.none,
          left: borderLeft
              ? const BorderSide(color: _DesignColors.brandStart, width: 4)
              : BorderSide.none,
          right: borderRight
              ? const BorderSide(color: _DesignColors.brandStart, width: 4)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft:
              borderTop && borderLeft ? const Radius.circular(8) : Radius.zero,
          topRight:
              borderTop && borderRight ? const Radius.circular(8) : Radius.zero,
          bottomLeft: borderBottom && borderLeft
              ? const Radius.circular(8)
              : Radius.zero,
          bottomRight: borderBottom && borderRight
              ? const Radius.circular(8)
              : Radius.zero,
        ),
      ),
    );
  }

  Widget _buildScannedResultCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _DesignColors.successBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _DesignColors.successBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _DesignColors.successBorder.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: _DesignColors.successIcon,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Scanned Successfully!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _DesignColors.successText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'User ID: $scannedCode',
                  style: const TextStyle(
                    fontSize: 12,
                    color: _DesignColors.successTextLight,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterActions(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),

        // Info Box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _DesignColors.infoBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _DesignColors.infoBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.info_outline,
                  color: _DesignColors.infoIcon,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Ask the user to show their QR code from the app to add them to your shop.',
                  style: TextStyle(
                    fontSize: 14,
                    color: _DesignColors.infoText,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Cancel Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton(
            onPressed: () => context.pop(),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _DesignColors.textSub,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showToast(BuildContext context, String message, bool isSuccess) {
    showToastAtTop(context, message, isSuccess);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Row(
    //       children: [
    //         Icon(
    //           isSuccess ? Icons.check_circle : Icons.warning_amber_rounded,
    //           color: Colors.white,
    //           size: 20,
    //         ),
    //         const SizedBox(width: 12),
    //         Expanded(
    //           child: Text(
    //             message,
    //             style: const TextStyle(
    //               fontSize: 14,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     backgroundColor:
    //         isSuccess ? _DesignColors.successIcon : _DesignColors.textAccent,
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     margin: const EdgeInsets.all(16),
    //   ),
    // );
  }
}
