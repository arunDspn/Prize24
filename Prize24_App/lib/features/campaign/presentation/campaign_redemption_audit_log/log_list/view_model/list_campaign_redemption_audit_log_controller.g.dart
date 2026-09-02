// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_campaign_redemption_audit_log_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ListCampaignRedemptionAuditLogController)
final listCampaignRedemptionAuditLogControllerProvider =
    ListCampaignRedemptionAuditLogControllerFamily._();

final class ListCampaignRedemptionAuditLogControllerProvider
    extends
        $AsyncNotifierProvider<
          ListCampaignRedemptionAuditLogController,
          PaginatedAuditLogState
        > {
  ListCampaignRedemptionAuditLogControllerProvider._({
    required ListCampaignRedemptionAuditLogControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'listCampaignRedemptionAuditLogControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() =>
      _$listCampaignRedemptionAuditLogControllerHash();

  @override
  String toString() {
    return r'listCampaignRedemptionAuditLogControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ListCampaignRedemptionAuditLogController create() =>
      ListCampaignRedemptionAuditLogController();

  @override
  bool operator ==(Object other) {
    return other is ListCampaignRedemptionAuditLogControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listCampaignRedemptionAuditLogControllerHash() =>
    r'e341f7953d38ff935b270e9b6abf71e0a8517da6';

final class ListCampaignRedemptionAuditLogControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ListCampaignRedemptionAuditLogController,
          AsyncValue<PaginatedAuditLogState>,
          PaginatedAuditLogState,
          FutureOr<PaginatedAuditLogState>,
          String
        > {
  ListCampaignRedemptionAuditLogControllerFamily._()
    : super(
        retry: null,
        name: r'listCampaignRedemptionAuditLogControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListCampaignRedemptionAuditLogControllerProvider call({
    required String campaignId,
  }) => ListCampaignRedemptionAuditLogControllerProvider._(
    argument: campaignId,
    from: this,
  );

  @override
  String toString() => r'listCampaignRedemptionAuditLogControllerProvider';
}

abstract class _$ListCampaignRedemptionAuditLogController
    extends $AsyncNotifier<PaginatedAuditLogState> {
  late final _$args = ref.$arg as String;
  String get campaignId => _$args;

  FutureOr<PaginatedAuditLogState> build({required String campaignId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<PaginatedAuditLogState>, PaginatedAuditLogState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedAuditLogState>,
                PaginatedAuditLogState
              >,
              AsyncValue<PaginatedAuditLogState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(campaignId: _$args));
  }
}
