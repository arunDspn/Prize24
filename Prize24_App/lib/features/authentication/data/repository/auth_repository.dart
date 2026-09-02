import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/authentication/data/repository/auth_repository_firebase_impl.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  // Future<GuestUser> signInAnonymously();
  // Future<AuthenticatedUser> signInWithEmailAndPassword(
  //   String email,
  //   String password,
  // );
  // Future<AuthenticatedUser> signUpWithEmailAndPassword({
  //   required String email,
  //   required String password,
  //   required String userName,
  // });
  // Future<void> forgotPassword(String email);
  Future<AppUser?> checkAuth();
  Future<AppUser?> signInWithGoogle();
  Future<AppUser?> signInWithApple();
  Future<void> signOut();
  Stream<AppUser?> onAuthChange();

  /// Sends a verification email to the user.
  // Future<void> sendEmailVerification();

  /// Set referrer code for the user. This is used when a new user signs up with a referral code.
  Future<void> setReferrerCode(String referralCode);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryFirebaseImpl();
}
