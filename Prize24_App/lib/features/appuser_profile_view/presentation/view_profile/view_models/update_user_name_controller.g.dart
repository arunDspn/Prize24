// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_name_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateUserNameController)
final updateUserNameControllerProvider = UpdateUserNameControllerProvider._();

final class UpdateUserNameControllerProvider
    extends $AsyncNotifierProvider<UpdateUserNameController, String?> {
  UpdateUserNameControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateUserNameControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateUserNameControllerHash();

  @$internal
  @override
  UpdateUserNameController create() => UpdateUserNameController();
}

String _$updateUserNameControllerHash() =>
    r'e77eea9229b0f803c517bd051cfea634b58a37a2';

abstract class _$UpdateUserNameController extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
