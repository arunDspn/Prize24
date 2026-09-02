import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_send_friend_request/ui/components/vendor_scanner_for_friend_request.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_send_friend_request/view_model/vendor_send_friend_request_controller.dart';

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

/// Page for vendors to send friend requests to other vendors
/// Supports both QR code scanning and manual vendor ID input
class VendorSendFriendRequestPage extends ConsumerStatefulWidget {
  const VendorSendFriendRequestPage({super.key});

  @override
  ConsumerState<VendorSendFriendRequestPage> createState() =>
      _VendorSendFriendRequestPageState();
}

class _VendorSendFriendRequestPageState
    extends ConsumerState<VendorSendFriendRequestPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isManualInput = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _scannedData; // Local state for QR scanned data

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _sendFriendRequest() {
    final vendorId =
        _isManualInput ? _textController.text.trim() : _scannedData;

    if (vendorId == null || vendorId.isEmpty) {
      setState(() {
        _errorMessage = 'Please scan QR code or enter partner ID';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    ref
        .read(vendorSendFriendRequestControllerProvider.notifier)
        .sendFriendRequest(vendorId);
  }

  void _onQrCodeScanned(String data) {
    setState(() {
      _scannedData = data;
      _textController.text = data;
      _isManualInput = true; // Switch to manual input to show the scanned data
    });
  }

  void _hideError() {
    setState(() {
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      vendorSendFriendRequestControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (data) {
            setState(() {
              _isLoading = false;
              _errorMessage = null;
            });
            // Show success toast
            _showToast(context, 'Friend request sent successfully!', true);
          },
          error: (error, stack) {
            setState(() {
              if (error is FirebaseFunctionsException) {
                _errorMessage = error.message ?? 'An error occurred';
              } else {
                _errorMessage = error.toString();
              }
              _isLoading = false;
            });
          },
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

              // Error Banner
              if (_errorMessage != null) _buildErrorBanner(),

              // Toggle Switch
              _buildToggleSwitch(),

              const SizedBox(height: 24),

              // Content area - QR Scanner or Text Input
              Expanded(
                child: _isManualInput ? _buildManualInput() : _buildQrScanner(),
              ),

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
        'Add Friend',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _DesignColors.textMain,
          letterSpacing: -0.3,
        ),
      ),
      actions: [
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

  Widget _buildErrorBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _DesignColors.errorBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _DesignColors.errorBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.warning_amber_rounded,
              color: _DesignColors.errorIcon,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _errorMessage!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _DesignColors.errorText,
              ),
            ),
          ),
          GestureDetector(
            onTap: _hideError,
            child: const Icon(
              Icons.close,
              color: _DesignColors.errorIcon,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSwitch() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _DesignColors.pageSubtle.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleTab(
              label: 'Scan QR Code',
              isActive: !_isManualInput,
              onTap: () {
                setState(() {
                  _isManualInput = false;
                  _errorMessage = null;
                });
              },
            ),
          ),
          Expanded(
            child: _buildToggleTab(
              label: 'Enter ID',
              isActive: _isManualInput,
              onTap: () {
                setState(() {
                  _isManualInput = true;
                  _errorMessage = null;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTab({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: isActive ? _DesignColors.brandGradient : null,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: _DesignColors.brandStart.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? Colors.white : _DesignColors.textSub,
          ),
        ),
      ),
    );
  }

  Widget _buildQrScanner() {
    return Column(
      children: [
        const Text(
          "Point your camera at another partner's QR code",
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
          child: Container(
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
                  child: VendorQrScannerForFriendRequest(
                    onScanned: _onQrCodeScanned,
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
          ),
        ),

        const SizedBox(height: 16),

        // Scanned Result Card
        if (_scannedData != null && _scannedData!.isNotEmpty)
          _buildScannedResultCard(),
      ],
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
                  'Partner ID: $_scannedData',
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

  Widget _buildManualInput() {
    return Column(
      children: [
        const Text(
          'Enter another partner ID manually',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _DesignColors.textMain,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Input Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                'PARTNER ID',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _DesignColors.textSub,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: _DesignColors.pageInput,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.transparent),
              ),
              child: TextField(
                controller: _textController,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _DesignColors.textMain,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter Partner ID',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _DesignColors.textSub.withOpacity(0.5),
                  ),
                  prefixIcon: const Icon(
                    Icons.person_add_outlined,
                    color: _DesignColors.textSub,
                    size: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: _DesignColors.brandStart,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

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
                  'Ask the another partner to show their QR code or share their Partner ID with you directly.',
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
      ],
    );
  }

  Widget _buildFooterActions(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),

        // Send Friend Request Button
        _GradientButton(
          label: 'Send Friend Request',
          isLoading: _isLoading,
          onPressed: _sendFriendRequest,
        ),

        const SizedBox(height: 12),

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
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Row(
    //       children: [
    //         Icon(
    //           isSuccess ? Icons.check_circle : Icons.info_outline,
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
    //     backgroundColor: _DesignColors.textAccent,
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     margin: const EdgeInsets.all(16),
    //   ),
    // );
    showToastAtTop(context, message, isSuccess);
  }
}

/// Gradient action button matching the HTML design
class _GradientButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  const _GradientButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: _DesignColors.brandGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _DesignColors.brandStart.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
