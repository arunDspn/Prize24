// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_club_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateClubController)
final createClubControllerProvider = CreateClubControllerProvider._();

final class CreateClubControllerProvider
    extends $AsyncNotifierProvider<CreateClubController, ClubModel?> {
  CreateClubControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createClubControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createClubControllerHash();

  @$internal
  @override
  CreateClubController create() => CreateClubController();
}

String _$createClubControllerHash() =>
    r'ee9db4b9a0e1e882b35cf312cdc6b94c7202df9c';

abstract class _$CreateClubController extends $AsyncNotifier<ClubModel?> {
  FutureOr<ClubModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ClubModel?>, ClubModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ClubModel?>, ClubModel?>,
              AsyncValue<ClubModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
