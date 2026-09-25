import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prize24_app/features/gift_library/data/gift_library_service.dart';
import 'package:prize24_app/features/gift_library/domain/gift_library_models.dart';
import 'package:prize24_app/features/shop/domain/model/check_in_response_model.dart';

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
      builder: (_) => const Center(child: CircularProgressIndicator()),
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
      builder: (context) => AlertDialog(
        title: Text(
          result.outcome == 'awarded' ? 'Gift assigned' : 'Reward result',
        ),
        content: Text(
          'Current cumulative streak: ${data.cumulativeStreak}\n'
          'Crossed milestone: ${data.milestone}\n'
          'Lifetime spend: $lifetimeSpend\n'
          'Milestone-cycle spend: $milestoneCycleSpend\n\n'
          '$message',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  } catch (error) {
    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Reward remains pending: $error')));
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
    builder: (context) => AlertDialog(
      title: const Text('Milestone reached'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current cumulative streak: ${data.cumulativeStreak}'),
          Text('Crossed milestone: ${data.milestone}'),
          const SizedBox(height: 8),
          Text('Lifetime spend: $lifetimeSpend'),
          Text('Milestone-cycle spend: $milestoneCycleSpend'),
          const SizedBox(height: 20),
          if (data.eligibleSources.contains('campaign'))
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.campaign_rounded),
              title: const Text('Campaign draw'),
              subtitle: const Text('Use the current campaign draw.'),
              onTap: () => Navigator.pop(context, 'campaign'),
            ),
          if (data.eligibleSources.contains('gift_library'))
            ListTile(
              contentPadding: EdgeInsets.zero,
              enabled: libraryHasStock,
              leading: const Icon(Icons.card_giftcard_rounded),
              title: const Text('Gift Library'),
              subtitle: Text(
                libraryHasStock
                    ? 'Choose a bucket for this customer.'
                    : libraryLoadError == null
                    ? 'Out of stock. Restock a bucket to continue.'
                    : 'Unable to check bucket inventory.',
              ),
              onTap: libraryHasStock
                  ? () => Navigator.pop(context, 'gift_library')
                  : null,
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Assign later'),
        ),
      ],
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
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: buckets.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                'This Gift Library has no active buckets.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              itemCount: buckets.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final bucket = buckets[index];
                final customerLine = customerId == null
                    ? ''
                    : '\n\nCustomer: $customerId';
                final inventoryLine = bucket.isAvailable
                    ? 'Remaining: ${bucket.remainingCount}'
                    : 'Out of stock';
                return ListTile(
                  leading: const Icon(Icons.redeem_rounded),
                  title: Text(bucket.name),
                  subtitle: Text('${bucket.description}\n$inventoryLine'),
                  isThreeLine: true,
                  enabled: bucket.isAvailable,
                  onTap: !bucket.isAvailable
                      ? null
                      : () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Assign this gift?'),
                              content: Text(
                                '${bucket.name}\n\n${bucket.description}'
                                '\n\nRemaining: ${bucket.remainingCount}'
                                '$customerLine',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Assign'),
                                ),
                              ],
                            ),
                          );
                          if ((confirmed ?? false) && context.mounted) {
                            Navigator.pop(context, bucket);
                          }
                        },
                );
              },
            ),
    ),
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
      appBar: AppBar(title: const Text('Pending Rewards')),
      body: FutureBuilder<List<RewardOpportunityListItem>>(
        future: _pending,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final pending = snapshot.data ?? const [];
          if (pending.isEmpty) {
            return const Center(child: Text('No pending milestone rewards.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: pending.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = pending[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.pending_actions_rounded),
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
      appBar: AppBar(
        title: Text(assigning ? 'Assign Library Gift' : 'Redeem Library Gift'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            assigning
                ? 'Scan an existing shop follower’s Prize24 QR code.'
                : 'Scan the customer’s wallet gift QR code.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 340,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MobileScanner(
                controller: _scanner,
                onDetect: (capture) {
                  final value = capture.barcodes.isEmpty
                      ? null
                      : capture.barcodes.first.rawValue;
                  if (value != null) unawaited(_handleCode(value));
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _manual,
            enabled: !_busy,
            decoration: InputDecoration(
              labelText: assigning ? 'Customer ID' : 'User gift ID',
              suffixIcon: IconButton(
                onPressed: _busy ? null : () => _handleCode(_manual.text),
                icon: const Icon(Icons.arrow_forward_rounded),
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
