import 'package:prize24_app/features/clubs/domain/exceptions/club_exception.dart';

/// Exception thrown when attempting to add a user who is already a member of the club
class UserAlreadyMemberException extends ClubException {
  UserAlreadyMemberException({
    required String userId,
    required String clubId,
  }) : super(
          message: 'User with ID $userId is already a member of the club.',
          userId: userId,
          clubId: clubId,
        );
}
