import 'package:freezed_annotation/freezed_annotation.dart';
part 'shop_follow_response_model.freezed.dart';

@freezed
abstract class ShopFollowResponseModel with _$ShopFollowResponseModel {
  const factory ShopFollowResponseModel({
    required bool success,
    required String message,
    Map<String, dynamic>? data,
    String? error,
  }) = _ShopFollowResponseModel;
}
