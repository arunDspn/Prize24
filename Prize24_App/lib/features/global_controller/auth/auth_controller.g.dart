// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Purpose
/// -  Gate keeper for authentication state when the app starts.
/// -  Provides methods to check authentication, update user state, and sign out.
/// -  Keeps the authentication state alive across the app lifecycle.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// Purpose
/// -  Gate keeper for authentication state when the app starts.
/// -  Provides methods to check authentication, update user state, and sign out.
/// -  Keeps the authentication state alive across the app lifecycle.
final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, AppUser?> {
  /// Purpose
  /// -  Gate keeper for authentication state when the app starts.
  /// -  Provides methods to check authentication, update user state, and sign out.
  /// -  Keeps the authentication state alive across the app lifecycle.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'1641251ac867b76bb385647bb42e01dafccfa320';

/// Purpose
/// -  Gate keeper for authentication state when the app starts.
/// -  Provides methods to check authentication, update user state, and sign out.
/// -  Keeps the authentication state alive across the app lifecycle.

abstract class _$AuthController extends $AsyncNotifier<AppUser?> {
  FutureOr<AppUser?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppUser?>, AppUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppUser?>, AppUser?>,
              AsyncValue<AppUser?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
