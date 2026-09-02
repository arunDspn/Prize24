import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/shop/domain/i_shop_repository.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_request_send_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'staff_request_send_controller.g.dart';

@riverpod
class StaffRequestSendController extends _$StaffRequestSendController {
  @override
  FutureOr<List<StaffRequestSendModel>> build({
    required String shopId,
  }) {
    return _getMockStaffRequests(shopId);
  }

  /// Fetch staff requests from API
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final requests = await _getMockStaffRequests(shopId);
      state = AsyncValue.data(requests);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Cancel a staff request
  Future<void> cancelRequest(String staffUserId) async {
    if (state.isLoading) return;

    final currentValue = state.value;
    if (currentValue == null) return;

    try {
      // Optimistically update the UI by removing the item
      final updatedRequests = currentValue
          .where((request) => request.receiverId != staffUserId)
          .toList();
      state = AsyncValue.data(updatedRequests);

      // TODO: Call actual API to cancel the request
      await _cancelStaffRequestAPI(staffUserId);
    } catch (error) {
      // Revert on error
      state = AsyncValue.data(currentValue);
      rethrow;
    }
  }

  /// Mock data for development - replace with actual API calls
  Future<List<StaffRequestSendModel>> _getMockStaffRequests(
      String shopId) async {
    final data = ref
        .read(shopRepositoryProvider)
        .getShopStaffRequestsSent(shopId: shopId);

    return data;

    // await Future<void>.delayed(
    //     const Duration(milliseconds: 1500)); // Simulate network delay

    // return [
    //   StaffRequestSendModel(
    //     staffUserId: '1',
    //     staffName: 'John Doe',
    //     staffEmail: 'john.doe@example.com',
    //     phoneNumber: '+1234567890',
    //     requestedAt: '2024-01-15T10:30:00Z',
    //     status: StaffRequestStatus.pending,
    //   ),
    //   StaffRequestSendModel(
    //     staffUserId: '2',
    //     staffName: 'Jane Smith',
    //     staffEmail: 'jane.smith@example.com',
    //     phoneNumber: '+1234567891',
    //     requestedAt: '2024-01-14T14:20:00Z',
    //     status: StaffRequestStatus.pending,
    //   ),
    //   StaffRequestSendModel(
    //     staffUserId: '3',
    //     staffName: 'Mike Johnson',
    //     staffEmail: 'mike.johnson@example.com',
    //     requestedAt: '2024-01-13T09:15:00Z',
    //     status: StaffRequestStatus.accepted,
    //   ),
    //   StaffRequestSendModel(
    //     staffUserId: '4',
    //     staffName: 'Sarah Wilson',
    //     phoneNumber: '+1234567893',
    //     requestedAt: '2024-01-12T16:45:00Z',
    //     status: StaffRequestStatus.rejected,
    //   ),
    // ];
  }

  /// Mock API call to cancel staff request - replace with actual implementation
  Future<void> _cancelStaffRequestAPI(String staffUserId) async {
    await Future<void>.delayed(
        const Duration(milliseconds: 800)); // Simulate network delay

    // TODO: Implement actual API call
    // Example:
    // await apiService.cancelStaffRequest(staffUserId);

    // Simulate potential API error for testing
    // if (staffUserId == '1') {
    //   throw Exception('Failed to cancel request');
    // }
  }
}
