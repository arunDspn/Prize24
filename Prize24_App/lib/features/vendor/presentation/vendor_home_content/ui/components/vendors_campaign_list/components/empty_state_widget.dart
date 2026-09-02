import 'package:flutter/material.dart';
import 'package:prize24_app/configs/assets.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state illustration
            Image.asset(AppAssets.campaignPlaceholder1),
            // Container(
            //   width: 120,
            //   height: 120,
            //   decoration: BoxDecoration(
            //     color: theme.colorScheme.surface,
            //     borderRadius: BorderRadius.circular(60),
            //     border: Border.all(
            //       color: theme.colorScheme.primary.withOpacity(0.3),
            //       width: 2,
            //     ),
            //   ),
            //   child: Icon(
            //     Icons.campaign_outlined,
            //     size: 60,
            //     color: theme.colorScheme.primary.withOpacity(0.7),
            //   ),
            // ),

            const SizedBox(height: 24),

            // Title
            Text(
              'Your first campaign starts here',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy',
              ),
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              'Launch campaigns to boost reach and engagement.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 16,
                fontFamily: 'Gilroy',
                height: 1.4,
              ),
            ),

            const SizedBox(height: 32),

            // Action button
            // Container(
            //   decoration: BoxDecoration(
            //     color: theme.colorScheme.primary,
            //     borderRadius: BorderRadius.circular(12),
            //     boxShadow: [
            //       BoxShadow(
            //         color: theme.colorScheme.primary.withOpacity(0.3),
            //         blurRadius: 8,
            //         offset: const Offset(0, 4),
            //       ),
            //     ],
            //   ),
            //   child: Material(
            //     color: Colors.transparent,
            //     child: InkWell(
            //       borderRadius: BorderRadius.circular(12),
            //       onTap: () {
            //         // This will be handled by the parent widget
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 24, vertical: 12),
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Icon(
            //               Icons.add,
            //               color: theme.colorScheme.onPrimary,
            //               size: 20,
            //             ),
            //             const SizedBox(width: 8),
            //             Text(
            //               'Create Campaign',
            //               style: TextStyle(
            //                 color: theme.colorScheme.onPrimary,
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w600,
            //                 fontFamily: 'Gilroy',
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
