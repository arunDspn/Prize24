import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/data/repository/vendor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vendor_phone_number_registeration_controller.g.dart';

@riverpod
class VendorPhoneNumberRegisterationController
    extends _$VendorPhoneNumberRegisterationController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  /// Register vendor phone number
  Future<void> registerVendorPhoneNumber({
    required String phoneNumber,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userId = ref.read(authControllerProvider).requireValue!.userId;
      await ref.read(vendorRepositoryProvider).registerVendorPhoneNumber(
            userId: userId,
            vendorPhoneNumber: phoneNumber,
          );
      return phoneNumber;
    });
  }
}
