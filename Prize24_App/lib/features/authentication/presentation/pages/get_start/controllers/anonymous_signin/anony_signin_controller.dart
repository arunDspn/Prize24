// import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
// import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'anony_signin_controller.g.dart';

// @riverpod
// class AnonySigninController extends _$AnonySigninController {
//   @override
//   FutureOr<GuestUser?> build() {
//     return null;
//   }

//   Future<void> anonymousSignIn() async {
//     state = const AsyncLoading();

//     state = await AsyncValue.guard(
//       () {
//         return ref.read(authRepositoryProvider).signInAnonymously();
//       },
//     );
//   }
// }
