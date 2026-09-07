import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prize24_app/features/shop/presentation/shop_activity_log/activity_log_list/ui/shop_activity_log_list_page.dart';
import 'package:prize24_app/features/shop/presentation/shop_activity_log/activity_log_list/ui/shop_activity_log_qr_scanner_page.dart';
import 'package:prize24_app/features/shop/presentation/shop_activity_log/activity_log_list/view_model/shop_activity_log_list_controller.dart';

void main() {
  group('UserQrScanGate', () {
    test('ignores empty values and accepts the first non-empty user ID', () {
      final gate = UserQrScanGate();

      expect(gate.accept(null), isNull);
      expect(gate.accept('   '), isNull);
      expect(gate.accept('  user-123  '), 'user-123');
    });

    test('ignores detections after accepting a user ID', () {
      final gate = UserQrScanGate();

      expect(gate.accept('user-123'), 'user-123');
      expect(gate.accept('user-456'), isNull);
    });
  });

  group('ShopActivityLogListPage QR filter', () {
    testWidgets('shows equally sized manual search and QR scan actions', (
      tester,
    ) async {
      final controller = _RecordingActivityLogController();
      await _pumpPage(tester, controller: controller);

      final searchButton = tester.getSize(
        find.byKey(const ValueKey('search-user-id')),
      );
      final scanButton = tester.getSize(
        find.byKey(const ValueKey('scan-user-qr')),
      );

      expect(searchButton, const Size.square(44));
      expect(scanButton, const Size.square(44));
      expect(find.byTooltip('Search User ID'), findsOneWidget);
      expect(find.byTooltip('Scan User QR'), findsOneWidget);
    });

    testWidgets('manual search trims and applies the entered user ID', (
      tester,
    ) async {
      final controller = _RecordingActivityLogController();
      await _pumpPage(tester, controller: controller);

      await tester.enterText(find.byType(TextField), '  manual-user  ');
      await tester.tap(find.byKey(const ValueKey('search-user-id')));
      await tester.pumpAndSettle();

      expect(controller.searches, ['manual-user']);
    });

    testWidgets('a scanned user ID populates the field and filters the list', (
      tester,
    ) async {
      final controller = _RecordingActivityLogController();
      await _pumpPage(
        tester,
        controller: controller,
        scannerLauncher: (_) async => '  scanned-user  ',
      );

      await tester.tap(find.byKey(const ValueKey('scan-user-qr')));
      await tester.pumpAndSettle();

      expect(controller.searches, ['scanned-user']);
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller?.text,
        'scanned-user',
      );
    });

    testWidgets('cancelling the scanner preserves the current filter', (
      tester,
    ) async {
      final controller = _RecordingActivityLogController();
      await _pumpPage(
        tester,
        controller: controller,
        scannerLauncher: (_) async => null,
      );

      await tester.enterText(find.byType(TextField), 'existing-user');
      await tester.tap(find.byKey(const ValueKey('search-user-id')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('scan-user-qr')));
      await tester.pumpAndSettle();

      expect(controller.searches, ['existing-user']);
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller?.text,
        'existing-user',
      );
    });

    testWidgets('clear resets a scanned user filter and the text field', (
      tester,
    ) async {
      final controller = _RecordingActivityLogController();
      await _pumpPage(
        tester,
        controller: controller,
        scannerLauncher: (_) async => 'scanned-user',
      );

      await tester.tap(find.byKey(const ValueKey('scan-user-qr')));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      expect(controller.searches, ['scanned-user', null]);
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller?.text,
        isEmpty,
      );
    });
  });
}

Future<void> _pumpPage(
  WidgetTester tester, {
  required _RecordingActivityLogController controller,
  UserQrScannerLauncher? scannerLauncher,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        shopActivityLogListControllerProvider(
          shopId: 'shop-1',
        ).overrideWith(() => controller),
      ],
      child: MaterialApp(
        home: ShopActivityLogListPage(
          shopId: 'shop-1',
          qrScannerLauncher: scannerLauncher,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _RecordingActivityLogController extends ShopActivityLogListController {
  final List<String?> searches = [];
  String? _activeUserId;

  @override
  FutureOr<PaginatedShopActivityLogState> build({required String shopId}) {
    return const PaginatedShopActivityLogState(items: [], hasMore: false);
  }

  @override
  Future<void> search(String? userId) async {
    searches.add(userId);
    _activeUserId = userId;
    state = const AsyncLoading();
    await Future<void>.delayed(Duration.zero);
    state = const AsyncData(
      PaginatedShopActivityLogState(
        items: [],
        hasMore: false,
        cursor: Object(),
      ),
    );
  }

  @override
  String? get filterUserId => _activeUserId;
}
