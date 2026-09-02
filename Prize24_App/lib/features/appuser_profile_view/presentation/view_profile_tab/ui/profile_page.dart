// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:prize24_app/core/ui/buttons.dart';
// import 'package:prize24_app/features/app_settings/presentation/profile_settings_page/darkmode_page.dart';
// import 'package:prize24_app/features/app_settings/presentation/profile_settings_page/languages_page.dart';
// import 'package:prize24_app/features/app_settings/presentation/profile_settings_page/notifications_page.dart';
// import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
// import 'package:prize24_app/features/authentication/presentation/pages/pop_auth/pop_auth_shell_page.dart';
// import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
// import 'package:prize24_app/routing/app_routes.dart';

// class ProfilePage extends ConsumerWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.listen(authControllerProvider, (previous, next) {
//       next.whenOrNull(
//         data: (data) {
//           if (data == null) {
//             context.go(AppRoutes.getStarted);
//           }
//         },
//       );
//     });
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const UserDetailsSection(),
//             const SizedBox(height: 30),
//             _buildSettingsHeader(),
//             const SizedBox(height: 5),
//             _buildSettingsOption(
//               context,
//               Icons.dark_mode,
//               'Dark Mode',
//               'Change theme',
//               const DarkModePage(),
//             ),
//             _buildSettingsOption(
//               context,
//               Icons.notifications_active,
//               'Notifications',
//               'Manage your notifications',
//               const NotificationsPage(),
//             ),
//             _buildSettingsOption(
//               context,
//               Icons.language,
//               'Languages',
//               'Change language',
//               const LanguagesPage(),
//             ),
//             const Spacer(),

//             // Sign Out
//             SizedBox(
//               width: double.infinity,
//               child: Primary1Button(
//                 text: 'Sign Out',
//                 onPressed: () {
//                   ref.read(authControllerProvider.notifier).signOut();
//                 },
//               ),
//             ),

//             // 20
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSettingsHeader() {
//     return Container(
//       alignment: Alignment.topLeft,
//       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//       child: const Text(
//         'Settings',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//           fontFamily: 'Gilroy',
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget _buildSettingsOption(
//     BuildContext context,
//     IconData icon,
//     String title,
//     String subtitle,
//     Widget page,
//   ) {
//     return SettingsOption(
//       icon: icon,
//       title: title,
//       subtitle: subtitle,
//       onTap: () => navigateToPage(context, page),
//     );
//   }

//   void navigateToPage(BuildContext context, Widget page) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => page),
//     );
//   }
// }

// class SettingsOption extends StatelessWidget {
//   const SettingsOption({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//     super.key,
//   });
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: ListTile(
//         leading: Container(
//           width: 35,
//           height: 35,
//           decoration: BoxDecoration(
//             color: Colors.white10,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: Colors.white),
//           ),
//           alignment: Alignment.center,
//           child: Icon(icon, color: Colors.white, size: 18),
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         subtitle: Text(
//           subtitle,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         trailing:
//             const Icon(Icons.trending_flat, color: Colors.white, size: 30),
//         onTap: onTap,
//       ),
//     );
//   }
// }

// class UserDetailsSection extends ConsumerWidget {
//   const UserDetailsSection({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appUser = ref.watch(authControllerProvider);

//     return appUser.maybeWhen(
//       orElse: () {
//         return const SizedBox();
//       },
//       data: (data) {
//         // if (data is GuestUser) {
//         //   return const _GuestUserSection();
//         // }
//         if (data is AppUser) {
//           return _AuthUserSection(data);
//         } else {
//           return const SizedBox();
//         }
//       },
//     );
//   }
// }

// Widget buildProfileAvatar({
//   required String imageUrl,
//   required bool isAnony,
//   VoidCallback? onProfileEdit,
// }) {
//   return Stack(
//     alignment: Alignment.bottomRight,
//     children: [
//       Container(
//         padding: const EdgeInsets.all(25),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.white, width: 4),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(1),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: Colors.white, width: 2),
//           ),
//           child: const CircleAvatar(
//             radius: 50,
//             backgroundColor: Colors.pinkAccent,
//             child: Text(
//               'A',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 35,
//                 fontFamily: 'Gilroy',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ),
//       if (isAnony)
//         const SizedBox()
//       else
//         IconButton(
//           icon: const CircleAvatar(
//             radius: 25,
//             backgroundColor: Colors.black,
//             child: Icon(Icons.border_color, color: Colors.white, size: 20),
//           ),
//           onPressed: onProfileEdit,
//         ),
//     ],
//   );
// }

// Widget buildProfileInfo(String text, double fontSize) {
//   return Text(
//     text,
//     style: TextStyle(
//       color: Colors.white,
//       fontSize: fontSize,
//       fontFamily: 'Gilroy',
//       fontWeight: FontWeight.w500,
//     ),
//   );
// }

// Widget buildSignInButton(BuildContext context) {
//   return ElevatedButton(
//     onPressed: () {
//       showModalBottomSheet<void>(
//         useRootNavigator: true,
//         showDragHandle: true,
//         isScrollControlled: true,
//         context: context,
//         barrierColor: Colors.black38,
//         builder: (context) {
//           return const IntrinsicHeight(child: PopAuthShellPage());
//         },
//       );
//     },
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.white10,
//       foregroundColor: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//     ),
//     child: const Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           'Sign in / Sign up',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(width: 10),
//         Icon(Icons.trending_flat, color: Colors.white),
//       ],
//     ),
//   );
// }

// class _AuthUserSection extends StatelessWidget {
//   const _AuthUserSection(this.user);

//   final AppUser user;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 50),
//         buildProfileAvatar(
//           imageUrl: '',
//           isAnony: false,
//           onProfileEdit: () {
//             context.push(
//               AppRoutes.editProfile,
//               extra: user,
//             );
//           },
//         ),
//         const SizedBox(height: 10),
//         buildProfileInfo(user.userName, 16),
//         const SizedBox(height: 5),
//         buildProfileInfo('+91 12213443', 16),
//         const SizedBox(height: 5),
//         buildProfileInfo('Joined in March 2025', 14),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }

// class _GuestUserSection extends StatelessWidget {
//   const _GuestUserSection();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 50),
//         buildProfileAvatar(
//           imageUrl: '',
//           isAnony: true,
//         ),
//         const SizedBox(height: 10),
//         buildProfileInfo('Anonymous User', 16),
//         // const SizedBox(height: 5),
//         // buildProfileInfo('+91 12213443', 16),
//         // const SizedBox(height: 5),
//         // buildProfileInfo('Joined in March 2025', 14),
//         // const SizedBox(height: 20),
//         buildSignInButton(
//           context,
//         ),
//       ],
//     );
//   }
// }
