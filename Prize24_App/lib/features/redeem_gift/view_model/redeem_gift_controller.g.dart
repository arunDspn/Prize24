// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redeem_gift_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RedeemGiftController)
final redeemGiftControllerProvider = RedeemGiftControllerProvider._();

final class RedeemGiftControllerProvider
    extends $AsyncNotifierProvider<RedeemGiftController, void> {
  RedeemGiftControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'redeemGiftControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$redeemGiftControllerHash();

  @$internal
  @override
  RedeemGiftController create() => RedeemGiftController();
}

String _$redeemGiftControllerHash() =>
    r'a4c11c6d0761f30471d92771b4d2a7f80a1a4f3e';

abstract class _$RedeemGiftController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
