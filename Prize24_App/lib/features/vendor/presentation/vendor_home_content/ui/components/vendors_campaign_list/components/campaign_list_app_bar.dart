import 'package:flutter/material.dart';

class CampaignListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CampaignListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      elevation: 0,
      title: Text(
        'My Campaigns',
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Gilroy',
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Implement sort functionality
          },
          icon: Icon(
            Icons.sort,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO: Implement more options
          },
          icon: Icon(
            Icons.more_vert,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
