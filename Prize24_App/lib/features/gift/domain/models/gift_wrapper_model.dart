import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
part 'gift_wrapper_model.freezed.dart';

@freezed
abstract class AutoRedeemableGift with _$AutoRedeemableGift {
  const factory AutoRedeemableGift({
    required GiftModel gift,
  }) = _AutoRedeemableGift;
}
