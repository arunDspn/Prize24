// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_request_send_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StaffRequestSendController)
final staffRequestSendControllerProvider = StaffRequestSendControllerFamily._();

final class StaffRequestSendControllerProvider
    extends
        $AsyncNotifierProvider<
          StaffRequestSendController,
          List<StaffRequestSendModel>
        > {
  StaffRequestSendControllerProvider._({
    required StaffRequestSendControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'staffRequestSendControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$staffRequestSendControllerHash();

  @override
  String toString() {
    return r'staffRequestSendControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StaffRequestSendController create() => StaffRequestSendController();

  @override
  bool operator ==(Object other) {
    return other is StaffRequestSendControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$staffRequestSendControllerHash() =>
    r'fb5c274f014634ba443ec720e7f3714f4893d7ef';

final class StaffRequestSendControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          StaffRequestSendController,
          AsyncValue<List<StaffRequestSendModel>>,
          List<StaffRequestSendModel>,
          FutureOr<List<StaffRequestSendModel>>,
          String
        > {
  StaffRequestSendControllerFamily._()
    : super(
        retry: null,
        name: r'staffRequestSendControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StaffRequestSendControllerProvider call({required String shopId}) =>
      StaffRequestSendControllerProvider._(argument: shopId, from: this);

  @override
  String toString() => r'staffRequestSendControllerProvider';
}

abstract class _$StaffRequestSendController
    extends $AsyncNotifier<List<StaffRequestSendModel>> {
  late final _$args = ref.$arg as String;
  String get shopId => _$args;

  FutureOr<List<StaffRequestSendModel>> build({required String shopId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<StaffRequestSendModel>>,
              List<StaffRequestSendModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<StaffRequestSendModel>>,
                List<StaffRequestSendModel>
              >,
              AsyncValue<List<StaffRequestSendModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(shopId: _$args));
  }
}
