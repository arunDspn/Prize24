// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_gifts_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ClubGiftsHistoryController)
final clubGiftsHistoryControllerProvider =
    ClubGiftsHistoryControllerProvider._();

final class ClubGiftsHistoryControllerProvider
    extends
        $AsyncNotifierProvider<
          ClubGiftsHistoryController,
          List<UserGiftModel>
        > {
  ClubGiftsHistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clubGiftsHistoryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clubGiftsHistoryControllerHash();

  @$internal
  @override
  ClubGiftsHistoryController create() => ClubGiftsHistoryController();
}

String _$clubGiftsHistoryControllerHash() =>
    r'a91b96bc1df700264a7b4c78fc12f21c8c470a9f';

abstract class _$ClubGiftsHistoryController
    extends $AsyncNotifier<List<UserGiftModel>> {
  FutureOr<List<UserGiftModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<UserGiftModel>>, List<UserGiftModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<UserGiftModel>>, List<UserGiftModel>>,
              AsyncValue<List<UserGiftModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
