// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_friends_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing vendor friends with real Firestore cursor pagination.

@ProviderFor(VendorFriendsController)
final vendorFriendsControllerProvider = VendorFriendsControllerProvider._();

/// Controller for managing vendor friends with real Firestore cursor pagination.
final class VendorFriendsControllerProvider
    extends
        $AsyncNotifierProvider<
          VendorFriendsController,
          VendorFriendsPaginatedState
        > {
  /// Controller for managing vendor friends with real Firestore cursor pagination.
  VendorFriendsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorFriendsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorFriendsControllerHash();

  @$internal
  @override
  VendorFriendsController create() => VendorFriendsController();
}

String _$vendorFriendsControllerHash() =>
    r'9bdbb70cb890fe3b0af28f91c2efc32face7e6d5';

/// Controller for managing vendor friends with real Firestore cursor pagination.

abstract class _$VendorFriendsController
    extends $AsyncNotifier<VendorFriendsPaginatedState> {
  FutureOr<VendorFriendsPaginatedState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<VendorFriendsPaginatedState>,
              VendorFriendsPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<VendorFriendsPaginatedState>,
                VendorFriendsPaginatedState
              >,
              AsyncValue<VendorFriendsPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
