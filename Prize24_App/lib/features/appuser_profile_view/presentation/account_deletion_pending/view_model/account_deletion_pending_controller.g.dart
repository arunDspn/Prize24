// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_pending_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountDeletionPendingController)
final accountDeletionPendingControllerProvider =
    AccountDeletionPendingControllerProvider._();

final class AccountDeletionPendingControllerProvider
    extends $AsyncNotifierProvider<AccountDeletionPendingController, bool?> {
  AccountDeletionPendingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountDeletionPendingControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountDeletionPendingControllerHash();

  @$internal
  @override
  AccountDeletionPendingController create() =>
      AccountDeletionPendingController();
}

String _$accountDeletionPendingControllerHash() =>
    r'c3b9614be0c2b3289fff1a04286b1930ddcc31af';

abstract class _$AccountDeletionPendingController
    extends $AsyncNotifier<bool?> {
  FutureOr<bool?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool?>, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool?>, bool?>,
              AsyncValue<bool?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
