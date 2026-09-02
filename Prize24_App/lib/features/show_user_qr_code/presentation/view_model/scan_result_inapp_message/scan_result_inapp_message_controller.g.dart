// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result_inapp_message_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scanResultInappMessageController)
final scanResultInappMessageControllerProvider =
    ScanResultInappMessageControllerProvider._();

final class ScanResultInappMessageControllerProvider
    extends
        $FunctionalProvider<
          AsyncValue<InappScanSuccessResults?>,
          InappScanSuccessResults?,
          Stream<InappScanSuccessResults?>
        >
    with
        $FutureModifier<InappScanSuccessResults?>,
        $StreamProvider<InappScanSuccessResults?> {
  ScanResultInappMessageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scanResultInappMessageControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanResultInappMessageControllerHash();

  @$internal
  @override
  $StreamProviderElement<InappScanSuccessResults?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<InappScanSuccessResults?> create(Ref ref) {
    return scanResultInappMessageController(ref);
  }
}

String _$scanResultInappMessageControllerHash() =>
    r'dcdeee65bb210238aa62a66ec42b0ad8ae9a1a13';
