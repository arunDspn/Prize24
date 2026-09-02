import 'package:prize24_app/features/clubs/domain/exceptions/club_exception.dart';

/// Exception thrown when a user is not found in the system
class UserNotFoundException extends ClubException {
  UserNotFoundException({
    required String userId,
  }) : super(
          message: 'User with ID $userId does not exist.',
          userId: userId,
        );
}
