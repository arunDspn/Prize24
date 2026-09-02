import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:prize24_app/common_widgets/quick_actions_widget.dart';
import 'package:prize24_app/features/clubs/domain/models/club_model.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/vendor_club_detail/ui/components/club_members/vendor_club_member_list_view.dart';
import 'package:prize24_app/routing/app_routes.dart';

class VendorClubDetailPage extends StatelessWidget {
  const VendorClubDetailPage({
    required this.club,
    super.key,
  });

  final ClubModel club;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(club.name),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              color: theme.colorScheme.primaryContainer,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    club.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    club.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: QuickActionsWidget(
                title: 'Quick Actions',
                titleIcon: Icons.bolt,
                actions: [
                  QuickActionItem(
                    icon: Icons.person_add,
                    title: 'Add Members',
                    subtitle: 'Invite users',
                    onTap: () => _handleAddMembers(context),
                  ),
                  QuickActionItem(
                    icon: Icons.check_circle_outline,
                    title: 'User Check-in',
                    subtitle: 'Scan QR code',
                    onTap: () => _handleUserCheckin(context),
                  ),
                ],
              ),
            ),

            // Club Information
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Information Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Club Information',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(height: 24),
                          _buildInfoRow(
                            context,
                            icon: Icons.calendar_today,
                            label: 'Gift Day',
                            value: 'Day ${club.giftDay}',
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            context,
                            icon: Icons.people,
                            label: 'Total Members',
                            value: club.totalMembers.toString(),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            context,
                            icon: Icons.access_time,
                            label: 'Created',
                            value: dateFormat.format(club.createdAt),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            context,
                            icon: Icons.update,
                            label: 'Last Updated',
                            value: dateFormat.format(club.updatedAt),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Campaign Information Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.campaign,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Campaign Details',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          _buildLabelValue(
                            context,
                            'Campaign Name',
                            club.campaignName,
                          ),
                          const SizedBox(height: 12),
                          _buildLabelValue(
                            context,
                            'Campaign Description',
                            club.campaignDescription,
                          ),
                          const SizedBox(height: 12),
                          _buildLabelValue(
                            context,
                            'Campaign ID',
                            club.campaignId,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Multiplier Streak Card (if available)
                  if (club.multipierStreak != null)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: theme.colorScheme.secondary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Multiplier Streak',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            _buildInfoRow(
                              context,
                              icon: Icons.trending_up,
                              label: 'Bonus Increment',
                              value: '${club.multipierStreak!.bonusIncrement}x',
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              context,
                              icon: Icons.event,
                              label: 'Days Required',
                              value:
                                  '${club.multipierStreak!.daysRequired} days',
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Shops List Card
                  // Card(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(
                  //               Icons.store,
                  //               color: theme.colorScheme.tertiary,
                  //             ),
                  //             const SizedBox(width: 8),
                  //             Text(
                  //               'Participating Shops',
                  //               style: theme.textTheme.titleLarge?.copyWith(
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //             const Spacer(),
                  //             // Chip(
                  //             //   label: Text('${club.shops.length}'),
                  //             //   backgroundColor:
                  //             //       theme.colorScheme.secondaryContainer,
                  //             // ),
                  //           ],
                  //         ),
                  //         const Divider(height: 24),
                  //         // if (club.shops.isEmpty)
                  //         //   Center(
                  //         //     child: Padding(
                  //         //       padding: const EdgeInsets.all(24),
                  //         //       child: Column(
                  //         //         children: [
                  //         //           Icon(
                  //         //             Icons.store_mall_directory_outlined,
                  //         //             size: 48,
                  //         //             color: theme.colorScheme.outline,
                  //         //           ),
                  //         //           const SizedBox(height: 8),
                  //         //           Text(
                  //         //             'No shops added yet',
                  //         //             style:
                  //         //                 theme.textTheme.bodyMedium?.copyWith(
                  //         //               color: theme.colorScheme.outline,
                  //         //             ),
                  //         //           ),
                  //         //         ],
                  //         //       ),
                  //         //     ),
                  //         //   )
                  //         // else
                  //         //   ListView.separated(
                  //         //     shrinkWrap: true,
                  //         //     physics: const NeverScrollableScrollPhysics(),
                  //         //     itemCount: club.shops.length,
                  //         //     separatorBuilder: (context, index) =>
                  //         //         const Divider(),
                  //         //     itemBuilder: (context, index) {
                  //         //       final shop = club.shops[index];
                  //         //       return ListTile(
                  //         //         contentPadding: EdgeInsets.zero,
                  //         //         leading: CircleAvatar(
                  //         //           backgroundColor:
                  //         //               theme.colorScheme.primaryContainer,
                  //         //           child: Icon(
                  //         //             Icons.store,
                  //         //             color:
                  //         //                 theme.colorScheme.onPrimaryContainer,
                  //         //           ),
                  //         //         ),
                  //         //         title: Text(
                  //         //           shop.shopName,
                  //         //           style: const TextStyle(
                  //         //             fontWeight: FontWeight.w600,
                  //         //           ),
                  //         //         ),
                  //         //         subtitle: Column(
                  //         //           crossAxisAlignment:
                  //         //               CrossAxisAlignment.start,
                  //         //           children: [
                  //         //             const SizedBox(height: 4),
                  //         //             Row(
                  //         //               children: [
                  //         //                 Icon(
                  //         //                   Icons.location_on,
                  //         //                   size: 14,
                  //         //                   color: theme.colorScheme.outline,
                  //         //                 ),
                  //         //                 const SizedBox(width: 4),
                  //         //                 Expanded(
                  //         //                   child: Text(
                  //         //                     shop.shopAddress,
                  //         //                     style: TextStyle(
                  //         //                       fontSize: 12,
                  //         //                       color:
                  //         //                           theme.colorScheme.outline,
                  //         //                     ),
                  //         //                   ),
                  //         //                 ),
                  //         //               ],
                  //         //             ),
                  //         //             const SizedBox(height: 2),
                  //         //             Row(
                  //         //               children: [
                  //         //                 Icon(
                  //         //                   Icons.phone,
                  //         //                   size: 14,
                  //         //                   color: theme.colorScheme.outline,
                  //         //                 ),
                  //         //                 const SizedBox(width: 4),
                  //         //                 Text(
                  //         //                   shop.phoneNumber,
                  //         //                   style: TextStyle(
                  //         //                     fontSize: 12,
                  //         //                     color: theme.colorScheme.outline,
                  //         //                   ),
                  //         //                 ),
                  //         //               ],
                  //         //             ),
                  //         //           ],
                  //         //         ),
                  //         //       );
                  //         //     },
                  //         //   ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 16),

                  // Club Members List
                  VendorClubMemberListView(club.id)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabelValue(
    BuildContext context,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.outline,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }

  // Quick Action Handlers
  void _handleAddMembers(BuildContext context) {
    context.push(AppRoutes.addUsersToClubByOwner, extra: club);
  }

  void _handleUserCheckin(BuildContext context) {
    context.push(AppRoutes.scanUsersForLoyaltyByClubOwner, extra: club);
  }
}
