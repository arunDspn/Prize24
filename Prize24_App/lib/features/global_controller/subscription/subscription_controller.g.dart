// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SubscriptionController)
final subscriptionControllerProvider = SubscriptionControllerProvider._();

final class SubscriptionControllerProvider
    extends $AsyncNotifierProvider<SubscriptionController, SubscriptionState?> {
  SubscriptionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionControllerHash();

  @$internal
  @override
  SubscriptionController create() => SubscriptionController();
}

String _$subscriptionControllerHash() =>
    r'f6f41598a09b22198e3cb8ffde3e32e32a953909';

abstract class _$SubscriptionController
    extends $AsyncNotifier<SubscriptionState?> {
  FutureOr<SubscriptionState?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SubscriptionState?>, SubscriptionState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SubscriptionState?>, SubscriptionState?>,
              AsyncValue<SubscriptionState?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
