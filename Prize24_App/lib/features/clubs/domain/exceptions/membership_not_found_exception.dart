import 'package:prize24_app/features/clubs/domain/exceptions/club_exception.dart';

/// Exception thrown when a club membership is not found
class MembershipNotFoundException extends ClubException {
  MembershipNotFoundException({
    required String userId,
    required String clubId,
    String? vendorId,
  }) : super(
          message:
              'Membership does not exist for user $userId in club $clubId.',
          userId: userId,
          clubId: clubId,
          vendorId: vendorId,
        );
}
