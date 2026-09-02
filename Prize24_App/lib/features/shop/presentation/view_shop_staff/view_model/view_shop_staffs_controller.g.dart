// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_shop_staffs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ViewShopStaffsController)
final viewShopStaffsControllerProvider = ViewShopStaffsControllerFamily._();

final class ViewShopStaffsControllerProvider
    extends
        $AsyncNotifierProvider<
          ViewShopStaffsController,
          ViewShopStaffsPaginatedState
        > {
  ViewShopStaffsControllerProvider._({
    required ViewShopStaffsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'viewShopStaffsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$viewShopStaffsControllerHash();

  @override
  String toString() {
    return r'viewShopStaffsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ViewShopStaffsController create() => ViewShopStaffsController();

  @override
  bool operator ==(Object other) {
    return other is ViewShopStaffsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$viewShopStaffsControllerHash() =>
    r'9ff938477472d0cfa814a3ac977647e9a39078fd';

final class ViewShopStaffsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ViewShopStaffsController,
          AsyncValue<ViewShopStaffsPaginatedState>,
          ViewShopStaffsPaginatedState,
          FutureOr<ViewShopStaffsPaginatedState>,
          String
        > {
  ViewShopStaffsControllerFamily._()
    : super(
        retry: null,
        name: r'viewShopStaffsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ViewShopStaffsControllerProvider call({required String shopId}) =>
      ViewShopStaffsControllerProvider._(argument: shopId, from: this);

  @override
  String toString() => r'viewShopStaffsControllerProvider';
}

abstract class _$ViewShopStaffsController
    extends $AsyncNotifier<ViewShopStaffsPaginatedState> {
  late final _$args = ref.$arg as String;
  String get shopId => _$args;

  FutureOr<ViewShopStaffsPaginatedState> build({required String shopId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ViewShopStaffsPaginatedState>,
              ViewShopStaffsPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ViewShopStaffsPaginatedState>,
                ViewShopStaffsPaginatedState
              >,
              AsyncValue<ViewShopStaffsPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(shopId: _$args));
  }
}
