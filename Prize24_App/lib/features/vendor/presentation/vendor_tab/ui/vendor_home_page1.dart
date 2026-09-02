import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/global_controller/subscription/subscription_controller.dart';
import 'package:prize24_app/features/vendor/presentation/become_a_vendor_paywall/view_model/register_user_as_vendor_controller.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import 'package:prize24_app/configs/assets.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/presentation/become_a_vendor_modal/view_model/become_a_vendor_controller.dart';
import 'package:prize24_app/features/vendor/presentation/partial_registeration_view/partial_registeration_view.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/vendor_home_content_view.dart';
import 'package:prize24_app/routing/app_routes.dart';

part 'components/authenicate_user_view.dart';
part 'components/pre_vendor_welcome_view.dart';

// part 'components/anonymous_user_view.dart';

/// This page is the entry point for vendors to manage their shops, coupons, and audience.
/// It also handles registration process for vendors.

class VendorHomePage extends ConsumerWidget {
  const VendorHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Remove this commented code if not needed
    // ref
    //   // Will handle when dynamic login
    //   ..listen(
    //     authControllerProvider,
    //     (previous, next) {
    //       next.whenOrNull(
    //         data: (data) {
    //           if (data == null) {
    //             return;
    //           }
    //           if (data.isVendor) {
    //             // ref
    //             //     .read(usersVendorDetailsControllerProvider.notifier)
    //             //     .getDetailsByUserId(
    //             //       userId: data.userId,
    //             //     );
    //           }
    //         },
    //       );
    //       previous?.whenOrNull(
    //         data: (data) {
    //           if (data == null) {
    //             return;
    //           }
    //           if (data.isVendor) {
    //             // ref
    //             //     .read(usersVendorDetailsControllerProvider.notifier)
    //             //     .getDetailsByUserId(
    //             //       userId: data.userId,
    //             //     );
    //           }
    //         },
    //       );
    //     },
    //   )

    // Will handle when vendor becomes a vendor
    ref.listen(
      becomeAVendorControllerProvider,
      (previous, next) {
        previous?.whenOrNull(
          data: (data) {
            logger.d('Previous Become a Vendor Data:');
          },
        );
        next.whenOrNull(
          error: (error, stackTrace) {
            logger.e('Become a Vendor Error: $error');
            showToastAtTop(
              context,
              'Something went wrong, Failed to register as a vendor',
              false,
            );
          },
          data: (_) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('Successfully registered as a vendor!'),
            //   ),
            // );
            showToastAtTop(
              context,
              'Successfully registered as a vendor!',
              true,
            );

            // Sync Update Authenticated User
            final user = ref.read(authControllerProvider).requireValue!;
            ref.read(authControllerProvider.notifier).updateAuthUser(
                  user: user.copyWith(
                    isVendor: true,
                  ),
                );
          },
        );
      },
    );

    final user = ref.watch(authControllerProvider).requireValue;

    return Scaffold(
      body: SafeArea(
        // Todo: Check if user is vendor or not
        child: user != null
            ? _BecomeVendorBody(
                user,
              )
            : Container(),
      ),
    );
  }
}

Widget buildLogo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        AppAssets.p24LogoIcon,
        height: 50,
      ),
      const Text(
        'Price24',
        style: TextStyle(
          // color:
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Gilroy',
        ),
      ),
    ],
  );
}

Widget buildText(
  String text, {
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.white,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'Gilroy',
    ),
  );
}

Widget buildImage(
  String assetPath, {
  double height = 100,
  EdgeInsets padding = EdgeInsets.zero,
}) {
  return Padding(
    padding: padding,
    child: Image.asset(
      assetPath,
      height: height,
    ),
  );
}

Widget buildButton({required String text, required VoidCallback onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        fixedSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Gilroy',
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.trending_flat),
        ],
      ),
    ),
  );
}
