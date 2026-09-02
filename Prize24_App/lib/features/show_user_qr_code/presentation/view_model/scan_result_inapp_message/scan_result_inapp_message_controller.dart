// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'scan_result_inapp_message_controller.g.dart';

// @riverpod
// class ScanResultInappMessageController
//     extends _$ScanResultInappMessageController {
//   @override
//   FutureOr<InappScanSuccessResults?> build() {
//     return null;
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/features/show_user_qr_code/presentation/view_model/scan_result_inapp_message/results/inapp_scan_success_results.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_result_inapp_message_controller.g.dart';

@riverpod
Stream<InappScanSuccessResults?> scanResultInappMessageController(
  Ref ref,
) async* {
  await for (final notification in inAppNotifcationsController.stream) {
    final msg = notification.data['type'] as String?;
    if (msg == 'check_in') {
      yield const InappScanSuccessResults.checkIn();
    } else if (msg == 'offer_avail_success') {
      yield const InappScanSuccessResults.prizeAvailed();
    } else if (msg == 'offer_redeem_success') {
      yield const InappScanSuccessResults.prizeRedeemed();
    } else {
      yield null;
    }
  }
}
