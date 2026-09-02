// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_user_gifts_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listUserGiftsUsecase)
final listUserGiftsUsecaseProvider = ListUserGiftsUsecaseProvider._();

final class ListUserGiftsUsecaseProvider
    extends
        $FunctionalProvider<
          ListUserGiftsUsecase,
          ListUserGiftsUsecase,
          ListUserGiftsUsecase
        >
    with $Provider<ListUserGiftsUsecase> {
  ListUserGiftsUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listUserGiftsUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listUserGiftsUsecaseHash();

  @$internal
  @override
  $ProviderElement<ListUserGiftsUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ListUserGiftsUsecase create(Ref ref) {
    return listUserGiftsUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListUserGiftsUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListUserGiftsUsecase>(value),
    );
  }
}

String _$listUserGiftsUsecaseHash() =>
    r'e5aed33eecbb9ced663525c4d2fb1464a6245745';
