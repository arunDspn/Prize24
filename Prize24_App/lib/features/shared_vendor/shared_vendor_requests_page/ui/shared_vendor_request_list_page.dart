import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_sharing_request_model.dart';
import 'package:prize24_app/features/shared_vendor/shared_vendor_requests_page/view_model/respond_shared_campaign_request_controller.dart';
import 'package:prize24_app/features/shared_vendor/shared_vendor_requests_page/view_model/shared_vendor_requests_controller.dart';

// Design System Colors (from HTML)
class _DesignColors {
  static const pageBg = Color(0xFFF8FAFC); // slate-50
  static const pageCard = Color(0xFFFFFFFF); // white
  static const pageInput = Color(0xFFF1F5F9); // slate-100
  static const textMain = Color(0xFF1E293B); // slate-800
  static const textSub = Color(0xFF64748B); // slate-500
  static const textAccent = Color(0xFF0F172A); // slate-900
  static const brandStart = Color(0xFFEF4444); // red-500
  static const brandEnd = Color(0xFFF97316); // orange-500
  static const red50 = Color(0xFFFEF2F2);
  static const red100 = Color(0xFFFEE2E2);
  static const red200 = Color(0xFFFECACA);
  static const red500 = Color(0xFFEF4444);
  static const red600 = Color(0xFFDC2626);

  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

class SharedVendorRequestListPage extends ConsumerStatefulWidget {
  const SharedVendorRequestListPage({super.key});

  @override
  ConsumerState<SharedVendorRequestListPage> createState() =>
      _SharedVendorRequestListPageState();
}

class _SharedVendorRequestListPageState
    extends ConsumerState<SharedVendorRequestListPage> {
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
      ref.read(sharedVendorRequestsControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sharedVendorRequestsControllerProvider);

    ref.listen(respondSharedCampaignRequestControllerProvider, (
      previous,
      next,
    ) {
      next.mapOrNull(
        loading: (loading) {
          // Show non dismissible loading dialog
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _DesignColors.pageCard,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _DesignColors.brandStart,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        error: (error) {
          // Dismiss loading dialog
          Navigator.of(context, rootNavigator: true).pop();
          _showToast(
            context,
            // 'Failed to respond to request: ${error.error}',
            'Failed to respond to request. Please try again.',
            isError: true,
          );
        },
        data: (data) {
          if (data.value.$1 != null && data.value.$2 != null) {
            // Dismiss loading dialog
            Navigator.of(context, rootNavigator: true).pop();
            final actionText = data.value.$2 == 'accept'
                ? 'Accepted'
                : 'Declined';

            // Update the request list state to remove the responded request
            ref
                .read(sharedVendorRequestsControllerProvider.notifier)
                .updateRequestState(data.value.$1!, data.value.$2!);
            if (context.mounted) {
              _showToast(
                context,
                '$actionText request with ID: ${data.value.$1}',
                isError: data.value.$2 == 'decline',
              );
            }
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: _DesignColors.pageBg,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          decoration: BoxDecoration(
            color: _DesignColors.pageCard.withValues(alpha: 0.95),
            border: const Border(
              bottom: BorderSide(color: _DesignColors.pageInput, width: 1),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Back button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                          color: _DesignColors.textMain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title
                  Expanded(
                    child: Text(
                      'Pending Campaign Requests',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _DesignColors.textMain,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: state.when(
        data: (paginatedState) {
          final requests = paginatedState.page;
          if (requests.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => ref
                  .read(sharedVendorRequestsControllerProvider.notifier)
                  .refresh(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [_buildEmptyState()],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref
                .read(sharedVendorRequestsControllerProvider.notifier)
                .refresh(),
            child: ListView.builder(
              controller: _scrollController,
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
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    top: 8,
                    left: 16,
                    right: 16,
                  ),
                  child: _ShareCampaignRequestCard(requestModel: request),
                );
              },
            ),
          );
        },
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(
          "Something went wrong while loading requests. Please try again.",
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 64),
        child: SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              _DesignColors.brandStart.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: _DesignColors.pageInput,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.folder_open_outlined,
                size: 36,
                color: _DesignColors.textSub.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No pending requests',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _DesignColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You have no pending campaign requests found.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: _DesignColors.textSub,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _DesignColors.red50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 36,
                color: _DesignColors.red500,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Something went wrong',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _DesignColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: _DesignColors.textSub,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).padding.bottom + 24,
        left: 16,
        right: 16,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 200),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isError
                      ? _DesignColors.brandStart
                      : _DesignColors.textAccent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isError
                          ? Icons.cancel_outlined
                          : Icons.check_circle_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        message,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

class _ShareCampaignRequestCard extends ConsumerWidget {
  const _ShareCampaignRequestCard({required this.requestModel});

  final CampaignSharingRequestModel requestModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: _DesignColors.pageCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DesignColors.pageInput),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with campaign name
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              requestModel.campaignName,
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _DesignColors.textMain,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // const SizedBox(height: 20),

          // Metadata Info
          // Vendor Row
          // Row(
          //   children: [
          //     ShaderMask(
          //       shaderCallback: (bounds) =>
          //           _DesignColors.gradient.createShader(bounds),
          //       child: const Icon(
          //         Icons.business_rounded,
          //         size: 18,
          //         color: Colors.white,
          //       ),
          //     ),
          //     const SizedBox(width: 8),
          //     Expanded(
          //       child: Text(
          //         'From: ${requestModel.senderVendorId}',
          //         style: GoogleFonts.inter(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w600,
          //           color: _DesignColors.textMain,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 8),

          // Date Row
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 18,
                color: _DesignColors.textSub,
              ),
              const SizedBox(width: 8),
              Text(
                'Requested: ${_formatDate(requestModel.requestAt)}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: _DesignColors.textSub,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          // Divider
          Container(height: 1, color: _DesignColors.pageInput),
          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              // Decline Button
              Expanded(
                child: _DeclineButton(
                  onPressed:
                      ref
                          .watch(sharedVendorRequestsControllerProvider)
                          .isLoading
                      ? null
                      : () => _onDeclinePressed(context, ref),
                  isLoading: ref
                      .watch(sharedVendorRequestsControllerProvider)
                      .isLoading,
                ),
              ),
              const SizedBox(width: 12),
              // Accept Button
              Expanded(
                child: _AcceptButton(
                  onPressed:
                      ref
                          .watch(sharedVendorRequestsControllerProvider)
                          .isLoading
                      ? null
                      : () => _onAcceptPressed(context, ref),
                  isLoading: ref
                      .watch(sharedVendorRequestsControllerProvider)
                      .isLoading,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onAcceptPressed(BuildContext context, WidgetRef ref) async {
    await ref
        .read(respondSharedCampaignRequestControllerProvider.notifier)
        .respondToRequest(requestModel.id, 'accept');
  }

  void _onDeclinePressed(BuildContext context, WidgetRef ref) {
    // Show confirmation dialog before declining
    showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 384),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: _DesignColors.pageCard,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Decline Request',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _DesignColors.textMain,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: _DesignColors.textSub,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'Are you sure you want to decline the request for "',
                    ),
                    TextSpan(
                      text: requestModel.campaignName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: _DesignColors.textMain,
                      ),
                    ),
                    const TextSpan(text: '"?'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Cancel Button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(false),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _DesignColors.textSub,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Decline Confirm Button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(true),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: _DesignColors.red50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _DesignColors.red100),
                        ),
                        child: Text(
                          'Decline',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _DesignColors.red600,
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
      ),
    ).then((confirmed) async {
      if (confirmed == true) {
        await ref
            .read(respondSharedCampaignRequestControllerProvider.notifier)
            .respondToRequest(requestModel.id, 'decline');
      }
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

class _DeclineButton extends StatelessWidget {
  const _DeclineButton({required this.onPressed, required this.isLoading});

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _DesignColors.red200),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _DesignColors.red500,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: _DesignColors.red500,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Decline',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _DesignColors.red500,
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

class _AcceptButton extends StatelessWidget {
  const _AcceptButton({required this.onPressed, required this.isLoading});

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 48,
          decoration: BoxDecoration(
            gradient: _DesignColors.gradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _DesignColors.brandStart.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Accept',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
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
