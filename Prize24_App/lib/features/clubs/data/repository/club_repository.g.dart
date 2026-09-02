// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clubRepositoryProvider)
final clubRepositoryProviderProvider = ClubRepositoryProviderProvider._();

final class ClubRepositoryProviderProvider
    extends
        $FunctionalProvider<IClubRepository, IClubRepository, IClubRepository>
    with $Provider<IClubRepository> {
  ClubRepositoryProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clubRepositoryProviderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clubRepositoryProviderHash();

  @$internal
  @override
  $ProviderElement<IClubRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IClubRepository create(Ref ref) {
    return clubRepositoryProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IClubRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IClubRepository>(value),
    );
  }
}

String _$clubRepositoryProviderHash() =>
    r'85d6a389aee9c285b3d7c61ca72441eeaf8fb673';
