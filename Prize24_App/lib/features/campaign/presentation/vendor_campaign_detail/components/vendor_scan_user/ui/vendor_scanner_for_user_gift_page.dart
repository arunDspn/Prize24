import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/vendor_scan_user/view_model/vendor_scan_user_controller.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/view_model/current_campaign_selection_controller.dart';

// ============================================================================
// Design System Constants (from HTML Tailwind config)
// ============================================================================

class _ScannerColors {
  // Slate palette
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Brand gradient
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);

  // Blue info
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue700 = Color(0xFF1D4ED8);

  // Orange badge
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange500 = Color(0xFFF97316);

  // Yellow flash
  static const Color yellow50 = Color(0xFFFEFCE8);
  static const Color yellow200 = Color(0xFFFEF08A);
  static const Color yellow600 = Color(0xFFCA8A04);

  // Success/Error
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green600 = Color(0xFF16A34A);
  static const Color red100 = Color(0xFFFEE2E2);
  static const Color red600 = Color(0xFFDC2626);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

class _ScannerShadows {
  static List<BoxShadow> soft = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 20,
      offset: const Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static List<BoxShadow> glow = [
    BoxShadow(
      color: _ScannerColors.brandStart.withOpacity(0.3),
      blurRadius: 20,
    ),
  ];
}

class AvailGiftUIData {
  // Constructors for different scenarios
  // For Owner and Shared Vendor (no shopId)
  factory AvailGiftUIData.forOwner({
    required String campaignId,
    required String campaignName,
  }) {
    return AvailGiftUIData._(
      campaignId: campaignId,
      campaignName: campaignName,
    );
  }

  // For Staff
  factory AvailGiftUIData.forStaff({
    required String campaignId,
    required String campaignName,
    required String shopId,
  }) {
    return AvailGiftUIData._(
      campaignId: campaignId,
      campaignName: campaignName,
      shopId: shopId,
    );
  }

  AvailGiftUIData._({
    required this.campaignId,
    required this.campaignName,
    this.shopId,
  });
  final String campaignId;
  final String campaignName;
  String? shopId;
}

enum AvailerType { owner, sharedVendor, staff }

/// Used to avail a gift to user by scanning their QR code
class ScannerToAvailGiftPage extends ConsumerStatefulWidget {
  // const ScannerToAvailGiftPage(this.campaignDetailsUIData, {super.key});

  // Named constructor based on AvailerType
  const ScannerToAvailGiftPage.owner({
    required this.campaignDetailsUIData,
    super.key,
  }) : availerType = AvailerType.owner;

  const ScannerToAvailGiftPage.sharedVendor({
    required this.campaignDetailsUIData,
    super.key,
  }) : availerType = AvailerType.sharedVendor;

  const ScannerToAvailGiftPage.staff({
    required this.campaignDetailsUIData,
    super.key,
  }) : availerType = AvailerType.staff;

  final AvailGiftUIData campaignDetailsUIData;
  final AvailerType availerType;

  @override
  ConsumerState<ScannerToAvailGiftPage> createState() =>
      _VendorScannerForUserGiftState();
}

class _VendorScannerForUserGiftState
    extends ConsumerState<ScannerToAvailGiftPage>
    with SingleTickerProviderStateMixin {
  MobileScannerController? controller;
  bool hasScanned = false;
  bool isFlashOn = false;
  late AnimationController _laserAnimationController;
  late Animation<double> _laserAnimation;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();

    // Initialize laser animation
    _laserAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _laserAnimation = Tween<double>(begin: 0.05, end: 0.95).animate(
      CurvedAnimation(parent: _laserAnimationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _laserAnimationController.dispose();
    controller?.dispose();
    super.dispose();
  }

  String get _roleLabel {
    switch (widget.availerType) {
      case AvailerType.owner:
        return 'Owner';
      case AvailerType.sharedVendor:
        return 'Shared Vendor';
      case AvailerType.staff:
        return 'Staff';
    }
  }

  void _rescan() {
    if (!mounted) return;

    setState(() {
      hasScanned = false;
      isFlashOn = false;
    });
    controller?.start();
    _laserAnimationController.repeat();
  }

  void _showScanResultDialog(String scannedCode) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: _ScannerColors.slate900.withOpacity(0.6),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ColorFilter.mode(
            Colors.black.withOpacity(0.1),
            BlendMode.darken,
          ),
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: _ScannerColors.slate100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.qr_code_rounded,
                      color: _ScannerColors.slate500,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  const Text(
                    'QR Code Detected',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _ScannerColors.slate900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Do you want to proceed with this user?',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _ScannerColors.slate500,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Scanned code display
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _ScannerColors.slate50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _ScannerColors.slate200),
                    ),
                    child: Text(
                      scannedCode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _ScannerColors.slate600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            _rescan();
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _ScannerColors.slate200,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: _ScannerColors.slate600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();

                            // Based on availer type call respective method
                            switch (widget.availerType) {
                              case AvailerType.owner:
                                {
                                  ref
                                      .read(
                                        vendorScanUserControllerProvider
                                            .notifier,
                                      )
                                      .handleScannedCodeByOwner(
                                        userId: scannedCode,
                                        campaignId: widget
                                            .campaignDetailsUIData
                                            .campaignId,
                                      );
                                  break;
                                }
                              case AvailerType.sharedVendor:
                                {
                                  ref
                                      .read(
                                        vendorScanUserControllerProvider
                                            .notifier,
                                      )
                                      .handleScannedCodeByOwner(
                                        userId: scannedCode,
                                        campaignId: widget
                                            .campaignDetailsUIData
                                            .campaignId,
                                      );
                                  break;
                                }

                              case AvailerType.staff:
                                {
                                  ref
                                      .read(
                                        vendorScanUserControllerProvider
                                            .notifier,
                                      )
                                      .handleScannedCodeByStaff(
                                        userId: scannedCode,
                                        campaignId: widget
                                            .campaignDetailsUIData
                                            .campaignId,
                                        shopId: widget
                                            .campaignDetailsUIData
                                            .shopId!,
                                      );
                                  break;
                                }
                            }
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: _ScannerColors.brandGradient,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: _ScannerShadows.glow,
                            ),
                            child: const Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
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
        );
      },
    );
  }

  void _showSuccessDialog({
    required String giftName,
    required String giftDescription,
    required String redemptionId,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: _ScannerColors.slate900.withOpacity(0.6),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: _ScannerColors.green100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: _ScannerColors.green600,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Gift Availed!',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _ScannerColors.slate900,
                  ),
                ),
                const SizedBox(height: 16),

                // Gift details card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _ScannerColors.slate50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _ScannerColors.slate100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'GIFT NAME',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _ScannerColors.slate400,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        giftName,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _ScannerColors.slate900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _ScannerColors.slate400,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        giftDescription,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _ScannerColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: _ScannerColors.slate200),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.confirmation_number_outlined,
                              color: _ScannerColors.slate400,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              redemptionId,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: _ScannerColors.slate500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Scan Another button
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _rescan();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _ScannerColors.slate900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Scan Another',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildExitButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: _ScannerColors.slate900.withOpacity(0.6),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Error Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: _ScannerColors.red100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_rounded,
                    color: _ScannerColors.red600,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Gift Availing Failed',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _ScannerColors.slate900,
                  ),
                ),
                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _ScannerColors.slate600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Scan Another button
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _rescan();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _ScannerColors.slate900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Scan Another',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildExitButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  void _exitToCampaignDetail(BuildContext dialogContext) {
    final navigator = Navigator.of(dialogContext);
    navigator.pop();
    navigator.pop();
  }

  Widget _buildExitButton(BuildContext dialogContext) {
    return GestureDetector(
      onTap: () => _exitToCampaignDetail(dialogContext),
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _ScannerColors.slate200),
        ),
        child: const Center(
          child: Text(
            'Exit',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _ScannerColors.slate600,
            ),
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: _ScannerColors.slate900.withOpacity(0.4),
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
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
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _ScannerColors.brandStart,
                        ),
                        backgroundColor: _ScannerColors.slate200,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Processing...',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _ScannerColors.slate600,
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

  @override
  Widget build(BuildContext context) {
    ref.listen(vendorScanUserControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data != null) {
            // Close any open dialogs
            Navigator.of(context, rootNavigator: true).popUntil((route) {
              return route is PageRoute;
            });

            if (data.success) {
              _showSuccessDialog(
                giftName: data.data?.giftName ?? 'Gift',
                giftDescription: data.data?.giftDescription ?? '',
                redemptionId: data.data?.redemptionId ?? '',
              );

              ref
                  .read(currentCampaignSelectionControllerProvider.notifier)
                  .reloadCurrentCampaignFromSource();
            } else {
              _showErrorDialog('Better luck next time!');
            }
          }
        },
        error: (error, stack) {
          // Close any open dialogs
          Navigator.of(context, rootNavigator: true).popUntil((route) {
            return route is PageRoute;
          });
          final errorText = error.toString();
          final isGiftExhaustedError =
              errorText.contains('[firebase_functions/resource-exhausted]') ||
              errorText.contains('GIFTS_EXHAUSTED');

          showToastAtTop(
            context,
            isGiftExhaustedError
                ? 'No gift available or no gift added'
                : 'Error scanning user',
            false,
          );
        },
        loading: () {
          _showLoadingDialog();
        },
      );
    });

    return Scaffold(
      backgroundColor: _ScannerColors.slate50,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            _buildAppBar(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 24,
                  bottom: 40,
                ),
                child: Column(
                  children: [
                    // Campaign Info Card
                    _buildCampaignInfoCard(),
                    const SizedBox(height: 24),

                    // Instructions
                    _buildInstructions(),
                    const SizedBox(height: 24),

                    // Scanner Viewport
                    _buildScannerViewport(),
                    const SizedBox(height: 24),

                    // Control Buttons
                    _buildControlButtons(),
                  ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: _ScannerColors.slate50.withOpacity(0.9),
        border: const Border(
          bottom: BorderSide(color: _ScannerColors.slate200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button and Title
          Row(
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
                    Icons.arrow_back_ios_new_rounded,
                    color: _ScannerColors.slate500,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Scan to Avail Gift',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _ScannerColors.slate900,
                ),
              ),
            ],
          ),

          // Role Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _ScannerColors.orange50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _ScannerColors.orange100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.workspace_premium_rounded,
                  color: _ScannerColors.orange500,
                  size: 12,
                ),
                const SizedBox(width: 6),
                Text(
                  _roleLabel.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _ScannerColors.slate600,
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

  Widget _buildCampaignInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _ScannerColors.slate100),
        boxShadow: _ScannerShadows.soft,
      ),
      child: Row(
        children: [
          // Gift Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: _ScannerColors.brandGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: _ScannerShadows.glow,
            ),
            child: const Icon(
              Icons.card_giftcard_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Campaign Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CAMPAIGN',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _ScannerColors.slate400,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.campaignDetailsUIData.campaignName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _ScannerColors.slate900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: ${widget.campaignDetailsUIData.campaignId}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: _ScannerColors.slate500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _ScannerColors.blue50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _ScannerColors.blue100),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_rounded, color: _ScannerColors.blue500, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Position the user's QR code within the frame below to scan automatically.",
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _ScannerColors.blue700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerViewport() {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: _ScannerColors.slate900,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: _ScannerColors.slate800, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            // Camera Feed
            MobileScanner(
              controller: controller,
              onDetect: (BarcodeCapture capture) {
                if (!hasScanned && capture.barcodes.isNotEmpty) {
                  final code = capture.barcodes.first.rawValue;
                  if (code != null) {
                    setState(() {
                      hasScanned = true;
                    });
                    controller?.stop();
                    _laserAnimationController.stop();
                    _showScanResultDialog(code);
                  }
                }
              },
            ),

            // Dark overlay
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
                      // Corner decorations
                      _buildCorner(Alignment.topLeft),
                      _buildCorner(Alignment.topRight),
                      _buildCorner(Alignment.bottomLeft),
                      _buildCorner(Alignment.bottomRight),
                    ],
                  ),
                ),
              ),
            ),

            // Laser Animation
            AnimatedBuilder(
              animation: _laserAnimation,
              builder: (context, child) {
                return Positioned(
                  top: 32 + (_laserAnimation.value * (380 - 64 - 32)),
                  left: 32 + 16,
                  right: 32 + 16,
                  child: Opacity(
                    opacity: _getLaserOpacity(_laserAnimation.value),
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: _ScannerColors.brandStart,
                        borderRadius: BorderRadius.circular(1),
                        boxShadow: [
                          const BoxShadow(
                            color: _ScannerColors.brandStart,
                            blurRadius: 15,
                          ),
                          const BoxShadow(
                            color: _ScannerColors.brandStart,
                            blurRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // Bottom hint
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Text(
                    hasScanned ? 'QR Code Detected' : 'Scanning...',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getLaserOpacity(double value) {
    if (value < 0.1) return value * 10;
    if (value > 0.9) return (1 - value) * 10;
    return 1.0;
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
                ? const BorderSide(color: _ScannerColors.brandStart, width: 4)
                : BorderSide.none,
            bottom: !isTop
                ? const BorderSide(color: _ScannerColors.brandStart, width: 4)
                : BorderSide.none,
            left: isLeft
                ? const BorderSide(color: _ScannerColors.brandStart, width: 4)
                : BorderSide.none,
            right: !isLeft
                ? const BorderSide(color: _ScannerColors.brandStart, width: 4)
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

  Widget _buildControlButtons() {
    final scannerDisabled = hasScanned;
    final flashBackgroundColor = scannerDisabled
        ? _ScannerColors.slate100
        : isFlashOn
        ? _ScannerColors.yellow50
        : Colors.white;
    final flashBorderColor = scannerDisabled
        ? _ScannerColors.slate200
        : isFlashOn
        ? _ScannerColors.yellow200
        : _ScannerColors.slate200;
    final flashContentColor = scannerDisabled
        ? _ScannerColors.slate400
        : isFlashOn
        ? _ScannerColors.yellow600
        : _ScannerColors.slate600;

    return Row(
      children: [
        // Flash Toggle Button
        Expanded(
          child: GestureDetector(
            onTap: scannerDisabled
                ? null
                : () {
                    setState(() {
                      isFlashOn = !isFlashOn;
                    });
                    controller?.toggleTorch();
                  },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: flashBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: flashBorderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isFlashOn
                        ? Icons.flash_on_rounded
                        : Icons.flash_off_rounded,
                    color: flashContentColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isFlashOn ? 'Flash On' : 'Flash Off',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: flashContentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Rescan Button
        Expanded(
          child: GestureDetector(
            onTap: () {
              _rescan();
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: _ScannerColors.slate900,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  const BoxShadow(
                    color: _ScannerColors.slate200,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Rescan',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
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
    );
  }
}
