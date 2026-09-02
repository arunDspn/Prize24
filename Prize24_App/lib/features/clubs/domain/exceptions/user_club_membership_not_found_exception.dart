import 'package:prize24_app/features/clubs/domain/exceptions/club_exception.dart';

/// Exception thrown when a user's club membership document is not found
class UserClubMembershipNotFoundException extends ClubException {
  UserClubMembershipNotFoundException({
    required String userId,
    required String clubId,
  }) : super(
          message:
              'User club membership does not exist for user $userId in club $clubId.',
          userId: userId,
          clubId: clubId,
        );
}
