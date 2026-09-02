import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/become_staff_request_model.dart';
import 'package:prize24_app/features/shop_staffs/presentation/user_view_staff_requests/view_model/user_staff_request_action_controller.dart';
import 'package:prize24_app/features/shop_staffs/presentation/user_view_staff_requests/view_model/user_staff_requests_recieved_controller.dart';

// Design System - Matching HTML Theme
class _DesignTokens {
  // Colors - Matching Tailwind theme from HTML
  static const Color pageBg = Color(0xFFF8FAFC); // slate-50
  static const Color pageCard = Color(0xFFFFFFFF); // white
  static const Color pageInput = Color(0xFFF1F5F9); // slate-100
  static const Color textMain = Color(0xFF1E293B); // slate-800
  static const Color textSub = Color(0xFF64748B); // slate-500
  static const Color textAccent = Color(0xFF0F172A); // slate-900
  static const Color brandStart = Color(0xFFEF4444); // red-500
  static const Color brandEnd = Color(0xFFF97316); // orange-500

  // Gradient
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );

  // Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
}

class UserListStaffRequestsPage extends ConsumerStatefulWidget {
  const UserListStaffRequestsPage({super.key});

  @override
  ConsumerState<UserListStaffRequestsPage> createState() =>
      _UserListStaffRequestsPageState();
}

class _UserListStaffRequestsPageState
    extends ConsumerState<UserListStaffRequestsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll - 200) {
      ref.read(userStaffRequestsRecievedControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffRequestsAsync = ref.watch(
      userStaffRequestsRecievedControllerProvider,
    );

    ref.listen(userStaffRequestActionControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data == null && data!.$1 == null && data.$2 == null) return;
          final requestId = data.$1;
          final shopId = data.$2;
          ref
              .read(userStaffRequestsRecievedControllerProvider.notifier)
              .removeRequestFromState(requestId!);
          ref.read(authControllerProvider.notifier).updateUserShopList(shopId!);
        },
        error: (error, stackTrace) {
          showToastAtTop(context, 'Action failed ', false);
        },
      );
    });

    return Scaffold(
      backgroundColor: _DesignTokens.pageBg,
      appBar: AppBar(
        backgroundColor: _DesignTokens.pageCard,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Staff Invitations',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            color: _DesignTokens.textMain,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: staffRequestsAsync.when(
        data: (paginatedState) {
          final requests = paginatedState.page;
          if (requests.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => ref
                  .read(userStaffRequestsRecievedControllerProvider.notifier)
                  .refresh(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [_buildEmptyState(context)],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref
                .read(userStaffRequestsRecievedControllerProvider.notifier)
                .refresh(),
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount:
                  requests.length + (paginatedState.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                // Load-more footer
                if (index == requests.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final request = requests[index];
                return _StaffRequestCard(
                  request: request,
                  onAccept: () => _handleAcceptRequest(context, ref, request),
                  onDecline: () => _handleDeclineRequest(context, ref, request),
                );
              },
            ),
          );
        },
        loading: () => const Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(_DesignTokens.brandStart),
            ),
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: _DesignTokens.brandStart,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Error loading staff invitations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    color: _DesignTokens.textMain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    color: _DesignTokens.textSub,
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () =>
                      ref.refresh(userStaffRequestsRecievedControllerProvider),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: _DesignTokens.brandGradient,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: _DesignTokens.textSub.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No Staff Invitations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: _DesignTokens.textSub.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You have no pending staff invitations at the moment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                color: _DesignTokens.textSub.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleAcceptRequest(
    BuildContext context,
    WidgetRef ref,
    BecomeStaffRequestModel request,
  ) async {
    try {
      // await ref
      //     .read(userStaffRequestsRecievedControllerProvider.notifier)
      //     .acceptStaffRequest(request);

      ref
          .read(userStaffRequestActionControllerProvider.notifier)
          .performAction(request: request, action: 'accept');

      if (context.mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Accepted request from ${request.shopName}'),
        //     backgroundColor: _DesignTokens.textAccent,
        //   ),
        // );
        showToastAtTop(
          context,
          'Accepted request from ${request.shopName}',
          true,
        );
      }
    } catch (e) {
      if (context.mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Failed to accept request: $e'),
        //     backgroundColor: _DesignTokens.brandStart,
        //   ),
        // );
        showToastAtTop(context, 'Failed to accept request', false);
      }
    }
  }

  Future<void> _handleDeclineRequest(
    BuildContext context,
    WidgetRef ref,
    BecomeStaffRequestModel request,
  ) async {
    try {
      // await ref
      //     .read(userStaffRequestsRecievedControllerProvider.notifier)
      //     .declineStaffRequest(request);

      ref
          .read(userStaffRequestActionControllerProvider.notifier)
          .performAction(request: request, action: 'decline');

      if (context.mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Declined request from ${request.shopName}'),
        //     backgroundColor: _DesignTokens.brandStart,
        //   ),
        // );
        showToastAtTop(
          context,
          'Declined request from ${request.shopName}',
          true,
        );
      }
    } catch (e) {
      if (context.mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Failed to decline request: $e'),
        //     backgroundColor: _DesignTokens.brandStart,
        //   ),
        // );
        showToastAtTop(context, 'Failed to decline request', false);
      }
    }
  }
}

class _StaffRequestCard extends StatelessWidget {
  const _StaffRequestCard({
    required this.request,
    required this.onAccept,
    required this.onDecline,
  });

  final BecomeStaffRequestModel request;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  String _getInitials(String name) {
    if (name.trim().isEmpty) return '';
    final words = name.trim().split(' ').where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '';
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  String _formatRequestDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _DesignTokens.pageCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DesignTokens.pageInput, width: 1),
        boxShadow: _DesignTokens.cardShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    gradient: _DesignTokens.brandGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _getInitials(request.shopName),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.shopName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: _DesignTokens.textMain,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'wants to work at ${request.shopName}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Inter',
                          color: _DesignTokens.textSub,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Details
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                children: [
                  _buildInfoRow(
                    icon: Icons.storefront,
                    label: 'SHOP',
                    value: request.shopName,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    icon: Icons.access_time,
                    label: 'REQUESTED',
                    value: _formatRequestDate(request.requestedAt),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Actions
            Row(
              children: [
                Expanded(child: _buildDeclineButton()),
                const SizedBox(width: 12),
                Expanded(child: _buildAcceptButton()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: _DesignTokens.textSub),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
            color: _DesignTokens.textSub.withOpacity(0.7),
            letterSpacing: 0.5,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: _DesignTokens.textMain,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDeclineButton() {
    return InkWell(
      onTap: onDecline,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFFFCDD2), // red-200
            width: 1,
          ),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.close,
                size: 18,
                color: Color(0xFFEF5350), // red-500
              ),
              SizedBox(width: 6),
              Text(
                'Decline',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                  color: Color(0xFFEF5350),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAcceptButton() {
    return InkWell(
      onTap: onAccept,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          gradient: _DesignTokens.brandGradient,
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check, size: 18, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'Accept',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
