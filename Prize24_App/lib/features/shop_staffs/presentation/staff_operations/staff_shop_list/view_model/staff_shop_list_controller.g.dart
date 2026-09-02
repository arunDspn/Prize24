// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_shop_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StaffShopListController)
final staffShopListControllerProvider = StaffShopListControllerFamily._();

final class StaffShopListControllerProvider
    extends
        $AsyncNotifierProvider<
          StaffShopListController,
          StaffShopListPaginatedState
        > {
  StaffShopListControllerProvider._({
    required StaffShopListControllerFamily super.from,
    required List<String> super.argument,
  }) : super(
         retry: null,
         name: r'staffShopListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$staffShopListControllerHash();

  @override
  String toString() {
    return r'staffShopListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StaffShopListController create() => StaffShopListController();

  @override
  bool operator ==(Object other) {
    return other is StaffShopListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$staffShopListControllerHash() =>
    r'e26e045350039fdbc061757b7920f840ca205950';

final class StaffShopListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          StaffShopListController,
          AsyncValue<StaffShopListPaginatedState>,
          StaffShopListPaginatedState,
          FutureOr<StaffShopListPaginatedState>,
          List<String>
        > {
  StaffShopListControllerFamily._()
    : super(
        retry: null,
        name: r'staffShopListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StaffShopListControllerProvider call({required List<String> shopIds}) =>
      StaffShopListControllerProvider._(argument: shopIds, from: this);

  @override
  String toString() => r'staffShopListControllerProvider';
}

abstract class _$StaffShopListController
    extends $AsyncNotifier<StaffShopListPaginatedState> {
  late final _$args = ref.$arg as List<String>;
  List<String> get shopIds => _$args;

  FutureOr<StaffShopListPaginatedState> build({required List<String> shopIds});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<StaffShopListPaginatedState>,
              StaffShopListPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<StaffShopListPaginatedState>,
                StaffShopListPaginatedState
              >,
              AsyncValue<StaffShopListPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(shopIds: _$args));
  }
}
