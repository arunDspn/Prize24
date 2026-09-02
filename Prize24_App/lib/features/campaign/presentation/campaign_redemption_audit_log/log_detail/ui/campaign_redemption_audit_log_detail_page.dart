import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prize24_app/features/campaign/domain/models/gift_redemption_audit_log_model.dart';
import 'package:prize24_app/features/campaign/presentation/campaign_redemption_audit_log/log_detail/view_model/customer_name_controller.dart';

// Shared colour palette – mirrors CampaignRedemptionAuditLogPage._DC
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
  static const Color red50 = Color(0xFFFFF1F2);
  static const Color red100 = Color(0xFFFFE4E6);
  static const Color red500 = Color(0xFFEF4444);
}

class CampaignRedemptionAuditLogDetailPage extends ConsumerStatefulWidget {
  const CampaignRedemptionAuditLogDetailPage({required this.log, super.key});

  final GiftRedemptionAuditLogModel log;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CampaignRedemptionAuditLogDetailPageState();
}

class _CampaignRedemptionAuditLogDetailPageState
    extends ConsumerState<CampaignRedemptionAuditLogDetailPage> {
  // ── helpers ──────────────────────────────────────────────────────────────

  GiftRedemptionAuditLogModel get _log => widget.log;

  IconData get _actionIcon {
    switch (_log.action.toLowerCase()) {
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

  String get _displayAction => _log.action
      .replaceAll('_', ' ')
      .split(' ')
      .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : w)
      .join(' ');

  String get _formattedTimestamp {
    final t = _log.timestamp;
    final hour = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.hour >= 12 ? 'PM' : 'AM';
    return '${t.day}/${t.month}/${t.year}  $hour:$minute $period';
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final customerNameState = ref.watch(
      customerNameControllerProvider(customerId: _log.customerId ?? ''),
    );

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
                  // ── Action hero card ────────────────────────────────────
                  _buildActionHeroCard(),
                  const SizedBox(height: 20),
                  // ── Customer card ───────────────────────────────────────
                  _buildSectionLabel('Customer'),
                  const SizedBox(height: 10),
                  _buildCustomerCard(customerNameState),
                  const SizedBox(height: 20),
                  // ── Transaction details ─────────────────────────────────
                  _buildSectionLabel('Transaction Details'),
                  const SizedBox(height: 10),
                  _buildDetailsCard(),
                  const SizedBox(height: 20),
                  // ── Meta ────────────────────────────────────────────────
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
            'Redemption Detail',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _DC.slate800,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            'Audit log entry',
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
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _displayAction,
                  style: const TextStyle(
                    fontSize: 22,
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

  // ── Customer card ─────────────────────────────────────────────────────────

  Widget _buildCustomerCard(AsyncValue<String?> customerNameState) {
    return _DetailCard(
      children: [
        _DetailRow(
          icon: Icons.badge_outlined,
          label: 'Customer ID',
          value: _log.customerId,
        ),
        const _CardDivider(),
        _DetailRow(
          icon: Icons.person_outline_rounded,
          label: 'Customer Name',
          valueWidget: customerNameState.when(
            data: (name) => Text(
              name ?? 'Unknown',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _DC.slate700,
                fontFamily: 'Inter',
              ),
            ),
            loading: () => const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: _DC.brandStart,
              ),
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
                  color: _DC.red500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Transaction details card ───────────────────────────────────────────────

  Widget _buildDetailsCard() {
    return _DetailCard(
      children: [
        _DetailRow(
          icon: Icons.card_giftcard_rounded,
          label: 'Gift ID',
          value: _log.giftId,
        ),
        const _CardDivider(),
        _DetailRow(
          icon: Icons.person_pin_outlined,
          label: 'Redeemed By',
          value: _log.redeemedBy,
        ),
        const _CardDivider(),
        _DetailRow(
          icon: Icons.shield_outlined,
          label: 'Redeemer Role',
          valueWidget: _RoleBadge(role: _log.redeemerRole),
        ),
        if (_log.shopId != null) ...[
          const _CardDivider(),
          _DetailRow(
            icon: Icons.store_outlined,
            label: 'Shop ID',
            value: _log.shopId!,
          ),
        ],
      ],
    );
  }

  // ── Meta card ─────────────────────────────────────────────────────────────

  Widget _buildMetaCard() {
    return _DetailCard(
      children: [
        _DetailRow(
          icon: Icons.functions_rounded,
          label: 'Function Name',
          value: _log.functionName,
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
}

// ── Shared sub-widgets ────────────────────────────────────────────────────────

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
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: _DC.slate100);
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.monospace = false,
  }) : assert(
         value != null || valueWidget != null,
         'Provide either value or valueWidget',
       );

  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final bool monospace;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        return _DC.slate500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        role.toUpperCase(),
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
