import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/campaign/domain/models/gift_redemption_audit_log_model.dart';
import 'package:prize24_app/features/campaign/presentation/campaign_redemption_audit_log/log_list/view_model/list_campaign_redemption_audit_log_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Shared color palette matching the vendor detail page theme
class _DC {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
  static const Color green50 = Color(0xFFF0FDF4);
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green500 = Color(0xFF22C55E);
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange500 = Color(0xFFF97316);
  static const Color purple50 = Color(0xFFF5F3FF);
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color red50 = Color(0xFFFFF1F2);
  static const Color red100 = Color(0xFFFFE4E6);
  static const Color red500 = Color(0xFFEF4444);
}

class CampaignRedemptionAuditLogListPage extends ConsumerStatefulWidget {
  const CampaignRedemptionAuditLogListPage({
    required this.campaignId,
    super.key,
  });

  final String campaignId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CampaignRedemptionAuditLogPageState();
}

class _CampaignRedemptionAuditLogPageState
    extends ConsumerState<CampaignRedemptionAuditLogListPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(
            listCampaignRedemptionAuditLogControllerProvider(
              campaignId: widget.campaignId,
            ).notifier,
          )
          .loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final redemptionAuditLogs = ref.watch(
      listCampaignRedemptionAuditLogControllerProvider(
        campaignId: widget.campaignId,
      ),
    );

    return Scaffold(
      backgroundColor: _DC.slate50,
      appBar: _buildAppBar(context),
      body: redemptionAuditLogs.when(
        data: (paginatedState) => _buildBody(paginatedState),
        loading: () => const Center(
          child: CircularProgressIndicator(color: _DC.brandStart),
        ),
        error: (error, _) => _buildErrorState(error),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: BoxDecoration(
          color: _DC.slate50.withOpacity(0.95),
          border: const Border(
            bottom: BorderSide(color: _DC.slate200, width: 1),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Back button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _DC.slate100,
                        border: Border.all(color: _DC.slate200, width: 1),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: _DC.slate700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Title
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Redemption Audit Log',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: _DC.slate800,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        'Campaign ID: ${widget.campaignId.length > 12 ? '${widget.campaignId.substring(0, 12)}…' : widget.campaignId}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: _DC.slate400,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
                // Refresh button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => ref
                        .read(
                          listCampaignRedemptionAuditLogControllerProvider(
                            campaignId: widget.campaignId,
                          ).notifier,
                        )
                        .refresh(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _DC.slate100,
                        border: Border.all(color: _DC.slate200, width: 1),
                      ),
                      child: const Icon(
                        Icons.refresh_rounded,
                        size: 18,
                        color: _DC.slate500,
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

  /// Builds a flat list that interleaves date-section headers with log items.
  List<Object> _buildFlatItems(List<GiftRedemptionAuditLogModel> logs) {
    final flat = <Object>[];
    DateTime? lastDate;
    for (var i = 0; i < logs.length; i++) {
      final d = logs[i].timestamp;
      final date = DateTime(d.year, d.month, d.day);
      if (lastDate == null || date != lastDate) {
        flat.add(date);
        lastDate = date;
      }
      flat.add(logs[i]);
    }
    return flat;
  }

  Widget _buildBody(PaginatedAuditLogState paginatedState) {
    final logs = paginatedState.items;

    if (logs.isEmpty) {
      return _buildEmptyState();
    }

    final flatItems = _buildFlatItems(logs);
    // Extra item count: +1 for the load-more footer
    final itemCount = flatItems.length + 1;

    return Column(
      children: [
        // Summary banner
        _buildSummaryBanner(logs.length, paginatedState.hasMore),
        // List
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == flatItems.length) {
                return _buildLoadMoreFooter(paginatedState);
              }
              final item = flatItems[index];
              if (item is DateTime) {
                return _DateSectionHeader(date: item);
              }
              final log = item as GiftRedemptionAuditLogModel;
              // Find the original index for the log item
              final logIndex = logs.indexOf(log);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _AuditLogListItem(log: log, index: logIndex),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadMoreFooter(PaginatedAuditLogState state) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: _DC.brandStart,
            ),
          ),
        ),
      );
    }
    if (!state.hasMore) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 40, height: 1, color: _DC.slate200),
            const SizedBox(width: 12),
            const Text(
              'All records loaded',
              style: TextStyle(
                fontSize: 12,
                color: _DC.slate400,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(width: 12),
            Container(width: 40, height: 1, color: _DC.slate200),
          ],
        ),
      );
    }
    return const SizedBox(height: 8);
  }

  Widget _buildSummaryBanner(int count, bool hasMore) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_DC.brandStart, _DC.brandEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _DC.brandStart.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.history_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Redemptions',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  hasMore ? '$count+ records' : '$count records',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.receipt_long_rounded, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text(
                  'Audit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _DC.slate100,
                shape: BoxShape.circle,
                border: Border.all(color: _DC.slate200, width: 1),
              ),
              child: const Icon(
                Icons.history_rounded,
                size: 36,
                color: _DC.slate400,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Redemptions Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _DC.slate700,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Redemption activity for this campaign\nwill appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _DC.slate400,
                height: 1.5,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _DC.red50,
                shape: BoxShape.circle,
                border: Border.all(color: _DC.red100, width: 1),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 36,
                color: _DC.red500,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Failed to Load',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _DC.slate700,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: _DC.slate400,
                height: 1.5,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => ref
                  .read(
                    listCampaignRedemptionAuditLogControllerProvider(
                      campaignId: widget.campaignId,
                    ).notifier,
                  )
                  .refresh(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_DC.brandStart, _DC.brandEnd],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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

class _DateSectionHeader extends StatelessWidget {
  const _DateSectionHeader({required this.date});

  final DateTime date;

  static const List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> _weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  String get _label {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (date == today) return 'Today';
    if (date == yesterday) return 'Yesterday';
    final weekday = _weekdays[date.weekday - 1];
    final month = _months[date.month - 1];
    return '$weekday, ${date.day} $month ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        children: [
          Container(width: 28, height: 1, color: _DC.slate200),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _DC.slate100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _DC.slate200, width: 1),
            ),
            child: Text(
              _label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _DC.slate500,
                fontFamily: 'Inter',
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Container(height: 1, color: _DC.slate200)),
        ],
      ),
    );
  }
}

class _AuditLogListItem extends StatelessWidget {
  const _AuditLogListItem({required this.log, required this.index});

  final GiftRedemptionAuditLogModel log;
  final int index;

  Color get _actionColor {
    switch (log.action.toLowerCase()) {
      case 'gift_redeemed':
        return _DC.green500;
      case 'gift_availed':
        return _DC.blue500;
      case 'gift_expired':
        return _DC.red500;
      default:
        return _DC.orange500;
    }
  }

  Color get _actionBgColor {
    switch (log.action.toLowerCase()) {
      case 'gift_redeemed':
        return _DC.green50;
      case 'gift_availed':
        return _DC.blue50;
      case 'gift_expired':
        return _DC.red50;
      default:
        return _DC.orange50;
    }
  }

  Color get _actionBorderColor {
    switch (log.action.toLowerCase()) {
      case 'gift_redeemed':
        return _DC.green100;
      case 'gift_availed':
        return _DC.blue100;
      case 'gift_expired':
        return _DC.red100;
      default:
        return _DC.orange100;
    }
  }

  IconData get _actionIcon {
    switch (log.action.toLowerCase()) {
      case 'gift_redeemed':
        return Icons.check_circle_outline_rounded;
      case 'gift_availed':
        return Icons.card_giftcard_rounded;
      case 'gift_expired':
        return Icons.cancel_outlined;
      default:
        return Icons.swap_horiz_rounded;
    }
  }

  String get _formattedTimestamp {
    final t = log.timestamp;
    final hour = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.hour >= 12 ? 'PM' : 'AM';
    return '${t.day}/${t.month}/${t.year}  $hour:$minute $period';
  }

  String get _displayAction {
    return log.action
        .replaceAll('_', ' ')
        .split(' ')
        .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : w)
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(
          AppRoutes.campaignRedemptionAuditLogDetail,
          extra: log,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _DC.slate100, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _actionBgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _actionBorderColor, width: 1),
                ),
                child: Icon(_actionIcon, color: _actionColor, size: 22),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Action label + role badge
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _displayAction,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _DC.slate800,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        _RoleBadge(role: log.redeemerRole),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Customer ID
                    _InfoRow(
                      icon: Icons.person_outline_rounded,
                      label: 'Customer',
                      value: log.customerId ?? 'Unknown Customer',
                    ),
                    const SizedBox(height: 4),
                    // Redeemed by
                    _InfoRow(
                      icon: Icons.badge_outlined,
                      label: 'By',
                      value: log.redeemedBy,
                    ),
                    const SizedBox(height: 4),
                    // Gift ID
                    _InfoRow(
                      icon: Icons.card_giftcard_outlined,
                      label: 'Gift',
                      value: log.giftId ?? 'N/A',
                    ),
                    if (log.shopId != null) ...[
                      const SizedBox(height: 4),
                      _InfoRow(
                        icon: Icons.store_outlined,
                        label: 'Shop',
                        value: log.shopId!,
                      ),
                    ],
                    const SizedBox(height: 10),
                    // Timestamp footer
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: _DC.slate400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formattedTimestamp,
                          style: const TextStyle(
                            fontSize: 11,
                            color: _DC.slate400,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 16,
                          color: _DC.slate400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.role});
  final String role;

  Color get _bgColor {
    switch (role.toLowerCase()) {
      case 'staff':
        return _DC.purple50;
      case 'vendor':
        return _DC.blue50;
      case 'admin':
        return _DC.red50;
      default:
        return _DC.slate100;
    }
  }

  Color get _textColor {
    switch (role.toLowerCase()) {
      case 'staff':
        return _DC.purple500;
      case 'vendor':
        return _DC.blue500;
      case 'admin':
        return _DC.red500;
      default:
        return _DC.slate600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        role.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: _textColor,
          fontFamily: 'Inter',
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final truncated = value.length > 22
        ? '${value.substring(0, 10)}…${value.substring(value.length - 6)}'
        : value;
    return Row(
      children: [
        Icon(icon, size: 13, color: _DC.slate400),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12,
            color: _DC.slate400,
            fontFamily: 'Inter',
          ),
        ),
        Expanded(
          child: Text(
            truncated,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _DC.slate600,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }
}
