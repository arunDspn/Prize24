// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_coupons_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// This controller fetches all redeemed coupons for a user with cursor pagination.

@ProviderFor(GetAllCouponsController)
final getAllCouponsControllerProvider = GetAllCouponsControllerProvider._();

/// This controller fetches all redeemed coupons for a user with cursor pagination.
final class GetAllCouponsControllerProvider
    extends
        $AsyncNotifierProvider<
          GetAllCouponsController,
          GetAllCouponsPaginatedState
        > {
  /// This controller fetches all redeemed coupons for a user with cursor pagination.
  GetAllCouponsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllCouponsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllCouponsControllerHash();

  @$internal
  @override
  GetAllCouponsController create() => GetAllCouponsController();
}

String _$getAllCouponsControllerHash() =>
    r'0a8a9af356413e2cffd8399823b5f3b2c47bcd8d';

/// This controller fetches all redeemed coupons for a user with cursor pagination.

abstract class _$GetAllCouponsController
    extends $AsyncNotifier<GetAllCouponsPaginatedState> {
  FutureOr<GetAllCouponsPaginatedState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<GetAllCouponsPaginatedState>,
              GetAllCouponsPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<GetAllCouponsPaginatedState>,
                GetAllCouponsPaginatedState
              >,
              AsyncValue<GetAllCouponsPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
