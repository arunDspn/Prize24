import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_request_model.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_sent_request_model.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_friends_and_requests/tabs/requests_tab/view_model/vendor_friend_requests_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_friends_and_requests/tabs/requests_tab/view_model/vendor_sent_requests_controller.dart';

// Design system colors from HTML
const Color _pageBg = Color(0xFFF8FAFC);
const Color _cardBg = Color(0xFFFFFFFF);
const Color _inputBg = Color(0xFFF1F5F9);
const Color _textMain = Color(0xFF1E293B);
const Color _textSub = Color(0xFF64748B);
const Color _brandStart = Color(0xFFEF4444);
const Color _brandEnd = Color(0xFFF97316);

enum RequestType { received, sent }

class RequestsTabView extends ConsumerStatefulWidget {
  const RequestsTabView({super.key});
  @override
  ConsumerState<RequestsTabView> createState() => _RequestsTabViewState();
}

class _RequestsTabViewState extends ConsumerState<RequestsTabView> {
  RequestType _selectedType = RequestType.received;
  final _receivedScrollController = ScrollController();
  final _sentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _receivedScrollController.addListener(_onReceivedScroll);
    _sentScrollController.addListener(_onSentScroll);
  }

  @override
  void dispose() {
    _receivedScrollController.dispose();
    _sentScrollController.dispose();
    super.dispose();
  }

  void _onReceivedScroll() {
    if (_receivedScrollController.position.pixels >=
        _receivedScrollController.position.maxScrollExtent - 200) {
      ref.read(vendorFriendRequestsControllerProvider.notifier).loadMore();
    }
  }

  void _onSentScroll() {
    if (_sentScrollController.position.pixels >=
        _sentScrollController.position.maxScrollExtent - 200) {
      ref.read(vendorSentRequestsControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final requestsState = ref.watch(vendorFriendRequestsControllerProvider);

    return ColoredBox(
      color: _pageBg,
      child: Column(
        children: [
          _buildSegmentedControl(),
          Expanded(
            child: _selectedType == RequestType.received
                ? _buildReceivedRequestsView(context, requestsState)
                : _buildSentRequestsView(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _inputBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            left: _selectedType == RequestType.received
                ? 0
                : MediaQuery.of(context).size.width / 2 - 20,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width / 2 - 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildSegmentButton(
                  RequestType.received,
                  Icons.move_to_inbox_outlined,
                  'Received',
                ),
              ),
              Expanded(
                child: _buildSegmentButton(
                  RequestType.sent,
                  Icons.send_outlined,
                  'Sent',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(RequestType type, IconData icon, String label) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: isSelected ? _textMain : _textSub),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? _textMain : _textSub,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceivedRequestsView(
    BuildContext context,
    AsyncValue<VendorFriendRequestsPaginatedState> requestsState,
  ) {
    return RefreshIndicator(
      backgroundColor: _cardBg,
      color: _brandStart,
      onRefresh: () =>
          ref.read(vendorFriendRequestsControllerProvider.notifier).refresh(),
      child: requestsState.when(
        data: (paginatedState) => _buildRequestsList(
          context,
          ref,
          paginatedState.page,
          paginatedState.isLoadingMore,
        ),
        loading: _buildLoadingView,
        error: (error, stack) => _buildErrorView(error.toString()),
      ),
    );
  }

  Widget _buildSentRequestsView(BuildContext context) {
    final sentRequestsState = ref.watch(vendorSentRequestsControllerProvider);
    return RefreshIndicator(
      backgroundColor: _cardBg,
      color: _brandStart,
      onRefresh: () =>
          ref.read(vendorSentRequestsControllerProvider.notifier).refresh(),
      child: sentRequestsState.when(
        data: (paginatedState) => _buildSentRequestsList(
          context,
          ref,
          paginatedState.page,
          paginatedState.isLoadingMore,
        ),
        loading: _buildLoadingView,
        error: (error, stack) => _buildSentErrorView(error.toString()),
      ),
    );
  }

  Widget _buildRequestsList(
    BuildContext context,
    WidgetRef ref,
    List<VendorFriendRequestModel> requests,
    bool isLoadingMore,
  ) {
    if (requests.isEmpty && !isLoadingMore) {
      return _buildEmptyView(
        Icons.move_to_inbox_outlined,
        'No Received Requests',
        "You don't have any pending requests.",
      );
    }
    return ListView.builder(
      controller: _receivedScrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: requests.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == requests.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(_brandStart),
              ),
            ),
          );
        }
        return _ReceivedRequestCard(request: requests[index]);
      },
    );
  }

  Widget _buildSentRequestsList(
    BuildContext context,
    WidgetRef ref,
    List<VendorSentRequestModel> sentRequests,
    bool isLoadingMore,
  ) {
    if (sentRequests.isEmpty && !isLoadingMore) {
      return _buildEmptyView(
        Icons.send_outlined,
        'No Sent Requests',
        "You haven't sent any friend requests yet.",
      );
    }
    return ListView.builder(
      controller: _sentScrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: sentRequests.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == sentRequests.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(_brandStart),
              ),
            ),
          );
        }
        return _SentRequestCard(request: sentRequests[index]);
      },
    );
  }

  Widget _buildEmptyView(IconData icon, String title, String desc) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: _inputBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 48, color: _textSub.withOpacity(0.5)),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textMain,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _textSub,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView() => const Center(
    child: SizedBox(
      width: 32,
      height: 32,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(_brandStart),
      ),
    ),
  );

  Widget _buildErrorView(String error) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.error_outline, size: 48, color: Colors.red),
        ),
        const SizedBox(height: 24),
        const Text(
          'Failed to Load Requests',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _textMain,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          error,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: _textSub,
            fontFamily: 'Inter',
          ),
        ),
      ],
    ),
  );

  Widget _buildSentErrorView(String error) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.error_outline, size: 48, color: Colors.red),
        ),
        const SizedBox(height: 24),
        const Text(
          'Failed to Load Sent Requests',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _textMain,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: _textSub,
              fontFamily: 'Inter',
            ),
          ),
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: () {
            ref.invalidate(vendorSentRequestsControllerProvider);
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Try Again'),
          style: OutlinedButton.styleFrom(
            foregroundColor: _textSub,
            side: const BorderSide(color: _inputBg),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    ),
  );
}

String _formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);
  if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
  }
  if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
  }
  if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
  }
  return 'Just now';
}

String _getInitials(String name) => name
    .split(' ')
    .take(2)
    .map((n) => n.isNotEmpty ? n[0] : '')
    .join()
    .toUpperCase();

class _ReceivedRequestCard extends ConsumerWidget {
  const _ReceivedRequestCard({required this.request});
  final VendorFriendRequestModel request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _inputBg),
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
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [_brandStart, _brandEnd]),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _getInitials(request.vendorName),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
                      request.vendorName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _textMain,
                        fontFamily: 'Inter',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(request.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: _textSub,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Decline',
                  icon: Icons.close,
                  isOutlined: true,
                  color: Colors.red,
                  onTap: () => _handleDecline(context, ref),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  label: 'Accept',
                  icon: Icons.check,
                  isOutlined: false,
                  color: _brandStart,
                  onTap: () => _handleAccept(context, ref),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleAccept(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (ctx) => _ConfirmDialog(
        iconBgColor: const Color(0xFFFED7AA),
        iconColor: _brandEnd,
        icon: Icons.person_add_outlined,
        title: 'Accept Request',
        desc: 'Accept friend request from ${request.vendorName}?',
        confirmText: 'Accept',
        confirmGradient: true,
        onConfirm: () {
          Navigator.of(ctx).pop();
          ref
              .read(vendorFriendRequestsControllerProvider.notifier)
              .acceptRequest(request);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Accepted ${request.vendorName}'),
          //     backgroundColor: _textMain,
          //     behavior: SnackBarBehavior.floating,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          // );
          showToastAtTop(context, 'Accepted ${request.vendorName}', true);
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  void _handleDecline(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (ctx) => _ConfirmDialog(
        iconBgColor: Colors.red.shade100,
        iconColor: Colors.red,
        icon: Icons.cancel_outlined,
        title: 'Decline Request',
        desc: 'Decline friend request from ${request.vendorName}?',
        confirmText: 'Decline',
        confirmGradient: false,
        confirmColor: Colors.red,
        onConfirm: () {
          Navigator.of(ctx).pop();
          ref
              .read(vendorFriendRequestsControllerProvider.notifier)
              .declineRequest(request);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Declined ${request.vendorName}'),
          //     backgroundColor: Colors.red,
          //     behavior: SnackBarBehavior.floating,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          // );
          showToastAtTop(context, 'Declined ${request.vendorName}', false);
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }
}

class _SentRequestCard extends ConsumerWidget {
  const _SentRequestCard({required this.request});
  final VendorSentRequestModel request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color statusBgColor;
    Color statusTextColor;
    IconData statusIcon;
    String statusText;
    switch (request.status) {
      case 'pending':
        statusBgColor = const Color(0xFFFFF7ED);
        statusTextColor = const Color(0xFFEA580C);
        statusIcon = Icons.schedule;
        statusText = 'PENDING';
      case 'accepted':
        statusBgColor = const Color(0xFFF0FDF4);
        statusTextColor = const Color(0xFF16A34A);
        statusIcon = Icons.check_circle;
        statusText = 'ACCEPTED';
      case 'declined':
        statusBgColor = const Color(0xFFFEF2F2);
        statusTextColor = const Color(0xFFDC2626);
        statusIcon = Icons.cancel;
        statusText = 'DECLINED';
      default:
        statusBgColor = _inputBg;
        statusTextColor = _textSub;
        statusIcon = Icons.help;
        statusText = 'UNKNOWN';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _inputBg),
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
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [_brandStart, _brandEnd]),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _getInitials(request.receiverName),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
                      request.receiverName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _textMain,
                        fontFamily: 'Inter',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(request.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: _textSub,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 12, color: statusTextColor),
                    const SizedBox(width: 6),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: statusTextColor,
                        letterSpacing: 0.5,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (request.status == 'pending') ...[
            const SizedBox(height: 16),
            _ActionButton(
              label: 'Cancel Request',
              icon: Icons.cancel_outlined,
              isOutlined: true,
              color: Colors.red,
              fullWidth: true,
              onTap: () => _handleCancel(context, ref),
            ),
          ],
        ],
      ),
    );
  }

  void _handleCancel(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (ctx) => _ConfirmDialog(
        iconBgColor: Colors.red.shade100,
        iconColor: Colors.red,
        icon: Icons.send_outlined,
        title: 'Cancel Request',
        desc: 'Cancel request sent to ${request.receiverName}?',
        confirmText: 'Yes, Cancel',
        confirmGradient: false,
        confirmColor: Colors.red,
        onConfirm: () {
          Navigator.of(ctx).pop();
          ref
              .read(vendorSentRequestsControllerProvider.notifier)
              .cancelSentRequest(request);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Cancelled request to ${request.receiverName}'),
          //     backgroundColor: Colors.red,
          //     behavior: SnackBarBehavior.floating,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          // );
          showToastAtTop(
            context,
            'Cancelled request to ${request.receiverName}',
            false,
          );
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isOutlined,
    required this.color,
    required this.onTap,
    this.fullWidth = false,
  });
  final String label;
  final IconData icon;
  final bool isOutlined;
  final Color color;
  final VoidCallback onTap;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: fullWidth ? double.infinity : null,
        decoration: BoxDecoration(
          gradient: isOutlined
              ? null
              : const LinearGradient(colors: [_brandStart, _brandEnd]),
          border: isOutlined ? Border.all(color: color.withOpacity(0.3)) : null,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isOutlined
              ? null
              : [
                  BoxShadow(
                    color: _brandStart.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: isOutlined ? color : Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isOutlined ? color : Colors.white,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({
    required this.iconBgColor,
    required this.iconColor,
    required this.icon,
    required this.title,
    required this.desc,
    required this.confirmText,
    required this.onConfirm,
    required this.onCancel,
    this.confirmGradient = false,
    this.confirmColor,
  });
  final Color iconBgColor;
  final Color iconColor;
  final IconData icon;
  final String title;
  final String desc;
  final String confirmText;
  final bool confirmGradient;
  final Color? confirmColor;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: iconColor),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _textMain,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: const TextStyle(
                fontSize: 14,
                color: _textSub,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onCancel,
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        border: Border.all(color: _inputBg),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _textSub,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: confirmGradient
                            ? const LinearGradient(
                                colors: [_brandStart, _brandEnd],
                              )
                            : null,
                        color: confirmGradient ? null : confirmColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: (confirmColor ?? _brandStart).withOpacity(
                              0.3,
                            ),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          confirmText,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Inter',
                          ),
                        ),
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
}
