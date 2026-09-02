import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/clubs/domain/models/club_entity.dart';

part 'club_entity_dto.freezed.dart';
part 'club_entity_dto.g.dart';

@freezed
abstract class ClubEntityDto with _$ClubEntityDto {
  const factory ClubEntityDto({
    required String name,
    required String description,
    required int giftDay,
    required String attachedCampaignId,
    int? multipierStreakDaysRequired,
    @Default(2) int bonusIncrement,
  }) = _ClubEntityDto;

  /// Create DTO from domain entity
  factory ClubEntityDto.fromDomain(ClubEntity entity) {
    return ClubEntityDto(
      name: entity.name,
      description: entity.description,
      giftDay: entity.giftDay,
      attachedCampaignId: entity.attachedCampaignId,
      multipierStreakDaysRequired: entity.multipierStreakDaysRequired,
      bonusIncrement: entity.bonusIncrement,
    );
  }
  const ClubEntityDto._();

  factory ClubEntityDto.fromJson(Map<String, dynamic> json) =>
      _$ClubEntityDtoFromJson(json);

  /// Convert DTO to domain entity
  ClubEntity toDomain() {
    return ClubEntity(
      name: name,
      description: description,
      giftDay: giftDay,
      attachedCampaignId: attachedCampaignId,
      multipierStreakDaysRequired: multipierStreakDaysRequired,
      bonusIncrement: bonusIncrement,
    );
  }
}
