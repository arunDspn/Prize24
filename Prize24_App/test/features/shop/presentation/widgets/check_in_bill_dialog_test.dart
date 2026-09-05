import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prize24_app/features/shop/presentation/widgets/check_in_bill_dialog.dart';

void main() {
  Future<void> pumpLauncher(
    WidgetTester tester, {
    required ValueChanged<CheckInBillDetails?> onResult,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: FilledButton(
              onPressed: () async {
                final result = await showCheckInBillDialog(
                  context,
                  userId: 'customer-123',
                );
                onResult(result);
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  testWidgets('enables submission only for valid bill details', (tester) async {
    await pumpLauncher(tester, onResult: (_) {});

    FilledButton submitButton() => tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Submit check-in'),
    );

    expect(submitButton().onPressed, isNull);

    await tester.enterText(find.byType(TextFormField).at(0), 'INV-42');
    await tester.enterText(find.byType(TextFormField).at(1), '0');
    await tester.pump();
    expect(submitButton().onPressed, isNull);

    await tester.enterText(find.byType(TextFormField).at(1), '10.25');
    await tester.pump();
    expect(submitButton().onPressed, isNotNull);
  });

  testWidgets('returns normalized bill details', (tester) async {
    CheckInBillDetails? result;
    await pumpLauncher(tester, onResult: (value) => result = value);

    await tester.enterText(find.byType(TextFormField).at(0), '  INV-42  ');
    await tester.enterText(find.byType(TextFormField).at(1), '123.45');
    await tester.pump();
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Submit check-in'),
          )
          .onPressed,
      isNotNull,
    );
    await tester.tap(find.text('Submit check-in'));
    await tester.pumpAndSettle();

    expect(result?.billNumber, 'INV-42');
    expect(result?.billAmount, 123.45);
  });

  testWidgets('cancel returns no bill details', (tester) async {
    CheckInBillDetails? result = const CheckInBillDetails(
      billNumber: 'sentinel',
      billAmount: 1,
    );
    await pumpLauncher(tester, onResult: (value) => result = value);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(result, isNull);
  });
}
