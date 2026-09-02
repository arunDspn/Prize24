import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/soft_delete_account/view_model/soft_delete_account_controller.dart';
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
  static const orange100 = Color(0xFFFFEDD5);
  static const orange200 = Color(0xFFFED7AA);
  static const orange500 = Color(0xFFF97316);
  static const orange600 = Color(0xFFEA580C);
  static const orange800 = Color(0xFF9A3412);
  static const blue50 = Color(0xFFEFF6FF);
  static const blue100 = Color(0xFFDBEAFE);
  static const blue600 = Color(0xFF2563EB);
}

class SoftDeleteAccountPage extends ConsumerStatefulWidget {
  const SoftDeleteAccountPage({super.key});

  @override
  ConsumerState<SoftDeleteAccountPage> createState() =>
      _SoftDeleteAccountPageState();
}

class _SoftDeleteAccountPageState
    extends ConsumerState<SoftDeleteAccountPage> {
  bool _understandConsequences = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      softDeleteAccountControllerProvider,
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
              _buildInfoMessage(),
              const SizedBox(height: 24),
              _buildWhatHappensList(),
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
                  'Deactivate Account',
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
                    color: _AppColors.orange100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _AppColors.orange200),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.pause_circle_outline,
                          size: 12, color: _AppColors.orange600),
                      SizedBox(width: 6),
                      Text(
                        'REQUEST',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _AppColors.orange800,
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
            _AppColors.orange500,
            _AppColors.orange600,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _AppColors.orange500.withOpacity(0.3),
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
              Icons.pause_circle_outline,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Request Account Deletion',
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
            'You can cancel this request anytime before it is processed',
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

  Widget _buildInfoMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _AppColors.blue50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _AppColors.blue100, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: _AppColors.blue600,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How This Works',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _AppColors.slate900,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'This sends a request to deactivate your account. Your data will not be removed immediately, and our team will process your request. You will be logged out once the request is submitted.',
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

  Widget _buildWhatHappensList() {
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
                Icons.checklist,
                color: _AppColors.orange600,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'What Happens Next',
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
            'Once you submit a deletion request:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _AppColors.slate600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 20),
          _buildStepItem(
            icon: Icons.send,
            title: 'Request Submitted',
            description:
                'Your account is marked for deletion and our team is notified',
            color: _AppColors.orange600,
          ),
          _buildStepItem(
            icon: Icons.lock_outline,
            title: 'Account Deactivated',
            description:
                'You will be signed out and won\'t be able to log back in while the request is pending',
            color: Color(0xFF3B82F6),
          ),
          _buildStepItem(
            icon: Icons.hourglass_empty,
            title: 'Data Retained Temporarily',
            description:
                'Your shops, campaigns, and account data stay intact until the request is reviewed and processed',
            color: Color(0xFF8B5CF6),
          ),
          _buildStepItem(
            icon: Icons.delete_outline,
            title: 'Final Deletion',
            description:
                'After review, your account and associated data will be permanently deleted',
            color: _AppColors.slate600,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
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
          color: _understandConsequences
              ? _AppColors.orange600
              : _AppColors.slate200,
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
              activeColor: _AppColors.orange600,
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
                'I understand that this will submit a request to delete my account, and I will be logged out immediately.',
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
        // Request Deletion Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _understandConsequences
                ? () {
                    _showFinalConfirmationDialog(context);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _AppColors.orange600,
              foregroundColor: Colors.white,
              disabledBackgroundColor: _AppColors.slate200,
              disabledForegroundColor: _AppColors.slate400,
              elevation: _understandConsequences ? 2 : 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              shadowColor: _AppColors.orange600.withOpacity(0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.send,
                  size: 22,
                  color: _understandConsequences
                      ? Colors.white
                      : _AppColors.slate400,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Send Deletion Request',
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
                color: _AppColors.orange100,
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                size: 32,
                color: _AppColors.orange600,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Confirm Deletion Request',
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
              'Are you sure you want to send a request to delete your account? You will be logged out immediately.',
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
                      // Trigger deletion request
                      ref
                          .read(softDeleteAccountControllerProvider.notifier)
                          .requestAccountDeletion();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _AppColors.orange600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Yes, Send Request',
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
                valueColor: AlwaysStoppedAnimation(_AppColors.orange600),
                backgroundColor: _AppColors.slate200,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sending Deletion Request',
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
              'Request Submitted',
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
              'Your account deletion request has been submitted. You will now be logged out.',
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
                color: _AppColors.orange100,
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 32,
                color: _AppColors.orange600,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Request Failed',
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
              'Failed to submit deletion request. Please try again later.',
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
