// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_followers_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShopFollowersController)
final shopFollowersControllerProvider = ShopFollowersControllerFamily._();

final class ShopFollowersControllerProvider
    extends
        $AsyncNotifierProvider<
          ShopFollowersController,
          ShopFollowersPaginatedState
        > {
  ShopFollowersControllerProvider._({
    required ShopFollowersControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'shopFollowersControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shopFollowersControllerHash();

  @override
  String toString() {
    return r'shopFollowersControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ShopFollowersController create() => ShopFollowersController();

  @override
  bool operator ==(Object other) {
    return other is ShopFollowersControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shopFollowersControllerHash() =>
    r'cefe84777818097362d99c1ccb89593b18c72e9c';

final class ShopFollowersControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ShopFollowersController,
          AsyncValue<ShopFollowersPaginatedState>,
          ShopFollowersPaginatedState,
          FutureOr<ShopFollowersPaginatedState>,
          String
        > {
  ShopFollowersControllerFamily._()
    : super(
        retry: null,
        name: r'shopFollowersControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ShopFollowersControllerProvider call({required String shopId}) =>
      ShopFollowersControllerProvider._(argument: shopId, from: this);

  @override
  String toString() => r'shopFollowersControllerProvider';
}

abstract class _$ShopFollowersController
    extends $AsyncNotifier<ShopFollowersPaginatedState> {
  late final _$args = ref.$arg as String;
  String get shopId => _$args;

  FutureOr<ShopFollowersPaginatedState> build({required String shopId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ShopFollowersPaginatedState>,
              ShopFollowersPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ShopFollowersPaginatedState>,
                ShopFollowersPaginatedState
              >,
              AsyncValue<ShopFollowersPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(shopId: _$args));
  }
}
