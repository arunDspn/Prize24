// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_shop_list_campaign_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StaffShopListCampaignController)
final staffShopListCampaignControllerProvider =
    StaffShopListCampaignControllerFamily._();

final class StaffShopListCampaignControllerProvider
    extends
        $AsyncNotifierProvider<
          StaffShopListCampaignController,
          StaffShopCampaignPaginatedState
        > {
  StaffShopListCampaignControllerProvider._({
    required StaffShopListCampaignControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'staffShopListCampaignControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$staffShopListCampaignControllerHash();

  @override
  String toString() {
    return r'staffShopListCampaignControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StaffShopListCampaignController create() => StaffShopListCampaignController();

  @override
  bool operator ==(Object other) {
    return other is StaffShopListCampaignControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$staffShopListCampaignControllerHash() =>
    r'7cd74d9dfc97cd3c94319427390ac0bf7e743b69';

final class StaffShopListCampaignControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          StaffShopListCampaignController,
          AsyncValue<StaffShopCampaignPaginatedState>,
          StaffShopCampaignPaginatedState,
          FutureOr<StaffShopCampaignPaginatedState>,
          String
        > {
  StaffShopListCampaignControllerFamily._()
    : super(
        retry: null,
        name: r'staffShopListCampaignControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StaffShopListCampaignControllerProvider call({required String shopId}) =>
      StaffShopListCampaignControllerProvider._(argument: shopId, from: this);

  @override
  String toString() => r'staffShopListCampaignControllerProvider';
}

abstract class _$StaffShopListCampaignController
    extends $AsyncNotifier<StaffShopCampaignPaginatedState> {
  late final _$args = ref.$arg as String;
  String get shopId => _$args;

  FutureOr<StaffShopCampaignPaginatedState> build({required String shopId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<StaffShopCampaignPaginatedState>,
              StaffShopCampaignPaginatedState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<StaffShopCampaignPaginatedState>,
                StaffShopCampaignPaginatedState
              >,
              AsyncValue<StaffShopCampaignPaginatedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(shopId: _$args));
  }
}
