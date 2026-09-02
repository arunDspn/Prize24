import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/common_widgets.dart';
import 'package:prize24_app/configs/assets.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/presentation/become_a_vendor_modal/view_model/become_a_vendor_controller.dart';

class BecomeAVendorModal extends ConsumerStatefulWidget {
  const BecomeAVendorModal({
    super.key,
  });

  @override
  ConsumerState<BecomeAVendorModal> createState() => _BecomeAVendorModalState();
}

class _BecomeAVendorModalState extends ConsumerState<BecomeAVendorModal> {
  // Controllers and Key
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      insetPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 16,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 650),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with close button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            AppAssets.p24LogoIcon,
                            height: 32,
                            width: 32,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Prize24',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor:
                          colorScheme.surface.withValues(alpha: 0.2),
                      foregroundColor: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title and subtitle
                      Text(
                        'Become a Vendor & Elevate Your Business!',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create coupons, run draws, and manage your audience with ease!',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 32),

                      // Info card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: colorScheme.primary,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Please register your shop first in order to become a vendor.',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Form field
                      TPrimaryTextFormField(
                        controller: _phoneNumberController,
                        label: 'Phone Number',
                        hint: 'Enter your phone number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          // Remove any spaces, dashes, or other non-digit characters
                          String cleanedValue =
                              value.replaceAll(RegExp(r'[^\d]'), '');

                          // Check if it starts with +91 (handle country code)
                          if (value.startsWith('+91')) {
                            cleanedValue = value
                                .substring(3)
                                .replaceAll(RegExp(r'[^\d]'), '');
                          }

                          // Indian mobile numbers should be exactly 10 digits
                          if (cleanedValue.length != 10) {
                            return 'Phone number must be 10 digits';
                          }

                          // Indian mobile numbers start with 6, 7, 8, or 9
                          if (!RegExp(r'^[6-9]').hasMatch(cleanedValue)) {
                            return 'Please enter a valid Indian mobile number';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      // Register button
                      Consumer(
                        builder: (context, ref, _) {
                          final controller =
                              ref.watch(becomeAVendorControllerProvider);
                          final isLoading = controller.isLoading;

                          return TPrimaryButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      final userId = (ref
                                              .read(authControllerProvider)
                                              .requireValue!)
                                          .userId;
                                      ref
                                          .read(becomeAVendorControllerProvider
                                              .notifier)
                                          .register(
                                            userId: userId,
                                            phoneNumber: _phoneNumberController
                                                .text
                                                .trim(),
                                          );
                                    }
                                  },
                            text: 'Register as Vendor',
                            icon: Icons.store,
                            isLoading: isLoading,
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // Additional info
                      Text(
                        'By registering, you agree to our vendor terms and conditions.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
