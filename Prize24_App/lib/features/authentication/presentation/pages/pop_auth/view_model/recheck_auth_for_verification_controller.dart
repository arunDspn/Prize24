// import 'package:prize24_app/app/view/app.dart';
// import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
// import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'recheck_auth_for_verification_controller.g.dart';

// @riverpod
// class RecheckAuthForVerificationController
//     extends _$RecheckAuthForVerificationController {
//   @override
//   FutureOr<AppUser?> build() async {
//     return null;
//   }

//   Future<void> recheckAuthForVerification() async {
//     state = const AsyncLoading();

//     state = await AsyncValue.guard(
//       () async {
//         final authRepository = ref.read(authRepositoryProvider);
//         final user = await authRepository.checkAuth();
//         if (user is AppUser) {
//           return user;
//         } else {
//           throw Exception('User is not authenticated');
//         }
//       },
//     );
//   }
// }
