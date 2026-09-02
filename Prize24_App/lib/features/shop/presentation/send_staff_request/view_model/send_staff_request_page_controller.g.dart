// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_staff_request_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SendStaffRequestPageController)
final sendStaffRequestPageControllerProvider =
    SendStaffRequestPageControllerProvider._();

final class SendStaffRequestPageControllerProvider
    extends $AsyncNotifierProvider<SendStaffRequestPageController, String?> {
  SendStaffRequestPageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendStaffRequestPageControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendStaffRequestPageControllerHash();

  @$internal
  @override
  SendStaffRequestPageController create() => SendStaffRequestPageController();
}

String _$sendStaffRequestPageControllerHash() =>
    r'3fc3aa0e27ac9bf5a044a16ce3962b9717b763a3';

abstract class _$SendStaffRequestPageController
    extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
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
    element.handleCreate(ref, build);
  }
}
