// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_club_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShopClubController)
final shopClubControllerProvider = ShopClubControllerFamily._();

final class ShopClubControllerProvider
    extends $AsyncNotifierProvider<ShopClubController, StaffClubDetailModel?> {
  ShopClubControllerProvider._({
    required ShopClubControllerFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'shopClubControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shopClubControllerHash();

  @override
  String toString() {
    return r'shopClubControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ShopClubController create() => ShopClubController();

  @override
  bool operator ==(Object other) {
    return other is ShopClubControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shopClubControllerHash() =>
    r'e5b518300afa542195b59481ebf9d24d46abf79d';

final class ShopClubControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ShopClubController,
          AsyncValue<StaffClubDetailModel?>,
          StaffClubDetailModel?,
          FutureOr<StaffClubDetailModel?>,
          String?
        > {
  ShopClubControllerFamily._()
    : super(
        retry: null,
        name: r'shopClubControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ShopClubControllerProvider call({required String? clubId}) =>
      ShopClubControllerProvider._(argument: clubId, from: this);

  @override
  String toString() => r'shopClubControllerProvider';
}

abstract class _$ShopClubController
    extends $AsyncNotifier<StaffClubDetailModel?> {
  late final _$args = ref.$arg as String?;
  String? get clubId => _$args;

  FutureOr<StaffClubDetailModel?> build({required String? clubId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<StaffClubDetailModel?>, StaffClubDetailModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<StaffClubDetailModel?>,
                StaffClubDetailModel?
              >,
              AsyncValue<StaffClubDetailModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(clubId: _$args));
  }
}
