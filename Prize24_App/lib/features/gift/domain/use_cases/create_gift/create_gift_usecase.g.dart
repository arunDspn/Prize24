// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_gift_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(createGiftUsecase)
final createGiftUsecaseProvider = CreateGiftUsecaseProvider._();

final class CreateGiftUsecaseProvider
    extends
        $FunctionalProvider<
          CreateGiftUsecase,
          CreateGiftUsecase,
          CreateGiftUsecase
        >
    with $Provider<CreateGiftUsecase> {
  CreateGiftUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createGiftUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createGiftUsecaseHash();

  @$internal
  @override
  $ProviderElement<CreateGiftUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateGiftUsecase create(Ref ref) {
    return createGiftUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateGiftUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateGiftUsecase>(value),
    );
  }
}

String _$createGiftUsecaseHash() => r'1d634865a12c029f35c80aec57c4e8f3f58a3320';

@ProviderFor(createAutoRedeemableGift)
final createAutoRedeemableGiftProvider = CreateAutoRedeemableGiftFamily._();

final class CreateAutoRedeemableGiftProvider
    extends
        $FunctionalProvider<
          AsyncValue<GiftModel>,
          GiftModel,
          FutureOr<GiftModel>
        >
    with $FutureModifier<GiftModel>, $FutureProvider<GiftModel> {
  CreateAutoRedeemableGiftProvider._({
    required CreateAutoRedeemableGiftFamily super.from,
    required GiftModel super.argument,
  }) : super(
         retry: null,
         name: r'createAutoRedeemableGiftProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$createAutoRedeemableGiftHash();

  @override
  String toString() {
    return r'createAutoRedeemableGiftProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<GiftModel> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<GiftModel> create(Ref ref) {
    final argument = this.argument as GiftModel;
    return createAutoRedeemableGift(ref, gift: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateAutoRedeemableGiftProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$createAutoRedeemableGiftHash() =>
    r'7702eebb6755723cbbba04fe59e04b41abbab595';

final class CreateAutoRedeemableGiftFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<GiftModel>, GiftModel> {
  CreateAutoRedeemableGiftFamily._()
    : super(
        retry: null,
        name: r'createAutoRedeemableGiftProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CreateAutoRedeemableGiftProvider call({required GiftModel gift}) =>
      CreateAutoRedeemableGiftProvider._(argument: gift, from: this);

  @override
  String toString() => r'createAutoRedeemableGiftProvider';
}

@ProviderFor(createAutoNonRedeemableGift)
final createAutoNonRedeemableGiftProvider =
    CreateAutoNonRedeemableGiftFamily._();

final class CreateAutoNonRedeemableGiftProvider
    extends
        $FunctionalProvider<
          AsyncValue<GiftModel>,
          GiftModel,
          FutureOr<GiftModel>
        >
    with $FutureModifier<GiftModel>, $FutureProvider<GiftModel> {
  CreateAutoNonRedeemableGiftProvider._({
    required CreateAutoNonRedeemableGiftFamily super.from,
    required ({GiftModel gift, List<AutoGiftPayloadModel> autoGiftPayloads})
    super.argument,
  }) : super(
         retry: null,
         name: r'createAutoNonRedeemableGiftProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$createAutoNonRedeemableGiftHash();

  @override
  String toString() {
    return r'createAutoNonRedeemableGiftProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<GiftModel> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<GiftModel> create(Ref ref) {
    final argument =
        this.argument
            as ({GiftModel gift, List<AutoGiftPayloadModel> autoGiftPayloads});
    return createAutoNonRedeemableGift(
      ref,
      gift: argument.gift,
      autoGiftPayloads: argument.autoGiftPayloads,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CreateAutoNonRedeemableGiftProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$createAutoNonRedeemableGiftHash() =>
    r'7be3718cc966a6daef739eed85cf5591839fad63';

final class CreateAutoNonRedeemableGiftFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<GiftModel>,
          ({GiftModel gift, List<AutoGiftPayloadModel> autoGiftPayloads})
        > {
  CreateAutoNonRedeemableGiftFamily._()
    : super(
        retry: null,
        name: r'createAutoNonRedeemableGiftProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CreateAutoNonRedeemableGiftProvider call({
    required GiftModel gift,
    required List<AutoGiftPayloadModel> autoGiftPayloads,
  }) => CreateAutoNonRedeemableGiftProvider._(
    argument: (gift: gift, autoGiftPayloads: autoGiftPayloads),
    from: this,
  );

  @override
  String toString() => r'createAutoNonRedeemableGiftProvider';
}

@ProviderFor(createCodeGift)
final createCodeGiftProvider = CreateCodeGiftFamily._();

final class CreateCodeGiftProvider
    extends
        $FunctionalProvider<
          AsyncValue<GiftModel>,
          GiftModel,
          FutureOr<GiftModel>
        >
    with $FutureModifier<GiftModel>, $FutureProvider<GiftModel> {
  CreateCodeGiftProvider._({
    required CreateCodeGiftFamily super.from,
    required ({GiftModel gift, List<CodeGiftCodeModel> codeGiftCodes})
    super.argument,
  }) : super(
         retry: null,
         name: r'createCodeGiftProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$createCodeGiftHash();

  @override
  String toString() {
    return r'createCodeGiftProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<GiftModel> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<GiftModel> create(Ref ref) {
    final argument =
        this.argument
            as ({GiftModel gift, List<CodeGiftCodeModel> codeGiftCodes});
    return createCodeGift(
      ref,
      gift: argument.gift,
      codeGiftCodes: argument.codeGiftCodes,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CreateCodeGiftProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$createCodeGiftHash() => r'0cbd13f64807b52c14247300666136b6982be25f';

final class CreateCodeGiftFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<GiftModel>,
          ({GiftModel gift, List<CodeGiftCodeModel> codeGiftCodes})
        > {
  CreateCodeGiftFamily._()
    : super(
        retry: null,
        name: r'createCodeGiftProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CreateCodeGiftProvider call({
    required GiftModel gift,
    required List<CodeGiftCodeModel> codeGiftCodes,
  }) => CreateCodeGiftProvider._(
    argument: (gift: gift, codeGiftCodes: codeGiftCodes),
    from: this,
  );

  @override
  String toString() => r'createCodeGiftProvider';
}
