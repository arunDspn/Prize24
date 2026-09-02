import 'dart:math';

/// Generates short, human-friendly alphanumeric codes.
///
/// Character space: 36 symbols (`A-Z`, `0-9`)
/// Total combinations for length 6: `36^6 = 2,176,782,336`.
class AlphanumericCodeService {
  AlphanumericCodeService({Random? random})
    : _random = random ?? Random.secure();

  final Random _random;

  static const String _charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  /// Generates a cryptographically secure random code.
  ///
  /// Example output: `X4P9Q2`.
  String generateCode({int length = 6}) {
    if (length <= 0) {
      throw ArgumentError.value(length, 'length', 'must be greater than 0');
    }

    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      buffer.write(_charset[_random.nextInt(_charset.length)]);
    }
    return buffer.toString();
  }

  /// Generates a unique code by checking storage and retrying if needed.
  ///
  /// [exists] should return `true` when the code is already present.
  /// This keeps collisions manageable even at high scale.
  Future<String> generateUniqueCode({
    int length = 6,
    required Future<bool> Function(String code) exists,
    int maxAttempts = 20,
  }) async {
    if (maxAttempts <= 0) {
      throw ArgumentError.value(
        maxAttempts,
        'maxAttempts',
        'must be greater than 0',
      );
    }

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final code = generateCode(length: length);
      final alreadyExists = await exists(code);
      if (!alreadyExists) {
        return code;
      }
    }

    throw StateError(
      'Could not generate a unique alphanumeric code after $maxAttempts attempts.',
    );
  }
}
