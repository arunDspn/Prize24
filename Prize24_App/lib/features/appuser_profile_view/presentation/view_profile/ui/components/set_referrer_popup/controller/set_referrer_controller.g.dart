// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_referrer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SetReferrerController)
final setReferrerControllerProvider = SetReferrerControllerProvider._();

final class SetReferrerControllerProvider
    extends $AsyncNotifierProvider<SetReferrerController, String?> {
  SetReferrerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setReferrerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setReferrerControllerHash();

  @$internal
  @override
  SetReferrerController create() => SetReferrerController();
}

String _$setReferrerControllerHash() =>
    r'0441aeca72ff18713cdaed1d69f1b9f6d4d3335b';

abstract class _$SetReferrerController extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
