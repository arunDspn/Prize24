import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/common_widgets/common_widgets.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/view_profile/ui/components/set_referrer_popup/set_referrer_view.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/view_profile/view_models/update_user_name_controller.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/authentication/presentation/pages/pop_auth/pop_auth_shell_page.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/presentation/partial_registeration_view/view_model/vendor_phone_number_registeration_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

/// Theme constants matching the HTML design
class _ProfileTheme {
  static const Color bgColor = Color(0xFFF8FAFC);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF1E293B);
  static const Color textSub = Color(0xFF64748B);
  static const Color accent = Color(0xFF0F172A);
  static const Color inputBg = Color(0xFFF1F5F9);
  static const Color gradStart = Color(0xFFEF4444); // red-500
  static const Color gradEnd = Color(0xFFF97316); // orange-500
}

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authControllerProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          if (data == null) {
            context.go(AppRoutes.getStarted);
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: _ProfileTheme.bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: _ProfileAppBar(),
      ),
      body: const SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              // User Profile Section
              UserDetailsSection(),
              SizedBox(height: 32),

              // User Tools Section
              _UserToolsSection(),

              SizedBox(height: 24),

              // Vendor Section (if user is vendor)
              VendorSection(),

              // Club Section (if user is vendor)
              // VendorClubSection(),
              SizedBox(height: 24),

              // Delete Account Section
              _DeleteAccountSection(),

              SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAppBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: _ProfileTheme.cardBg.withOpacity(0.8),
        border: const Border(
          bottom: BorderSide(color: _ProfileTheme.inputBg, width: 1),
        ),
      ),
      child: ClipRRect(
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _ProfileTheme.textMain,
                    fontFamily: 'Inter',
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () async {
                      final shouldSignOut = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Sign Out'),
                          content: const Text(
                            'Are you sure you want to sign out?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Sign Out'),
                            ),
                          ],
                        ),
                      );
                      if ((shouldSignOut ?? false) && context.mounted) {
                        await ref
                            .read(authControllerProvider.notifier)
                            .signOut();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.logout,
                        size: 22,
                        color: _ProfileTheme.gradStart,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserDetailsSection extends ConsumerWidget {
  const UserDetailsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(authControllerProvider).requireValue;

    if (appUser == null) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(_ProfileTheme.gradStart),
        ),
      );
    }
    return _AuthUserSection(appUser);
  }
}

class _AuthUserSection extends ConsumerWidget {
  const _AuthUserSection(this.user);

  final AppUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(updateUserNameControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data != null && context.mounted && data != user.userName) {
            showToastAtTop(context, 'Name updated successfully!', true);

            ref.read(authControllerProvider.notifier).updateUserName(data);
          }
        },
      );
    });
    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile Avatar with gradient
          _GradientAvatar(
            userName: user.userName,
            imageUrl: user.profilePic,
            onEditPressed: () {
              // context.push(AppRoutes.editProfile, extra: user);
            },
          ),
          const SizedBox(height: 16),

          // User Name with Edit Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _ProfileTheme.textMain,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => _showEditNameDialog(context, user.userName, ref),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _ProfileTheme.inputBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        // Text
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _ProfileTheme.gradStart,
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.edit,
                          size: 12,
                          color: _ProfileTheme.gradStart,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // User Role Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _ProfileTheme.gradStart.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              user.isVendor ? 'Vendor Partner' : 'Standard Member',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _ProfileTheme.gradStart,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Contact Info Card
          _ContactInfoCard(user: user),
        ],
      ),
    );
  }
}

// Helper function to show Edit Name Dialog
void _showEditNameDialog(
  BuildContext context,
  String currentName,
  WidgetRef ref,
) {
  final nameController = TextEditingController(text: currentName);

  showDialog<void>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _ProfileTheme.cardBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _ProfileTheme.textMain,
                      fontFamily: 'Inter',
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      nameController.dispose();
                      Navigator.pop(context);
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _ProfileTheme.inputBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: _ProfileTheme.textSub,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Name Input Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _ProfileTheme.textMain,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: _ProfileTheme.textMain,
                      fontFamily: 'Inter',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle: const TextStyle(
                        color: _ProfileTheme.textSub,
                        fontFamily: 'Inter',
                      ),
                      filled: true,
                      fillColor: _ProfileTheme.inputBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: _ProfileTheme.gradStart,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        nameController.dispose();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(
                          color: _ProfileTheme.inputBg,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _ProfileTheme.textMain,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement save name functionality
                        final newName = nameController.text.trim();
                        if (newName.isNotEmpty) {
                          // Add your implementation here
                          // ref
                          //     .read(authControllerProvider.notifier)
                          //     .updateUserName(newName);

                          ref
                              .read(updateUserNameControllerProvider.notifier)
                              .updateUserName(newName);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text('Name update: $newName'),
                          //     backgroundColor: _ProfileTheme.gradStart,
                          //     behavior: SnackBarBehavior.floating,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(12),
                          //     ),
                          //   ),
                          // );
                        }
                        // nameController.dispose();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: _ProfileTheme.gradStart,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
  // ).then((_) => nameController.dispose());
}

// Helper function to show Edit Phone Dialog
void _showEditPhoneDialog(
  BuildContext context,
  String currentPhone,
  WidgetRef ref,
) {
  final TextEditingController phoneController = TextEditingController(
    text: currentPhone == 'Not provided' ? '' : currentPhone,
  );

  showDialog<void>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _ProfileTheme.cardBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Phone Number',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _ProfileTheme.textMain,
                      fontFamily: 'Inter',
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      phoneController.dispose();
                      Navigator.pop(context);
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _ProfileTheme.inputBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: _ProfileTheme.textSub,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Phone Input Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _ProfileTheme.textMain,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: _ProfileTheme.textMain,
                      fontFamily: 'Inter',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter 10-digit phone number',
                      hintStyle: const TextStyle(
                        color: _ProfileTheme.textSub,
                        fontFamily: 'Inter',
                      ),
                      prefixIcon: const Icon(
                        Icons.phone_outlined,
                        color: _ProfileTheme.textSub,
                      ),
                      filled: true,
                      fillColor: _ProfileTheme.inputBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: _ProfileTheme.gradStart,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please enter a valid 10-digit phone number',
                    style: TextStyle(
                      fontSize: 12,
                      color: _ProfileTheme.textSub.withOpacity(0.8),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        phoneController.dispose();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(
                          color: _ProfileTheme.inputBg,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _ProfileTheme.textMain,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final newPhone = phoneController.text.trim();
                        // Validate phone number
                        if (newPhone.isNotEmpty && newPhone.length == 10) {
                          ref
                              .read(
                                vendorPhoneNumberRegisterationControllerProvider
                                    .notifier,
                              )
                              .registerVendorPhoneNumber(phoneNumber: newPhone);
                          Navigator.pop(context);
                        } else {
                          // Show error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Please enter a valid 10-digit phone number',
                              ),
                              backgroundColor: _ProfileTheme.gradStart,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: _ProfileTheme.gradStart,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _GradientAvatar extends StatelessWidget {
  const _GradientAvatar({
    required this.userName,
    this.imageUrl,
    this.onEditPressed,
  });

  final String userName;
  final String? imageUrl;
  final VoidCallback? onEditPressed;

  String get _initials {
    if (userName.isEmpty) return '';
    // Filter out empty parts (handles multiple consecutive spaces)
    final partsIterable = userName.split(' ').where((part) => part.isNotEmpty);
    if (partsIterable.isEmpty) return '';
    final parts = partsIterable.toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _ProfileTheme.cardBg, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_ProfileTheme.gradStart, _ProfileTheme.gradEnd],
            ),
          ),
          child: ClipOval(
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildInitials(),
                  )
                : _buildInitials(),
          ),
        ),
        // if (onEditPressed != null)
        //   Positioned(
        //     right: 0,
        //     bottom: 0,
        //     child: Material(
        //       color: _ProfileTheme.accent,
        //       shape: const CircleBorder(),
        //       elevation: 2,
        //       child: InkWell(
        //         onTap: onEditPressed,
        //         customBorder: const CircleBorder(),
        //         child: const Padding(
        //           padding: EdgeInsets.all(8),
        //           child: Icon(
        //             Icons.edit,
        //             size: 14,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }

  Widget _buildInitials() {
    return Center(
      child: Text(
        _initials.isNotEmpty ? _initials : 'U',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

class _ContactInfoCard extends ConsumerWidget {
  const _ContactInfoCard({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to phone number updates
    ref.listen(vendorPhoneNumberRegisterationControllerProvider, (
      previous,
      next,
    ) {
      next.whenOrNull(
        data: (data) {
          if (data != null && context.mounted) {
            showToastAtTop(context, 'Phone number updated successfully!', true);

            // Update local auth state
            ref
                .read(authControllerProvider.notifier)
                .updateUserVendorNumber(data);
          }
        },
        error: (error, stackTrace) {
          if (context.mounted) {
            showToastAtTop(context, 'Failed to update phone number', false);
          }
        },
      );
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _ProfileTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _ProfileTheme.inputBg, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (user.isVendor)
            _InfoRow(
              icon: Icons.phone_outlined,
              label: 'VENDOR PHONE',
              value: user.vendorPhoneNumber ?? 'Not provided',
              isFirst: true,
              onEdit: () => _showEditPhoneDialog(
                context,
                user.vendorPhoneNumber ?? 'Not provided',
                ref,
              ),
            ),
          _InfoRow(
            icon: Icons.email_outlined,
            label: 'EMAIL',
            value: user.userEmail,
          ),
          _MenuItem(
            icon: Icons.qr_code_outlined,
            title: 'View My Referral Code',
            subtitle: 'Share your referral code with friends and earn rewards',
            onTap: () => _showReferralCodeDialog(
              context: context,
              referralCode: user.referralCode,
            ),
            isLast: user.referredBy != null,
          ),
          if (user.referredBy == null)
            _MenuItem(
              icon: Icons.store_outlined,
              title: 'Set My Referrer',
              subtitle: 'Have a referral code? Set your referrer',
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (_) => const SetReferrerView(),
                );
              },
              isLast: true,
            ),
        ],
      ),
    );
  }
}

void _showReferralCodeDialog({
  required BuildContext context,
  required String referralCode,
}) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _ProfileTheme.cardBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Referral Code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _ProfileTheme.textMain,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Share this code with friends and earn rewards when they join.',
                style: TextStyle(
                  fontSize: 14,
                  color: _ProfileTheme.textSub,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: _ProfileTheme.inputBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _ProfileTheme.inputBg),
                ),
                child: Text(
                  referralCode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                    color: _ProfileTheme.textMain,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(
                          color: _ProfileTheme.inputBg,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _ProfileTheme.textMain,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: referralCode),
                        );
                        if (context.mounted) {
                          Navigator.pop(context);
                          showToastAtTop(
                            context,
                            'Referral code copied!',
                            true,
                          );
                        }
                      },
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text(
                        'Copy',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: _ProfileTheme.gradStart,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isFirst = false,
    this.isLast = false,
    this.onEdit,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isFirst;
  final bool isLast;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: _ProfileTheme.inputBg, width: 1),
              ),
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(16) : Radius.zero,
          bottom: isLast ? const Radius.circular(16) : Radius.zero,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: _ProfileTheme.textSub),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    color: _ProfileTheme.textSub,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _ProfileTheme.textMain,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          // Show edit icon only if onEdit callback is provided
          if (onEdit != null)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onEdit,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _ProfileTheme.inputBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color: _ProfileTheme.gradStart,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _ProfileTheme.textMain,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    required this.onTap,
    this.showChevron = true,
    this.isFirst = false,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final VoidCallback onTap;
  final bool showChevron;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _ProfileTheme.cardBg,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: isLast
                ? null
                : const Border(
                    bottom: BorderSide(color: _ProfileTheme.inputBg, width: 1),
                  ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _ProfileTheme.inputBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor ?? _ProfileTheme.accent,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _ProfileTheme.textMain,
                        fontFamily: 'Inter',
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _ProfileTheme.textSub,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (showChevron)
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: _ProfileTheme.textSub.withOpacity(0.5),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _ProfileTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _ProfileTheme.inputBg, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(children: children),
      ),
    );
  }
}

class GuestUserSection extends StatelessWidget {
  const GuestUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _GradientAvatar(userName: 'Guest', onEditPressed: null),
        const SizedBox(height: 16),
        const Text(
          'Guest User',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _ProfileTheme.textMain,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Sign in to access all features',
          style: TextStyle(
            fontSize: 14,
            color: _ProfileTheme.textSub,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TPrimaryButton(
            text: 'Sign In / Sign Up',
            icon: Icons.login,
            onPressed: () {
              showModalBottomSheet<void>(
                useRootNavigator: true,
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                barrierColor: Colors.black38,
                builder: (context) {
                  return const IntrinsicHeight(child: PopAuthShellPage());
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _UserToolsSection extends ConsumerWidget {
  const _UserToolsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(authControllerProvider);

    return Column(
      children: [
        const _SectionHeader(title: 'User Tools'),
        const SizedBox(height: 12),
        _MenuCard(
          children: [
            _MenuItem(
              icon: Icons.store_outlined,
              title: 'Staff Invitations',
              subtitle: 'Manage invitations to join shop teams',
              onTap: () {
                context.push(AppRoutes.userStaffRequests);
              },
              isFirst: true,
            ),
            _MenuItem(
              icon: Icons.description_outlined,
              title: 'Staff Operations',
              subtitle: 'Visitor Check-in | Visitor Avail | Visitor Redeem',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return StaffShopListPage(
                //         shopIds: appUser.requireValue!.staffShopIds ?? [],
                //         staffId: appUser.requireValue!.userId,
                //       );
                //     },
                //   ),
                // );
                context.push(
                  AppRoutes.staffShops,
                  extra: (
                    appUser.requireValue!.staffShopIds ?? [],
                    appUser.requireValue!.userId,
                  ),
                );
              },
              isLast: true,
            ),
          ],
        ),
      ],
    );
  }
}

class VendorSection extends ConsumerWidget {
  const VendorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(authControllerProvider);

    return appUser.maybeWhen(
      orElse: () => const SizedBox(),
      data: (data) {
        if (data == null || !data.isVendor) {
          return const SizedBox();
        }

        return Column(
          children: [
            const _SectionHeader(title: 'Partner Tools'),
            const SizedBox(height: 12),
            _MenuCard(
              children: [
                // _MenuItem(
                //   icon: Icons.qr_code_2,
                //   title: 'Show QR Code',
                //   subtitle: 'Display your vendor ID',
                //   onTap: () {
                //     context.push(AppRoutes.vendorQrCode, extra: data);
                //   },
                //   isFirst: true,
                // ),
                // _MenuItem(
                //   icon: Icons.people_outline,
                //   title: 'Partner Friends',
                //   subtitle: 'Manage your network',
                //   onTap: () {
                //     context.push(AppRoutes.vendorFriendsAndRequests,
                //         extra: data);
                //   },
                // ),
                // _MenuItem(
                //   icon: Icons.share_outlined,
                //   title: 'Campaign Requests',
                //   subtitle: 'Share and manage campaigns',
                //   onTap: () {
                //     context.push(AppRoutes.shareCampaignRequests);
                //   },
                // ),
                _MenuItem(
                  icon: Icons.subscriptions_sharp,
                  title: 'Manage Subscriptions',
                  subtitle: 'Manage your partner subscriptions',
                  onTap: () {
                    context.push(AppRoutes.manageSubscriptions);
                  },
                  isLast: true,
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

class _DeleteAccountSection extends StatelessWidget {
  const _DeleteAccountSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delete Account',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _ProfileTheme.textSub,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Permanently delete your account and all associated data',
            style: TextStyle(
              fontSize: 12,
              color: _ProfileTheme.textSub.withOpacity(0.7),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              context.push(AppRoutes.softDeleteAccount);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFDC2626),
              side: const BorderSide(color: Color(0xFFDC2626), width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Delete Account',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
