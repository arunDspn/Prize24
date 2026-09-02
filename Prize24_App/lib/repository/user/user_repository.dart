import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/repository/user/user_repository_firebase_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_repository.g.dart';

abstract class UserRepository {
  // Get user profile

  // Edit user profile
  Future<AppUser> getUserProfile();

  Future<void> editUserProfile({
    required String userId,
    required String? userName,
    required String? imageUrl,
  });

  Future<void> updateUserName({
    required String userId,
    required String newUserName,
  });

  /// Get user name by user id
  Future<String?> getUserNameById(String userId);
}

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepositoryFirebaseImpl();
}
