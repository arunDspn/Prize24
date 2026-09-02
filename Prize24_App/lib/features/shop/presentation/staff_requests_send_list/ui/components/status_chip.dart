part of '../staff_request_send_page.dart';

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final StaffRequestStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color chipColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case StaffRequestStatus.pending:
        chipColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange;
        icon = Icons.schedule;
        break;
      case StaffRequestStatus.accepted:
        chipColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case StaffRequestStatus.rejected:
        chipColor = theme.colorScheme.error.withValues(alpha: 0.1);
        textColor = theme.colorScheme.error;
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: textColor,
          ),
          const SizedBox(width: 4),
          Text(
            status.toShortString().toUpperCase(),
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
