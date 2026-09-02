import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// QR Scanner Widget for shop staff request
class ShopQrScannerForStaffRequest extends ConsumerStatefulWidget {
  const ShopQrScannerForStaffRequest({
    required this.onScanned,
    super.key,
  });
  final void Function(String) onScanned;

  @override
  ConsumerState<ShopQrScannerForStaffRequest> createState() =>
      _ShopQrScannerState();
}

class _ShopQrScannerState extends ConsumerState<ShopQrScannerForStaffRequest> {
  MobileScannerController? controller;
  bool hasScanned = false;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: (BarcodeCapture capture) {
                if (!hasScanned && capture.barcodes.isNotEmpty) {
                  final code = capture.barcodes.first.rawValue;
                  if (code != null) {
                    hasScanned = true;
                    widget.onScanned(code);
                  }
                }
              },
            ),
            // Overlay with scanning area
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
              ),
              child: Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Point camera at User QR code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
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
}
