// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_gift_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateGiftUsecase)
final updateGiftUsecaseProvider = UpdateGiftUsecaseProvider._();

final class UpdateGiftUsecaseProvider
    extends
        $FunctionalProvider<
          UpdateGiftUsecase,
          UpdateGiftUsecase,
          UpdateGiftUsecase
        >
    with $Provider<UpdateGiftUsecase> {
  UpdateGiftUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateGiftUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateGiftUsecaseHash();

  @$internal
  @override
  $ProviderElement<UpdateGiftUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateGiftUsecase create(Ref ref) {
    return updateGiftUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateGiftUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateGiftUsecase>(value),
    );
  }
}

String _$updateGiftUsecaseHash() => r'cd337cdab1074560c2954008a0f95a55d3b4a44d';
