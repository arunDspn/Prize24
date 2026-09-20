import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prize24_app/features/gift_library/domain/gift_library_models.dart';
import 'package:prize24_app/features/gift_library/presentation/gift_reward_flow.dart';
import 'package:prize24_app/features/shop/domain/model/check_in_response_model.dart';

void main() {
  test('builds reward summary data from a version-1 check-in', () {
    const response = CheckInRepsponseDataModel(
      cumulativeStreak: 16,
      consecutiveDays: 4,
      bonusApplied: true,
      isGiftDay: true,
      isNewUser: false,
      cumulativeBillSum: 125.75,
      milestoneCycleBillSum: 40.25,
      crossedMilestone: 15,
      rewardOpportunity: RewardOpportunityModel(
        id: 'customer-1_15',
        status: 'pending',
        eligibleSources: ['campaign', 'gift_library'],
      ),
    );

    final data = RewardFlowData.fromCheckIn(
      userId: 'customer-1',
      data: response,
    );

    expect(data.cumulativeStreak, 16);
    expect(data.milestone, 15);
    expect(data.cumulativeBillSum, 125.75);
    expect(data.milestoneCycleBillSum, 40.25);
    expect(data.eligibleSources, ['campaign', 'gift_library']);
  });

  testWidgets('shows guidance when a Gift Library has no active buckets', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: FilledButton(
              onPressed: () => showGiftLibraryBucketPicker(context, const []),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(
      find.text('This Gift Library has no active buckets.'),
      findsOneWidget,
    );
  });

  testWidgets('shows both reward sources and the monetary milestone summary', (
    tester,
  ) async {
    const data = RewardFlowData(
      opportunityId: 'opportunity-1',
      userId: 'customer-1',
      milestone: 15,
      cumulativeStreak: 16,
      eligibleSources: ['campaign', 'gift_library'],
      cumulativeBillSum: 125.75,
      milestoneCycleBillSum: 40.25,
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: FilledButton(
                onPressed: () => unawaited(
                  showRewardSourceDialog(
                    context: context,
                    data: data,
                    lifetimeSpend: '125.75',
                    milestoneCycleSpend: '40.25',
                    libraryHasStock: false,
                    libraryLoadError: null,
                  ),
                ),
                child: const Text('Resolve'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Resolve'));
    await tester.pumpAndSettle();

    expect(find.text('Current cumulative streak: 16'), findsOneWidget);
    expect(find.text('Crossed milestone: 15'), findsOneWidget);
    expect(find.text('Lifetime spend: 125.75'), findsOneWidget);
    expect(find.text('Milestone-cycle spend: 40.25'), findsOneWidget);
    expect(find.text('Campaign draw'), findsOneWidget);
    expect(find.text('Gift Library'), findsOneWidget);
    expect(
      find.text('Out of stock. Restock a bucket to continue.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Assign later'));
    await tester.pumpAndSettle();
  });

  testWidgets('confirms both the customer and selected library bucket', (
    tester,
  ) async {
    final now = DateTime(2026);
    final bucket = GiftLibraryBucketModel(
      id: 'bucket-1',
      name: 'Free Coffee',
      description: 'One regular coffee',
      status: 'active',
      remainingCount: 3,
      createdAt: now,
      updatedAt: now,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: FilledButton(
              onPressed: () => showGiftLibraryBucketPicker(context, [
                bucket,
              ], customerId: 'customer-1'),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Free Coffee'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Customer: customer-1'), findsOneWidget);
    expect(find.textContaining('One regular coffee'), findsWidgets);
  });

  testWidgets('disables an out-of-stock bucket', (tester) async {
    final now = DateTime(2026);
    final bucket = GiftLibraryBucketModel(
      id: 'bucket-empty',
      name: 'Carrot',
      description: 'One carrot bundle',
      status: 'active',
      remainingCount: 0,
      createdAt: now,
      updatedAt: now,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: FilledButton(
              onPressed: () => showGiftLibraryBucketPicker(context, [bucket]),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Out of stock'), findsOneWidget);
    final tile = tester.widget<ListTile>(
      find.widgetWithText(ListTile, 'Carrot'),
    );
    expect(tile.enabled, isFalse);
  });
}
