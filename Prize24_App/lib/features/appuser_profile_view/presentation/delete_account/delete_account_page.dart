import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/delete_account/view_model/delete_account_controller.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

/// Design System Colors
class _AppColors {
  static const slate50 = Color(0xFFF8FAFC);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate300 = Color(0xFFCBD5E1);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate600 = Color(0xFF475569);
  static const slate700 = Color(0xFF334155);
  static const slate900 = Color(0xFF0F172A);
  static const red100 = Color(0xFFFEE2E2);
  static const red200 = Color(0xFFFECACA);
  static const red600 = Color(0xFFDC2626);
  static const red800 = Color(0xFF991B1B);
  static const orange500 = Color(0xFFF97316);
  static const yellow50 = Color(0xFFFEFCE8);
  static const yellow100 = Color(0xFFFEF9C3);
  static const yellow600 = Color(0xFFCA8A04);
}

class DeleteAccountPage extends ConsumerStatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  ConsumerState<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends ConsumerState<DeleteAccountPage> {
  bool _understandConsequences = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      deleteAccountControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (data) {
            // Close loading dialog
            if (Navigator.canPop(context)) {
              Navigator.of(context, rootNavigator: true).pop();
            }
            // Show success dialog then logout
            _showSuccessDialog(context, ref);
          },
          error: (error, stackTrace) {
            // Close loading dialog
            if (Navigator.canPop(context)) {
              Navigator.of(context, rootNavigator: true).pop();
            }
            // Show error dialog
            _showErrorDialog(context, error.toString());
          },
          loading: () {
            // Show loading dialog
            _showDeletionRequestDialog(context);
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: _AppColors.slate50,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildWarningHeader(),
              const SizedBox(height: 24),
              _buildWarningMessage(),
              const SizedBox(height: 24),
              _buildDataDeletionList(),
              const SizedBox(height: 24),
              _buildConfirmationCheckbox(),
              const SizedBox(height: 24),
              _buildActionButtons(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: BoxDecoration(
          color: _AppColors.slate50.withOpacity(0.9),
          border: const Border(
            bottom: BorderSide(color: _AppColors.slate200, width: 1),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: _AppColors.slate500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _AppColors.slate900,
                    fontFamily: 'Inter',
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _AppColors.red100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _AppColors.red200),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.warning, size: 12, color: _AppColors.red600),
                      SizedBox(width: 6),
                      Text(
                        'DANGER',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _AppColors.red800,
                          letterSpacing: 0.5,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWarningHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _AppColors.red600,
            _AppColors.orange500,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _AppColors.red600.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.error_outline,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Permanent Account Deletion',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'This action cannot be undone',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.9),
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWarningMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _AppColors.yellow50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _AppColors.yellow100, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: _AppColors.yellow600,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Important Notice',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _AppColors.slate900,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Deleting your account will permanently remove all your data from our servers. This includes all personal information, activity history, and associated content.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _AppColors.slate700,
                    height: 1.5,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataDeletionList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _AppColors.slate200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.delete_sweep,
                color: _AppColors.red600,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'What Will Be Deleted',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _AppColors.slate900,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'The following data will be permanently removed:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _AppColors.slate600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 20),
          _buildDeletionItem(
            icon: Icons.store,
            title: 'Your Shops',
            description:
                'All shops you own will be permanently deleted, including shop details and settings',
            color: _AppColors.red600,
          ),
          _buildDeletionItem(
            icon: Icons.campaign,
            title: 'Your Campaigns',
            description:
                'All campaigns you created will be removed along with their configurations',
            color: _AppColors.orange500,
          ),
          _buildDeletionItem(
            icon: Icons.local_fire_department,
            title: 'Streaks & Progress',
            description:
                'Your activity streaks and engagement progress will be lost',
            color: Color(0xFFF59E0B),
          ),
          _buildDeletionItem(
            icon: Icons.favorite,
            title: 'Following Shops',
            description: 'Your list of followed shops and preferences',
            color: Color(0xFFEC4899),
          ),
          _buildDeletionItem(
            icon: Icons.card_giftcard,
            title: 'Availed Gifts',
            description: 'History of all gifts you have claimed or redeemed',
            color: Color(0xFF8B5CF6),
          ),
          _buildDeletionItem(
            icon: Icons.badge,
            title: 'Staff Positions',
            description:
                'Your role as staff in shops will be revoked and removed',
            color: Color(0xFF3B82F6),
          ),
          _buildDeletionItem(
            icon: Icons.people,
            title: 'Vendor Network',
            description:
                'Partner connections, shared campaigns, and vendor relationships',
            color: Color(0xFF10B981),
          ),
          _buildDeletionItem(
            icon: Icons.person,
            title: 'Personal Information',
            description:
                'Profile data, email, phone number, and account credentials',
            color: _AppColors.slate600,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDeletionItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _AppColors.slate900,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _AppColors.slate500,
                    height: 1.4,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationCheckbox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              _understandConsequences ? _AppColors.red600 : _AppColors.slate200,
          width: _understandConsequences ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: _understandConsequences,
              onChanged: (value) {
                setState(() {
                  _understandConsequences = value ?? false;
                });
              },
              activeColor: _AppColors.red600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _understandConsequences = !_understandConsequences;
                });
              },
              child: const Text(
                'I understand that this action is permanent and irreversible. All my data will be deleted and cannot be recovered.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _AppColors.slate700,
                  height: 1.5,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Delete Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _understandConsequences
                ? () {
                    // TODO: Implement delete account functionality
                    _showFinalConfirmationDialog(context);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _AppColors.red600,
              foregroundColor: Colors.white,
              disabledBackgroundColor: _AppColors.slate200,
              disabledForegroundColor: _AppColors.slate400,
              elevation: _understandConsequences ? 2 : 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              shadowColor: _AppColors.red600.withOpacity(0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete_forever,
                  size: 22,
                  color: _understandConsequences
                      ? Colors.white
                      : _AppColors.slate400,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Delete My Account Permanently',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Cancel Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: _AppColors.slate300, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Cancel, Keep My Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _AppColors.slate700,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFinalConfirmationDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: _AppColors.slate900.withOpacity(0.7),
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _AppColors.red100,
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                size: 32,
                color: _AppColors.red600,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Final Confirmation',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: _AppColors.slate900,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Are you absolutely sure you want to delete your account? This action cannot be undone.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: _AppColors.slate600,
                height: 1.5,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(
                        color: _AppColors.slate200,
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _AppColors.slate700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Trigger deletion
                      ref
                          .read(deleteAccountControllerProvider.notifier)
                          .deleteAccount();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _AppColors.red600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Yes, Delete',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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
  }

  void _showDeletionRequestDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: _AppColors.slate900.withOpacity(0.7),
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: const EdgeInsets.all(32),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation(_AppColors.red600),
                backgroundColor: _AppColors.slate200,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Deletion Request Sending',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _AppColors.slate900,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Once successful you will be logged out',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _AppColors.slate600,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: _AppColors.slate900.withOpacity(0.7),
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.check_circle,
                size: 32,
                color: Color(0xFF16A34A),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Account Deleted',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: _AppColors.slate900,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Your account has been successfully deleted. You will now be logged out.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: _AppColors.slate600,
                height: 1.5,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Close dialog
                  Navigator.of(context, rootNavigator: true).pop();
                  // Sign out
                  await ref.read(authControllerProvider.notifier).signOut();
                  // Navigate to get started
                  if (context.mounted) {
                    context.go(AppRoutes.getStarted);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Okay',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: _AppColors.slate900.withOpacity(0.7),
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _AppColors.red100,
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 32,
                color: _AppColors.red600,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Deletion Failed',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: _AppColors.slate900,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Failed to delete account. Please try again later.',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: _AppColors.slate600,
                height: 1.5,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _AppColors.slate900,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
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
