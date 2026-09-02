// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_all_vendors_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ListAllVendorsController)
final listAllVendorsControllerProvider = ListAllVendorsControllerFamily._();

final class ListAllVendorsControllerProvider
    extends
        $AsyncNotifierProvider<
          ListAllVendorsController,
          VendorListPaginatedState
        > {
  ListAllVendorsControllerProvider._({
    required ListAllVendorsControllerFamily super.from,
    required ({List<String> alreadyAddedVendorIds, String campaignId})
    super.argument,
  }) : super(
         retry: null,
         name: r'listAllVendorsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listAllVendorsControllerHash();

  @override
  String toString() {
    return r'listAllVendorsControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ListAllVendorsController create() => ListAllVendorsController();

  @override
  bool operator ==(Object other) {
    return other is ListAllVendorsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listAllVendorsControllerHash() =>
    r'243057e179e7cbdfd16db441f38b0f5a45a0e6f2';

final class ListAllVendorsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ListAllVendorsController,
          AsyncValue<VendorListPaginatedState>,
          VendorListPaginatedState,
          FutureOr<VendorListPaginatedState>,
          ({List<String> alreadyAddedVendorIds, String campaignId})
        > {
  ListAllVendorsControllerFamily._()
    : super(
        retry: null,
        name: r'listAllVendorsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListAllVendorsControllerProvider call({
    required List<String> alreadyAddedVendorIds,
    required String campaignId,
  }) => ListAllVendorsControllerProvider._(
    argument: (
      alreadyAddedVendorIds: alreadyAddedVendorIds,
      campaignId: campaignId,
    ),
    from: this,
  );

  @override
  String toString() => r'listAllVendorsControllerProvider';
}

abstract class _$ListAllVendorsController
    extends $AsyncNotifier<VendorListPaginatedState> {
  late final _$args =
      ref.$arg as ({List<String> alreadyAddedVendorIds, String campaignId});
  List<String> get alreadyAddedVendorIds => _$args.alreadyAddedVendorIds;
  String get campaignId => _$args.campaignId;

  FutureOr<VendorListPaginatedState> build({
    required List<String> alreadyAddedVendorIds,
    required String campaignId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<VendorListPaginatedState>,
              VendorListPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<VendorListPaginatedState>,
                VendorListPaginatedState
              >,
              AsyncValue<VendorListPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(
      ref,
      () => build(
        alreadyAddedVendorIds: _$args.alreadyAddedVendorIds,
        campaignId: _$args.campaignId,
      ),
    );
  }
}
