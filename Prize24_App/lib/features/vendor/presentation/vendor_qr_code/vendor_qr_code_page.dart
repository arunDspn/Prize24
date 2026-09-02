import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';

class VendorQrCodePage extends ConsumerWidget {
  const VendorQrCodePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor QR Code'),
        centerTitle: true,
      ),
      body: authState.when(
        data: (user) {
          if (user!.isVendor) {
            return _buildQrCodeContent(context, user);
          } else {
            return _buildNotVendorContent(context);
          }
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading user data',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrCodeContent(BuildContext context, AppUser user) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Vendor Info
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: theme.colorScheme.primary,
                    child:
                        user.profilePic != null && user.profilePic!.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  user.profilePic!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Text(
                                      user.userName.isNotEmpty
                                          ? user.userName[0].toUpperCase()
                                          : 'V',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.onPrimary,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Text(
                                user.userName.isNotEmpty
                                    ? user.userName[0].toUpperCase()
                                    : 'V',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.userName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vendor ID: ${user.userId}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // QR Code
          Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  PrettyQrView.data(
                    data: user.userId,
                    decoration: const PrettyQrDecoration(
                      shape: PrettyQrSmoothSymbol(
                        color: Colors.black,
                      ),
                      image: PrettyQrDecorationImage(
                        image: AssetImage('assets/images/p24_logo_icon.png'),
                        position: PrettyQrDecorationImagePosition.embedded,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Scan this QR code to connect with this vendor',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Copy Vendor ID Button
          FilledButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: user.userId));
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: const Text('Vendor ID copied to clipboard!'),
              //     backgroundColor: theme.colorScheme.inverseSurface,
              //     behavior: SnackBarBehavior.floating,
              //   ),
              // );
              showToastAtTop(
                context,
                'Vendor ID copied to clipboard!',
                true,
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copy Vendor ID'),
          ),

          const SizedBox(height: 16),

          // Share QR Code Button
          FilledButton.tonalIcon(
            onPressed: () {
              // TODO: Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Share functionality coming soon!'),
                  backgroundColor: theme.colorScheme.surfaceVariant,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.share),
            label: const Text('Share QR Code'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotVendorContent(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store_outlined,
              color: theme.colorScheme.secondary,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Not a Vendor',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You need to become a vendor to access this feature.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
