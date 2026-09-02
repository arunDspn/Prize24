import 'package:flutter/material.dart';
import 'package:prize24_app/common_widgets/quick_action2/quick_action2_widget.dart';

/// Example screen demonstrating QuickAction2Widget usage
class QuickAction2ExampleScreen extends StatelessWidget {
  const QuickAction2ExampleScreen({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Actions 2 Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Shop Management Actions
            QuickAction2Widget(
              title: 'Quick Actions',
              actions: [
                QuickAction2Item(
                  icon: Icons.store,
                  label: 'Edit Shop',
                  iconBackgroundColor: Colors.black,
                  onTap: () => _showSnackBar(context, 'Edit Shop tapped'),
                ),
                QuickAction2Item(
                  icon: Icons.people,
                  label: 'Manage Staff',
                  iconBackgroundColor: const Color(0xFF4A90E2),
                  onTap: () => _showSnackBar(context, 'Manage Staff tapped'),
                ),
                QuickAction2Item(
                  icon: Icons.local_offer,
                  label: 'Shop Offers',
                  iconBackgroundColor: Colors.grey.shade600,
                  onTap: () => _showSnackBar(context, 'Shop Offers tapped'),
                ),
                QuickAction2Item(
                  icon: Icons.qr_code,
                  label: 'Shop QR Code',
                  iconBackgroundColor: const Color(0xFF00BCD4),
                  onTap: () => _showSnackBar(context, 'Shop QR Code tapped'),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Example 2: User Profile Actions
            QuickAction2Widget(
              title: 'Account Settings',
              actions: [
                QuickAction2Item(
                  icon: Icons.person,
                  label: 'Edit Profile',
                  iconBackgroundColor: Colors.purple,
                  onTap: () => _showSnackBar(context, 'Edit Profile tapped'),
                ),
                QuickAction2Item(
                  icon: Icons.security,
                  label: 'Security',
                  iconBackgroundColor: Colors.orange,
                  onTap: () => _showSnackBar(context, 'Security tapped'),
                ),
                QuickAction2Item(
                  icon: Icons.notifications,
                  label: 'Notifications',
                  iconBackgroundColor: Colors.green,
                  onTap: () => _showSnackBar(context, 'Notifications tapped'),
                ),
                QuickAction2Item(
                  icon: Icons.help,
                  label: 'Help & Support',
                  iconBackgroundColor: Colors.red,
                  onTap: () => _showSnackBar(context, 'Help tapped'),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Example 3: Campaign Actions (2 items)
            QuickAction2Widget(
              title: 'Campaign Tools',
              actions: [
                QuickAction2Item(
                  icon: Icons.add_circle,
                  label: 'Create Campaign',
                  iconBackgroundColor: theme.colorScheme.primary,
                  onTap: () => _showSnackBar(context, 'Create Campaign tapped'),
                ),
                QuickAction2Item(
                  icon: Icons.bar_chart,
                  label: 'View Analytics',
                  iconBackgroundColor: Colors.indigo,
                  onTap: () => _showSnackBar(context, 'View Analytics tapped'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
