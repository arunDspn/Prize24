import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/utils/sentry_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'apple_signin_controller.g.dart';

@riverpod
class AppleSigninController extends _$AppleSigninController {
  @override
  FutureOr<AppUser?> build() async {
    return null;
  }

  // Apple Sign-In
  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      try {
        final authRepository = ref.read(authRepositoryProvider);
        final user = await authRepository.signInWithApple();
        if (user != null) {
          // Update the global auth state
          ref.read(authControllerProvider.notifier).updateAuthUser(user: user);

          // Analytics
          final analytics = ref.read(analyticsServiceProvider);
          await analytics.logLogin('apple');
          await analytics.setUserIdentifier(user.userId);
          await analytics.setUserTrait('is_vendor', user.isVendor.toString());
        }
        return user;
      } catch (e) {
        final errorMessage = e.toString();
        if (!errorMessage.contains('Cancelled by user')) {
          await SentryHelper.captureException(e);
        }
        rethrow;
      }
    });
  }
}
