// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_club_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clubService)
final clubServiceProvider = ClubServiceProvider._();

final class ClubServiceProvider
    extends $FunctionalProvider<IClubService, IClubService, IClubService>
    with $Provider<IClubService> {
  ClubServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clubServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clubServiceHash();

  @$internal
  @override
  $ProviderElement<IClubService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IClubService create(Ref ref) {
    return clubService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IClubService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IClubService>(value),
    );
  }
}

String _$clubServiceHash() => r'97ef3a4f93a1646e9310c17ea3de8c9aeededd6d';
