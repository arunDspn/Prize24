import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop/domain/model/shop_follow_response_model.dart';
part 'shop_follow_response_dto.freezed.dart';
part 'shop_follow_response_dto.g.dart';

/**
 *     success: boolean;
    message: string;
    data?: any;
    error?: string;
 */

@freezed
abstract class ShopFollowResponseDto with _$ShopFollowResponseDto {
  const factory ShopFollowResponseDto({
    required bool success,
    required String message,
    Map<String, dynamic>? data,
    String? error,
  }) = _ShopFollowResponseDto;

  factory ShopFollowResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ShopFollowResponseDtoFromJson(json);

  // Private constructor
  const ShopFollowResponseDto._();

  // To Domain Model conversion
  ShopFollowResponseModel toDomain() {
    return ShopFollowResponseModel(
      success: success,
      message: message,
      data: data,
      error: error,
    );
  }
}
