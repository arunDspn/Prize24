import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/core/data/audit_log/activity_log_dto.dart';
import 'package:prize24_app/features/shop/domain/model/shop_activity_log.dart';
import 'package:prize24_app/features/shop/presentation/shop_activity_log/activity_log_list/ui/shop_activity_log_qr_scanner_page.dart';
import 'package:prize24_app/features/shop/presentation/shop_activity_log/activity_log_list/view_model/shop_activity_log_list_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

typedef UserQrScannerLauncher = Future<String?> Function(BuildContext context);

// Shared color palette
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
  static const Color teal50 = Color(0xFFF0FDFA);
  static const Color teal100 = Color(0xFFCCFBF1);
  static const Color teal500 = Color(0xFF14B8A6);
}

class ShopActivityLogListPage extends ConsumerStatefulWidget {
  const ShopActivityLogListPage({
    required this.shopId,
    this.qrScannerLauncher,
    super.key,
  });

  final String shopId;

  /// Overrides the default scanner route, allowing the scanner result flow to
  /// be exercised without a platform camera in widget tests.
  final UserQrScannerLauncher? qrScannerLauncher;

  @override
  ConsumerState<ShopActivityLogListPage> createState() =>
      _ShopActivityLogListPageState();
}

class _ShopActivityLogListPageState
    extends ConsumerState<ShopActivityLogListPage> {
  late final ScrollController _scrollController;
  late final TextEditingController _userIdController;
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _userIdController = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _userIdController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(
            shopActivityLogListControllerProvider(
              shopId: widget.shopId,
            ).notifier,
          )
          .loadMore();
    }
  }

  void _onSearch() {
    _searchFocus.unfocus();
    final query = _userIdController.text.trim();
    ref
        .read(
          shopActivityLogListControllerProvider(shopId: widget.shopId).notifier,
        )
        .search(query.isEmpty ? null : query);
  }

  void _onClearSearch() {
    _searchFocus.unfocus();
    _userIdController.clear();
    ref
        .read(
          shopActivityLogListControllerProvider(shopId: widget.shopId).notifier,
        )
        .search(null);
  }

  Future<void> _onScanQr() async {
    _searchFocus.unfocus();

    final userId =
        await (widget.qrScannerLauncher?.call(context) ??
            Navigator.of(context).push<String>(
              MaterialPageRoute<String>(
                fullscreenDialog: true,
                builder: (_) => const ShopActivityLogQrScannerPage(),
              ),
            ));

    if (!mounted || userId == null) return;

    final normalizedUserId = userId.trim();
    if (normalizedUserId.isEmpty) return;

    _userIdController.text = normalizedUserId;
    await ref
        .read(
          shopActivityLogListControllerProvider(shopId: widget.shopId).notifier,
        )
        .search(normalizedUserId);
  }

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(
      shopActivityLogListControllerProvider(shopId: widget.shopId),
    );

    return Scaffold(
      backgroundColor: _DC.slate50,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: logsAsync.when(
              data: (paginatedState) => _buildBody(paginatedState),
              loading: () => const Center(
                child: CircularProgressIndicator(color: _DC.brandStart),
              ),
              error: (error, _) => _buildErrorState(error),
            ),
          ),
        ],
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
                        'Shop Activity Log',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: _DC.slate800,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        'Shop ID: ${widget.shopId.length > 12 ? '${widget.shopId.substring(0, 12)}…' : widget.shopId}',
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
                          shopActivityLogListControllerProvider(
                            shopId: widget.shopId,
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

  Widget _buildSearchBar() {
    final notifier = ref.read(
      shopActivityLogListControllerProvider(shopId: widget.shopId).notifier,
    );
    final isFiltered = notifier.filterUserId != null;

    return Container(
      color: _DC.slate50,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isFiltered ? _DC.brandStart : _DC.slate200,
                  width: isFiltered ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _userIdController,
                focusNode: _searchFocus,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _onSearch(),
                style: const TextStyle(
                  fontSize: 13,
                  color: _DC.slate800,
                  fontFamily: 'Inter',
                ),
                decoration: InputDecoration(
                  hintText: 'Filter by User ID…',
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: _DC.slate400,
                    fontFamily: 'Inter',
                  ),
                  prefixIcon: const Icon(
                    Icons.person_search_rounded,
                    size: 18,
                    color: _DC.slate400,
                  ),
                  suffixIcon: isFiltered
                      ? GestureDetector(
                          onTap: _onClearSearch,
                          child: const Icon(
                            Icons.close_rounded,
                            size: 16,
                            color: _DC.slate400,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _FilterActionButton(
            key: const ValueKey('search-user-id'),
            tooltip: 'Search User ID',
            icon: Icons.search_rounded,
            onTap: _onSearch,
          ),
          const SizedBox(width: 8),
          _FilterActionButton(
            key: const ValueKey('scan-user-qr'),
            tooltip: 'Scan User QR',
            icon: Icons.qr_code_scanner_rounded,
            onTap: _onScanQr,
          ),
        ],
      ),
    );
  }

  /// Builds a flat list that interleaves date-section headers with log items.
  List<Object> _buildFlatItems(List<ShopActivityLogEntry> logs) {
    final flat = <Object>[];
    DateTime? lastDate;
    for (final log in logs) {
      final d = log.timestamp;
      final date = DateTime(d.year, d.month, d.day);
      if (lastDate == null || date != lastDate) {
        flat.add(date);
        lastDate = date;
      }
      flat.add(log);
    }
    return flat;
  }

  Widget _buildBody(PaginatedShopActivityLogState paginatedState) {
    final logs = paginatedState.items;
    final notifier = ref.read(
      shopActivityLogListControllerProvider(shopId: widget.shopId).notifier,
    );
    final filterUserId = notifier.filterUserId;

    if (logs.isEmpty) {
      return _buildEmptyState(filterUserId: filterUserId);
    }

    final flatItems = _buildFlatItems(logs);
    final itemCount = flatItems.length + 1; // +1 for load-more footer

    return Column(
      children: [
        // Summary banner
        _buildSummaryBanner(
          logs.length,
          paginatedState.hasMore,
          filterUserId: filterUserId,
        ),
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
              final log = item as ShopActivityLogEntry;
              final logIndex = logs.indexOf(log);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ActivityLogListItem(log: log, index: logIndex),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadMoreFooter(PaginatedShopActivityLogState state) {
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

  Widget _buildSummaryBanner(int count, bool hasMore, {String? filterUserId}) {
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
              Icons.manage_history_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filterUserId != null
                      ? 'Filtered Activities'
                      : 'Total Activities',
                  style: const TextStyle(
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
                if (filterUserId != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'User: ${filterUserId.length > 20 ? '${filterUserId.substring(0, 10)}…${filterUserId.substring(filterUserId.length - 6)}' : filterUserId}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white70,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  filterUserId != null
                      ? Icons.person_rounded
                      : Icons.timeline_rounded,
                  color: Colors.white,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  filterUserId != null ? 'Filtered' : 'Activity',
                  style: const TextStyle(
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

  Widget _buildEmptyState({String? filterUserId}) {
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
              child: Icon(
                filterUserId != null
                    ? Icons.person_search_rounded
                    : Icons.manage_history_rounded,
                size: 36,
                color: _DC.slate400,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              filterUserId != null ? 'No Results' : 'No Activity Yet',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _DC.slate700,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              filterUserId != null
                  ? 'No activity logs found\nfor this user ID.'
                  : 'Shop activity events will\nappear here.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: _DC.slate400,
                height: 1.5,
                fontFamily: 'Inter',
              ),
            ),
            if (filterUserId != null) ...[
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _onClearSearch,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: _DC.slate100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _DC.slate200),
                  ),
                  child: const Text(
                    'Clear Filter',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _DC.slate600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
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
                    shopActivityLogListControllerProvider(
                      shopId: widget.shopId,
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

class _FilterActionButton extends StatelessWidget {
  const _FilterActionButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_DC.brandStart, _DC.brandEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _DC.brandStart.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onTap,
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Date section header
// ---------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------
// Activity log list item
// ---------------------------------------------------------------------------

class _ActivityLogListItem extends StatelessWidget {
  const _ActivityLogListItem({required this.log, required this.index});

  final ShopActivityLogEntry log;
  final int index;

  Color get _actionColor {
    switch (log.action) {
      case 'check_in_success':
        return _DC.green500;
      case 'gift_avail_triggered':
        return _DC.blue500;
      case 'follower_added':
        return _DC.teal500;
      case 'check_in_failed':
        return _DC.red500;
      default:
        return _DC.orange500;
    }
  }

  Color get _actionBgColor {
    switch (log.action) {
      case 'check_in_success':
        return _DC.green50;
      case 'gift_avail_triggered':
        return _DC.blue50;
      case 'follower_added':
        return _DC.teal50;
      case 'check_in_failed':
        return _DC.red50;
      default:
        return _DC.orange50;
    }
  }

  Color get _actionBorderColor {
    switch (log.action) {
      case 'check_in_success':
        return _DC.green100;
      case 'gift_avail_triggered':
        return _DC.blue100;
      case 'follower_added':
        return _DC.teal100;
      case 'check_in_failed':
        return _DC.red100;
      default:
        return _DC.orange100;
    }
  }

  IconData get _actionIcon {
    switch (log.action) {
      case 'check_in_success':
        return Icons.check_circle_outline_rounded;
      case 'gift_avail_triggered':
        return Icons.card_giftcard_rounded;
      case 'follower_added':
        return Icons.person_add_outlined;
      case 'check_in_failed':
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

  /// Extracts the primary customer ID from the payload (if available).
  String? get _customerId {
    final p = log.payload;
    return switch (p) {
      ShopGiftAvailTriggeredPayload(:final customerId) => customerId,
      ShopCheckInSuccessPayload(:final customerId) => customerId,
      ShopCheckInFailedPayload(:final customerId) => customerId,
      ShopFollowerAddedPayload(:final customerId) => customerId,
      UnknownShopPayload() => null,
    };
  }

  /// Extracts supplementary detail lines for each action type.
  List<({IconData icon, String label, String value})> get _detailRows {
    final p = log.payload;
    return switch (p) {
      ShopGiftAvailTriggeredPayload() => [
        if ((p).giftName != null)
          (
            icon: Icons.card_giftcard_outlined,
            label: 'Gift',
            value: p.giftName!,
          ),
        (icon: Icons.bar_chart_rounded, label: 'Status', value: p.availStatus),
        if (p.streakValue != null)
          (
            icon: Icons.local_fire_department_outlined,
            label: 'Streak',
            value: '${p.streakValue}',
          ),
      ],
      ShopCheckInSuccessPayload() => [
        (
          icon: Icons.receipt_long_outlined,
          label: 'Bill ID',
          value: p.billNumber,
        ),
        (
          icon: Icons.payments_outlined,
          label: 'Bill Amount',
          value: p.billAmount.toStringAsFixed(2),
        ),
        (
          icon: Icons.local_fire_department_outlined,
          label: 'Streak',
          value: '${p.cumulativeStreak}',
        ),
        (
          icon: Icons.calendar_today_outlined,
          label: 'Days',
          value: '${p.consecutiveDays} consecutive',
        ),
        if (p.bonusApplied && p.bonusValue != null)
          (
            icon: Icons.star_outline_rounded,
            label: 'Bonus',
            value: '+${p.bonusValue}',
          ),
      ],
      ShopCheckInFailedPayload() => [
        if (p.failureReason != null)
          (
            icon: Icons.info_outline_rounded,
            label: 'Reason',
            value: p.failureReason!,
          ),
      ],
      ShopFollowerAddedPayload() => [
        (
          icon: Icons.how_to_reg_outlined,
          label: 'Method',
          value: p.addedMethod,
        ),
        (
          icon: Icons.local_fire_department_outlined,
          label: 'Initial Streak',
          value: '${p.initialStreak}',
        ),
      ],
      UnknownShopPayload() => [],
    };
  }

  @override
  Widget build(BuildContext context) {
    final details = _detailRows;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(AppRoutes.shopActivityLogDetail, extra: log),
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
                    // Action label + role badge + success indicator
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
                        _RoleBadge(role: log.actorRole),
                        const SizedBox(width: 6),
                        _SuccessBadge(success: log.success),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Customer ID
                    if (_customerId != null) ...[
                      _InfoRow(
                        icon: Icons.person_outline_rounded,
                        label: 'Customer',
                        value: _customerId!,
                      ),
                      const SizedBox(height: 4),
                    ],
                    // Actor ID
                    _InfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Actor',
                      value: log.actorId,
                    ),
                    // Payload-specific detail rows
                    for (final row in details) ...[
                      const SizedBox(height: 4),
                      _InfoRow(
                        icon: row.icon,
                        label: row.label,
                        value: row.value,
                      ),
                    ],
                    // Error info (if any)
                    if (!log.success && log.errorMessage != null) ...[
                      const SizedBox(height: 4),
                      _InfoRow(
                        icon: Icons.error_outline_rounded,
                        label: 'Error',
                        value: log.errorMessage!,
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

// ---------------------------------------------------------------------------
// Role badge
// ---------------------------------------------------------------------------

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.role});
  final ActivityLogActorRole role;

  Color get _bgColor {
    switch (role) {
      case ActivityLogActorRole.staff:
        return _DC.purple50;
      case ActivityLogActorRole.owner:
        return _DC.blue50;
      case ActivityLogActorRole.sharedVendor:
        return _DC.orange50;
      case ActivityLogActorRole.system:
        return _DC.slate100;
      case ActivityLogActorRole.customer:
        return _DC.teal50;
    }
  }

  Color get _textColor {
    switch (role) {
      case ActivityLogActorRole.staff:
        return _DC.purple500;
      case ActivityLogActorRole.owner:
        return _DC.blue500;
      case ActivityLogActorRole.sharedVendor:
        return _DC.orange500;
      case ActivityLogActorRole.system:
        return _DC.slate600;
      case ActivityLogActorRole.customer:
        return _DC.teal500;
    }
  }

  String get _label => role.toJson().toUpperCase().replaceAll('_', ' ');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
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

// ---------------------------------------------------------------------------
// Success / failure badge
// ---------------------------------------------------------------------------

class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge({required this.success});
  final bool success;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: success ? _DC.green50 : _DC.red50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: success ? _DC.green100 : _DC.red100,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            success ? Icons.check_rounded : Icons.close_rounded,
            size: 10,
            color: success ? _DC.green500 : _DC.red500,
          ),
          const SizedBox(width: 3),
          Text(
            success ? 'OK' : 'FAIL',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: success ? _DC.green500 : _DC.red500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Info row
// ---------------------------------------------------------------------------

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
