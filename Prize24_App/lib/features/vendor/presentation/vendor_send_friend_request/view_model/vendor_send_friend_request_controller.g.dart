// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_send_friend_request_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for sending friend requests to vendors
/// This controller handles the business logic of sending friend requests
/// UI state (loading, scanning mode) is managed in the widget itself

@ProviderFor(VendorSendFriendRequestController)
final vendorSendFriendRequestControllerProvider =
    VendorSendFriendRequestControllerProvider._();

/// Controller for sending friend requests to vendors
/// This controller handles the business logic of sending friend requests
/// UI state (loading, scanning mode) is managed in the widget itself
final class VendorSendFriendRequestControllerProvider
    extends
        $AsyncNotifierProvider<
          VendorSendFriendRequestController,
          VendorFriendModel?
        > {
  /// Controller for sending friend requests to vendors
  /// This controller handles the business logic of sending friend requests
  /// UI state (loading, scanning mode) is managed in the widget itself
  VendorSendFriendRequestControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorSendFriendRequestControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$vendorSendFriendRequestControllerHash();

  @$internal
  @override
  VendorSendFriendRequestController create() =>
      VendorSendFriendRequestController();
}

String _$vendorSendFriendRequestControllerHash() =>
    r'5d65a0bc32042528f911b2b74855b720b342521d';

/// Controller for sending friend requests to vendors
/// This controller handles the business logic of sending friend requests
/// UI state (loading, scanning mode) is managed in the widget itself

abstract class _$VendorSendFriendRequestController
    extends $AsyncNotifier<VendorFriendModel?> {
  FutureOr<VendorFriendModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<VendorFriendModel?>, VendorFriendModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VendorFriendModel?>, VendorFriendModel?>,
              AsyncValue<VendorFriendModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
