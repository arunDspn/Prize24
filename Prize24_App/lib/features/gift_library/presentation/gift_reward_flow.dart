import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prize24_app/features/gift_library/data/gift_library_service.dart';
import 'package:prize24_app/features/gift_library/domain/gift_library_models.dart';
import 'package:prize24_app/features/shop/domain/model/check_in_response_model.dart';

abstract final class _RewardColors {
  static const background = Color(0xFFF8FAFC);
  static const text = Color(0xFF0F172A);
  static const supporting = Color(0xFF64748B);
  static const border = Color(0xFFE2E8F0);
  static const muted = Color(0xFFF1F5F9);
  static const brandStart = Color(0xFFFF5F6D);
  static const brandEnd = Color(0xFFFFC371);
  static const green = Color(0xFF16A34A);
  static const greenSurface = Color(0xFFF0FDF4);
  static const orange = Color(0xFFEA580C);
  static const orangeSurface = Color(0xFFFFF7ED);
  static const red = Color(0xFFDC2626);
  static const redSurface = Color(0xFFFEF2F2);
  static const blue = Color(0xFF2563EB);
  static const blueSurface = Color(0xFFEFF6FF);
  static const shadow = <BoxShadow>[
    BoxShadow(color: Color(0x120F172A), blurRadius: 24, offset: Offset(0, 10)),
  ];
}

class RewardFlowData {
  const RewardFlowData({
    required this.opportunityId,
    required this.userId,
    required this.milestone,
    required this.cumulativeStreak,
    required this.eligibleSources,
    required this.cumulativeBillSum,
    required this.milestoneCycleBillSum,
    this.selectedSource,
  });

  factory RewardFlowData.fromCheckIn({
    required String userId,
    required CheckInRepsponseDataModel data,
  }) {
    final opportunity = data.rewardOpportunity!;
    return RewardFlowData(
      opportunityId: opportunity.id,
      userId: userId,
      milestone: data.crossedMilestone ?? data.cumulativeStreak,
      cumulativeStreak: data.cumulativeStreak,
      eligibleSources: opportunity.eligibleSources,
      selectedSource: opportunity.selectedSource,
      cumulativeBillSum: data.cumulativeBillSum,
      milestoneCycleBillSum: data.milestoneCycleBillSum,
    );
  }

  factory RewardFlowData.fromPending(RewardOpportunityListItem item) {
    return RewardFlowData(
      opportunityId: item.id,
      userId: item.userId,
      milestone: item.milestone,
      cumulativeStreak: item.cumulativeStreak,
      eligibleSources: item.eligibleSources,
      selectedSource: item.selectedSource,
      cumulativeBillSum: item.cumulativeBillSum,
      milestoneCycleBillSum: item.milestoneCycleBillSum,
    );
  }

  final String opportunityId;
  final String userId;
  final int milestone;
  final int cumulativeStreak;
  final List<String> eligibleSources;
  final String? selectedSource;
  final double cumulativeBillSum;
  final double milestoneCycleBillSum;
}

Stream<int> watchPendingRewardCount(String shopId) {
  return FirebaseFirestore.instance
      .collection('shops')
      .doc(shopId)
      .collection('rewardOpportunities')
      .where('status', isEqualTo: 'pending')
      .snapshots()
      .map((snapshot) => snapshot.size);
}

String? automaticallySelectedRewardSource(RewardFlowData data) {
  if (data.selectedSource != null) return data.selectedSource;
  if (data.eligibleSources.length == 1 &&
      data.eligibleSources.single == 'campaign') {
    return 'campaign';
  }
  return null;
}

Future<void> showMilestoneRewardFlow({
  required BuildContext context,
  required WidgetRef ref,
  required String shopId,
  required RewardFlowData data,
}) async {
  final lifetimeSpend = data.cumulativeBillSum.toStringAsFixed(2);
  final milestoneCycleSpend = data.milestoneCycleBillSum.toStringAsFixed(2);
  AttachedGiftLibraryModel? attachedLibrary;
  Object? libraryLoadError;
  if (data.eligibleSources.contains('gift_library')) {
    try {
      attachedLibrary = await ref
          .read(giftLibraryServiceProvider)
          .getAttachedLibrary(shopId, opportunityId: data.opportunityId);
    } catch (error) {
      libraryLoadError = error;
    }
  }
  if (!context.mounted) return;

  final libraryHasStock = attachedLibrary?.hasAvailableBuckets ?? false;
  var source = automaticallySelectedRewardSource(data);
  source ??= await showRewardSourceDialog(
    context: context,
    data: data,
    lifetimeSpend: lifetimeSpend,
    milestoneCycleSpend: milestoneCycleSpend,
    libraryHasStock: libraryHasStock,
    libraryLoadError: libraryLoadError,
  );
  if (source == null || !context.mounted) return;

  String? bucketId;
  if (source == 'gift_library') {
    if (libraryLoadError != null || !libraryHasStock) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            libraryLoadError == null
                ? 'Reward remains pending until a bucket is restocked.'
                : 'Reward remains pending: $libraryLoadError',
          ),
        ),
      );
      return;
    }
    final bucket = await showGiftLibraryBucketPicker(
      context,
      attachedLibrary!.buckets,
      customerId: data.userId,
    );
    if (bucket == null || !context.mounted) return;
    bucketId = bucket.id;
  }

  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _RewardProcessingDialog(),
    ),
  );
  try {
    final result = await ref
        .read(giftLibraryServiceProvider)
        .resolveReward(
          shopId: shopId,
          userId: data.userId,
          opportunityId: data.opportunityId,
          source: source,
          bucketId: bucketId,
        );
    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    final message = switch (result.outcome) {
      'awarded' => '${result.giftName ?? 'Gift'} assigned successfully.',
      'no_prize' => 'Campaign completed. No prize was won.',
      _ => 'The selected reward is currently unavailable.',
    };
    await showDialog<void>(
      context: context,
      builder: (context) => _RewardResultDialog(
        awarded: result.outcome == 'awarded',
        title: result.outcome == 'awarded' ? 'Gift assigned' : 'Reward result',
        message: message,
        data: data,
        lifetimeSpend: lifetimeSpend,
        milestoneCycleSpend: milestoneCycleSpend,
      ),
    );
  } catch (error) {
    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    await showDialog<void>(
      context: context,
      builder: (_) => _RewardFailureDialog(error: error),
    );
  }
}

Future<String?> showRewardSourceDialog({
  required BuildContext context,
  required RewardFlowData data,
  required String lifetimeSpend,
  required String milestoneCycleSpend,
  required bool libraryHasStock,
  required Object? libraryLoadError,
}) {
  return showDialog<String>(
    context: context,
    builder: (context) => _MilestoneDialog(
      data: data,
      lifetimeSpend: lifetimeSpend,
      milestoneCycleSpend: milestoneCycleSpend,
      libraryHasStock: libraryHasStock,
      libraryLoadError: libraryLoadError,
    ),
  );
}

Future<GiftLibraryBucketModel?> showGiftLibraryBucketPicker(
  BuildContext context,
  List<GiftLibraryBucketModel> buckets, {
  String? customerId,
}) {
  return showModalBottomSheet<GiftLibraryBucketModel>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (context) =>
        _BucketPickerSheet(buckets: buckets, customerId: customerId),
  );
}

class PendingRewardsPage extends ConsumerStatefulWidget {
  const PendingRewardsPage({required this.shopId, super.key});

  final String shopId;

  @override
  ConsumerState<PendingRewardsPage> createState() => _PendingRewardsPageState();
}

class _PendingRewardsPageState extends ConsumerState<PendingRewardsPage> {
  late Future<List<RewardOpportunityListItem>> _pending;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _pending = ref
        .read(giftLibraryServiceProvider)
        .listPendingRewards(widget.shopId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _RewardColors.background,
      appBar: const _RewardAppBar(title: 'Pending Rewards'),
      body: FutureBuilder<List<RewardOpportunityListItem>>(
        future: _pending,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _RewardState(
              loading: true,
              icon: Icons.pending_actions_rounded,
              title: 'Loading pending rewards',
              description: 'Checking milestones that still need attention.',
            );
          }
          if (snapshot.hasError) {
            return _RewardState(
              icon: Icons.cloud_off_rounded,
              title: 'Unable to load rewards',
              description: '${snapshot.error}',
              actionLabel: 'Try again',
              onAction: () => setState(_reload),
            );
          }
          final pending = snapshot.data ?? const [];
          if (pending.isEmpty) {
            return const _RewardState(
              icon: Icons.task_alt_rounded,
              title: 'All rewards are up to date',
              description: 'No pending milestone rewards.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: pending.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = pending[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _RewardColors.border),
                  boxShadow: _RewardColors.shadow,
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const _RewardIcon(
                    icon: Icons.pending_actions_rounded,
                    color: _RewardColors.orange,
                    background: _RewardColors.orangeSurface,
                  ),
                  title: Text('Milestone ${item.milestone}'),
                  subtitle: Text(
                    'Customer ${item.userId}\n'
                    'Cycle ${item.milestoneCycleBillSum.toStringAsFixed(2)} · '
                    'Lifetime ${item.cumulativeBillSum.toStringAsFixed(2)}',
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () async {
                    await showMilestoneRewardFlow(
                      context: context,
                      ref: ref,
                      shopId: widget.shopId,
                      data: RewardFlowData.fromPending(item),
                    );
                    if (mounted) setState(_reload);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

enum LibraryScannerMode { assign, redeem }

class GiftLibraryScannerPage extends ConsumerStatefulWidget {
  const GiftLibraryScannerPage({
    required this.shopId,
    required this.mode,
    super.key,
  });

  final String shopId;
  final LibraryScannerMode mode;

  @override
  ConsumerState<GiftLibraryScannerPage> createState() =>
      _GiftLibraryScannerPageState();
}

class _GiftLibraryScannerPageState
    extends ConsumerState<GiftLibraryScannerPage> {
  final MobileScannerController _scanner = MobileScannerController();
  final TextEditingController _manual = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _scanner.dispose();
    _manual.dispose();
    super.dispose();
  }

  Future<void> _handleCode(String code) async {
    if (_busy || code.trim().isEmpty) return;
    setState(() => _busy = true);
    await _scanner.stop();
    try {
      if (widget.mode == LibraryScannerMode.redeem) {
        await ref
            .read(giftLibraryServiceProvider)
            .redeemShopGift(shopId: widget.shopId, userGiftId: code.trim());
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gift redeemed successfully.')),
          );
        }
      } else {
        final attached = await ref
            .read(giftLibraryServiceProvider)
            .getAttachedLibrary(widget.shopId, followerUserId: code.trim());
        if (!mounted) return;
        final bucket = await showGiftLibraryBucketPicker(
          context,
          attached.buckets,
          customerId: code.trim(),
        );
        if (bucket == null) return;
        final requestId = FirebaseFirestore.instance
            .collection('_ids')
            .doc()
            .id;
        final result = await ref
            .read(giftLibraryServiceProvider)
            .assignManualGift(
              shopId: widget.shopId,
              userId: code.trim(),
              bucketId: bucket.id,
              requestId: requestId,
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${result.giftName ?? 'Gift'} assigned.')),
          );
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to complete action: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
        unawaited(_scanner.start());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final assigning = widget.mode == LibraryScannerMode.assign;
    return Scaffold(
      backgroundColor: _RewardColors.background,
      appBar: _RewardAppBar(
        title: assigning ? 'Assign Library Gift' : 'Redeem Library Gift',
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          _ScannerModeCard(assigning: assigning),
          const SizedBox(height: 14),
          _InstructionCard(
            text: assigning
                ? 'Scan an existing shop follower’s Prize24 QR code.'
                : 'Scan the customer’s wallet gift QR code.',
          ),
          const SizedBox(height: 16),
          Container(
            height: 360,
            decoration: BoxDecoration(
              color: _RewardColors.text,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: _RewardColors.text, width: 4),
              boxShadow: _RewardColors.shadow,
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  controller: _scanner,
                  onDetect: (capture) {
                    final value = capture.barcodes.isEmpty
                        ? null
                        : capture.barcodes.first.rawValue;
                    if (value != null) unawaited(_handleCode(value));
                  },
                ),
                IgnorePointer(
                  child: Center(
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _manual,
            enabled: !_busy,
            decoration: InputDecoration(
              labelText: assigning ? 'Customer ID' : 'User gift ID',
              hintText: assigning
                  ? 'Enter customer ID manually'
                  : 'Enter wallet gift ID manually',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.keyboard_rounded),
              suffixIcon: IconButton.filled(
                onPressed: _busy ? null : () => _handleCode(_manual.text),
                icon: const Icon(Icons.arrow_forward_rounded),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: _RewardColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: _RewardColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: _RewardColors.brandStart,
                  width: 1.5,
                ),
              ),
            ),
            onSubmitted: _handleCode,
          ),
          if (_busy) ...[
            const SizedBox(height: 20),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}

class _MilestoneDialog extends StatelessWidget {
  const _MilestoneDialog({
    required this.data,
    required this.lifetimeSpend,
    required this.milestoneCycleSpend,
    required this.libraryHasStock,
    required this.libraryLoadError,
  });

  final RewardFlowData data;
  final String lifetimeSpend;
  final String milestoneCycleSpend;
  final bool libraryHasStock;
  final Object? libraryLoadError;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _RewardColors.border),
          boxShadow: _RewardColors.shadow,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _GradientRewardIcon(icon: Icons.emoji_events_rounded),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Milestone reached',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: _RewardColors.text,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Choose how to reward this customer.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: _RewardColors.supporting,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: _RewardColors.muted,
                    ),
                    icon: const Icon(Icons.close_rounded, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.local_fire_department_rounded,
                    text: 'Current cumulative streak: ${data.cumulativeStreak}',
                    color: _RewardColors.orange,
                    background: _RewardColors.orangeSurface,
                  ),
                  _InfoChip(
                    icon: Icons.flag_rounded,
                    text: 'Crossed milestone: ${data.milestone}',
                    color: _RewardColors.blue,
                    background: _RewardColors.blueSurface,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _SpendCard(
                      label: 'Lifetime spend: $lifetimeSpend',
                      value: lifetimeSpend,
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _SpendCard(
                      label: 'Milestone-cycle spend: $milestoneCycleSpend',
                      value: milestoneCycleSpend,
                      icon: Icons.sync_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (data.eligibleSources.contains('campaign'))
                _RewardSourceCard(
                  key: const Key('campaign-reward-source-card'),
                  icon: Icons.campaign_rounded,
                  title: 'Campaign draw',
                  description: 'Use the current campaign draw.',
                  color: _RewardColors.brandStart,
                  onTap: () => Navigator.pop(context, 'campaign'),
                ),
              if (data.eligibleSources.contains('campaign') &&
                  data.eligibleSources.contains('gift_library'))
                const SizedBox(height: 8),
              if (data.eligibleSources.contains('gift_library'))
                _RewardSourceCard(
                  key: const Key('gift-library-reward-source-card'),
                  icon: Icons.card_giftcard_rounded,
                  title: 'Gift Library',
                  description: libraryHasStock
                      ? 'Choose a bucket for this customer.'
                      : libraryLoadError == null
                      ? 'Out of stock. Restock a bucket to continue.'
                      : 'Unable to check bucket inventory.',
                  color: libraryHasStock
                      ? _RewardColors.green
                      : _RewardColors.red,
                  enabled: libraryHasStock,
                  onTap: () => Navigator.pop(context, 'gift_library'),
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(46),
                    foregroundColor: _RewardColors.text,
                    side: const BorderSide(color: _RewardColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Assign later'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpendCard extends StatelessWidget {
  const _SpendCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: _RewardColors.muted,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: _RewardColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 19, color: _RewardColors.supporting),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: _RewardColors.text,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: _RewardColors.supporting,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardSourceCard extends StatelessWidget {
  const _RewardSourceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
    super.key,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white : _RewardColors.redSurface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: enabled ? _RewardColors.border : const Color(0xFFFECACA),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(17),
        child: ListTile(
          enabled: enabled,
          minTileHeight: 60,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 2,
          ),
          leading: _RewardIcon(
            icon: icon,
            color: color,
            background: color.withValues(alpha: .1),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              height: 1.35,
            ),
          ),
          trailing: Icon(
            enabled ? Icons.arrow_forward_rounded : Icons.block_rounded,
            color: enabled ? color : _RewardColors.red,
          ),
          onTap: enabled ? onTap : null,
        ),
      ),
    );
  }
}

class _BucketPickerSheet extends StatelessWidget {
  const _BucketPickerSheet({required this.buckets, this.customerId});

  final List<GiftLibraryBucketModel> buckets;
  final String? customerId;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * .86,
      ),
      decoration: const BoxDecoration(
        color: _RewardColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: _RewardColors.border,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
            child: Row(
              children: [
                const _GradientRewardIcon(icon: Icons.card_giftcard_rounded),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose a gift',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: _RewardColors.text,
                        ),
                      ),
                      Text(
                        customerId == null
                            ? 'Select an available inventory bucket.'
                            : 'Customer ID · $customerId',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: _RewardColors.supporting,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Close',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: _RewardColors.border),
          if (buckets.isEmpty)
            const Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(32),
                child: _RewardState(
                  icon: Icons.inventory_2_outlined,
                  title: 'No gifts available',
                  description: 'This Gift Library has no active buckets.',
                ),
              ),
            )
          else
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                itemCount: buckets.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final bucket = buckets[index];
                  final inventory = bucket.isAvailable
                      ? 'Remaining: ${bucket.remainingCount}'
                      : 'Out of stock';
                  return Container(
                    decoration: BoxDecoration(
                      color: bucket.isAvailable
                          ? Colors.white
                          : _RewardColors.redSurface,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: bucket.isAvailable
                            ? _RewardColors.border
                            : const Color(0xFFFECACA),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(17),
                      child: ListTile(
                        enabled: bucket.isAvailable,
                        contentPadding: const EdgeInsets.all(14),
                        leading: _RewardIcon(
                          icon: Icons.redeem_rounded,
                          color: bucket.isAvailable
                              ? _RewardColors.green
                              : _RewardColors.red,
                          background: bucket.isAvailable
                              ? _RewardColors.greenSurface
                              : _RewardColors.redSurface,
                        ),
                        title: Text(
                          bucket.name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text('${bucket.description}\n$inventory'),
                        isThreeLine: true,
                        trailing: bucket.isAvailable
                            ? const Icon(Icons.chevron_right_rounded)
                            : const Icon(
                                Icons.block_rounded,
                                color: _RewardColors.red,
                              ),
                        onTap: !bucket.isAvailable
                            ? null
                            : () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => _GiftConfirmationDialog(
                                    bucket: bucket,
                                    customerId: customerId,
                                  ),
                                );
                                if ((confirmed ?? false) && context.mounted) {
                                  Navigator.pop(context, bucket);
                                }
                              },
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _GiftConfirmationDialog extends StatelessWidget {
  const _GiftConfirmationDialog({required this.bucket, this.customerId});

  final GiftLibraryBucketModel bucket;
  final String? customerId;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 440),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _RewardColors.border),
          boxShadow: _RewardColors.shadow,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _GradientRewardIcon(
                icon: Icons.card_giftcard_rounded,
                size: 58,
              ),
              const SizedBox(height: 16),
              const Text(
                'Assign this gift?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _RewardColors.text,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _RewardColors.muted,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      bucket.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      bucket.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: _RewardColors.supporting,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Remaining: ${bucket.remainingCount}'),
                    if (customerId != null) ...[
                      const SizedBox(height: 5),
                      Text('Customer: $customerId'),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        foregroundColor: _RewardColors.text,
                        side: const BorderSide(color: _RewardColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        backgroundColor: _RewardColors.brandStart,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Assign'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardProcessingDialog extends StatelessWidget {
  const _RewardProcessingDialog();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: _RewardColors.shadow,
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: _RewardColors.brandStart),
            SizedBox(height: 14),
            Text(
              'Assigning reward…',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: _RewardColors.text,
                decoration: TextDecoration.none,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardResultDialog extends StatelessWidget {
  const _RewardResultDialog({
    required this.awarded,
    required this.title,
    required this.message,
    required this.data,
    required this.lifetimeSpend,
    required this.milestoneCycleSpend,
  });

  final bool awarded;
  final String title;
  final String message;
  final RewardFlowData data;
  final String lifetimeSpend;
  final String milestoneCycleSpend;

  @override
  Widget build(BuildContext context) {
    final color = awarded ? _RewardColors.green : _RewardColors.orange;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 440),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _RewardColors.border),
          boxShadow: _RewardColors.shadow,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RewardIcon(
                icon: awarded ? Icons.check_rounded : Icons.info_outline,
                color: color,
                background: awarded
                    ? _RewardColors.greenSurface
                    : _RewardColors.orangeSurface,
                size: 58,
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _RewardColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: _RewardColors.supporting,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _RewardColors.muted,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text('Current cumulative streak: ${data.cumulativeStreak}'),
                    Text('Crossed milestone: ${data.milestone}'),
                    Text('Lifetime spend: $lifetimeSpend'),
                    Text('Milestone-cycle spend: $milestoneCycleSpend'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: _RewardColors.brandStart,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardFailureDialog extends StatelessWidget {
  const _RewardFailureDialog({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 440),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _RewardColors.border),
          boxShadow: _RewardColors.shadow,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _RewardIcon(
                icon: Icons.refresh_rounded,
                color: _RewardColors.orange,
                background: _RewardColors.orangeSurface,
                size: 58,
              ),
              const SizedBox(height: 16),
              const Text(
                'Reward still pending',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _RewardColors.text,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Nothing was consumed. You can safely retry this reward from '
                'Pending Rewards.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  height: 1.45,
                  color: _RewardColors.supporting,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _RewardColors.redSurface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  '$error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: _RewardColors.red,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: _RewardColors.brandStart,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _RewardAppBar({required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 64,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: const Border(bottom: BorderSide(color: _RewardColors.border)),
      leadingWidth: 68,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
        child: Material(
          color: _RewardColors.muted,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Navigator.maybePop(context),
            child: const Icon(Icons.arrow_back_rounded, size: 20),
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: _RewardColors.text,
        ),
      ),
    );
  }
}

class _RewardState extends StatelessWidget {
  const _RewardState({
    required this.icon,
    required this.title,
    required this.description,
    this.loading = false,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool loading;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: _RewardColors.border),
          boxShadow: _RewardColors.shadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RewardIcon(
              icon: icon,
              color: _RewardColors.brandStart,
              background: const Color(0xFFFFF1F2),
              size: 56,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _RewardColors.text,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: _RewardColors.supporting,
              ),
            ),
            if (loading) ...[
              const SizedBox(height: 18),
              const CircularProgressIndicator(
                strokeWidth: 2.5,
                color: _RewardColors.brandStart,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _GradientRewardIcon extends StatelessWidget {
  const _GradientRewardIcon({required this.icon, this.size = 48});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_RewardColors.brandStart, _RewardColors.brandEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * .3),
      ),
      child: Icon(icon, color: Colors.white, size: size * .5),
    );
  }
}

class _RewardIcon extends StatelessWidget {
  const _RewardIcon({
    required this.icon,
    required this.color,
    required this.background,
    this.size = 46,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * .3),
      ),
      child: Icon(icon, color: color, size: size * .5),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.text,
    required this.color,
    required this.background,
  });

  final IconData icon;
  final String text;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerModeCard extends StatelessWidget {
  const _ScannerModeCard({required this.assigning});

  final bool assigning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _RewardColors.border),
        boxShadow: _RewardColors.shadow,
      ),
      child: Row(
        children: [
          _GradientRewardIcon(
            icon: assigning ? Icons.card_giftcard_rounded : Icons.qr_code_2,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assigning ? 'Manual gift assignment' : 'Gift redemption',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _RewardColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  assigning
                      ? 'Inventory is consumed when the gift is assigned.'
                      : 'Redeem a wallet gift at this shop.',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: _RewardColors.supporting,
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

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _RewardColors.blueSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: _RewardColors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                height: 1.4,
                color: _RewardColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
