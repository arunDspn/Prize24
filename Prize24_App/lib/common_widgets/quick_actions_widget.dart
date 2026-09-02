import 'package:flutter/material.dart';

/// Data class for individual quick action items
class QuickActionItem {
  const QuickActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
}

/// Reusable Quick Actions Widget
///
/// A horizontal scrollable list of action cards that can be used
/// across different pages to provide quick access to common actions.
class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({
    required this.title,
    required this.actions,
    this.titleIcon = Icons.flash_on,
    super.key,
  });

  /// Title displayed above the quick actions
  final String title;

  /// Icon displayed next to the title
  final IconData titleIcon;

  /// List of quick action items to display
  final List<QuickActionItem> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              titleIcon,
              color: colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Gilroy',
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actions.map((action) {
              final index = actions.indexOf(action);
              return Row(
                children: [
                  if (index > 0) const SizedBox(width: 12),
                  _QuickActionCard(
                    colorScheme: colorScheme,
                    theme: theme,
                    action: action,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

/// Individual Quick Action Card Widget
class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.colorScheme,
    required this.theme,
    required this.action,
  });

  final ColorScheme colorScheme;
  final ThemeData theme;
  final QuickActionItem action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 100,
      child: Card(
        elevation: 0,
        color: colorScheme.primaryContainer.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: action.onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  action.icon,
                  color: colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  action.title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy',
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  action.subtitle,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontFamily: 'Gilroy',
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
