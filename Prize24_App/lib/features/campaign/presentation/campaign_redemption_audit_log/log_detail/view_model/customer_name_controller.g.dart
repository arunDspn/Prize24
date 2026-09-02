// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_name_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomerNameController)
final customerNameControllerProvider = CustomerNameControllerFamily._();

final class CustomerNameControllerProvider
    extends $AsyncNotifierProvider<CustomerNameController, String?> {
  CustomerNameControllerProvider._({
    required CustomerNameControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'customerNameControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerNameControllerHash();

  @override
  String toString() {
    return r'customerNameControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CustomerNameController create() => CustomerNameController();

  @override
  bool operator ==(Object other) {
    return other is CustomerNameControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerNameControllerHash() =>
    r'e805506fbec289aa8b55aa3b426d961db8240a99';

final class CustomerNameControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CustomerNameController,
          AsyncValue<String?>,
          String?,
          FutureOr<String?>,
          String
        > {
  CustomerNameControllerFamily._()
    : super(
        retry: null,
        name: r'customerNameControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CustomerNameControllerProvider call({required String customerId}) =>
      CustomerNameControllerProvider._(argument: customerId, from: this);

  @override
  String toString() => r'customerNameControllerProvider';
}

abstract class _$CustomerNameController extends $AsyncNotifier<String?> {
  late final _$args = ref.$arg as String;
  String get customerId => _$args;

  FutureOr<String?> build({required String customerId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(customerId: _$args));
  }
}
