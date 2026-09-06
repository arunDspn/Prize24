import 'package:country_code_picker_plus/country_code_picker_plus.dart';

final List<Country> _supportedCountries = const CountryCodePicker().countryList
    .map(Country.fromJson)
    .toList(growable: false);

class ShopPhoneNumberParts {
  const ShopPhoneNumberParts({
    required this.country,
    required this.localNumber,
  });

  final Country country;
  final String localNumber;
}

ShopPhoneNumberParts parseShopPhoneNumber(String phoneNumber) {
  final trimmedPhoneNumber = phoneNumber.trim();
  final digits = trimmedPhoneNumber.replaceAll(RegExp('[^0-9]'), '');
  final normalizedPhoneNumber = trimmedPhoneNumber.startsWith('+')
      ? '+$digits'
      : digits;

  Country? matchedCountry;
  if (normalizedPhoneNumber.startsWith('+')) {
    for (final country in _supportedCountries) {
      if (normalizedPhoneNumber.startsWith(country.dialCode) &&
          (matchedCountry == null ||
              country.dialCode.length > matchedCountry.dialCode.length)) {
        matchedCountry = country;
      }
    }
  }

  final country =
      matchedCountry ??
      _supportedCountries.firstWhere((country) => country.code == 'IN');
  final localNumber = matchedCountry == null
      ? digits
      : normalizedPhoneNumber.substring(country.dialCode.length);

  return ShopPhoneNumberParts(country: country, localNumber: localNumber);
}
