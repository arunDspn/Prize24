import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('plugin.libphonenumber');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'isValidPhoneNumber':
          final phoneNumber = methodCall.arguments['phoneNumber'] as String?;
          final isoCode = methodCall.arguments['isoCode'] as String?;
          if (phoneNumber == '9878987678' && isoCode == 'IN') {
            return true;
          }
          return false;
        case 'normalizePhoneNumber':
          final phoneNumber = methodCall.arguments['phoneNumber'] as String?;
          final isoCode = methodCall.arguments['isoCode'] as String?;
          if (phoneNumber == '9878987678' && isoCode == 'IN') {
            return '+919878987678';
          }
          return null;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('validates an India mobile number', () async {
    final isValid = await PhoneService.parsePhoneNumber('9878987678', 'IN');

    expect(isValid, true);
  });

  test('normalizes an India mobile number to E.164', () async {
    final normalized = await PhoneService.getNormalizedPhoneNumber(
      '9878987678',
      'IN',
    );

    expect(normalized, '+919878987678');
  });

  test('rejects an invalid India mobile number', () async {
    final isValid = await PhoneService.parsePhoneNumber('1234567890', 'IN');

    expect(isValid, false);
  });
}
