// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_campaign_activity_log_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ListCampaignActivityLogController)
final listCampaignActivityLogControllerProvider =
    ListCampaignActivityLogControllerFamily._();

final class ListCampaignActivityLogControllerProvider
    extends
        $AsyncNotifierProvider<
          ListCampaignActivityLogController,
          PaginatedActivityLogState
        > {
  ListCampaignActivityLogControllerProvider._({
    required ListCampaignActivityLogControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'listCampaignActivityLogControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() =>
      _$listCampaignActivityLogControllerHash();

  @override
  String toString() {
    return r'listCampaignActivityLogControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ListCampaignActivityLogController create() =>
      ListCampaignActivityLogController();

  @override
  bool operator ==(Object other) {
    return other is ListCampaignActivityLogControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listCampaignActivityLogControllerHash() =>
    r'161b36b704357088b6ac551751989faaa9075ee6';

final class ListCampaignActivityLogControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ListCampaignActivityLogController,
          AsyncValue<PaginatedActivityLogState>,
          PaginatedActivityLogState,
          FutureOr<PaginatedActivityLogState>,
          String
        > {
  ListCampaignActivityLogControllerFamily._()
    : super(
        retry: null,
        name: r'listCampaignActivityLogControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListCampaignActivityLogControllerProvider call({
    required String campaignId,
  }) => ListCampaignActivityLogControllerProvider._(
    argument: campaignId,
    from: this,
  );

  @override
  String toString() => r'listCampaignActivityLogControllerProvider';
}

abstract class _$ListCampaignActivityLogController
    extends $AsyncNotifier<PaginatedActivityLogState> {
  late final _$args = ref.$arg as String;
  String get campaignId => _$args;

  FutureOr<PaginatedActivityLogState> build({required String campaignId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PaginatedActivityLogState>,
              PaginatedActivityLogState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedActivityLogState>,
                PaginatedActivityLogState
              >,
              AsyncValue<PaginatedActivityLogState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(campaignId: _$args));
  }
}
