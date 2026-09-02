import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/shop/presentation/staff_add_user_to_shop/view_model/staff_add_user_to_shop_controller.dart';

class StaffAddUserToShopPage extends ConsumerStatefulWidget {
  const StaffAddUserToShopPage({
    required this.shopId,
    super.key,
  });

  final String shopId;

  @override
  ConsumerState<StaffAddUserToShopPage> createState() =>
      _StaffAddUserToClubPageState();
}

class _StaffAddUserToClubPageState
    extends ConsumerState<StaffAddUserToShopPage> {
  MobileScannerController cameraController = MobileScannerController();

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
          title: const Text('Check-in Confirmation'),
          content: const Text('Check in to the Shop?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                ref.read(staffAddUserToShopControllerProvider.notifier).addUser(
                      shopId: widget.shopId,
                      userId: code,
                    );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      staffAddUserToShopControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (data) {
            if (data == null) return;
            if (data.success) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text('User added to shop successfully'),
              //   ),
              // );
              showToastAtTop(
                context,
                'User added to shop successfully',
                true,
              );
              // Pop
              Navigator.of(context).pop();
            } else {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text('Failed to add user: ${data.message}'),
              //   ),
              // );
              showToastAtTop(
                context,
                'Failed to add user: ${data.message}',
                false,
              );
            }
          },
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                // content: Text('Error: $error'),
                content: Text('Something went wrong! Please try again.'),
              ),
            );
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User to Club'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _onDetect,
      ),
    );
  }
}
