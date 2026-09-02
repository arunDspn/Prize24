// import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
// import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'email_signin_controller.g.dart';

// @riverpod
// class EmailSigninController extends _$EmailSigninController {
//   @override
//   FutureOr<AppUser?> build() {
//     return null;
//   }

//   Future<void> emailSignIn({
//     required String email,
//     required String password,
//   }) async {
//     state = const AsyncLoading();

//     state = await AsyncValue.guard(
//       () async {
//         return ref.read(authRepositoryProvider).signInWithEmailAndPassword(
//               email,
//               password,
//             );
//       },
//     );
//   }
// }
