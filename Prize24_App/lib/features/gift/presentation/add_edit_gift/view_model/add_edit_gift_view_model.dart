import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/gift/domain/use_cases/create_gift/create_gift_usecase.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_edit_gift_view_model.freezed.dart';
part 'add_edit_gift_view_model.g.dart';

/// State class for Add/Edit Gift form
@freezed
abstract class AddEditGiftState with _$AddEditGiftState {
  const factory AddEditGiftState({
    // Basic form fields
    @Default('') String giftName,
    @Default('') String description,
    @Default('1') String totalGifts,
    @Default(true) bool isRedeemable,
    @Default('') String plugSlugName,

    // Collections
    @Default([]) List<GiftCodeData> giftCodes,
    @Default([]) List<String> giftPayloads,
    @Default([]) List<ShopModel> selectedShops,

    // UI State
    @Default(false) bool isLoading,
    @Default(false) bool isSubmitting,
    String? errorMessage,

    // Form validation
    @Default({}) Map<String, String> fieldErrors,

    // Edit mode data
    GiftModel? existingGift,
  }) = _AddEditGiftState;
}

/// Data class for gift codes with payloads
@freezed
abstract class GiftCodeData with _$GiftCodeData {
  const factory GiftCodeData({
    @Default('') String code,
    @Default('') String payload,
  }) = _GiftCodeData;
}

/// Add/Edit Gift View Model
@riverpod
class AddEditGiftViewModel extends _$AddEditGiftViewModel {
  @override
  AddEditGiftState build() {
    return const AddEditGiftState();
  }

  /// Initialize the form for editing an existing gift
  /// TODO: Implement when GiftModel structure is finalized
  // void initializeForEdit(GiftModel gift) {
  //   // Implementation will be added once GiftModel structure is confirmed
  // }

  /// Update basic form fields
  void updateGiftName(String value) {
    state = state.copyWith(
      giftName: value,
      fieldErrors: Map<String, String>.from(state.fieldErrors)
        ..remove('giftName'),
    );
  }

  void updateDescription(String value) {
    state = state.copyWith(
      description: value,
      fieldErrors: Map<String, String>.from(state.fieldErrors)
        ..remove('description'),
    );
  }

  void updatePlugSlugName(String value) {
    state = state.copyWith(
      plugSlugName: value,
      fieldErrors: Map<String, String>.from(state.fieldErrors)
        ..remove('plugSlugName'),
    );
  }

  void updateTotalGifts(String value, {GiftType? giftType}) {
    final newErrors = Map<String, String>.from(state.fieldErrors)
      ..remove('totalGifts');

    state = state.copyWith(
      totalGifts: value,
      fieldErrors: newErrors,
    );

    // Update payloads for auto non-redeemable gifts
    if (giftType == GiftType.auto && !state.isRedeemable) {
      final totalCount = int.tryParse(value) ?? 0;
      final newPayloads = <String>[];

      // Keep existing payloads up to the new count
      for (int i = 0; i < totalCount; i++) {
        if (i < state.giftPayloads.length) {
          newPayloads.add(state.giftPayloads[i]);
        } else {
          newPayloads.add('');
        }
      }

      state = state.copyWith(giftPayloads: newPayloads);
    }

    // Update gift codes for code type gifts
    if (giftType == GiftType.code) {
      final totalCount = int.tryParse(value) ?? 0;
      final newCodes = <GiftCodeData>[];

      // Keep existing codes up to the new count
      for (int i = 0; i < totalCount; i++) {
        if (i < state.giftCodes.length) {
          newCodes.add(state.giftCodes[i]);
        } else {
          newCodes.add(const GiftCodeData());
        }
      }

      state = state.copyWith(giftCodes: newCodes);
    }
  }

  void toggleRedeemable(bool value, {GiftType? giftType}) {
    state = state.copyWith(
      isRedeemable: value,
      // Clear data that's not relevant for the new redeemability state
      selectedShops: value ? state.selectedShops : [],
      giftPayloads: value ? [] : state.giftPayloads,
    );

    // For code gifts, update the payload field in gift codes
    if (giftType == GiftType.code) {
      final updatedCodes = state.giftCodes
          .map((code) => value ? code.copyWith(payload: '') : code)
          .toList();

      state = state.copyWith(giftCodes: updatedCodes);
    }
  }

  /// Gift codes management (for code type gifts)
  void addGiftCode() {
    final newCodes = List<GiftCodeData>.from(state.giftCodes);
    newCodes.add(const GiftCodeData());
    state = state.copyWith(
      giftCodes: newCodes,
      // Update total gifts to match number of codes
      totalGifts: newCodes.length.toString(),
    );
  }

  void removeGiftCode(int index) {
    if (state.giftCodes.length > 1) {
      final newCodes = List<GiftCodeData>.from(state.giftCodes);
      newCodes.removeAt(index);
      state = state.copyWith(
        giftCodes: newCodes,
        // Update total gifts to match number of codes
        totalGifts: newCodes.length.toString(),
      );
    }
  }

  void updateGiftCode(int index, String code) {
    if (index < state.giftCodes.length) {
      final newCodes = List<GiftCodeData>.from(state.giftCodes);
      newCodes[index] = newCodes[index].copyWith(code: code);
      state = state.copyWith(giftCodes: newCodes);
    }
  }

  void updateGiftCodePayload(int index, String payload) {
    // increment total gifts if payload is updated
    if (index < state.giftCodes.length) {
      final newCodes = List<GiftCodeData>.from(state.giftCodes);
      newCodes[index] = newCodes[index].copyWith(payload: payload);
      state = state.copyWith(
        giftCodes: newCodes,
      );
    }
  }

  /// Gift payloads management (for auto non-redeemable gifts)
  void updateGiftPayload(int index, String payload) {
    if (index < state.giftPayloads.length) {
      final newPayloads = List<String>.from(state.giftPayloads);
      newPayloads[index] = payload;
      state = state.copyWith(giftPayloads: newPayloads);
    }
  }

  /// Shop management (for redeemable gifts)
  void addSelectedShop(ShopModel shop) {
    if (!state.selectedShops.contains(shop)) {
      final newShops = List<ShopModel>.from(state.selectedShops);
      newShops.add(shop);
      state = state.copyWith(selectedShops: newShops);
    }
  }

  void removeSelectedShop(ShopModel shop) {
    final newShops = List<ShopModel>.from(state.selectedShops);
    newShops.remove(shop);
    state = state.copyWith(selectedShops: newShops);
  }

  void updateSelectedShops(List<ShopModel> shops) {
    state = state.copyWith(selectedShops: shops);
  }

  /// Form validation
  bool validateForm(GiftType giftType, {bool isPublicCampaign = false}) {
    final errors = <String, String>{};

    // Basic validation
    if (state.giftName.trim().isEmpty) {
      errors['giftName'] = 'Gift name is required';
    } else if (state.giftName.length > 100) {
      errors['giftName'] = 'Gift name must be less than 100 characters';
    }

    if (state.description.trim().isEmpty) {
      errors['description'] = 'Description is required';
    } else if (state.description.length > 500) {
      errors['description'] = 'Description must be less than 500 characters';
    }

    // Validate plug slug name for public campaigns
    if (isPublicCampaign && giftType == GiftType.code) {
      if (state.plugSlugName.trim().isEmpty) {
        errors['plugSlugName'] =
            'Plug slug name is required for public campaigns';
      } else {
        final slugPattern = RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$');
        final trimmedSlug = state.plugSlugName.trim().toLowerCase();
        if (!slugPattern.hasMatch(trimmedSlug)) {
          errors['plugSlugName'] =
              'Must be lowercase, alphanumeric, and separated by hyphens';
        } else if (trimmedSlug.length < 3) {
          errors['plugSlugName'] = 'Must be at least 3 characters long';
        } else if (trimmedSlug.length > 50) {
          errors['plugSlugName'] = 'Must be less than 50 characters';
        }
      }
    }

    final totalGifts = int.tryParse(state.totalGifts);
    if (state.totalGifts.trim().isEmpty) {
      errors['totalGifts'] = 'Total gifts is required';
    } else if (totalGifts == null || totalGifts < 1) {
      errors['totalGifts'] = 'Must be at least 1';
    } else if (totalGifts > 10000) {
      errors['totalGifts'] = 'Cannot exceed 10,000';
    }

    // Gift type specific validation
    if (giftType == GiftType.code) {
      _validateCodeGift(errors, totalGifts);
    } else {
      _validateAutoGift(errors, totalGifts);
    }

    // Redeemable gift validation
    if (state.isRedeemable && state.selectedShops.isEmpty) {
      errors['shops'] =
          'At least one shop must be selected for redeemable gifts';
    }

    state = state.copyWith(fieldErrors: errors);
    return errors.isEmpty;
  }

  void _validateCodeGift(Map<String, String> errors, int? totalGifts) {
    if (state.giftCodes.isEmpty) {
      errors['codes'] = 'At least one gift code is required';
      return;
    }

    // Check for empty codes and duplicates
    final Set<String> uniqueCodes = {};
    for (int i = 0; i < state.giftCodes.length; i++) {
      final code = state.giftCodes[i].code.trim();

      if (code.isEmpty) {
        errors['code_$i'] = 'Code ${i + 1} cannot be empty';
      } else if (uniqueCodes.contains(code)) {
        errors['code_$i'] = 'Duplicate code';
      } else {
        uniqueCodes.add(code);
      }

      // Validate payload for non-redeemable
      if (!state.isRedeemable) {
        final payload = state.giftCodes[i].payload.trim();
        if (payload.isEmpty) {
          errors['payload_$i'] = 'Payload ${i + 1} is required';
        } else if (payload.length < 10) {
          errors['payload_$i'] =
              'Payload ${i + 1} must be at least 10 characters';
        }
      }
    }

    // Check if total gifts matches number of codes
    if (totalGifts != null && totalGifts != state.giftCodes.length) {
      errors['totalGifts'] = 'Total gifts must match number of codes';
    }
  }

  void _validateAutoGift(Map<String, String> errors, int? totalGifts) {
    if (!state.isRedeemable) {
      // Validate payloads
      if (totalGifts != null) {
        if (state.giftPayloads.length != totalGifts) {
          errors['payloads'] = 'Number of payloads must match total gifts';
        } else {
          for (int i = 0; i < state.giftPayloads.length; i++) {
            final payload = state.giftPayloads[i].trim();
            if (payload.isEmpty) {
              errors['payload_$i'] = 'Payload ${i + 1} is required';
            } else if (payload.length < 10) {
              errors['payload_$i'] =
                  'Payload ${i + 1} must be at least 10 characters';
            }
          }
        }
      }
    }
  }

  /// Create or update gift
  Future<GiftModel?> saveGift({
    required GiftType giftType,
    required String campaignId,
    required String campaignName,
    bool isPublicCampaign = false,
  }) async {
    if (!validateForm(giftType, isPublicCampaign: isPublicCampaign)) {
      return null;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      final userId = (ref.read(authControllerProvider).requireValue!).userId;
      final GiftModel result;

      if (state.existingGift != null) {
        // Update existing gift
        throw UnimplementedError('Update gift not implemented');
      } else {
        // Create new gift

        // Gift Type is AUTO and isRedeemable is TRUE
        if (giftType == GiftType.auto && state.isRedeemable) {
          final usecase = ref.read(createGiftUsecaseProvider);
          final gift = GiftModel(
            id: null,
            name: state.giftName.trim(),
            description: state.description.trim(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            campaignId: campaignId,
            campaignName: campaignName,
            totalQuantity: int.parse(state.totalGifts),
            remainingQuantity: int.parse(state.totalGifts),
            giftType: giftType.toShortString(),
            isRedeemable: true,
            publicgSlug: isPublicCampaign
                ? state.plugSlugName.trim().toLowerCase()
                : null,
            supportedShops: state.selectedShops
                .map(
                  (shop) => SupportedShopModel(
                    id: shop.id!,
                    name: shop.shopName,
                    shopAddress: shop.shopAddress,
                    shopPhone: shop.shopPhone,
                  ),
                )
                .toList(),
            userId: userId,
          );

          result = await usecase.createAutoRedeemableGift(gift: gift);
        }

        // Gift Type is AUTO and isRedeemable is FALSE
        else if (giftType == GiftType.auto && !state.isRedeemable) {
          final usecase = ref.read(createGiftUsecaseProvider);
          final gift = GiftModel(
            id: null,
            name: state.giftName.trim(),
            description: state.description.trim(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            campaignId: campaignId,
            campaignName: campaignName,
            totalQuantity: int.parse(state.totalGifts),
            remainingQuantity: int.parse(state.totalGifts),
            giftType: giftType.toShortString(),
            isRedeemable: false,
            publicgSlug: isPublicCampaign
                ? state.plugSlugName.trim().toLowerCase()
                : null,
            userId: userId,
          );

          final autoGiftPayloads = state.giftPayloads
              .map(
                (payload) => AutoGiftPayloadModel(
                  id: null,
                  content: payload.trim(),
                ),
              )
              .toList();
          result = await usecase.createAutoNonRedeemableGift(
            gift: gift,
            autoGiftPayloads: autoGiftPayloads,
          );
        }

        // Gift Type is CODE and isRedeemable is TRUE OR FALSE
        else if (giftType == GiftType.code) {
          final usecase = ref.read(createGiftUsecaseProvider);
          final gift = GiftModel(
            id: null,
            name: state.giftName.trim(),
            description: state.description.trim(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            campaignId: campaignId,
            campaignName: campaignName,
            totalQuantity: int.parse(state.totalGifts),
            remainingQuantity: int.parse(state.totalGifts),
            giftType: giftType.toShortString(),
            isRedeemable: state.isRedeemable,
            userId: userId,
            publicgSlug: isPublicCampaign
                ? state.plugSlugName.trim().toLowerCase()
                : null,
            supportedShops: state.isRedeemable
                ? state.selectedShops
                    .map(
                      (shop) => SupportedShopModel(
                        id: shop.id!,
                        name: shop.shopName,
                        shopAddress: shop.shopAddress,
                        shopPhone: shop.shopPhone,
                      ),
                    )
                    .toList()
                : null,
          );

          final codeGiftCodes = state.giftCodes
              .map(
                (codeData) => CodeGiftCodeModel(
                  id: null,
                  code: codeData.code.trim(),
                  isRedeemed: false,
                  payload: state.isRedeemable ? null : codeData.payload.trim(),
                ),
              )
              .toList();
          result = await usecase.createCodeGift(
            gift: gift,
            codeGiftCodes: codeGiftCodes,
          );
        } else {
          throw UnimplementedError('Unknown gift type or redeemability');
        }
      }

      state = state.copyWith(isSubmitting: false);
      return result;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return null;
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Reset form to initial state
  void resetForm() {
    state = const AddEditGiftState();
  }
}
