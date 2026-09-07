import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/phone_number_link.dart';
import 'package:prize24_app/features/happy_hours/domain/model/shop_follower_model.dart';
import 'package:prize24_app/features/shop/domain/model/follower_streak_log_model.dart';
import 'package:prize24_app/features/shop/presentation/shop_follower_detail/component/user_streak_log/user_streak_log_controller.dart';

/// Theme constants matching the profile/settings page design
class _FollowerDetailTheme {
  static const Color bgColor = Color(0xFFF8FAFC);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF1E293B);
  static const Color textSub = Color(0xFF64748B);
  static const Color inputBg = Color(0xFFF1F5F9);
  static const Color gradStart = Color(0xFFEF4444); // red-500
  static const Color gradEnd = Color(0xFFF97316); // orange-500
}

class ShopFollowerDetailPage extends ConsumerWidget {
  const ShopFollowerDetailPage({
    required this.follower,
    required this.shopId,
    super.key,
  });

  final ShopFollowerModel follower;
  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = userStreakLogControllerProvider(
      shopId: shopId,
      userId: follower.userId,
    );
    final streakLogState = ref.watch(provider);
    return Scaffold(
      backgroundColor: _FollowerDetailTheme.bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: _FollowerDetailAppBar(),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              // Profile Avatar Section
              _UserProfileSection(follower: follower),

              const SizedBox(height: 32),

              // User Info Section
              const _SectionHeader(title: 'User Information'),
              const SizedBox(height: 12),
              _UserInfoCard(follower: follower),

              const SizedBox(height: 24),

              // Streak Logs Section
              const _SectionHeader(title: 'Streak Logs'),
              const SizedBox(height: 12),
              _StreakLogsSection(
                streakLogState: streakLogState,
                onLoadMore: () => ref.read(provider.notifier).loadMore(),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _FollowerDetailAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _FollowerDetailTheme.cardBg.withOpacity(0.8),
        border: const Border(
          bottom: BorderSide(color: _FollowerDetailTheme.inputBg, width: 1),
        ),
      ),
      child: ClipRRect(
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _FollowerDetailTheme.inputBg,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: _FollowerDetailTheme.textMain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Follower Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _FollowerDetailTheme.textMain,
                    fontFamily: 'Inter',
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

class _UserProfileSection extends StatelessWidget {
  const _UserProfileSection({required this.follower});

  final ShopFollowerModel follower;

  String get _initials {
    if (follower.userName.isEmpty) return 'U';
    final parts = follower.userName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return follower.userName[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Avatar with gradient
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _FollowerDetailTheme.cardBg,
                  width: 4,
                ),
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
                  colors: [
                    _FollowerDetailTheme.gradStart,
                    _FollowerDetailTheme.gradEnd,
                  ],
                ),
              ),
              child: ClipOval(
                child:
                    follower.userProfilePic != null &&
                        follower.userProfilePic!.isNotEmpty
                    ? Image.network(
                        follower.userProfilePic!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildInitials(),
                      )
                    : _buildInitials(),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // User Name
        Text(
          follower.userName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _FollowerDetailTheme.textMain,
            fontFamily: 'Inter',
          ),
        ),

        const SizedBox(height: 8),

        // Follower Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _FollowerDetailTheme.gradStart.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Follower',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _FollowerDetailTheme.gradStart,
              fontFamily: 'Inter',
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Streak Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.local_fire_department,
                size: 16,
                color: Color(0xFFF97316),
              ),
              const SizedBox(width: 6),
              Text(
                '${follower.cumulativeStreak} Streak',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFF97316),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInitials() {
    return Center(
      child: Text(
        _initials,
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
            color: _FollowerDetailTheme.textMain,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

class _UserInfoCard extends StatelessWidget {
  const _UserInfoCard({required this.follower});

  final ShopFollowerModel follower;

  @override
  Widget build(BuildContext context) {
    final phoneNumber = follower.userPhoneNumber?.trim();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _FollowerDetailTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _FollowerDetailTheme.inputBg, width: 1),
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
        child: Column(
          children: [
            _InfoRow(
              icon: Icons.person_outline,
              label: 'USERNAME',
              value: follower.userName,
              isFirst: true,
            ),
            if (phoneNumber != null && phoneNumber.isNotEmpty)
              _InfoRow(
                icon: Icons.phone_outlined,
                label: 'PHONE NUMBER',
                valueWidget: PhoneNumberLink(
                  key: const ValueKey('follower-detail-phone'),
                  phoneNumber: phoneNumber,
                  iconColor: _FollowerDetailTheme.gradStart,
                  iconSize: 15,
                  showIcon: false,
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _FollowerDetailTheme.gradStart,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            _InfoRow(
              icon: Icons.local_fire_department,
              label: 'CUMULATIVE STREAK',
              value: '${follower.cumulativeStreak} days',
            ),
            _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'FOLLOWED AT',
              value: follower.followedAt.toLocal().toString().split(' ')[0],
            ),
            _InfoRow(
              icon: Icons.login_outlined,
              label: 'LAST CHECK-IN',
              value: follower.lastCheckInDate != null
                  ? follower.lastCheckInDate!.toLocal().toString().split(' ')[0]
                  : 'Never',
            ),
            _InfoRow(
              icon: Icons.emoji_events_outlined,
              label: 'LAST GIFT DAY STREAK',
              value: follower.lastGiftDayStreak != null
                  ? '${follower.lastGiftDayStreak} days'
                  : 'N/A',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.isFirst = false,
    this.isLast = false,
  }) : assert(
         value != null || valueWidget != null,
         'Either value or valueWidget must be provided.',
       );

  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _FollowerDetailTheme.cardBg,
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(
                  color: _FollowerDetailTheme.inputBg,
                  width: 1,
                ),
              ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _FollowerDetailTheme.inputBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: _FollowerDetailTheme.textSub),
          ),
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
                    color: _FollowerDetailTheme.textSub,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 2),
                valueWidget ??
                    Text(
                      value!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: _FollowerDetailTheme.textMain,
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
}

class _StreakLogsSection extends StatelessWidget {
  const _StreakLogsSection({
    required this.streakLogState,
    required this.onLoadMore,
  });

  final AsyncValue<PaginatedStreakLogState> streakLogState;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return streakLogState.when(
      data: (state) {
        if (state.items.isEmpty) {
          return _buildEmptyState();
        }
        return _buildStreakLogsList(state, context);
      },
      error: (error, stackTrace) => _buildErrorState(),
      loading: () => _buildLoadingState(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: _FollowerDetailTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _FollowerDetailTheme.inputBg, width: 1),
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _FollowerDetailTheme.inputBg,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              size: 32,
              color: _FollowerDetailTheme.textSub,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No streak logs available',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _FollowerDetailTheme.textMain,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Streak logs will appear here when available',
            style: TextStyle(
              fontSize: 14,
              color: _FollowerDetailTheme.textSub,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: _FollowerDetailTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _FollowerDetailTheme.inputBg, width: 1),
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _FollowerDetailTheme.gradStart.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.error_outline,
              size: 32,
              color: _FollowerDetailTheme.gradStart,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Error loading streak logs',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _FollowerDetailTheme.textMain,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Please try again later',
            style: TextStyle(
              fontSize: 14,
              color: _FollowerDetailTheme.textSub,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: _FollowerDetailTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _FollowerDetailTheme.inputBg, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: _FollowerDetailTheme.gradStart,
        ),
      ),
    );
  }

  Widget _buildStreakLogsList(
    PaginatedStreakLogState state,
    BuildContext context,
  ) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: _FollowerDetailTheme.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _FollowerDetailTheme.inputBg, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: List.generate(state.items.length, (index) {
                final log = state.items[index];
                return _StreakLogItem(
                  log: log,
                  isFirst: index == 0,
                  isLast: index == state.items.length - 1,
                );
              }),
            ),
          ),
        ),
        if (state.hasMore || state.isLoadingMore) ...[
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: state.isLoadingMore
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: _FollowerDetailTheme.gradStart,
                      ),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: onLoadMore,
                      icon: const Icon(
                        Icons.expand_more,
                        size: 18,
                        color: _FollowerDetailTheme.gradStart,
                      ),
                      label: const Text(
                        'Load More',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _FollowerDetailTheme.gradStart,
                          fontFamily: 'Inter',
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(
                          color: _FollowerDetailTheme.gradStart,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ],
    );
  }
}

class _StreakLogItem extends StatelessWidget {
  const _StreakLogItem({
    required this.log,
    this.isFirst = false,
    this.isLast = false,
  });

  final FollowerStreakLogModel log;
  final bool isFirst;
  final bool isLast;

  Color get _accentColor =>
      log.isGiftDay ? Colors.green : _FollowerDetailTheme.gradStart;

  @override
  Widget build(BuildContext context) {
    final local = log.timestamp.toLocal();
    final date =
        '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
    final hour12 = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final period = local.hour < 12 ? 'AM' : 'PM';
    final time =
        '${hour12.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')} $period';

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator
          SizedBox(
            width: 48,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _accentColor.withOpacity(0.12),
                  ),
                  child: Icon(
                    log.isGiftDay
                        ? Icons.card_giftcard
                        : Icons.local_fire_department,
                    size: 16,
                    color: _accentColor,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: _FollowerDetailTheme.inputBg,
                    ),
                  ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + badges row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          log.isGiftDay ? 'Gift Day' : 'Check-in',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _accentColor,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      if (log.bonusApplied)
                        const Icon(
                          Icons.verified,
                          size: 15,
                          color: Colors.green,
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Date & time
                  Text(
                    '$date  $time',
                    style: const TextStyle(
                      fontSize: 12,
                      color: _FollowerDetailTheme.textSub,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Streak chips
                  Row(
                    children: [
                      _MiniChip(label: '� ${log.consecutiveDays}d consecutive'),
                      const SizedBox(width: 6),
                      _MiniChip(
                        label: '🔥 ${log.cumulativeStreak}d cumulative',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _StreakLogItem extends StatelessWidget {
//   const _StreakLogItem({
//     required this.log,
//     this.isFirst = false,
//     this.isLast = false,
//   });

//   final FollowerStreakLogModel log;
//   final bool isFirst;
//   final bool isLast;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _FollowerDetailTheme.cardBg,
//         border: isLast
//             ? null
//             : const Border(
//                 bottom: BorderSide(
//                   color: _FollowerDetailTheme.inputBg,
//                   width: 1,
//                 ),
//               ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header Row
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: log.isGiftDay
//                       ? Colors.green.withOpacity(0.1)
//                       : Colors.amber.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   log.isGiftDay ? Icons.card_giftcard : Icons.star,
//                   color: log.isGiftDay ? Colors.green : Colors.amber,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       log.scannerName,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: _FollowerDetailTheme.textMain,
//                         fontFamily: 'Inter',
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       log.scannerType,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: _FollowerDetailTheme.textSub,
//                         fontFamily: 'Inter',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Type Badge
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 4,
//                 ),
//                 decoration: BoxDecoration(
//                   color: _FollowerDetailTheme.gradStart.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   log.isGiftDay ? 'Gift Day' : 'Streak',
//                   style: const TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w600,
//                     color: _FollowerDetailTheme.gradStart,
//                     fontFamily: 'Inter',
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Comment
//           if (log.comment.isNotEmpty) ...[
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: _FollowerDetailTheme.inputBg,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.comment_outlined,
//                     size: 16,
//                     color: _FollowerDetailTheme.textSub.withOpacity(0.7),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       log.comment,
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontStyle: FontStyle.italic,
//                         color: _FollowerDetailTheme.textSub.withOpacity(0.9),
//                         fontFamily: 'Inter',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],

//           const SizedBox(height: 12),

//           // Date and Time Row
//           Row(
//             children: [
//               Expanded(
//                 child: _DetailChip(
//                   icon: Icons.calendar_today,
//                   label: log.scanTime.toLocal().toString().split(' ')[0],
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: _DetailChip(
//                   icon: Icons.access_time,
//                   label: log.scanTime
//                       .toLocal()
//                       .toString()
//                       .split(' ')[1]
//                       .split('.')[0],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 8),

//           // Streak Stats Row
//           Row(
//             children: [
//               Expanded(
//                 child: _StatChip(
//                   icon: Icons.trending_up,
//                   label: 'Consecutive',
//                   value: log.consecutiveDays.toString(),
//                   iconColor: Colors.orange,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: _StatChip(
//                   icon: Icons.stacked_line_chart,
//                   label: 'Total',
//                   value: log.cumulativeStreak.toString(),
//                   iconColor: Colors.purple,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _FollowerDetailTheme.inputBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: _FollowerDetailTheme.textMain,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
