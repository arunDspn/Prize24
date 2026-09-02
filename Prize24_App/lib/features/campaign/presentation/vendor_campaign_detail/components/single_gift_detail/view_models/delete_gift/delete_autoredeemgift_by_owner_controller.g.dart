// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_autoredeemgift_by_owner_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeleteAutoredeemgiftByOwnerController)
final deleteAutoredeemgiftByOwnerControllerProvider =
    DeleteAutoredeemgiftByOwnerControllerProvider._();

final class DeleteAutoredeemgiftByOwnerControllerProvider
    extends
        $AsyncNotifierProvider<DeleteAutoredeemgiftByOwnerController, String?> {
  DeleteAutoredeemgiftByOwnerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteAutoredeemgiftByOwnerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$deleteAutoredeemgiftByOwnerControllerHash();

  @$internal
  @override
  DeleteAutoredeemgiftByOwnerController create() =>
      DeleteAutoredeemgiftByOwnerController();
}

String _$deleteAutoredeemgiftByOwnerControllerHash() =>
    r'7e6c193d8f57cfff0abb1fbb3dcd74cf2f835e6a';

abstract class _$DeleteAutoredeemgiftByOwnerController
    extends $AsyncNotifier<String?> {
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
