import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Accepts the first non-empty QR payload and ignores later detections.
///
/// Kept separate from the camera widget so result handling can be tested
/// without requiring a platform camera.
final class UserQrScanGate {
  bool _hasAcceptedResult = false;

  String? accept(String? rawValue) {
    if (_hasAcceptedResult) return null;

    final userId = rawValue?.trim();
    if (userId == null || userId.isEmpty) return null;

    _hasAcceptedResult = true;
    return userId;
  }
}

/// Full-screen scanner that returns a customer's raw Prize24 user ID.
class ShopActivityLogQrScannerPage extends StatefulWidget {
  const ShopActivityLogQrScannerPage({super.key});

  @override
  State<ShopActivityLogQrScannerPage> createState() =>
      _ShopActivityLogQrScannerPageState();
}

class _ShopActivityLogQrScannerPageState
    extends State<ShopActivityLogQrScannerPage>
    with WidgetsBindingObserver {
  late final MobileScannerController _cameraController;
  final UserQrScanGate _scanGate = UserQrScanGate();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: const [BarcodeFormat.qrCode],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_cameraController.value.hasCameraPermission) return;

    switch (state) {
      case AppLifecycleState.resumed:
        unawaited(_startCamera());
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        unawaited(_stopCamera());
    }
  }

  Future<void> _startCamera() async {
    try {
      await _cameraController.start();
    } on MobileScannerException {
      // The scanner's errorBuilder presents initialization errors to the user.
    }
  }

  Future<void> _stopCamera() async {
    try {
      await _cameraController.stop();
    } on MobileScannerException {
      // Stopping is best-effort while the route or app is transitioning.
    }
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    for (final barcode in capture.barcodes) {
      final userId = _scanGate.accept(barcode.rawValue);
      if (userId == null) continue;

      await _stopCamera();
      if (!mounted) return;
      Navigator.of(context).pop(userId);
      return;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_cameraController.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Scan User QR',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700),
        ),
        actions: [
          ValueListenableBuilder<MobileScannerState>(
            valueListenable: _cameraController,
            builder: (context, state, _) {
              final canUseTorch =
                  state.isRunning && state.torchState != TorchState.unavailable;
              final torchIsOn = state.torchState == TorchState.on;
              return IconButton(
                tooltip: torchIsOn ? 'Turn flash off' : 'Turn flash on',
                onPressed: canUseTorch ? _cameraController.toggleTorch : null,
                icon: Icon(
                  torchIsOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                ),
              );
            },
          ),
          ValueListenableBuilder<MobileScannerState>(
            valueListenable: _cameraController,
            builder: (context, state, _) {
              final canSwitch =
                  state.isRunning &&
                  (state.availableCameras == null ||
                      state.availableCameras! > 1);
              return IconButton(
                tooltip: 'Switch camera',
                onPressed: canSwitch ? _cameraController.switchCamera : null,
                icon: const Icon(Icons.cameraswitch_rounded),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _cameraController,
            onDetect: _onDetect,
            errorBuilder: (context, error) => _ScannerError(
              error: error,
              onClose: () => Navigator.of(context).pop(),
            ),
          ),
          ValueListenableBuilder<MobileScannerState>(
            valueListenable: _cameraController,
            builder: (context, state, _) => state.error == null
                ? const IgnorePointer(child: _ScannerOverlay())
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(flex: 2),
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.68),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              "Align the customer's Prize24 QR code inside the frame",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.4,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _ScannerError extends StatelessWidget {
  const _ScannerError({required this.error, required this.onClose});

  final MobileScannerException error;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final permissionDenied =
        error.errorCode == MobileScannerErrorCode.permissionDenied;

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.no_photography_outlined,
                color: Colors.white70,
                size: 56,
              ),
              const SizedBox(height: 20),
              Text(
                permissionDenied
                    ? 'Camera access needed'
                    : 'Camera unavailable',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                permissionDenied
                    ? 'Allow camera access in your device settings, '
                          'then try again.'
                    : 'The QR scanner could not start on this device.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onClose,
                child: const Text('Back to Activity Log'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
