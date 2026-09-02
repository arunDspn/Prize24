import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prize24_app/features/clubs/domain/models/club_member_vendor_data_model.dart';

class ClubMemberDetailPage extends StatelessWidget {
  const ClubMemberDetailPage({
    required this.clubMemberData,
    super.key,
  });

  final ClubMemberVendorDataModel clubMemberData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Member Detail'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        clubMemberData.userName.isNotEmpty
                            ? clubMemberData.userName[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      clubMemberData.userName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'User ID: ${clubMemberData.userId}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Streak Information
            Text(
              'Streak Information',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  _buildInfoTile(
                    context,
                    icon: Icons.local_fire_department,
                    iconColor: Colors.orange,
                    title: 'Total Streak',
                    value: '${clubMemberData.streakTotal}',
                  ),
                  const Divider(height: 1),
                  _buildInfoTile(
                    context,
                    icon: Icons.calendar_today,
                    iconColor: Colors.blue,
                    title: 'Consecutive Days',
                    value: '${clubMemberData.consecutiveDays}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Activity Dates
            Text(
              'Activity Dates',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  _buildInfoTile(
                    context,
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    title: 'Last Check-In',
                    value: clubMemberData.lastCheckInDate != null
                        ? dateFormat.format(clubMemberData.lastCheckInDate!)
                        : 'No check-in yet',
                  ),
                  const Divider(height: 1),
                  _buildInfoTile(
                    context,
                    icon: Icons.card_giftcard,
                    iconColor: Colors.purple,
                    title: 'Last Bonus',
                    value: clubMemberData.lastBonusDate != null
                        ? dateFormat.format(clubMemberData.lastBonusDate!)
                        : 'No bonus yet',
                  ),
                  const Divider(height: 1),
                  _buildInfoTile(
                    context,
                    icon: Icons.group_add,
                    iconColor: Colors.teal,
                    title: 'Joined At',
                    value: dateFormat.format(clubMemberData.joinedAt),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
