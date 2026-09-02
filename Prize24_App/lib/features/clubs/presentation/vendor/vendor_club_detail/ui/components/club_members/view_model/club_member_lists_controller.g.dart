// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_member_lists_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ClubMemberListsController)
final clubMemberListsControllerProvider = ClubMemberListsControllerFamily._();

final class ClubMemberListsControllerProvider
    extends
        $AsyncNotifierProvider<
          ClubMemberListsController,
          List<ClubMemberVendorDataModel>
        > {
  ClubMemberListsControllerProvider._({
    required ClubMemberListsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'clubMemberListsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$clubMemberListsControllerHash();

  @override
  String toString() {
    return r'clubMemberListsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ClubMemberListsController create() => ClubMemberListsController();

  @override
  bool operator ==(Object other) {
    return other is ClubMemberListsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$clubMemberListsControllerHash() =>
    r'5da9a536a39d311495aac394bdd41d0969bedf7a';

final class ClubMemberListsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ClubMemberListsController,
          AsyncValue<List<ClubMemberVendorDataModel>>,
          List<ClubMemberVendorDataModel>,
          FutureOr<List<ClubMemberVendorDataModel>>,
          String
        > {
  ClubMemberListsControllerFamily._()
    : super(
        retry: null,
        name: r'clubMemberListsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ClubMemberListsControllerProvider call({required String clubId}) =>
      ClubMemberListsControllerProvider._(argument: clubId, from: this);

  @override
  String toString() => r'clubMemberListsControllerProvider';
}

abstract class _$ClubMemberListsController
    extends $AsyncNotifier<List<ClubMemberVendorDataModel>> {
  late final _$args = ref.$arg as String;
  String get clubId => _$args;

  FutureOr<List<ClubMemberVendorDataModel>> build({required String clubId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ClubMemberVendorDataModel>>,
              List<ClubMemberVendorDataModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ClubMemberVendorDataModel>>,
                List<ClubMemberVendorDataModel>
              >,
              AsyncValue<List<ClubMemberVendorDataModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(clubId: _$args));
  }
}
