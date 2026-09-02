import 'package:prize24_app/features/vendor/domain/use_cases/become_a_vendor_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'become_a_vendor_controller.g.dart';

@riverpod
class BecomeAVendorController extends _$BecomeAVendorController {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> register({
    required String userId,
    required String phoneNumber,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        await ref.read(becomeAVendorUsecaseProvider).call(
              userId: userId,
              phoneNumber: phoneNumber,
            );
      },
    );
  }
}
