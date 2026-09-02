import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/shop_staff_model.dart';
import 'package:prize24_app/utils/firebase_helper.dart';
part 'shop_staff_dto.freezed.dart';
part 'shop_staff_dto.g.dart';

@freezed
abstract class ShopStaffDto with _$ShopStaffDto {
  const factory ShopStaffDto({
    String? staffId,
    required String staffName,
    @JsonKey(
      fromJson: FirebaseHelper.timestampFromJson,
      toJson: FirebaseHelper.timestampToJson,
    )
    required Timestamp addedAt,
    String? staffPhone,
  }) = _ShopStaffDto;

  factory ShopStaffDto.fromJson(Map<String, dynamic> json) =>
      _$ShopStaffDtoFromJson(json);

  // Private const constructor to prevent direct instantiation
  const ShopStaffDto._();

  // Converts DTO to domain model
  ShopStaffModel toDomain() {
    return ShopStaffModel(
      staffId: staffId!,
      staffName: staffName,
      addedAt: addedAt.toDate(),
      staffPhone: staffPhone,
    );
  }
}
