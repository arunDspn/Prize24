// import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
// import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'register_account_controller.g.dart';

// @riverpod
// class RegisterAccountController extends _$RegisterAccountController {
//   @override
//   FutureOr<AuthenticatedUser?> build() {
//     return null;
//   }

//   Future<void> registerAccount({
//     required String email,
//     required String password,
//     required String userName,
//   }) async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(
//       () async {
//         return ref.read(authRepositoryProvider).signUpWithEmailAndPassword(
//               email: email,
//               password: password,
//               userName: userName,
//             );
//       },
//     );
//   }
// }
