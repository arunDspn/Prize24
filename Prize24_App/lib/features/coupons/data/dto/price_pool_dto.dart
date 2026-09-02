import 'package:freezed_annotation/freezed_annotation.dart';
part 'price_pool_dto.freezed.dart';
part 'price_pool_dto.g.dart';

@freezed
abstract class PricePoolDto with _$PricePoolDto {
  const factory PricePoolDto({
    required String prizeName,
    required String prizeDescription,
  }) = _PricePoolDto;

  factory PricePoolDto.fromJson(Map<String, dynamic> json) =>
      _$PricePoolDtoFromJson(json);
}
