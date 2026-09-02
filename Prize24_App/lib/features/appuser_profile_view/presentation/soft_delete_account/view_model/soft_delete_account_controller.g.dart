// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soft_delete_account_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SoftDeleteAccountController)
final softDeleteAccountControllerProvider =
    SoftDeleteAccountControllerProvider._();

final class SoftDeleteAccountControllerProvider
    extends $AsyncNotifierProvider<SoftDeleteAccountController, String?> {
  SoftDeleteAccountControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'softDeleteAccountControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$softDeleteAccountControllerHash();

  @$internal
  @override
  SoftDeleteAccountController create() => SoftDeleteAccountController();
}

String _$softDeleteAccountControllerHash() =>
    r'c835c744dbc477dfc394986afbd87a33a84054b5';

abstract class _$SoftDeleteAccountController extends $AsyncNotifier<String?> {
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
