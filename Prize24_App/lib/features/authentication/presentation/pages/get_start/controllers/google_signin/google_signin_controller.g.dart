// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_signin_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoogleSigninController)
final googleSigninControllerProvider = GoogleSigninControllerProvider._();

final class GoogleSigninControllerProvider
    extends $AsyncNotifierProvider<GoogleSigninController, AppUser?> {
  GoogleSigninControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleSigninControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleSigninControllerHash();

  @$internal
  @override
  GoogleSigninController create() => GoogleSigninController();
}

String _$googleSigninControllerHash() =>
    r'06a821ad96f14ced101677078dc3f5aee4fc441d';

abstract class _$GoogleSigninController extends $AsyncNotifier<AppUser?> {
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
