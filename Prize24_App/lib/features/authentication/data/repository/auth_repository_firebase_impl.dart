import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/core/services/alphanumeric_code_service.dart';
import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/utils/date_convertors.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepositoryFirebaseImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Logger logger = Logger();

  /// Helper method to get APNS token with retry logic.
  /// On physical iOS devices, the APNS token may not be immediately available
  /// after requesting permission. This method retries for up to 10 seconds.
  Future<String?> _getAPNSTokenWithRetry({int maxRetries = 10}) async {
    for (int i = 0; i < maxRetries; i++) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        logger.i('APNS token obtained after ${i + 1} attempt(s)');
        return apnsToken;
      }
      // Wait 1 second before retrying
      await Future<void>.delayed(const Duration(seconds: 1));
      logger.d('Waiting for APNS token... attempt ${i + 1}/$maxRetries');
    }
    return null;
  }

  /// Helper method to get FCM token for iOS with proper APNS token handling.
  /// Returns a tuple of (fcmToken, isSimulator).
  Future<(String?, bool)> _getFCMTokenForIOS(String userId) async {
    await FirebaseMessaging.instance.requestPermission();

    // Try to get APNS token with retry
    final apnsToken = await _getAPNSTokenWithRetry(maxRetries: 10);

    if (apnsToken == null) {
      logger.w(
        'APNS token is null after retries - likely running on iOS Simulator. Using fake FCM token.',
      );
      // Generate a fake token for simulator testing
      final fakeToken =
          'simulator_token_${userId}_${DateTime.now().millisecondsSinceEpoch}';
      return (fakeToken, true);
    } else {
      // Get real FCM token on physical device
      final fcmToken = await FirebaseMessaging.instance.getToken();
      return (fcmToken, false);
    }
  }

  // @override
  // Future<AuthenticatedUser> signInWithEmailAndPassword(
  //   String email,
  //   String password,
  // ) async {
  //   final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );

  //   // Read userId from user's collection
  //   final userName = await _firestore
  //       .collection('users')
  //       .doc(userCredential.user!.uid)
  //       .get();

  //   if (userCredential.user == null) {
  //     throw Exception('User not found');
  //   } else {
  //     // Check this user email is verified or not
  //     final isEmailVerified = userCredential.user!.emailVerified;

  //     return AuthenticatedUser(
  //       userId: userCredential.user!.uid,
  //       userEmail: userCredential.user!.email ?? 'no email',
  //       userName:
  //           userName.data()?['userName'] as String? ?? '', // Backward comp
  //       userAvatar: userName.data()?['userAvatar'] as String? ?? '',
  //       isVendor: userName.data()?['isVendor'] as bool? ?? false,
  //       // vendorId: userName.data()?['vendorId'] as String?,
  //       isVerified: isEmailVerified,
  //     );
  //   }
  // }

  // @override
  // Future<AuthenticatedUser> signUpWithEmailAndPassword({
  //   required String email,
  //   required String password,
  //   required String userName,
  // }) async {
  //   final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );

  //   if (userCredential.user == null) {
  //     throw Exception('User not found');
  //   } else {
  //     // Store user id in users collections
  //     await _firestore.collection('users').doc(userCredential.user!.uid).set({
  //       'userName': userName,
  //       'isVendor': false,
  //       'createdAt': DateTime.now(),
  //       'updatedAt': DateTime.now(),
  //     });

  //     // Send verification email
  //     await userCredential.user!.sendEmailVerification();

  //     return AuthenticatedUser(
  //       userId: userCredential.user!.uid,
  //       userEmail: userCredential.user!.email!,
  //       userName: userName,
  //       isVendor: false,
  //       isVerified: userCredential.user!.emailVerified,
  //     );
  //   }
  // }

  // @override
  // Future<void> forgotPassword(String email) async {
  //   await _firebaseAuth.sendPasswordResetEmail(
  //     email: email,
  //   );
  // }

  @override
  Future<AppUser?> checkAuth() async {
    logger.i('Checking authentication status');
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    String? currentfcmToken;
    bool isSimulator = false;

    if (Platform.isIOS) {
      final result = await _getFCMTokenForIOS(firebaseUser.uid);
      currentfcmToken = result.$1;
      isSimulator = result.$2;
    } else {
      // Get fcmToken from FCM service for non-iOS platforms
      currentfcmToken = await FirebaseMessaging.instance.getToken();
    }

    final appUser = await _getCurrentUserFromId(firebaseUser.uid);

    if (appUser == null) {
      return null;
    }

    /// Update FCM token if it's different
    // Now the FCM token will be properly updated on Android devices,
    // since the condition only checks if the token has changed,
    // without requiring the iOS-specific APNS token to be present.
    if (currentfcmToken != appUser.fcmToken && !isSimulator) {
      // Update fcmToken
      await _firestore.collection('users').doc(appUser.userId).update({
        'fcmToken': currentfcmToken,
        'updatedAt': DateTime.now(),
      });
      logger.i('Updated FCM token for user: ${appUser.userEmail}');

      if (appUser.subscribedShopTopics != null &&
          appUser.subscribedShopTopics!.isNotEmpty) {
        await Future.wait(
          appUser.subscribedShopTopics!.map((topic) async {
            await FirebaseMessaging.instance.subscribeToTopic(topic);
            logger.i('Subscribed to topic: $topic');
          }),
        );
      }
    }

    return appUser;
    // // Get revenue cat customer info and update user purchase info
    // final customerInfo = await Purchases.getCustomerInfo();
    // if (customerInfo.entitlements.active.isNotEmpty) {
    //   final maxShops = RevenueCatHelper.getMaxShops(customerInfo);
    //   final maxCampaigns = RevenueCatHelper.getMaxCampaigns(customerInfo);
    //   final maxUserFollowing =
    //       RevenueCatHelper.getMaxUserFollowing(customerInfo);

    //   final virtualCurrencies = await Purchases.getVirtualCurrencies();
    //   final virtualCurrency = virtualCurrencies.all['P24COIN'];
    //   final balance = virtualCurrency?.balance;

    //   final updatedUser = appUser.copyWith(
    //     maximumShops: maxShops,
    //     maximumCampaigns: maxCampaigns,
    //     maximumUserFollowing: maxUserFollowing,
    //     p24Coins: balance ?? 0,
    //   );
    //   return updatedUser;
    // }

    // final virtualCurrencies = await Purchases.getVirtualCurrencies();
    // final virtualCurrency = virtualCurrencies.all['P24COIN'];
    // final balance = virtualCurrency?.balance;
    // return appUser.copyWith(
    //   p24Coins: balance ?? 0,
    // );
  }

  Future<AppUser?> _getCurrentUserFromId(String userId) async {
    final user = await _firestore.collection('users').doc(userId).get();

    if (!user.exists || user.data() == null) {
      return null;
    }

    return AppUser(
      userId: userId,
      userEmail: user.data()?['userEmail'] as String? ?? '',
      userName: user.data()?['userName'] as String? ?? '',
      profilePic: user.data()?['userAvatar'] as String? ?? '',
      isVendor: user.data()?['isVendor'] as bool? ?? false,
      fcmToken: user.data()?['fcmToken'] as String? ?? '',
      subscribedShopTopics: List<String>.from(
        user.data()?['subscribedShopTopics'] as List? ?? [],
      ),
      staffShopIds: List<String>.from(
        user.data()?['staffShopIds'] as List? ?? [],
      ),
      vendorPhoneNumber: user.data()?['vendorPhoneNumber'] as String?,
      referralCode: user.data()?['referralCode'] as String? ?? 'OLD USER',
      referredBy: user.data()?['referredBy'] as String?,
      deletionRequestedAt: const TimestampConverter().fromJson(
        user.data()?['deletionRequestedAt'],
      ),
    );
  }

  Future<AppUser> _signUpUser({
    required String userId,
    required String email,
    required String userName,
    required String? fcmToken,
    String? userAvatar,
    String? userPhoneNumber,
  }) async {
    logger.i('Signing up new user: $email');

    final newUserReferralCode = AlphanumericCodeService().generateCode(
      length: 8,
    );

    // Create a new document in the 'users' collection with the user's details
    await _firestore.collection('users').doc(userId).set({
      'userEmail': email,
      'userName': userName,
      'userAvatar': userAvatar ?? '',
      'userPhoneNumber': userPhoneNumber ?? '',
      'role': 'user',
      'isVendor': false,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
      'fcmToken': fcmToken ?? '',
      'staffShopIds': <String>[],
      'referralCode': newUserReferralCode,
    });

    // Store referral code mapping for quick lookup during referral redemption
    await _firestore.collection('referralCodes').doc(newUserReferralCode).set({
      'userId': userId,
      'createdAt': DateTime.now(),
    });

    await _syncRevenueCatUserId(userId);

    // todo: Use !
    return AppUser(
      userId: userId,
      userEmail: email,
      userName: userName,
      profilePic: userAvatar ?? '',
      userPhoneNumber: userPhoneNumber ?? '',
      fcmToken: fcmToken ?? '',
      isVendor: false,
      referralCode: newUserReferralCode,
    );
  }

  Future<void> _syncRevenueCatUserId(String firebaseUid) async {
    try {
      // Map Firebase UID directly to RevenueCat App User ID.
      final LogInResult result = await Purchases.logIn(firebaseUid);
      logger.i(
        'RevenueCat logIn successful for uid=$firebaseUid, created=${result.created}',
      );
    } catch (e) {
      logger.e('RevenueCat logIn failed for uid=$firebaseUid: $e');
      rethrow;
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      await GoogleSignIn.instance.initialize(
        // serverClientId: AppConfig.googleClientId,
        serverClientId: FlavorConfig.isDevelopment
            ? '658213032436-3hh9nrk5p9majp7g14kibtsedt0u90oo.apps.googleusercontent.com'
            : '667868429256-k41nhl5j10akcij1u0pggm40221ul5id.apps.googleusercontent.com',
      );

      final googleUser = await GoogleSignIn.instance.authenticate(
        scopeHint: ['email', 'profile'],
      );
      // final googleUser = await gs.();

      // Obtain the auth details from the request
      final googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        // accessToken: googleAuth?.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      // Get App User
      final appUser = await _getCurrentUserFromId(userCredential.user!.uid);

      // Get fcmToken from FCM service
      String? currentfcmToken;
      bool isSimulator = false;

      if (Platform.isIOS) {
        final result = await _getFCMTokenForIOS(userCredential.user!.uid);
        currentfcmToken = result.$1;
        isSimulator = result.$2;
      } else {
        // Get fcmToken from FCM service for non-iOS platforms
        currentfcmToken = await FirebaseMessaging.instance.getToken();
      }

      // Old user
      if (appUser != null) {
        logger.i('User already exists: ${appUser.userEmail}');

        await _syncRevenueCatUserId(userCredential.user!.uid);

        /// Update FCM token if it's different
        if (currentfcmToken != appUser.fcmToken && !isSimulator) {
          // Update fcmToken
          await _firestore.collection('users').doc(appUser.userId).update({
            'fcmToken': currentfcmToken,
            'updatedAt': DateTime.now(),
          });
          logger.i('Updated FCM token for user: ${appUser.userEmail}');

          if (appUser.subscribedShopTopics != null &&
              appUser.subscribedShopTopics!.isNotEmpty) {
            await Future.wait(
              appUser.subscribedShopTopics!.map((topic) async {
                await FirebaseMessaging.instance.subscribeToTopic(topic);
                logger.i('Subscribed to topic: $topic');
              }),
            );
          }
        }

        // // Get revenue cat customer info and update user purchase info
        // final customerInfo = await Purchases.getCustomerInfo();
        // if (customerInfo.entitlements.active.isNotEmpty) {
        //   final maxShops = RevenueCatHelper.getMaxShops(customerInfo);
        //   final maxCampaigns = RevenueCatHelper.getMaxCampaigns(customerInfo);
        //   final maxUserFollowing =
        //       RevenueCatHelper.getMaxUserFollowing(customerInfo);

        //   final updatedUser = appUser.copyWith(
        //     maximumShops: maxShops,
        //     maximumCampaigns: maxCampaigns,
        //     maximumUserFollowing: maxUserFollowing,
        //   );

        //   final virtualCurrencies = await Purchases.getVirtualCurrencies();
        //   final virtualCurrency = virtualCurrencies.all['P24COIN'];
        //   final balance = virtualCurrency?.balance;

        //   return updatedUser.copyWith(
        //     p24Coins: balance ?? 0,
        //   );
        // }

        // final virtualCurrencies = await Purchases.getVirtualCurrencies();
        // final virtualCurrency = virtualCurrencies.all['P24COIN'];
        // final balance = virtualCurrency?.balance;
        // return appUser.copyWith(
        //   p24Coins: balance ?? 0,
        // );

        return appUser;
      } else {
        // New User - Sign Up
        logger.i('New user signing up: ${userCredential.user!.email}');

        return _signUpUser(
          userId: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          userName: userCredential.user!.displayName ?? 'No Name',
          userAvatar: userCredential.user!.photoURL,
          userPhoneNumber: userCredential.user!.phoneNumber,
          fcmToken: currentfcmToken ?? '',
        );
      }
    } catch (e) {
      logger.e('Error during Google Sign-In: $e');
      rethrow;
    }
  }

  @override
  Future<AppUser> signInWithApple() async {
    try {
      // Generate a nonce for security
      final rawNonce = _generateNonce();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

      // Request Apple ID credential
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      // Create OAuth credential for Firebase
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with the credential
      final userCredential = await _firebaseAuth.signInWithCredential(
        oauthCredential,
      );

      if (userCredential.user == null) {
        throw Exception('Failed to sign in with Apple');
      }

      // Get App User from Firestore
      final appUser = await _getCurrentUserFromId(userCredential.user!.uid);

      // Get fcmToken from FCM service
      String? currentfcmToken;
      bool isSimulator = false;

      if (Platform.isIOS) {
        final result = await _getFCMTokenForIOS(userCredential.user!.uid);
        currentfcmToken = result.$1;
        isSimulator = result.$2;
      } else {
        // Get fcmToken from FCM service for non-iOS platforms
        currentfcmToken = await FirebaseMessaging.instance.getToken();
      }

      // Old user
      if (appUser != null) {
        logger.i(r'User already exists: ${appUser.userEmail}');

        await _syncRevenueCatUserId(userCredential.user!.uid);

        /// Update FCM token if it's different
        if (currentfcmToken != appUser.fcmToken && !isSimulator) {
          // Update fcmToken
          await _firestore.collection('users').doc(appUser.userId).update({
            'fcmToken': currentfcmToken,
            'updatedAt': DateTime.now(),
          });
          logger.i(r'Updated FCM token for user: ${appUser.userEmail}');

          if (appUser.subscribedShopTopics != null &&
              appUser.subscribedShopTopics!.isNotEmpty) {
            await Future.wait(
              appUser.subscribedShopTopics!.map((topic) async {
                await FirebaseMessaging.instance.subscribeToTopic(topic);
                logger.i('Subscribed to topic: $topic');
              }),
            );
          }
        }

        return appUser;
      } else {
        // New User - Sign Up
        logger.i(
          r'New user signing up with Apple: ${userCredential.user!.email}',
        );

        // Get display name from Apple credential if available
        String userName = 'No Name';
        if (appleCredential.givenName != null ||
            appleCredential.familyName != null) {
          userName =
              '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
                  .trim();
        } else if (userCredential.user!.displayName != null) {
          userName = userCredential.user!.displayName!;
        }

        return _signUpUser(
          userId: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          userName: userName,
          userAvatar: userCredential.user!.photoURL,
          userPhoneNumber: userCredential.user!.phoneNumber,
          fcmToken: currentfcmToken ?? '',
        );
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      logger.e('Apple Sign-In authorization error: ${e.code} - ${e.message}');

      // Handle specific error codes
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
          throw Exception('Apple Sign-In was canceled by the user');
        case AuthorizationErrorCode.failed:
          throw Exception('Apple Sign-In failed. Please try again.');
        case AuthorizationErrorCode.invalidResponse:
          throw Exception('Invalid response from Apple. Please try again.');
        case AuthorizationErrorCode.notHandled:
          throw Exception('Apple Sign-In request was not handled');
        case AuthorizationErrorCode.unknown:
          throw Exception(
            'An unknown error occurred during Apple Sign-In. Please try again.',
          );
        default:
          throw Exception('Apple Sign-In error: ${e.message}');
      }
    } on FirebaseAuthException catch (e) {
      logger.e(
        'Firebase Auth error during Apple Sign-In: ${e.code} - ${e.message}',
      );
      throw Exception('Authentication failed: ${e.message}');
    } catch (e) {
      logger.e('Unexpected error during Apple Sign-In: $e');
      rethrow;
    }
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

  @override
  Future<void> signOut() async {
    await Purchases.logOut();
    await _firebaseAuth.signOut();
  }

  @override
  Stream<AppUser?> onAuthChange() {
    return _firebaseAuth.authStateChanges().map((event) {
      if (event == null) {
        return null;
      } else {
        // Get userName from user collections
        _firestore.collection('users').doc(event.uid).get().then((value) {
          final userName = value.data()?['userName'] ?? '';

          return AppUser(
            userId: event.uid,
            userEmail: event.email ?? 'no email',
            userName: userName as String? ?? 'No Name',
            profilePic: value.data()?['userAvatar'] as String? ?? '',
            isVendor: value.data()?['isVendor'] as bool? ?? false,
            fcmToken: value.data()?['fcmToken'] as String? ?? '',
            referralCode:
                value.data()?['referralCode'] as String? ?? 'OLD USER',
            referredBy: value.data()?['referredBy'] as String?,
            deletionRequestedAt: const TimestampConverter().fromJson(
              value.data()?['deletionRequestedAt'],
            ),
          );
        });
      }
      return null;
    });
  }

  @override
  Future<void> setReferrerCode(String referralCode) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('No authenticated user found.');
    }

    final normalizedCode = referralCode.trim();
    if (normalizedCode.isEmpty) {
      throw Exception('Referral code cannot be empty.');
    }

    final referralDoc = await _firestore
        .collection('referralCodes')
        .doc(normalizedCode)
        .get();

    if (!referralDoc.exists || referralDoc.data() == null) {
      throw Exception('Invalid referral code.');
    }

    final referrerUserId = referralDoc.data()?['userId'] as String?;
    if (referrerUserId == null || referrerUserId.isEmpty) {
      throw Exception('Referral code is malformed.');
    }

    if (referrerUserId == currentUser.uid) {
      throw Exception('You cannot use your own referral code.');
    }

    final refereeUserDoc = await _firestore
        .collection('users')
        .doc(currentUser.uid)
        .get();
    if (!refereeUserDoc.exists) {
      throw Exception('Current user document not found.');
    }

    final existingReferrer = refereeUserDoc.data()?['referredBy'] as String?;
    if (existingReferrer != null && existingReferrer.isNotEmpty) {
      throw Exception('Referral code has already been set for this user.');
    }

    final batch = _firestore.batch();

    final refereeUserRef = _firestore.collection('users').doc(currentUser.uid);
    batch.update(refereeUserRef, {
      'referredBy': referrerUserId,
      'updatedAt': DateTime.now(),
    });

    final refereeRecordRef = _firestore
        .collection('users')
        .doc(referrerUserId)
        .collection('referees')
        .doc(currentUser.uid);
    batch.set(refereeRecordRef, {
      'refereeUserId': currentUser.uid,
      'referralCode': normalizedCode,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    });

    await batch.commit();
    logger.i(
      'Referral applied successfully. referee=${currentUser.uid}, referrer=$referrerUserId',
    );
  }

  // @override
  // Future<GuestUser> signInAnonymously() async {
  //   await _firebaseAuth.signInAnonymously();
  //   // final user = userCredential.user.;
  //   // return GuestUser(userId: userCredential.user!.uid);
  //   return GuestUser();
  // }

  // @override
  // Future<void> sendEmailVerification() async {
  //   final user = _firebaseAuth.currentUser;
  //   if (user == null) {
  //     throw Exception('No user is currently signed in.');
  //   }

  //   if (!user.emailVerified) {
  //     await user.sendEmailVerification();
  //   } else {
  //     throw Exception('Email is already verified.');
  //   }
  // }
}
