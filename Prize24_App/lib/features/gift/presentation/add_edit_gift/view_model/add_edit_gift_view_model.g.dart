// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_gift_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Add/Edit Gift View Model

@ProviderFor(AddEditGiftViewModel)
final addEditGiftViewModelProvider = AddEditGiftViewModelProvider._();

/// Add/Edit Gift View Model
final class AddEditGiftViewModelProvider
    extends $NotifierProvider<AddEditGiftViewModel, AddEditGiftState> {
  /// Add/Edit Gift View Model
  AddEditGiftViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addEditGiftViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addEditGiftViewModelHash();

  @$internal
  @override
  AddEditGiftViewModel create() => AddEditGiftViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddEditGiftState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddEditGiftState>(value),
    );
  }
}

String _$addEditGiftViewModelHash() =>
    r'fb513d5c6cf4355ede631314e8a8cde9b9ee4c7d';

/// Add/Edit Gift View Model

abstract class _$AddEditGiftViewModel extends $Notifier<AddEditGiftState> {
  AddEditGiftState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AddEditGiftState, AddEditGiftState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AddEditGiftState, AddEditGiftState>,
              AddEditGiftState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
