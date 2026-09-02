// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_slug_availabilty_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PublicSlugAvailabiltyController)
final publicSlugAvailabiltyControllerProvider =
    PublicSlugAvailabiltyControllerProvider._();

final class PublicSlugAvailabiltyControllerProvider
    extends $AsyncNotifierProvider<PublicSlugAvailabiltyController, bool?> {
  PublicSlugAvailabiltyControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'publicSlugAvailabiltyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$publicSlugAvailabiltyControllerHash();

  @$internal
  @override
  PublicSlugAvailabiltyController create() => PublicSlugAvailabiltyController();
}

String _$publicSlugAvailabiltyControllerHash() =>
    r'9423ad51af287340758da56ed2e10e7d24e34053';

abstract class _$PublicSlugAvailabiltyController extends $AsyncNotifier<bool?> {
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
