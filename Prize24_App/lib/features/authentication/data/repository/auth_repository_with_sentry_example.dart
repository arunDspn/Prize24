import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/utils/sentry_helper.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Example implementation showing Sentry integration in auth repository
/// This is a REFERENCE file showing how to enhance auth_repository_firebase_impl.dart
///
/// DO NOT USE THIS FILE DIRECTLY - Copy the pattern into your actual implementation
class AuthRepositoryWithSentryExample implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Logger logger = Logger();

  @override
  Future<AppUser?> checkAuth() async {
    // This already exists - no Sentry needed as it's called frequently
    return null;
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    // ✅ EXAMPLE: Wrapping entire operation with Sentry error handling
    return await SentryHelper.executeWithErrorHandling<AppUser>(
          operationName: 'signInWithGoogle',
          operation: () async {
            // Add breadcrumb at start
            SentryHelper.addBreadcrumb(
              message: 'Starting Google Sign In',
              category: 'auth',
              data: {'flavor': FlavorConfig.name},
            );

            try {
              // Initialize Google Sign In
              await GoogleSignIn.instance.initialize(
                serverClientId: FlavorConfig.isDevelopment
                    ? '658213032436-3hh9nrk5p9majp7g14kibtsedt0u90oo.apps.googleusercontent.com'
                    : '667868429256-k41nhl5j10akcij1u0pggm40221ul5id.apps.googleusercontent.com',
              );

              // Authenticate with Google
              final googleUser = await GoogleSignIn.instance.authenticate(
                scopeHint: ['email', 'profile'],
              );

              SentryHelper.addBreadcrumb(
                message: 'Google authentication successful',
                category: 'auth',
              );

              // Get auth details
              final googleAuth = googleUser.authentication;

              // Create Firebase credential
              final credential = GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
              );

              // Sign in to Firebase
              final userCredential = await FirebaseAuth.instance
                  .signInWithCredential(credential);

              if (userCredential.user == null) {
                // Track critical error - user credential returned null
                await SentryHelper.captureMessage(
                  'Firebase sign-in returned null user credential',
                  level: SentryLevel.error,
                  extra: {'auth_method': 'google'},
                );
                throw Exception('Sign in failed - no user credential');
              }

              SentryHelper.addBreadcrumb(
                message: 'Firebase sign-in successful',
                category: 'auth',
                data: {'userId': userCredential.user!.uid},
              );

              // Get or create app user
              final appUser = await _processGoogleSignIn(userCredential);

              // ✅ CRITICAL: Set user context in Sentry for all future errors
              SentryHelper.setUser(
                userId: appUser.userId,
                email: appUser.userEmail,
                username: appUser.userName,
              );

              SentryHelper.addBreadcrumb(
                message: 'Google Sign In completed successfully',
                category: 'auth',
                data: {
                  'userId': appUser.userId,
                  'isNewUser': await _isNewUser(userCredential.user!.uid),
                },
              );

              return appUser;
            } on FirebaseAuthException catch (e) {
              // Track Firebase-specific auth errors
              await SentryHelper.captureException(
                e,
                stackTrace: StackTrace.current,
                hint: 'Firebase Auth Error during Google Sign In',
                extra: {
                  'error_code': e.code,
                  'error_message': e.message,
                  'auth_method': 'google',
                },
                level: SentryLevel.error,
              );
              rethrow;
            } on PlatformException catch (e) {
              // Track Google Sign In platform errors
              await SentryHelper.captureException(
                e,
                stackTrace: StackTrace.current,
                hint: 'Google Sign In Platform Error',
                extra: {
                  'error_code': e.code,
                  'error_message': e.message,
                  'platform': Platform.operatingSystem,
                },
                level: SentryLevel.error,
              );
              rethrow;
            }
          },
          additionalContext: {
            'auth_method': 'google',
            'flavor': FlavorConfig.name,
            'platform': Platform.operatingSystem,
          },
        )
        as AppUser; // Safe cast since we rethrow on error
  }

  @override
  Future<AppUser?> signInWithApple() async {
    // ✅ EXAMPLE: Similar pattern for Apple Sign In
    return await SentryHelper.executeWithErrorHandling<AppUser?>(
      operationName: 'signInWithApple',
      operation: () async {
        SentryHelper.addBreadcrumb(
          message: 'Starting Apple Sign In',
          category: 'auth',
          data: {'flavor': FlavorConfig.name},
        );

        try {
          // Generate nonce
          final rawNonce = _generateNonce();
          final nonce = _sha256ofString(rawNonce);

          // Request Apple credential
          final appleCredential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            nonce: nonce,
          );

          SentryHelper.addBreadcrumb(
            message: 'Apple authentication successful',
            category: 'auth',
          );

          // Create OAuth credential
          final oauthCredential = OAuthProvider('apple.com').credential(
            idToken: appleCredential.identityToken,
            rawNonce: rawNonce,
          );

          // Sign in to Firebase
          final userCredential = await _firebaseAuth.signInWithCredential(
            oauthCredential,
          );

          if (userCredential.user == null) {
            await SentryHelper.captureMessage(
              'Firebase sign-in returned null user credential',
              level: SentryLevel.error,
              extra: {'auth_method': 'apple'},
            );
            throw Exception('Sign in failed - no user credential');
          }

          SentryHelper.addBreadcrumb(
            message: 'Firebase sign-in successful',
            category: 'auth',
            data: {'userId': userCredential.user!.uid},
          );

          // Process Apple sign in
          final appUser = await _processAppleSignIn(
            userCredential,
            appleCredential,
          );

          // Set Sentry user context
          if (appUser != null) {
            SentryHelper.setUser(
              userId: appUser.userId,
              email: appUser.userEmail,
              username: appUser.userName,
            );
          }

          SentryHelper.addBreadcrumb(
            message: 'Apple Sign In completed successfully',
            category: 'auth',
            data: {'userId': appUser?.userId},
          );

          return appUser;
        } on SignInWithAppleAuthorizationException catch (e) {
          // Track Apple-specific auth errors
          await SentryHelper.captureException(
            e,
            stackTrace: StackTrace.current,
            hint: 'Apple Sign In Authorization Error',
            extra: {
              'error_code': e.code.toString(),
              'error_message': e.message,
            },
            level: SentryLevel.error,
          );
          rethrow;
        } on FirebaseAuthException catch (e) {
          await SentryHelper.captureException(
            e,
            stackTrace: StackTrace.current,
            hint: 'Firebase Auth Error during Apple Sign In',
            extra: {
              'error_code': e.code,
              'error_message': e.message,
              'auth_method': 'apple',
            },
            level: SentryLevel.error,
          );
          rethrow;
        }
      },
      additionalContext: {
        'auth_method': 'apple',
        'flavor': FlavorConfig.name,
        'platform': Platform.operatingSystem,
      },
    );
  }

  @override
  Future<void> signOut() async {
    // ✅ EXAMPLE: Track sign out and clear Sentry context
    await SentryHelper.executeWithErrorHandling(
      operationName: 'signOut',
      operation: () async {
        SentryHelper.addBreadcrumb(
          message: 'User signing out',
          category: 'auth',
        );

        await _firebaseAuth.signOut();
        await GoogleSignIn.instance.signOut();

        // ✅ CRITICAL: Clear user context from Sentry
        SentryHelper.clearUser();

        SentryHelper.addBreadcrumb(
          message: 'Sign out successful',
          category: 'auth',
        );
      },
      additionalContext: {'operation': 'sign_out'},
    );
  }

  @override
  Stream<AppUser?> onAuthChange() {
    // Stream-based - no Sentry needed
    return const Stream.empty();
  }

  // Helper methods (implementation details omitted for brevity)
  Future<AppUser> _processGoogleSignIn(UserCredential userCredential) async {
    // Implementation here...
    throw UnimplementedError();
  }

  Future<AppUser?> _processAppleSignIn(
    UserCredential userCredential,
    AuthorizationCredentialAppleID appleCredential,
  ) async {
    // Implementation here...
    throw UnimplementedError();
  }

  Future<bool> _isNewUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return !doc.exists;
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<void> setReferrerCode(String referralCode) {
    // TODO: implement setReferrerCode
    throw UnimplementedError();
  }
}
