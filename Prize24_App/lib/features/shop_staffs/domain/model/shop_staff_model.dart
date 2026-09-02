import 'package:freezed_annotation/freezed_annotation.dart';
part 'shop_staff_model.freezed.dart';

@freezed
abstract class ShopStaffModel with _$ShopStaffModel {
  const factory ShopStaffModel({
    required String staffId,
    required String staffName,
    required DateTime addedAt,
    String? staffPhone,
  }) = _ShopStaffModel;
}
