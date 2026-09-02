import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/configs/theme_config.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/vendor_scan_user/view_model/vendor_scan_user_controller.dart';
import 'package:prize24_app/features/shop/presentation/staff_scan_loyality/view_model/user_checkin_by_staff_controller.dart';

class StaffScanLoyalityPage extends ConsumerStatefulWidget {
  const StaffScanLoyalityPage({
    required this.campaignId,
    required this.shopId,
    super.key,
  });

  final String? campaignId;
  final String shopId;

  @override
  ConsumerState<StaffScanLoyalityPage> createState() =>
      _StaffScanLoyalityPageState();
}

class _StaffScanLoyalityPageState extends ConsumerState<StaffScanLoyalityPage>
    with SingleTickerProviderStateMixin {
  MobileScannerController cameraController = MobileScannerController();
  final TextEditingController _manualCodeController = TextEditingController();

  /// Holds the scanned QR code value
  /// User ID
  String? scannedCode;
  bool _isScannerDisabled = false;

  /// Animation controller for laser scan line
  late AnimationController _scanAnimationController;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    _scanAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _scanAnimation = Tween<double>(begin: 0.05, end: 0.95).animate(
      CurvedAnimation(parent: _scanAnimationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    cameraController.dispose();
    _manualCodeController.dispose();
    super.dispose();
  }

  void _rescan() {
    setState(() {
      _isScannerDisabled = false;
      scannedCode = null;
    });
    cameraController.start();
    _scanAnimationController.repeat();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isScannerDisabled) return;
    final barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final code = barcode.rawValue;
      if (code != null) {
        // Stop the scanner to prevent multiple reads
        cameraController.stop();
        _scanAnimationController.stop();
        setState(() {
          _isScannerDisabled = true;
          scannedCode = code;
        });
        _showConfirmDialog(code);
        break;
      }
    }
  }

  void _showConfirmDialog(String code) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: const Color(0xFF0F172A).withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return BackdropFilter(
          filter: ColorFilter.mode(
            Colors.black.withOpacity(0.4 * animation.value),
            BlendMode.srcOver,
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.95,
              end: 1.0,
            ).animate(curvedAnimation),
            child: FadeTransition(
              opacity: animation,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  constraints: const BoxConstraints(maxWidth: 400),
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            Icons.qr_code_2_rounded,
                            size: 24,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        const Text(
                          'Check In Club',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Subtitle
                        Row(
                          children: [
                            const Text(
                              'Confirm check-in for user ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                code.length > 12
                                    ? '${code.substring(0, 12)}...'
                                    : code,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF475569),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Text(
                              '?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        ThemeConfig.primaryColor,
                                        ThemeConfig.secondaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ThemeConfig.primaryColor
                                            .withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                            userCheckinByStaffControllerProvider
                                                .notifier,
                                          )
                                          .checkInUser(
                                            userId: code,
                                            shopId: widget.shopId,
                                          );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
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
              ),
            ),
          ),
        );
      },
    );
  }

  void _showGiftDialog(String giftName) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: const Color(0xFF0F172A).withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return BackdropFilter(
          filter: ColorFilter.mode(
            Colors.black.withOpacity(0.4 * animation.value),
            BlendMode.srcOver,
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.95,
              end: 1.0,
            ).animate(curvedAnimation),
            child: FadeTransition(
              opacity: animation,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  constraints: const BoxConstraints(maxWidth: 400),
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Gift Icon
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Icon(
                            Icons.card_giftcard_rounded,
                            size: 32,
                            color: Colors.green.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        const Text(
                          'Scan Successful',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Gift name
                        Text(
                          giftName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF475569),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // OK Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F172A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLoadingDialog(String text) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Loading',
      barrierColor: const Color(0xFF0F172A).withOpacity(0.4),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        ThemeConfig.primaryColor,
                      ),
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF475569),
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

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(vendorScanUserControllerProvider, (previous, next) {
        next.when(
          data: (data) {
            if (data != null) {
              // Handle successful scan avail response if needed

              // Dismiss any open dialogs
              Navigator.of(context).pop();

              // Show success message in dialog
              _showGiftDialog(data.data?.giftName ?? 'No Gift');
            }
          },
          loading: () {
            // Optionally show a loading indicator
            _showLoadingDialog('Availing gift...');
          },
          error: (error, stack) {
            // Dismiss any open dialogs
            Navigator.of(context).pop();
            showToastAtTop(context, 'Error during scan', false);
          },
        );
      })
      ..listen(userCheckinByStaffControllerProvider, (previous, next) {
        next.when(
          data: (data) {
            if (data != null) {
              // Close any open dialogs
              Navigator.of(context).pop();

              if (data.success) {
                // Gift Day check
                if (data.data != null && data.data!.isGiftDay) {
                  if (widget.campaignId == null) {
                    // Show gift dialog since no campaign, just sucess information
                    _showGiftDialog(
                      ' Gift Day! Check-in successful with ${data.data!.cumulativeStreak} points! No campaign associated, so no gift details available.',
                    );
                  } else {
                    showToastAtTop(
                      context,
                      'Check-in successful! Points: ${data.data!.cumulativeStreak}. Its a Gift Day!.',
                      true,
                    );

                    // Call for gift avail
                    ref
                        .read(vendorScanUserControllerProvider.notifier)
                        .handleScannedCodeByStaff(
                          shopId: widget.shopId,
                          userId: scannedCode!,
                          campaignId: widget.campaignId!,
                          availedViaStreak: true,
                        );
                  }
                } else {
                  showToastAtTop(
                    context,
                    'Check-in successful! Points: ${data.data!.cumulativeStreak}.',
                    true,
                  );
                }
              } else {
                final error = data.error ?? 'Check-in failed';
                showToastAtTop(context, 'Error during check-in', false);
              }
            }
          },
          loading: () {
            // Close any open dialogs
            Navigator.of(context, rootNavigator: true).pop();
            // Optionally show a loading indicator dialog
            _showLoadingDialog('Checking in...');
          },
          error: (error, stack) {
            // Close any open dialogs
            Navigator.of(context, rootNavigator: true).pop();

            if (error is FirebaseFunctionsException &&
                error.code == 'already-exists') {
              showToastAtTop(
                context,
                'User has already checked in today',
                false,
              );
            } else {
              showToastAtTop(context, 'Error during check-in', false);
            }
          },
        );
      });

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            _buildAppBar(),
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Instructions Card
                    _buildInstructionsCard(),
                    const SizedBox(height: 20),
                    // Scanner Viewport - fixed height
                    SizedBox(height: 280, child: _buildScannerViewport()),
                    const SizedBox(height: 16),
                    // Scanned result badge
                    if (scannedCode != null && scannedCode!.isNotEmpty)
                      _buildScannedResultBadge(),
                    // Divider
                    _buildOrDivider(),
                    const SizedBox(height: 16),
                    // Manual Entry
                    _buildManualEntrySection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannedResultBadge() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_rounded,
              color: Colors.green.shade600,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scanned Successfully!',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'User ID: $scannedCode',
                  style: TextStyle(fontSize: 12, color: Colors.green.shade700),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (_isScannerDisabled) ...[
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: _rescan,
              icon: const Icon(
                Icons.refresh_rounded,
                size: 16,
                color: ThemeConfig.primaryColor,
              ),
              label: const Text(
                'Rescan',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: ThemeConfig.primaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR ENTER MANUALLY',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
      ],
    );
  }

  Widget _buildManualEntrySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _manualCodeController,
          style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
          decoration: InputDecoration(
            hintText: 'Enter Customer User ID',
            hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
            filled: true,
            fillColor: const Color(0xFFF1F5F9),
            prefixIcon: const Icon(
              Icons.person_outline_rounded,
              color: Color(0xFF64748B),
              size: 20,
            ),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _manualCodeController,
              builder: (context, value, _) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: Color(0xFF94A3B8),
                    size: 18,
                  ),
                  onPressed: () => _manualCodeController.clear(),
                );
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: ThemeConfig.primaryColor,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          onSubmitted: (_) => _handleManualCheckin(),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 52,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ThemeConfig.primaryColor, ThemeConfig.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: ThemeConfig.primaryColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _handleManualCheckin,
                child: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.how_to_reg_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Check In',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleManualCheckin() {
    final code = _manualCodeController.text.trim();
    if (code.isEmpty) {
      showToastAtTop(context, 'Please enter a Customer User ID', false);
      return;
    }
    setState(() {
      scannedCode = code;
    });
    _showConfirmDialog(code);
  }

  Widget _buildAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withOpacity(0.9),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Back button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  size: 28,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Title
          const Text(
            'Scan for Check-in',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),
          // Staff Mode Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.storefront_rounded,
                  size: 12,
                  color: Color(0xFF64748B),
                ),
                SizedBox(width: 6),
                Text(
                  'STAFF MODE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF475569),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDBEAFE), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            child: const Icon(
              Icons.info_rounded,
              size: 20,
              color: Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Ask the customer to show their Loyalty QR Code to check them in.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1D4ED8),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerViewport() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0xFF1E293B), width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Camera Feed
              Positioned.fill(
                child: MobileScanner(
                  controller: cameraController,
                  onDetect: _onDetect,
                ),
              ),
              // Dark overlay
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
              // Reticle Frame
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
                        // Top Left Corner
                        Positioned(
                          top: -1,
                          left: -1,
                          child: _buildCorner(
                            borderTop: true,
                            borderLeft: true,
                          ),
                        ),
                        // Top Right Corner
                        Positioned(
                          top: -1,
                          right: -1,
                          child: _buildCorner(
                            borderTop: true,
                            borderRight: true,
                          ),
                        ),
                        // Bottom Left Corner
                        Positioned(
                          bottom: -1,
                          left: -1,
                          child: _buildCorner(
                            borderBottom: true,
                            borderLeft: true,
                          ),
                        ),
                        // Bottom Right Corner
                        Positioned(
                          bottom: -1,
                          right: -1,
                          child: _buildCorner(
                            borderBottom: true,
                            borderRight: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Laser Scan Line
              AnimatedBuilder(
                animation: _scanAnimation,
                builder: (context, child) {
                  // Calculate the scannable area (inside the reticle padding)
                  final scanAreaStart = 40.0;
                  final scanAreaHeight =
                      size - 80; // 32 padding on each side + some margin
                  return Positioned(
                    left: 40,
                    right: 40,
                    top:
                        scanAreaStart + (_scanAnimation.value * scanAreaHeight),
                    child: Opacity(
                      opacity: _getLaserOpacity(_scanAnimation.value),
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ThemeConfig.primaryColor.withOpacity(0),
                              ThemeConfig.primaryColor,
                              ThemeConfig.primaryColor.withOpacity(0),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeConfig.primaryColor.withOpacity(0.8),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: ThemeConfig.primaryColor.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Disabled Scanner Overlay with Rescan Button
              if (_isScannerDisabled)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.qr_code_scanner_rounded,
                            color: Colors.white70,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Scanner Disabled',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Tap below to scan another QR code',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _rescan,
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'Rescan QR Code',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeConfig.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  double _getLaserOpacity(double value) {
    if (value < 0.1) return value * 10;
    if (value > 0.9) return (1 - value) * 10;
    return 1.0;
  }

  Widget _buildCorner({
    bool borderTop = false,
    bool borderBottom = false,
    bool borderLeft = false,
    bool borderRight = false,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border(
          top: borderTop
              ? const BorderSide(color: ThemeConfig.primaryColor, width: 4)
              : BorderSide.none,
          bottom: borderBottom
              ? const BorderSide(color: ThemeConfig.primaryColor, width: 4)
              : BorderSide.none,
          left: borderLeft
              ? const BorderSide(color: ThemeConfig.primaryColor, width: 4)
              : BorderSide.none,
          right: borderRight
              ? const BorderSide(color: ThemeConfig.primaryColor, width: 4)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: borderTop && borderLeft
              ? const Radius.circular(12)
              : Radius.zero,
          topRight: borderTop && borderRight
              ? const Radius.circular(12)
              : Radius.zero,
          bottomLeft: borderBottom && borderLeft
              ? const Radius.circular(12)
              : Radius.zero,
          bottomRight: borderBottom && borderRight
              ? const Radius.circular(12)
              : Radius.zero,
        ),
      ),
    );
  }
}
