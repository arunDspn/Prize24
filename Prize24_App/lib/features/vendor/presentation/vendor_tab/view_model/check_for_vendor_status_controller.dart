import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'check_for_vendor_status_controller.g.dart';

@riverpod
class CheckForVendorStatusController extends _$CheckForVendorStatusController {
  @override
  FutureOr<bool> build() async {
    final user = ref.watch(authControllerProvider).requireValue;

    // Return false if user is null
    if (user == null) {
      return false;
    }

    final customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.active.isEmpty && !user.isVendor) {
      return false;
    } else if (customerInfo.entitlements.active.isNotEmpty && !user.isVendor) {
      // Update user status to vendor in your app's user management system
      throw UnimplementedError(
          'Update user status to vendor logic not implemented');
    } else if (customerInfo.entitlements.active.isEmpty && user.isVendor) {
      // Handle case where user is marked as vendor but has no active entitlements
      throw UnimplementedError(
          'Handle inconsistent vendor status logic not implemented');
    } else {
      return true;
    }
  }
}
