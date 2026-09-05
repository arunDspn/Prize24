import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/core/data/audit_log/activity_log_dto.dart';
import 'package:prize24_app/features/campaign/presentation/campaign_redemption_audit_log/log_detail/view_model/customer_name_controller.dart';
import 'package:prize24_app/features/shop/domain/model/shop_activity_log.dart';
import 'package:url_launcher/url_launcher.dart';

// ── Design constants (mirrored from CampaignRedemptionAuditLogDetailPage) ────
class _DC {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color purple50 = Color(0xFFF5F3FF);
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color green50 = Color(0xFFF0FDF4);
  static const Color green500 = Color(0xFF22C55E);
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange500 = Color(0xFFF97316);
  static const Color red50 = Color(0xFFFFF1F2);
  static const Color red100 = Color(0xFFFFE4E6);
  static const Color red500 = Color(0xFFEF4444);
}

class ShopActivityLogDetailPage extends ConsumerStatefulWidget {
  const ShopActivityLogDetailPage({required this.entry, super.key});

  final ShopActivityLogEntry entry;

  @override
  ConsumerState<ShopActivityLogDetailPage> createState() =>
      _ShopActivityLogDetailPageState();
}

class _ShopActivityLogDetailPageState
    extends ConsumerState<ShopActivityLogDetailPage> {
  // ── helpers ───────────────────────────────────────────────────────────────

  ShopActivityLogEntry get _entry => widget.entry;

  String get _formattedTimestamp {
    final t = _entry.timestamp;
    final hour = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.hour >= 12 ? 'PM' : 'AM';
    return '${t.day}/${t.month}/${t.year}  $hour:$minute $period';
  }

  String get _displayAction => _entry.action
      .replaceAll('_', ' ')
      .split(' ')
      .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : w)
      .join(' ');

  Future<void> _callPhoneNumber() async {
    final phoneNumber = _entry.phoneNumber?.trim();
    if (phoneNumber == null || phoneNumber.isEmpty) return;

    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) &&
        mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open the dialer')),
      );
    }
  }

  IconData get _actionIcon => switch (_entry.payload) {
    ShopGiftAvailTriggeredPayload() => Icons.card_giftcard_rounded,
    ShopCheckInSuccessPayload() => Icons.check_circle_outline_rounded,
    ShopCheckInFailedPayload() => Icons.cancel_outlined,
    ShopFollowerAddedPayload() => Icons.person_add_alt_1_rounded,
    UnknownShopPayload() => Icons.swap_horiz_rounded,
  };

  String get _payloadCustomerId => switch (_entry.payload) {
    ShopGiftAvailTriggeredPayload p => p.customerId,
    ShopCheckInSuccessPayload p => p.customerId,
    ShopCheckInFailedPayload p => p.customerId,
    ShopFollowerAddedPayload p => p.customerId,
    UnknownShopPayload() => '',
  };

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final actorNameState = ref.watch(
      customerNameControllerProvider(customerId: _entry.actorId),
    );
    final customerNameState = _payloadCustomerId.isNotEmpty
        ? ref.watch(
            customerNameControllerProvider(customerId: _payloadCustomerId),
          )
        : null;

    return Scaffold(
      backgroundColor: _DC.slate50,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Action hero card ──────────────────────────────────
                  _buildActionHeroCard(),
                  const SizedBox(height: 20),

                  // ── Actor ─────────────────────────────────────────────
                  _buildSectionLabel('Actor'),
                  const SizedBox(height: 10),
                  _buildActorCard(actorNameState),
                  const SizedBox(height: 20),

                  // ── Payload ───────────────────────────────────────────
                  _buildSectionLabel('Payload'),
                  const SizedBox(height: 10),
                  _buildPayloadCard(customerNameState),
                  const SizedBox(height: 20),

                  // ── Error (failure only) ──────────────────────────────
                  if (!_entry.success) ...[
                    _buildSectionLabel('Error'),
                    const SizedBox(height: 10),
                    _buildErrorCard(),
                    const SizedBox(height: 20),
                  ],

                  // ── Meta ──────────────────────────────────────────────
                  _buildSectionLabel('Meta'),
                  const SizedBox(height: 10),
                  _buildMetaCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Sliver AppBar ─────────────────────────────────────────────────────────

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      snap: true,
      backgroundColor: _DC.slate50.withOpacity(0.95),
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _DC.slate100,
                borderRadius: BorderRadius.circular(20),
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
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Activity Log Detail',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _DC.slate800,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            'Shop activity log entry',
            style: TextStyle(
              fontSize: 12,
              color: _DC.slate400,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: _DC.slate200),
      ),
    );
  }

  // ── Action hero card ──────────────────────────────────────────────────────

  Widget _buildActionHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_DC.brandStart, _DC.brandEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _DC.brandStart.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(_actionIcon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Action',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _displayAction,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 6),
                _StatusBadge(success: _entry.success),
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
                const Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                  size: 13,
                ),
                const SizedBox(width: 4),
                Text(
                  _formattedTimestamp,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Actor card ────────────────────────────────────────────────────────────

  Widget _buildActorCard(AsyncValue<String?> actorNameState) {
    return _DetailCard(
      children: [
        _DetailRow(
          icon: Icons.badge_outlined,
          label: 'Actor ID',
          value: _entry.actorId,
        ),
        const _CardDivider(),
        _DetailRow(
          icon: Icons.person_outline_rounded,
          label: 'Actor Name',
          valueWidget: _nameWidget(actorNameState),
        ),
        if (_entry.phoneNumber?.trim().isNotEmpty == true) ...[
          const _CardDivider(),
          _DetailRow(
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            value: _entry.phoneNumber!.trim(),
            onTap: _callPhoneNumber,
          ),
        ],
        const _CardDivider(),
        _DetailRow(
          icon: Icons.shield_outlined,
          label: 'Actor Role',
          valueWidget: _RoleBadge(role: _entry.actorRole),
        ),
      ],
    );
  }

  // ── Payload card ──────────────────────────────────────────────────────────

  Widget _buildPayloadCard(AsyncValue<String?>? customerNameState) {
    return switch (_entry.payload) {
      ShopGiftAvailTriggeredPayload p => _DetailCard(
        children: [
          if (customerNameState != null) ...[
            _DetailRow(
              icon: Icons.person_outline_rounded,
              label: 'Customer',
              valueWidget: _nameWidget(
                customerNameState,
                fallbackId: p.customerId,
              ),
            ),
            const _CardDivider(),
          ],
          _DetailRow(
            icon: Icons.campaign_outlined,
            label: 'Campaign ID',
            value: p.campaignId,
            monospace: true,
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.info_outline_rounded,
            label: 'Avail Status',
            valueWidget: _AvailStatusBadge(status: p.availStatus),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.local_fire_department_outlined,
            label: 'Triggered by Streak',
            valueWidget: _BoolBadge(value: p.triggeredByStreak),
          ),
          if (p.streakValue != null) ...[
            const _CardDivider(),
            _DetailRow(
              icon: Icons.trending_up_rounded,
              label: 'Streak Value',
              value: p.streakValue.toString(),
            ),
          ],
          if (p.giftCycleDay != null) ...[
            const _CardDivider(),
            _DetailRow(
              icon: Icons.calendar_today_outlined,
              label: 'Gift Cycle Day',
              value: p.giftCycleDay.toString(),
            ),
          ],
          if (p.giftName != null && p.giftId != null) ...[
            const _CardDivider(),
            _DetailRow(
              icon: Icons.card_giftcard_rounded,
              label: 'Gift',
              value: '${p.giftName} (${p.giftId})',
            ),
          ],
          if (p.luckFactor != null && p.randomNumber != null) ...[
            const _CardDivider(),
            _DetailRow(
              icon: Icons.casino_outlined,
              label: 'Luck / Random',
              value:
                  '${p.luckFactor!.toStringAsFixed(4)}  /  ${p.randomNumber!.toStringAsFixed(4)}',
            ),
          ],
          if (p.failureReason != null) ...[
            const _CardDivider(),
            _DetailRow(
              icon: Icons.error_outline_rounded,
              label: 'Failure Reason',
              value: p.failureReason!,
            ),
          ],
          if (p.shopId != null) ...[
            const _CardDivider(),
            _DetailRow(
              icon: Icons.store_outlined,
              label: 'Shop ID',
              value: p.shopId!,
              monospace: true,
            ),
          ],
        ],
      ),
      ShopCheckInSuccessPayload p => _DetailCard(
        children: [
          if (customerNameState != null) ...[
            _DetailRow(
              icon: Icons.person_outline_rounded,
              label: 'Customer',
              valueWidget: _nameWidget(
                customerNameState,
                fallbackId: p.customerId,
              ),
            ),
            const _CardDivider(),
          ],
          _DetailRow(
            icon: Icons.store_outlined,
            label: 'Shop ID',
            value: p.shopId,
            monospace: true,
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.receipt_long_outlined,
            label: 'Bill ID',
            value: p.billNumber,
            monospace: true,
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.payments_outlined,
            label: 'Bill Amount',
            value: p.billAmount.toStringAsFixed(2),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.autorenew_rounded,
            label: 'Current Cycle Bill Sum',
            value: p.cycleBillSum.toStringAsFixed(2),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.history_rounded,
            label: 'Previous Cycle Bill Sum',
            value: p.previousCycleBillSum.toStringAsFixed(2),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Cumulative Bill Sum',
            value: p.cumulativeBillSum.toStringAsFixed(2),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.trending_up_rounded,
            label: 'Cumulative Streak',
            value: p.cumulativeStreak.toString(),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.date_range_outlined,
            label: 'Consecutive Days',
            value: p.consecutiveDays.toString(),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.history_rounded,
            label: 'Previous Streak',
            value: p.previousStreak.toString(),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.star_outline_rounded,
            label: 'Bonus Applied',
            valueWidget: _BoolBadge(value: p.bonusApplied),
          ),
          if (p.bonusApplied && p.bonusValue != null) ...[
            const _CardDivider(),
            _DetailRow(
              icon: Icons.add_circle_outline_rounded,
              label: 'Bonus Value',
              value: p.bonusValue.toString(),
            ),
          ],
          const _CardDivider(),
          _DetailRow(
            icon: Icons.card_giftcard_rounded,
            label: 'Is Gift Day',
            valueWidget: _BoolBadge(value: p.isGiftDay),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.person_add_alt_1_rounded,
            label: 'Auto Followed',
            valueWidget: _BoolBadge(value: p.wasAutoFollowed),
          ),
          if (p.campaignId != null) ...[
            const _CardDivider(),
            _DetailRow(
              icon: Icons.campaign_outlined,
              label: 'Campaign ID',
              value: p.campaignId!,
              monospace: true,
            ),
          ],
        ],
      ),
      ShopCheckInFailedPayload p => _DetailCard(
        children: [
          if (customerNameState != null) ...[
            _DetailRow(
              icon: Icons.person_outline_rounded,
              label: 'Customer',
              valueWidget: _nameWidget(
                customerNameState,
                fallbackId: p.customerId,
              ),
            ),
            const _CardDivider(),
          ],
          _DetailRow(
            icon: Icons.store_outlined,
            label: 'Shop ID',
            value: p.shopId,
            monospace: true,
          ),
          if (p.failureReason != null) ...[
            const _CardDivider(),
            _DetailRow(
              icon: Icons.error_outline_rounded,
              label: 'Failure Reason',
              value: p.failureReason!,
            ),
          ],
        ],
      ),
      ShopFollowerAddedPayload p => _DetailCard(
        children: [
          if (customerNameState != null) ...[
            _DetailRow(
              icon: Icons.person_outline_rounded,
              label: 'Customer',
              valueWidget: _nameWidget(
                customerNameState,
                fallbackId: p.customerId,
              ),
            ),
            const _CardDivider(),
          ],
          _DetailRow(
            icon: Icons.store_outlined,
            label: 'Shop ID',
            value: p.shopId,
            monospace: true,
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.how_to_reg_outlined,
            label: 'Added Method',
            value: p.addedMethod.replaceAll('_', ' '),
          ),
          const _CardDivider(),
          _DetailRow(
            icon: Icons.trending_up_rounded,
            label: 'Initial Streak',
            value: p.initialStreak.toString(),
          ),
        ],
      ),
      UnknownShopPayload() => _DetailCard(
        children: [
          const _DetailRow(
            icon: Icons.help_outline_rounded,
            label: 'Payload',
            value: 'Unknown action type',
          ),
        ],
      ),
    };
  }

  // ── Error card ────────────────────────────────────────────────────────────

  Widget _buildErrorCard() {
    return _DetailCard(
      children: [
        if (_entry.errorCode != null)
          _DetailRow(
            icon: Icons.code_rounded,
            label: 'Error Code',
            value: _entry.errorCode!,
            monospace: true,
          ),
        if (_entry.errorCode != null && _entry.errorMessage != null)
          const _CardDivider(),
        if (_entry.errorMessage != null)
          _DetailRow(
            icon: Icons.error_outline_rounded,
            label: 'Error Message',
            value: _entry.errorMessage!,
          ),
        if (_entry.errorCode == null && _entry.errorMessage == null)
          const _DetailRow(
            icon: Icons.help_outline_rounded,
            label: 'Error',
            value: 'No error details provided',
          ),
      ],
    );
  }

  // ── Meta card ─────────────────────────────────────────────────────────────

  Widget _buildMetaCard() {
    return _DetailCard(
      children: [
        _DetailRow(
          icon: Icons.fingerprint_rounded,
          label: 'Log ID',
          value: _entry.logId,
          monospace: true,
        ),
        const _CardDivider(),
        _DetailRow(
          icon: Icons.functions_rounded,
          label: 'Function Name',
          value: _entry.functionName,
          monospace: true,
        ),
        const _CardDivider(),
        _DetailRow(
          icon: Icons.access_time_filled_rounded,
          label: 'Timestamp',
          value: _formattedTimestamp,
        ),
      ],
    );
  }

  // ── Section label ─────────────────────────────────────────────────────────

  Widget _buildSectionLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: _DC.slate400,
        fontFamily: 'Inter',
        letterSpacing: 1.2,
      ),
    );
  }

  // ── Shared name helper ────────────────────────────────────────────────────

  Widget _nameWidget(AsyncValue<String?> state, {String? fallbackId}) {
    return state.when(
      data: (name) {
        final display = name != null && fallbackId != null
            ? '$name ($fallbackId)'
            : name ?? fallbackId ?? 'Unknown';
        return Text(
          display,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _DC.slate700,
            fontFamily: 'Inter',
          ),
        );
      },
      loading: () => const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2, color: _DC.brandStart),
      ),
      error: (_, __) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _DC.red50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _DC.red100),
        ),
        child: const Text(
          'Failed to load',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _DC.red500,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Column(children: children),
    );
  }
}

class _CardDivider extends StatelessWidget {
  const _CardDivider();

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, thickness: 1, color: _DC.slate100);
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.monospace = false,
    this.onTap,
  }) : assert(
         value != null || valueWidget != null,
         'Provide either value or valueWidget',
       );

  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final bool monospace;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: _DC.slate100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: _DC.slate500),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: _DC.slate400,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                valueWidget ??
                    Text(
                      value!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _DC.slate700,
                        fontFamily: monospace ? 'monospace' : 'Inter',
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );

    return onTap == null ? row : InkWell(onTap: onTap, child: row);
  }
}

// ── Status badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.success});
  final bool success;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: success
            ? Colors.white.withOpacity(0.25)
            : Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            success ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: Colors.white,
            size: 13,
          ),
          const SizedBox(width: 4),
          Text(
            success ? 'Success' : 'Failed',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

// ── Role badge ────────────────────────────────────────────────────────────────

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.role});
  final ActivityLogActorRole role;

  Color get _bgColor => switch (role) {
    ActivityLogActorRole.staff => _DC.purple50,
    ActivityLogActorRole.owner => _DC.blue50,
    ActivityLogActorRole.sharedVendor => _DC.orange50,
    ActivityLogActorRole.customer => _DC.green50,
    ActivityLogActorRole.system => _DC.slate100,
  };

  Color get _textColor => switch (role) {
    ActivityLogActorRole.staff => _DC.purple500,
    ActivityLogActorRole.owner => _DC.blue500,
    ActivityLogActorRole.sharedVendor => _DC.orange500,
    ActivityLogActorRole.customer => _DC.green500,
    ActivityLogActorRole.system => _DC.slate500,
  };

  String get _label => switch (role) {
    ActivityLogActorRole.sharedVendor => 'SHARED VENDOR',
    _ => role.name.toUpperCase(),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _textColor,
          fontFamily: 'Inter',
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ── Bool badge ────────────────────────────────────────────────────────────────

class _BoolBadge extends StatelessWidget {
  const _BoolBadge({required this.value});
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: value ? _DC.green50 : _DC.red50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            value ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: value ? _DC.green500 : _DC.red500,
            size: 13,
          ),
          const SizedBox(width: 4),
          Text(
            value ? 'Yes' : 'No',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: value ? _DC.green500 : _DC.red500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

// ── Avail status badge ────────────────────────────────────────────────────────

class _AvailStatusBadge extends StatelessWidget {
  const _AvailStatusBadge({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final isSuccess = status.toLowerCase() == 'success';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSuccess ? _DC.green50 : _DC.red50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuccess ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: isSuccess ? _DC.green500 : _DC.red500,
            size: 13,
          ),
          const SizedBox(width: 4),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isSuccess ? _DC.green500 : _DC.red500,
              fontFamily: 'Inter',
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
