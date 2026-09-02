part of '../staff_request_send_page.dart';

class _RequestsList extends ConsumerWidget {
  const _RequestsList({
    required this.requests,
    required this.shopId,
  });

  final List<StaffRequestSendModel> requests;
  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _StaffRequestCard(
            request: request,
            onCancel: () => _showCancelDialog(context, ref, request, shopId),
          ),
        );
      },
    );
  }

  void _showCancelDialog(
    BuildContext context,
    WidgetRef ref,
    StaffRequestSendModel request,
    String shopId,
  ) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Cancel Request',
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to cancel the staff request sent to ${request.receiverName}?',
            style: const TextStyle(
              fontFamily: 'Gilroy',
            ),
          ),
          actions: [
            TOutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Keep Request',
              width: 120,
              height: 40,
            ),
            const SizedBox(width: 8),
            TPrimaryButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _cancelRequest(context, ref, request, shopId);
              },
              text: 'Cancel Request',
              backgroundColor: Theme.of(context).colorScheme.error,
              width: 140,
              height: 40,
            ),
          ],
        );
      },
    );
  }

  Future<void> _cancelRequest(
    BuildContext context,
    WidgetRef ref,
    StaffRequestSendModel request,
    String shopId,
  ) async {
    try {
      await ref
          .read(staffRequestSendControllerProvider(shopId: shopId).notifier)
          .cancelRequest(request.receiverId);

      if (context.mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       'Request to ${request.receiverName} has been cancelled',
        //       style: const TextStyle(fontFamily: 'Gilroy'),
        //     ),
        //     backgroundColor: Theme.of(context).colorScheme.primary,
        //   ),
        // );
        showToastAtTop(
          context,
          'Request to ${request.receiverName} has been cancelled',
          true,
        );
      }
    } catch (error) {
      if (context.mounted) {
     
        showToastAtTop(
          context,
          'Failed to cancel request',
          false,
        );
      }
    }
  }
}
