// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_streak_log_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserStreakLogController)
final userStreakLogControllerProvider = UserStreakLogControllerFamily._();

final class UserStreakLogControllerProvider
    extends
        $AsyncNotifierProvider<
          UserStreakLogController,
          PaginatedStreakLogState
        > {
  UserStreakLogControllerProvider._({
    required UserStreakLogControllerFamily super.from,
    required ({String shopId, String userId}) super.argument,
  }) : super(
         retry: null,
         name: r'userStreakLogControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userStreakLogControllerHash();

  @override
  String toString() {
    return r'userStreakLogControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  UserStreakLogController create() => UserStreakLogController();

  @override
  bool operator ==(Object other) {
    return other is UserStreakLogControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userStreakLogControllerHash() =>
    r'3c13825e3138b79fe2384516eab704526da2e397';

final class UserStreakLogControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          UserStreakLogController,
          AsyncValue<PaginatedStreakLogState>,
          PaginatedStreakLogState,
          FutureOr<PaginatedStreakLogState>,
          ({String shopId, String userId})
        > {
  UserStreakLogControllerFamily._()
    : super(
        retry: null,
        name: r'userStreakLogControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserStreakLogControllerProvider call({
    required String shopId,
    required String userId,
  }) => UserStreakLogControllerProvider._(
    argument: (shopId: shopId, userId: userId),
    from: this,
  );

  @override
  String toString() => r'userStreakLogControllerProvider';
}

abstract class _$UserStreakLogController
    extends $AsyncNotifier<PaginatedStreakLogState> {
  late final _$args = ref.$arg as ({String shopId, String userId});
  String get shopId => _$args.shopId;
  String get userId => _$args.userId;

  FutureOr<PaginatedStreakLogState> build({
    required String shopId,
    required String userId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PaginatedStreakLogState>,
              PaginatedStreakLogState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedStreakLogState>,
                PaginatedStreakLogState
              >,
              AsyncValue<PaginatedStreakLogState>,
              Object?,
              Object?
            >;
    element.handleCreate(
      ref,
      () => build(shopId: _$args.shopId, userId: _$args.userId),
    );
  }
}
