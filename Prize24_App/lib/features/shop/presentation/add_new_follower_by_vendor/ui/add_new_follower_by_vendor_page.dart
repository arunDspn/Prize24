import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/shop/presentation/vendor_add_user_to_shop/view_model/add_users_to_club_by_vendor_controller.dart';
import 'package:prize24_app/features/shop/presentation/add_new_follower_by_vendor/view_model/add_new_follower_vendor_controller.dart';

class AddNewFollowerToShopByVendorPage extends ConsumerStatefulWidget {
  const AddNewFollowerToShopByVendorPage({
    required this.shopId,
    super.key,
  });

  final String shopId;

  @override
  ConsumerState<AddNewFollowerToShopByVendorPage> createState() =>
      _AddNewFollowerToShopByVendorPageState();
}

class _AddNewFollowerToShopByVendorPageState
    extends ConsumerState<AddNewFollowerToShopByVendorPage> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? code = barcode.rawValue;
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
          title: const Text('Add User to Club'),
          content: Text('Add user with ID: $code to the club?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                cameraController.start(); // Restart scanner
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // Add user to club using the controller
                ref
                    .read(addNewFollowerVendorControllerProvider.notifier)
                    .addNewFollowerByVendor(
                      userId: code,
                      shopId: widget.shopId,
                      userFCMToken: '',
                    );
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
      addUsersToClubByVendorControllerProvider,
      (previous, next) {
        next.maybeWhen(
          error: (error, stackTrace) {
            Navigator.of(context).pop(); // Close loading dialog

            showToastAtTop(
              context,
              'Something went wrong! Please try again.',
              // 'Error: $error',
              false,
            );
          },
          data: (_) {
            Navigator.of(context).pop();
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('User added to club successfully!')),
            // );
            showToastAtTop(
              context,
              'User added to club successfully!',
              true,
            );
          },
          loading: () {
            // Show loading indicator in dialog
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
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
      appBar: AppBar(
        title: const Text('Scan QR Code'),
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
