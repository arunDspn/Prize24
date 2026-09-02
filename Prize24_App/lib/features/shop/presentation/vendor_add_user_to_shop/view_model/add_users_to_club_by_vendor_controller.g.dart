// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_users_to_club_by_vendor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddUsersToClubByVendorController)
final addUsersToClubByVendorControllerProvider =
    AddUsersToClubByVendorControllerProvider._();

final class AddUsersToClubByVendorControllerProvider
    extends $AsyncNotifierProvider<AddUsersToClubByVendorController, void> {
  AddUsersToClubByVendorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addUsersToClubByVendorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addUsersToClubByVendorControllerHash();

  @$internal
  @override
  AddUsersToClubByVendorController create() =>
      AddUsersToClubByVendorController();
}

String _$addUsersToClubByVendorControllerHash() =>
    r'e77cd035ce46ef95a174639fbe9039584fb45e88';

abstract class _$AddUsersToClubByVendorController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
