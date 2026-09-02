part of '../staff_request_send_page.dart';

class _StaffRequestCard extends StatelessWidget {
  const _StaffRequestCard({
    required this.request,
    required this.onCancel,
  });

  final StaffRequestSendModel request;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      theme.colorScheme.primary.withValues(alpha: 0.1),
                  child: Text(
                    request.receiverName.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.receiverName,
                        style: const TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _StatusChip(status: request.status),
                    ],
                  ),
                ),
                if (request.status == StaffRequestStatus.pending)
                  IconButton(
                    onPressed: onCancel,
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: theme.colorScheme.error,
                    ),
                    tooltip: 'Cancel Request',
                  ),
              ],
            ),
            ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
            ],
            // if (request.staffEmail != null)
            //   _InfoRow(
            //     icon: Icons.email_outlined,
            //     label: 'Email',
            //     value: request.staffEmail!,
            //   ),
            // if (request.phoneNumber != null)
            //   _InfoRow(
            //     icon: Icons.phone_outlined,
            //     label: 'Phone',
            //     value: request.phoneNumber!,
            //   ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.access_time,
              label: 'Requested',
              value: _formatDate(request.requestedAt.toIso8601String()),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateString;
    }
  }
}
