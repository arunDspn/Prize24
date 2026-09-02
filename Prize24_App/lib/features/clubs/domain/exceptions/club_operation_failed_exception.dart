import 'package:prize24_app/features/clubs/domain/exceptions/club_exception.dart';

/// Exception thrown when a club operation fails
class ClubOperationFailedException extends ClubException {
  final String operation;
  final dynamic originalError;

  ClubOperationFailedException({
    required this.operation,
    required String message,
    this.originalError,
    String? userId,
    String? clubId,
    String? vendorId,
  }) : super(
          message: 'Club operation "$operation" failed: $message',
          userId: userId,
          clubId: clubId,
          vendorId: vendorId,
        );

  @override
  String toString() {
    if (originalError != null) {
      return '$message\nOriginal error: $originalError';
    }
    return message;
  }
}
