// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_staff_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(staffRepositoryProvider)
final staffRepositoryProviderProvider = StaffRepositoryProviderProvider._();

final class StaffRepositoryProviderProvider
    extends
        $FunctionalProvider<
          IStaffRepository,
          IStaffRepository,
          IStaffRepository
        >
    with $Provider<IStaffRepository> {
  StaffRepositoryProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffRepositoryProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffRepositoryProviderHash();

  @$internal
  @override
  $ProviderElement<IStaffRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IStaffRepository create(Ref ref) {
    return staffRepositoryProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IStaffRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IStaffRepository>(value),
    );
  }
}

String _$staffRepositoryProviderHash() =>
    r'd0f41b1d1bcfbb72a130986a5ba6a07a15804364';
