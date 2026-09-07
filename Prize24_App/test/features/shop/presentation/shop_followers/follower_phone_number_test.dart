import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prize24_app/common_widgets/phone_number_link.dart';
import 'package:prize24_app/features/happy_hours/domain/model/shop_follower_model.dart';
import 'package:prize24_app/features/shop/data/dto/shop_follower_dto.dart';
import 'package:prize24_app/features/shop/presentation/shop_follower_detail/component/user_streak_log/user_streak_log_controller.dart';
import 'package:prize24_app/features/shop/presentation/shop_follower_detail/ui/shop_follower_detail_page.dart';
import 'package:prize24_app/features/shop/presentation/shop_followers/ui/shop_followers_page.dart';
import 'package:prize24_app/features/shop/presentation/shop_followers/view_model/shop_followers_controller.dart';

void main() {
  group('ShopFollowerDto phone number', () {
    test('deserializes a populated phone number', () {
      final dto = ShopFollowerDto.fromJson({
        'userId': 'user-1',
        'userName': 'Follower One',
        'userPhoneNumber': '+919876543210',
        'cumulativeStreak': 4,
        'followedAt': Timestamp.fromMillisecondsSinceEpoch(0),
      });

      expect(dto.userPhoneNumber, '+919876543210');
      expect(dto.toDomain().userPhoneNumber, '+919876543210');
    });

    test('accepts an existing document without a phone field', () {
      final dto = ShopFollowerDto.fromJson({
        'userId': 'user-1',
        'userName': 'Follower One',
        'cumulativeStreak': 4,
        'followedAt': Timestamp.fromMillisecondsSinceEpoch(0),
      });

      expect(dto.userPhoneNumber, isNull);
      expect(dto.toDomain().userPhoneNumber, isNull);
    });
  });

  group('PhoneNumberLink', () {
    testWidgets('launches the expected tel URI', (tester) async {
      Uri? launchedUri;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhoneNumberLink(
              phoneNumber: '+919876543210',
              launcher: (uri) async {
                launchedUri = uri;
                return true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('+919876543210'));
      await tester.pump();

      expect(launchedUri, Uri.parse('tel:+919876543210'));
    });

    testWidgets('shows feedback when the dialer cannot open', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhoneNumberLink(
              phoneNumber: '+919876543210',
              launcher: (_) async => false,
            ),
          ),
        ),
      );

      await tester.tap(find.text('+919876543210'));
      await tester.pump();

      expect(find.text('Unable to open the phone dialer.'), findsOneWidget);
    });
  });

  group('follower phone UI', () {
    testWidgets('shows the phone number on list and detail pages', (
      tester,
    ) async {
      final follower = _follower(userPhoneNumber: '+919876543210');

      await tester.pumpWidget(
        ProviderScope(
          key: UniqueKey(),
          overrides: [
            shopFollowersControllerProvider(
              shopId: 'shop-1',
            ).overrideWith(() => _FakeShopFollowersController(follower)),
          ],
          child: const MaterialApp(home: ShopFollowersPage(shopId: 'shop-1')),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('+919876543210'), findsOneWidget);

      await tester.pumpWidget(
        ProviderScope(
          key: UniqueKey(),
          overrides: [
            userStreakLogControllerProvider(
              shopId: 'shop-1',
              userId: 'user-1',
            ).overrideWith(_FakeUserStreakLogController.new),
          ],
          child: MaterialApp(
            home: ShopFollowerDetailPage(follower: follower, shopId: 'shop-1'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('PHONE NUMBER'), findsOneWidget);
      expect(find.text('+919876543210'), findsOneWidget);
    });

    testWidgets('hides missing and blank phone numbers', (tester) async {
      for (final phoneNumber in <String?>[null, '   ']) {
        final follower = _follower(userPhoneNumber: phoneNumber);

        await tester.pumpWidget(
          ProviderScope(
            key: UniqueKey(),
            overrides: [
              shopFollowersControllerProvider(
                shopId: 'shop-1',
              ).overrideWith(() => _FakeShopFollowersController(follower)),
            ],
            child: const MaterialApp(home: ShopFollowersPage(shopId: 'shop-1')),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(PhoneNumberLink), findsNothing);

        await tester.pumpWidget(
          ProviderScope(
            key: UniqueKey(),
            overrides: [
              userStreakLogControllerProvider(
                shopId: 'shop-1',
                userId: 'user-1',
              ).overrideWith(_FakeUserStreakLogController.new),
            ],
            child: MaterialApp(
              home: ShopFollowerDetailPage(
                follower: follower,
                shopId: 'shop-1',
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('PHONE NUMBER'), findsNothing);
        expect(find.byType(PhoneNumberLink), findsNothing);
      }
    });
  });
}

ShopFollowerModel _follower({String? userPhoneNumber}) {
  return ShopFollowerModel(
    userId: 'user-1',
    userName: 'Follower One',
    userPhoneNumber: userPhoneNumber,
    cumulativeStreak: 4,
    followedAt: DateTime(2026),
  );
}

class _FakeShopFollowersController extends ShopFollowersController {
  _FakeShopFollowersController(this.follower);

  final ShopFollowerModel follower;

  @override
  FutureOr<ShopFollowersPaginatedState> build({required String shopId}) {
    return ShopFollowersPaginatedState(followers: [follower]);
  }
}

class _FakeUserStreakLogController extends UserStreakLogController {
  @override
  FutureOr<PaginatedStreakLogState> build({
    required String shopId,
    required String userId,
  }) {
    return const PaginatedStreakLogState(items: [], hasMore: false);
  }
}
