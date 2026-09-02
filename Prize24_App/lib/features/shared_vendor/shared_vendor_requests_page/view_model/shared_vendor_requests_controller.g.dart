// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_vendor_requests_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SharedVendorRequestsController)
final sharedVendorRequestsControllerProvider =
    SharedVendorRequestsControllerProvider._();

final class SharedVendorRequestsControllerProvider
    extends
        $AsyncNotifierProvider<
          SharedVendorRequestsController,
          SharedVendorRequestsPaginatedState
        > {
  SharedVendorRequestsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedVendorRequestsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedVendorRequestsControllerHash();

  @$internal
  @override
  SharedVendorRequestsController create() => SharedVendorRequestsController();
}

String _$sharedVendorRequestsControllerHash() =>
    r'e80d3257ef31a75b774378b749ccb32b089783d9';

abstract class _$SharedVendorRequestsController
    extends $AsyncNotifier<SharedVendorRequestsPaginatedState> {
  FutureOr<SharedVendorRequestsPaginatedState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<SharedVendorRequestsPaginatedState>,
              SharedVendorRequestsPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<SharedVendorRequestsPaginatedState>,
                SharedVendorRequestsPaginatedState
              >,
              AsyncValue<SharedVendorRequestsPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
