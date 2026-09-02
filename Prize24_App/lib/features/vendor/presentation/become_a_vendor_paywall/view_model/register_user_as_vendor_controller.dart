import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/data/repository/vendor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_user_as_vendor_controller.g.dart';

@Riverpod(keepAlive: true)
class RegisterUserAsVendorController extends _$RegisterUserAsVendorController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  /// Register the user as a vendor
  Future<void> registerAsVendor() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        final userId = ref.read(authControllerProvider).requireValue?.userId;
        if (userId == null) {
          throw Exception('User not authenticated');
        }
        await ref
            .read(vendorRepositoryProvider)
            .registerAsVendor(userId: userId);

        return userId;
      },
    );
  }
}
