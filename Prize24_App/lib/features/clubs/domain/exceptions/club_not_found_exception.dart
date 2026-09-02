import 'package:prize24_app/features/clubs/domain/exceptions/club_exception.dart';

/// Exception thrown when a club is not found
class ClubNotFoundException extends ClubException {
  ClubNotFoundException({
    required String clubId,
    String? vendorId,
  }) : super(
          message: 'Club with ID $clubId does not exist.',
          clubId: clubId,
          vendorId: vendorId,
        );
}
