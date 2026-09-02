import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/shop/presentation/send_staff_request/ui/components/shop_scanner_for_staff_request.dart';
import 'package:prize24_app/features/shop/presentation/send_staff_request/view_model/send_staff_request_page_controller.dart';

/// Page for shops to send staff requests to users
/// Supports both QR code scanning and manual user ID input
class SendStaffRequestPage extends ConsumerStatefulWidget {
  const SendStaffRequestPage({
    required this.shopDetails,
    super.key,
  });

  /// 1. Shop ID to which staff request is sent
  /// 2. Shop Name
  final (String, String) shopDetails;

  @override
  ConsumerState<SendStaffRequestPage> createState() =>
      _SendStaffRequestPageState();
}

class _SendStaffRequestPageState extends ConsumerState<SendStaffRequestPage>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  bool _isManualInput = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _scannedData;

  // Brand colors from HTML design
  static const Color _brandStart = Color(0xFFFF5F6D);
  static const Color _brandEnd = Color(0xFFFFC371);
  static const Color _slate50 = Color(0xFFF8FAFC);
  static const Color _slate100 = Color(0xFFF1F5F9);
  static const Color _slate200 = Color(0xFFE2E8F0);
  static const Color _slate400 = Color(0xFF94A3B8);
  static const Color _slate500 = Color(0xFF64748B);
  static const Color _slate800 = Color(0xFF1E293B);
  static const Color _slate900 = Color(0xFF0F172A);

  late AnimationController _toggleController;
  late Animation<double> _toggleAnimation;

  @override
  void initState() {
    super.initState();
    _toggleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _toggleAnimation = CurvedAnimation(
      parent: _toggleController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _toggleController.dispose();
    super.dispose();
  }

  void _sendStaffRequest() {
    final userId = _isManualInput ? _textController.text.trim() : _scannedData;

    if (userId == null || userId.isEmpty) {
      setState(() {
        _errorMessage = 'Please scan QR code or enter user ID';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    ref.read(sendStaffRequestPageControllerProvider.notifier).sendStaffRequest(
          shopId: widget.shopDetails.$1,
          receiverId: userId,
          shopName: widget.shopDetails.$2,
        );
  }

  void _onQrCodeScanned(String data) {
    setState(() {
      _scannedData = data;
      _textController.text = data;
      _isManualInput = true;
    });
    _toggleController.forward();
  }

  void _setMode(bool isManual) {
    setState(() {
      _isManualInput = isManual;
      _errorMessage = null;
    });
    if (isManual) {
      _toggleController.forward();
    } else {
      _toggleController.reverse();
    }
  }

  void _resetScanner() {
    setState(() {
      _scannedData = null;
      _isManualInput = false;
    });
    _toggleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      sendStaffRequestPageControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (data) {
            setState(() {
              _isLoading = false;
              _errorMessage = null;
            });

            _showToast('Staff request sent successfully!', isSuccess: true);

            _textController.clear();
            setState(() {
              _scannedData = null;
            });

            Future.delayed(const Duration(milliseconds: 1500), () {
              if (context.mounted) {
                context.pop();
              }
            });
          },
          error: (error, stack) {
            setState(() {
              _errorMessage = error.toString();
              _isLoading = false;
            });
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: _slate50,
      body: Column(
        children: [
          // AppBar
          _buildAppBar(),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 160),
              child: Column(
                children: [
                  // Toggle Switch
                  _buildToggleSwitch(),
                  const SizedBox(height: 32),
                  // Error Banner
                  if (_errorMessage != null) _buildErrorBanner(),
                  // Content View
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isManualInput
                        ? _buildManualInput()
                        : _buildScannerView(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Sticky Footer
      bottomSheet: _buildStickyFooter(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 64 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: _slate50.withValues(alpha: 0.9),
        border: const Border(
          bottom: BorderSide(color: _slate200),
        ),
      ),
      child: ClipRRect(
        child: Row(
          children: [
            const SizedBox(width: 8),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.pop(),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: _slate500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Add Staff',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _slate900,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSwitch() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonWidth = (constraints.maxWidth - 12) / 2;
          return Stack(
            children: [
              // Sliding Indicator
              AnimatedBuilder(
                animation: _toggleAnimation,
                builder: (context, child) {
                  return Positioned(
                    left: _isManualInput ? buttonWidth + 6 : 0,
                    top: 0,
                    bottom: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.elasticOut,
                      width: buttonWidth,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_brandStart, _brandEnd],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: _brandStart.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _setMode(false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner_rounded,
                              size: 18,
                              color: !_isManualInput ? Colors.white : _slate500,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Scan QR',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    !_isManualInput ? Colors.white : _slate500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _setMode(true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.keyboard_rounded,
                              size: 18,
                              color: _isManualInput ? Colors.white : _slate500,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Manual ID',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    _isManualInput ? Colors.white : _slate500,
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
          );
        },
      ),
    );
  }

  Widget _buildErrorBanner() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          border: Border.all(color: const Color(0xFFFEE2E2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning_rounded,
              color: Color(0xFFEF4444),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _errorMessage!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFB91C1C),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _errorMessage = null),
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFFF87171),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerView() {
    return Column(
      key: const ValueKey('scanner'),
      children: [
        const Text(
          "Point your camera at the user's QR code",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _slate500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        // Scanner Viewport
        Container(
          height: 260,
          decoration: BoxDecoration(
            color: _slate900,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _slate800, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Scanner Component
                ShopQrScannerForStaffRequest(
                  onScanned: _onQrCodeScanned,
                ),
                // Simple corner markers only
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Stack(
                      children: [
                        ..._buildCornerPieces(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Scanned Result
        if (_scannedData != null && _scannedData!.isNotEmpty)
          _buildScanResult(),
      ],
    );
  }

  List<Widget> _buildCornerPieces() {
    return [
      // Top Left
      Positioned(
        top: -1,
        left: -1,
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: _brandStart, width: 4),
              left: BorderSide(color: _brandStart, width: 4),
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
          ),
        ),
      ),
      // Top Right
      Positioned(
        top: -1,
        right: -1,
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: _brandStart, width: 4),
              right: BorderSide(color: _brandStart, width: 4),
            ),
            borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
          ),
        ),
      ),
      // Bottom Left
      Positioned(
        bottom: -1,
        left: -1,
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: _brandStart, width: 4),
              left: BorderSide(color: _brandStart, width: 4),
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
          ),
        ),
      ),
      // Bottom Right
      Positioned(
        bottom: -1,
        right: -1,
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: _brandStart, width: 4),
              right: BorderSide(color: _brandStart, width: 4),
            ),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(8)),
          ),
        ),
      ),
    ];
  }

  Widget _buildScanResult() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FDF4),
          border: Border.all(color: const Color(0xFFBBF7D0)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF16A34A),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'QR Code Detected',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF166534),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ID: $_scannedData',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF15803D),
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _resetScanner,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.refresh_rounded,
                  color: Color(0xFF15803D),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualInput() {
    return Column(
      key: const ValueKey('manual'),
      children: [
        const Text(
          'Enter User ID manually',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _slate500,
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
                'USER ID',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _slate400,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _slate200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _textController,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: _slate900,
                ),
                decoration: InputDecoration(
                  hintText: 'e.g., U-12345',
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: _slate400,
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(16),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      size: 22,
                      color: _slate400,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFFB923C),
                      width: 2,
                    ),
                  ),
                  enabledBorder: InputBorder.none,
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
            color: _slate50,
            border: Border.all(color: _slate100),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_rounded,
                color: _slate400,
                size: 20,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Ask the user to show their QR code or share '
                  'their User ID directly with you.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _slate500,
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

  Widget _buildStickyFooter() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        border: const Border(
          top: BorderSide(color: _slate200),
        ),
      ),
      child: ClipRRect(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Send Request Button
            GestureDetector(
              onTap: _isLoading ? null : _sendStaffRequest,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_brandStart, _brandEnd],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _brandStart.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Send Staff Request',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Cancel Button
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _slate500,
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

  void _showToast(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle_rounded : Icons.info_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor:
            isSuccess ? const Color(0xFF16A34A) : const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
