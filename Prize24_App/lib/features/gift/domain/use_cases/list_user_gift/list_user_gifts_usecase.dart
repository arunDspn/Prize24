import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/core/models/paginated_result.dart';
import 'package:prize24_app/features/gift/data/repository/i_gift_repository.dart';
import 'package:prize24_app/features/gift/domain/models/user_gift_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_user_gifts_usecase.g.dart';

@riverpod
ListUserGiftsUsecase listUserGiftsUsecase(Ref ref) {
  final giftRepository = ref.watch(giftRepositoryProvider);
  return ListUserGiftsUsecase(giftRepository: giftRepository);
}

/// Use case for fetching all gifts that belong to a specific user
class ListUserGiftsUsecase {
  ListUserGiftsUsecase({required IGiftRepository giftRepository})
    : _giftRepository = giftRepository;

  final IGiftRepository _giftRepository;

  /// Fetches a page of gifts that belong to a specific user
  ///
  /// [userId]: The ID of the user to fetch gifts for
  /// [cursor]: Opaque cursor from previous call for pagination
  /// [limit]: Number of gifts per page
  /// Returns a [PaginatedResult] of [UserGiftModel] objects
  Future<PaginatedResult<UserGiftModel>> call({
    required String userId,
    Object? cursor,
    int limit = 20,
  }) async {
    try {
      _validateUserId(userId);

      return await _giftRepository.fetchUsersAllGifts(
        userId: userId,
        cursor: cursor,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Failed to fetch user gifts: $e');
    }
  }

  /// Validates the user ID parameter
  void _validateUserId(String userId) {
    if (userId.trim().isEmpty) {
      throw Exception('User ID cannot be empty');
    }

    if (userId.length < 3) {
      throw Exception('User ID must be at least 3 characters long');
    }
  }
}
