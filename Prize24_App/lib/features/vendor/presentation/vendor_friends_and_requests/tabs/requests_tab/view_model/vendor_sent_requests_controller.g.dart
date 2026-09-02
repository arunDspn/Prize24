// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_sent_requests_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing vendor sent friend requests with real Firestore cursor pagination.

@ProviderFor(VendorSentRequestsController)
final vendorSentRequestsControllerProvider =
    VendorSentRequestsControllerProvider._();

/// Controller for managing vendor sent friend requests with real Firestore cursor pagination.
final class VendorSentRequestsControllerProvider
    extends
        $AsyncNotifierProvider<
          VendorSentRequestsController,
          VendorSentRequestsPaginatedState
        > {
  /// Controller for managing vendor sent friend requests with real Firestore cursor pagination.
  VendorSentRequestsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorSentRequestsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorSentRequestsControllerHash();

  @$internal
  @override
  VendorSentRequestsController create() => VendorSentRequestsController();
}

String _$vendorSentRequestsControllerHash() =>
    r'25e5ac0fa0763cb003af90c777bac8ade8e0c776';

/// Controller for managing vendor sent friend requests with real Firestore cursor pagination.

abstract class _$VendorSentRequestsController
    extends $AsyncNotifier<VendorSentRequestsPaginatedState> {
  FutureOr<VendorSentRequestsPaginatedState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<VendorSentRequestsPaginatedState>,
              VendorSentRequestsPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<VendorSentRequestsPaginatedState>,
                VendorSentRequestsPaginatedState
              >,
              AsyncValue<VendorSentRequestsPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
