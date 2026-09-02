import 'dart:async';

import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'set_referrer_controller.g.dart';

@riverpod
class SetReferrerController extends _$SetReferrerController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> setReferrer(String referralCode) async {
    final authRepository = ref.read(authRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await authRepository.setReferrerCode(referralCode);
      return referralCode;
    });
  }
}
