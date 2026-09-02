import 'package:prize24_app/core/services/analytics/analytics_service.dart';
import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/utils/sentry_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'google_signin_controller.g.dart';

@riverpod
class GoogleSigninController extends _$GoogleSigninController {
  @override
  FutureOr<AppUser?> build() {
    return null;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      try {
        final authRepository = ref.read(authRepositoryProvider);
        final user = await authRepository.signInWithGoogle();
        if (user != null) {
          // Update the global auth state
          ref.read(authControllerProvider.notifier).updateAuthUser(user: user);

          // Analytics
          final analytics = ref.read(analyticsServiceProvider);
          await analytics.logLogin('google');
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
