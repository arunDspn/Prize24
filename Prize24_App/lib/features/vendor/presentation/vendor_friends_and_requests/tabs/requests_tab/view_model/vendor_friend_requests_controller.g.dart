// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_friend_requests_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing vendor friend requests with real Firestore cursor pagination.

@ProviderFor(VendorFriendRequestsController)
final vendorFriendRequestsControllerProvider =
    VendorFriendRequestsControllerProvider._();

/// Controller for managing vendor friend requests with real Firestore cursor pagination.
final class VendorFriendRequestsControllerProvider
    extends
        $AsyncNotifierProvider<
          VendorFriendRequestsController,
          VendorFriendRequestsPaginatedState
        > {
  /// Controller for managing vendor friend requests with real Firestore cursor pagination.
  VendorFriendRequestsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorFriendRequestsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorFriendRequestsControllerHash();

  @$internal
  @override
  VendorFriendRequestsController create() => VendorFriendRequestsController();
}

String _$vendorFriendRequestsControllerHash() =>
    r'a3a79b2649b554b31b52f432038d88ac6e750541';

/// Controller for managing vendor friend requests with real Firestore cursor pagination.

abstract class _$VendorFriendRequestsController
    extends $AsyncNotifier<VendorFriendRequestsPaginatedState> {
  FutureOr<VendorFriendRequestsPaginatedState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<VendorFriendRequestsPaginatedState>,
              VendorFriendRequestsPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<VendorFriendRequestsPaginatedState>,
                VendorFriendRequestsPaginatedState
              >,
              AsyncValue<VendorFriendRequestsPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
