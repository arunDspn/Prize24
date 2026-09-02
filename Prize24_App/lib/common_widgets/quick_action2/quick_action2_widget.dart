import 'package:flutter/material.dart';

/// Data class for individual quick action items in grid layout
class QuickAction2Item {
  const QuickAction2Item({
    required this.icon,
    required this.label,
    required this.iconBackgroundColor,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  /// Icon to display
  final IconData icon;

  /// Label/title text
  final String label;

  /// Background color around the icon
  final Color iconBackgroundColor;

  /// Icon color (default: white)
  final Color iconColor;

  /// Callback when action is tapped
  final VoidCallback onTap;
}

/// Quick Actions 2 Widget - Grid Layout
///
/// A 2-column grid layout of action cards with customizable icons,
/// labels, and colors. Used for quick access to common actions.
///
/// Example usage:
/// ```dart
/// QuickAction2Widget(
///   title: 'Quick Actions',
///   actions: [
///     QuickAction2Item(
///       icon: Icons.edit,
///       label: 'Edit Shop',
///       iconBackgroundColor: Colors.black,
///       onTap: () {},
///     ),
///     QuickAction2Item(
///       icon: Icons.people,
///       label: 'Manage Staff',
///       iconBackgroundColor: Colors.blue,
///       onTap: () {},
///     ),
///   ],
/// )
/// ```
class QuickAction2Widget extends StatelessWidget {
  const QuickAction2Widget({
    required this.actions,
    this.title = 'Quick Actions',
    super.key,
  });

  /// Title displayed above the quick actions
  final String title;

  /// List of quick action items to display (2-column grid)
  final List<QuickAction2Item> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'Gilroy',
              color: colorScheme.onSurface,
            ),
          ),
        ),

        // Grid of actions (2 columns)
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.5,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            return _QuickAction2Card(
              action: actions[index],
              theme: theme,
              colorScheme: colorScheme,
            );
          },
        ),
      ],
    );
  }
}

/// Individual Quick Action 2 Card Widget
class _QuickAction2Card extends StatelessWidget {
  const _QuickAction2Card({
    required this.action,
    required this.theme,
    required this.colorScheme,
  });

  final QuickAction2Item action;
  final ThemeData theme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Icon with colored background
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: action.iconBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  action.icon,
                  color: action.iconColor,
                  size: 28,
                ),
              ),

              const SizedBox(width: 16),

              // Label
              Expanded(
                child: Text(
                  action.label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy',
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
