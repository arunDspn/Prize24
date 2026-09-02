part of '../vendor_home_page1.dart';

/// Vendor Home Page for Authenticated Users
/// If User is not a vendor, show Become a Vendor CTA
/// If User is a vendor, show Vendor Home Content View
class _BecomeVendorBody extends ConsumerWidget {
  const _BecomeVendorBody(this.user);

  final AppUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final vendorStatus = ref.watch(checkForVendorStatusControllerProvider);

    // return vendorStatus.when(
    //   data: (isVendor) {
    //     if (!isVendor) {
    //       // Navigate to Become a Vendor Paywall
    //       WidgetsBinding.instance.addPostFrameCallback((_) {
    //         context.go(AppRoutes.becomeAVendorPaywall);
    //       });
    //       return const SizedBox.shrink();
    //     } else {
    //       return const VendorHomeContentView(
    //         vendorId: '',
    //       );
    //     }
    //   },
    //   loading: () => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    //   error: (error, stackTrace) => Center(
    //     child: Text('Error: $error'),
    //   ),
    // );
    // // Check this user has RevenueCat entitlement for vendor features
    return !user.isVendor
        ? const PreVendorWelcomeView()
        : user.vendorPhoneNumber != null
            ? const VendorHomeContentView(
                vendorId: '',
              )
            : const PartialRegisterationView();
  }
}
