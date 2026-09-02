// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_staff_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(staffServiceProvider)
final staffServiceProviderProvider = StaffServiceProviderProvider._();

final class StaffServiceProviderProvider
    extends $FunctionalProvider<IStaffService, IStaffService, IStaffService>
    with $Provider<IStaffService> {
  StaffServiceProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffServiceProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffServiceProviderHash();

  @$internal
  @override
  $ProviderElement<IStaffService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IStaffService create(Ref ref) {
    return staffServiceProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IStaffService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IStaffService>(value),
    );
  }
}

String _$staffServiceProviderHash() =>
    r'ec8cf0e715931d567a059de2c4cb26f9ddebc7af';
