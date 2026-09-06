import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/repository/user/user_repository.dart';

class UserRepositoryFirebaseImpl implements UserRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> editUserProfile({
    required String? userName,
    required String? imageUrl,
    required String userId,
  }) async {
    final userRef = _firestore.collection('users').doc(userId);
    await userRef.update({
      if (userName != null) 'userName': userName,
      if (imageUrl != null) 'imageUrl': imageUrl,
    });
  }

  @override
  Future<AppUser> getUserProfile() {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserName({
    required String userId,
    required String newUserName,
  }) async {
    final userRef = _firestore.collection('users').doc(userId);
    await userRef.update({'userName': newUserName});
  }

  @override
  Future<void> updateUserPhoneNumber({
    required String userId,
    required String userPhoneNumber,
  }) async {
    final userRef = _firestore.collection('users').doc(userId);
    await userRef.update({
      'userPhoneNumber': userPhoneNumber,
      'updatedAt': DateTime.now(),
    });
  }

  @override
  Future<String?> getUserNameById(String userId) async {
    final userRef = _firestore.collection('users').doc(userId);
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      final data = userSnapshot.data();
      return data?['userName'] as String?;
    }
    return null;
  }
}
