// part of '../vendor_home_page1.dart';

// /// Vendor Home Page for Anonymous Users
// class _AnonyUserView extends StatelessWidget {
//   const _AnonyUserView();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         buildLogo(),
//         const SizedBox(height: 20),
//         buildText(
//           'Become a Vendor & \n Elevate Your Business!',
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//         const SizedBox(height: 20),
//         buildText(
//           'Create coupons, run draws, and\n manage your audience with ease!',
//           fontSize: 16,
//           color: Colors.grey,
//         ),
//         const SizedBox(height: 10),
//         buildImage(
//           Assets.vendor,
//           height: 250,
//           padding: const EdgeInsets.only(left: 30, top: 30),
//         ),
//         const SizedBox(height: 50),
//         buildText(
//           'You need to sign in or sign up to become a vendor.',
//           fontSize: 16,
//           color: Colors.grey,
//         ),
//         const SizedBox(height: 20),
//         buildButton(
//           text: 'Sign In or Sign Up',
//           onPressed: () {
//             showModalBottomSheet<void>(
//               useRootNavigator: true,
//               showDragHandle: true,
//               isScrollControlled: true,
//               context: context,
//               barrierColor: Colors.black38,
//               builder: (context) {
//                 return const IntrinsicHeight(
//                   child: PopAuthShellPage(),
//                 );
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
