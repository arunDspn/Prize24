import 'package:freezed_annotation/freezed_annotation.dart';
part 'inapp_scan_success_results.freezed.dart';

@freezed
sealed class InappScanSuccessResults with _$InappScanSuccessResults {
  const factory InappScanSuccessResults.checkIn() =
      InappScanSuccessResultsCheckIn;

  const factory InappScanSuccessResults.prizeAvailed() =
      InappScanSuccessResultsPrizeAvailed;

  const factory InappScanSuccessResults.prizeRedeemed() =
      InappScanSuccessResultsPrizeRedeemed;
}
