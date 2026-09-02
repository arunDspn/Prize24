import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/vendor/data/repository/i_vendor_repository.dart';
import 'package:prize24_app/features/vendor/data/repository/vendor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'become_a_vendor_usecase.g.dart';

@riverpod
BecomeAVendorUseCase becomeAVendorUsecase(Ref ref) {
  final repository = ref.watch(vendorRepositoryProvider);
  return BecomeAVendorUseCase(repository);
}

/// Use case for submitting referral codes
class BecomeAVendorUseCase {
  const BecomeAVendorUseCase(this._repository);
  final IVendorRepository _repository;

  Future<void> call({
    required String userId,
    required String phoneNumber,
  }) async {
    try {
      if (userId.trim().isEmpty) {
        throw Exception('User ID cannot be empty');
      }

      if (phoneNumber.trim().isEmpty) {
        throw Exception('Phone number cannot be empty');
      }

      final result = await _repository.becomeAVendor(
        userId: userId.trim(),
        vendorPhoneNumber: phoneNumber.trim(),
      );

      return result;
    } catch (e) {
      throw Exception('Failed to become a vendor: $e');
    }
  }
}
