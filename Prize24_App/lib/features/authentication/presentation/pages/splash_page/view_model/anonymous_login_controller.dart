// import 'package:prize24_app/features/authentication/data/repository/auth_repository.dart';
// import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'anonymous_login_controller.g.dart';

// @riverpod
// class AnonymousLoginController extends _$AnonymousLoginController {
//   @override
//   FutureOr<AppUser?> build() async {
//     return null;
//   }

//   Future<AppUser?> loginAnonymously() async {
//     state = const AsyncLoading();

//     final user = await ref.read(authRepositoryProvider).signInAnonymously();
//     state = AsyncData(user);

//     return user;
//   }
// }
