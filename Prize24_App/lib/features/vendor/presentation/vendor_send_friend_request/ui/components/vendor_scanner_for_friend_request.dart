import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// QR Scanner Widget for vendor friend request
class VendorQrScannerForFriendRequest extends ConsumerStatefulWidget {
  const VendorQrScannerForFriendRequest({
    required this.onScanned,
    super.key,
  });
  final void Function(String) onScanned;

  @override
  ConsumerState<VendorQrScannerForFriendRequest> createState() =>
      _VendorQrScannerState();
}

class _VendorQrScannerState
    extends ConsumerState<VendorQrScannerForFriendRequest> {
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
                  final String? code = capture.barcodes.first.rawValue;
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
                color: Colors.black.withOpacity(0.5),
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
                      'Scan Vendor QR Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
