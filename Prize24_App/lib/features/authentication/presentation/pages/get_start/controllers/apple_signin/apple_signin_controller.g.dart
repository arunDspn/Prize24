// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_signin_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppleSigninController)
final appleSigninControllerProvider = AppleSigninControllerProvider._();

final class AppleSigninControllerProvider
    extends $AsyncNotifierProvider<AppleSigninController, AppUser?> {
  AppleSigninControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appleSigninControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appleSigninControllerHash();

  @$internal
  @override
  AppleSigninController create() => AppleSigninController();
}

String _$appleSigninControllerHash() =>
    r'337365187cf63089dfa00cd5f40ea9d9b369aa67';

abstract class _$AppleSigninController extends $AsyncNotifier<AppUser?> {
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
