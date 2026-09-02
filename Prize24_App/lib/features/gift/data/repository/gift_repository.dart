import 'package:cloud_functions/cloud_functions.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/gift/data/dto/gift_dto.dart';
import 'package:prize24_app/features/gift/data/repository/i_gift_repository.dart';
import 'package:prize24_app/features/gift/data/service/i_gift_service.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';

class GiftRepository implements IGiftRepository {
  GiftRepository({required IGiftService giftService})
    : _giftService = giftService;

  final IGiftService _giftService;
  // @override
  // Future<GiftModel> createGift({
  //   required GiftModel gift,
  // }) async {
  //   // Convert GiftModel to GiftDto
  //   final giftDto = GiftDto.fromDomainModel(
  //     gift,
  //     // userId: gift.userId, // Assuming userId is not needed here
  //   );

  //   // Call the service to create the gift
  //   final createdGiftDto = await _giftService.createGift(giftDto: giftDto);

  //   // Convert back to GiftModel and return
  //   return createdGiftDto.toDomainModel();
  // }

  @override
  Future<GiftModel> updateGift({required GiftModel gift}) {
    // TODO: implement updateGift
    throw UnimplementedError();
  }

  @override
  Future<void> deleteGift({required String giftId, required String userId}) {
    // TODO: implement deleteGift
    throw UnimplementedError();
  }

  @override
  Future<PaginatedResult<UserGiftModel>> fetchUsersAllGifts({
    required String userId,
    Object? cursor,
    int limit = 20,
  }) async {
    final (dtos, nextCursor) = await _giftService.fetchUsersAllGifts(
      userId: userId,
      cursor: cursor,
      limit: limit,
    );

    final models = dtos.map((dto) => dto.toDomainModel()).toList();
    return PaginatedResult(
      items: models,
      cursor: nextCursor,
      hasMore: nextCursor != null,
    );
  }

  @override
  Future<GiftModel> redeemGift({
    required String giftId,
    required String userId,
  }) {
    // TODO: implement redeemGift
    throw UnimplementedError();
  }

  @override
  Future<List<GiftModel>> fetchCampaignGifts({
    required String campaignId,
    int? page,
    int? limit,
  }) async {
    // Fetch campaign gifts using the service
    final giftDtos = await _giftService.fetchCampaignGifts(
      campaignId: campaignId,
      page: page,
      limit: limit,
    );

    // Convert List<GiftDto> to List<GiftModel>
    return giftDtos.map((dto) => dto.toDomainModel()).toList();
  }

  @override
  Future<GiftModel> createAutoNonRedeemableGift({
    required GiftModel gift,
    required List<AutoGiftPayloadModel> autoGiftPayloads,
  }) async {
    // Convert GiftModel to GiftDto
    final giftDto = GiftDto.fromDomainModel(gift);

    // Call the service to create the auto non-redeemable gift
    final createdGiftDto = await _giftService.createAutoNonRedeemableGift(
      giftDto: giftDto,
      autoGiftPayloadDtos: autoGiftPayloads
          .map(AutoGiftPayloadDto.fromDomainModel)
          .toList(),
    );

    // Convert back to GiftModel and return
    return createdGiftDto.toDomainModel();
  }

  @override
  Future<GiftModel> createAutoRedeemableGift({required GiftModel gift}) async {
    // Convert GiftModel to GiftDto
    final giftDto = GiftDto.fromDomainModel(gift);

    // Call the service to create the auto redeemable gift
    final createdGiftDto = await _giftService.createAutoRedeemableGift(
      giftDto: giftDto,
    );

    // Convert back to GiftModel and return
    return createdGiftDto.toDomainModel();
  }

  @override
  Future<GiftModel> createCodeGift({
    required GiftModel gift,
    required List<CodeGiftCodeModel> codeGiftCodes,
  }) async {
    // Convert GiftModel to GiftDto
    final giftDto = GiftDto.fromDomainModel(gift);

    // Convert List<CodeGiftCodeModel> to List<CodeGiftCodeDto>
    final codeGiftCodeDtos = codeGiftCodes
        .map(CodeGiftCodeDto.fromDomainModel)
        .toList();

    // Call the service to create the code gift
    final createdGiftDto = await _giftService.createCodeGift(
      giftDto: giftDto,
      codeGiftCodes: codeGiftCodeDtos,
    );

    // Convert back to GiftModel and return
    return createdGiftDto.toDomainModel();
  }

  @override
  Future<GiftModel> editGift({required GiftModel gift}) async {
    // Convert GiftModel to GiftDto
    final giftDto = GiftDto.fromDomainModel(gift);

    // Call the service to edit the gift
    final editedGiftDto = await _giftService.editGift(giftDto: giftDto);

    // Convert back to GiftModel and return
    return editedGiftDto.toDomainModel();
  }

  @override
  Future<String> deleteAutoRedeemableGift({
    required String campaignId,
    required String giftId,
  }) async {
    // Call the service to delete the auto redeemable gift
    final result = await _giftService.deleteAutoRedeemableGift(
      campaignId: campaignId,
      giftId: giftId,
    );

    return result;
  }
}
