import 'package:flutter_test/flutter_test.dart';
import 'package:prize24_app/features/shop/presentation/add_edit_shop/shop_phone_number_parser.dart';

void main() {
  group('parseShopPhoneNumber', () {
    test('separates an Indian dial code without removing local digits', () {
      final result = parseShopPhoneNumber('+919876543210');

      expect(result.country.code, 'IN');
      expect(result.country.dialCode, '+91');
      expect(result.localNumber, '9876543210');
    });

    test('restores the country for a non-Indian number', () {
      final result = parseShopPhoneNumber('+442079460018');

      expect(result.country.code, 'GB');
      expect(result.country.dialCode, '+44');
      expect(result.localNumber, '2079460018');
    });

    test('uses the longest matching dial code', () {
      final result = parseShopPhoneNumber('+16845551234');

      expect(result.country.code, 'AS');
      expect(result.country.dialCode, '+1684');
      expect(result.localNumber, '5551234');
    });

    test('keeps a legacy local number and defaults to India', () {
      final result = parseShopPhoneNumber('98765 43210');

      expect(result.country.code, 'IN');
      expect(result.country.dialCode, '+91');
      expect(result.localNumber, '9876543210');
    });
  });
}
