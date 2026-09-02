import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/account_deletion_pending/view_model/account_deletion_pending_controller.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';
import 'package:prize24_app/utils/date_convertors.dart';

/// Design System Colors
class _AppColors {
  static const slate50 = Color(0xFFF8FAFC);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate300 = Color(0xFFCBD5E1);
  static const slate600 = Color(0xFF475569);
  static const slate700 = Color(0xFF334155);
  static const slate900 = Color(0xFF0F172A);
  static const orange100 = Color(0xFFFFEDD5);
  static const orange200 = Color(0xFFFED7AA);
  static const orange500 = Color(0xFFF97316);
  static const orange600 = Color(0xFFEA580C);
  static const orange800 = Color(0xFF9A3412);
}

/// Shown instead of Home whenever the signed-in user's account has a
/// pending deletion request (`AppUser.deletionRequestedAt != null`).
/// Lets the user cancel the request to keep the account, or sign out.
class AccountDeletionPendingPage extends ConsumerWidget {
  const AccountDeletionPendingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      accountDeletionPendingControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (success) {
            if (previous is AsyncLoading) {
              if (Navigator.canPop(context)) {
                Navigator.of(context, rootNavigator: true).pop();
              }
              if (success == true) {
                context.go(AppRoutes.home);
              } else if (success == false) {
                _showErrorDialog(context);
              }
            }
          },
          error: (error, stackTrace) {
            if (Navigator.canPop(context)) {
              Navigator.of(context, rootNavigator: true).pop();
            }
            _showErrorDialog(context);
          },
          loading: () {
            _showLoadingDialog(context);
          },
        );
      },
    );

    final user = ref.watch(authControllerProvider).value;
    final requestedAt = user?.deletionRequestedAt;

    return Scaffold(
      backgroundColor: _AppColors.slate50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildHeader(requestedAt),
              const SizedBox(height: 24),
              _buildInfoCard(),
              const SizedBox(height: 24),
              _buildActionButtons(context, ref),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(DateTime? requestedAt) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
            'Deletion Requested',
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
            requestedAt != null
                ? 'Requested on ${formatDate1(requestedAt)}'
                : 'Your account is pending deletion',
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

  Widget _buildInfoCard() {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _AppColors.orange100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _AppColors.orange200),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.hourglass_empty,
                      size: 12,
                      color: _AppColors.orange600,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'PENDING',
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
          const SizedBox(height: 16),
          const Text(
            'This account can\'t be used right now',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _AppColors.slate900,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You previously requested to delete this account. It will be '
            'permanently deleted once our team processes the request. If '
            'this was a mistake, you can cancel the request below to keep '
            'your account and data.',
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
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Cancel Deletion Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ref
                  .read(accountDeletionPendingControllerProvider.notifier)
                  .cancelAccountDeletion();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _AppColors.orange600,
              foregroundColor: Colors.white,
              elevation: 2,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              shadowColor: _AppColors.orange600.withOpacity(0.3),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.undo, size: 22, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Cancel Deletion Request',
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
        // Sign Out Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).signOut();
              if (context.mounted) {
                context.go(AppRoutes.getStarted);
              }
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: _AppColors.slate300, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Sign Out',
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

  void _showLoadingDialog(BuildContext context) {
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
            const SizedBox(
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
              'Cancelling Deletion Request',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _AppColors.slate900,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
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
              'Could Not Cancel Request',
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
              'Please try again later.',
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
