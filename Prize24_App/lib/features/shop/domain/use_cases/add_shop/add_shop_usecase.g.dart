// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_shop_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(addShopUsecase)
final addShopUsecaseProvider = AddShopUsecaseProvider._();

final class AddShopUsecaseProvider
    extends $FunctionalProvider<AddShopUsecase, AddShopUsecase, AddShopUsecase>
    with $Provider<AddShopUsecase> {
  AddShopUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addShopUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addShopUsecaseHash();

  @$internal
  @override
  $ProviderElement<AddShopUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddShopUsecase create(Ref ref) {
    return addShopUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddShopUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddShopUsecase>(value),
    );
  }
}

String _$addShopUsecaseHash() => r'ea8f8b4e6d8e841451d4ad3f19d9e48bbf582745';
