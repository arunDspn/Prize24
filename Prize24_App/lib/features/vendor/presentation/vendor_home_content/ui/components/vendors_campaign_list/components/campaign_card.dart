import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/view_model/current_campaign_selection_controller.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Modern color palette from HTML design
class _CampaignCardColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange500 = Color(0xFFF97316);
  static const Color violet50 = Color(0xFFF5F3FF);
  static const Color violet100 = Color(0xFFEDE9FE);
  static const Color violet500 = Color(0xFF8B5CF6);
  static const Color green500 = Color(0xFF22C55E);
}

class CampaignCard extends ConsumerWidget {
  final CampaignModel campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authControllerProvider).value;
    final isOwner = authUser?.userId == campaign.vendorId;
    final isAutoGift = campaign.allowedGiftType.name == 'auto';

    // Choose color scheme based on gift type
    final Color primaryColor = isAutoGift
        ? _CampaignCardColors.orange500
        : _CampaignCardColors.violet500;
    final Color bgLight = isAutoGift
        ? _CampaignCardColors.orange50
        : _CampaignCardColors.violet50;
    final Color borderLight = isAutoGift
        ? _CampaignCardColors.orange100
        : _CampaignCardColors.violet100;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          // Main Card
          GestureDetector(
            onTap: () {
              ref
                  .read(currentCampaignSelectionControllerProvider.notifier)
                  .selectCampaign(campaign);
              context.push(AppRoutes.vendorCampaignDetails, extra: campaign);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _CampaignCardColors.slate100,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                    spreadRadius: -2,
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Gradient Bar
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isAutoGift
                            ? [
                                _CampaignCardColors.brandStart,
                                _CampaignCardColors.brandEnd,
                              ]
                            : [
                                _CampaignCardColors.violet500,
                                const Color(0xFFD946EF),
                              ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Section
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon Box
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: bgLight,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: borderLight,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                isAutoGift
                                    ? Icons.campaign_rounded
                                    : Icons.workspace_premium_rounded,
                                color: primaryColor,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Title & Vendor
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 40,
                                ), // Space for edit button
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      campaign.name,
                                      style: const TextStyle(
                                        color: _CampaignCardColors.slate900,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Plus Jakarta Sans',
                                        height: 1.3,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.storefront_rounded,
                                          size: 14,
                                          color: _CampaignCardColors.slate400,
                                        ),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            campaign.vendorName,
                                            style: const TextStyle(
                                              color:
                                                  _CampaignCardColors.slate500,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Plus Jakarta Sans',
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Description
                        if (campaign.description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Text(
                              campaign.description,
                              style: const TextStyle(
                                color: _CampaignCardColors.slate600,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Plus Jakarta Sans',
                                height: 1.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        // Stats Bar
                        // Container(
                        //   padding: const EdgeInsets.all(16),
                        //   decoration: BoxDecoration(
                        //     color: _CampaignCardColors.slate50,
                        //     borderRadius: BorderRadius.circular(16),
                        //     border: Border.all(
                        //       color: _CampaignCardColors.slate100,
                        //       width: 1,
                        //     ),
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       // Participants Stat
                        //       Expanded(
                        //         child: _buildModernStatItem(
                        //           icon: Icons.people_rounded,
                        //           label: 'Joined',
                        //           value: _formatNumber(
                        //             campaign.totalParticipants,
                        //           ),
                        //         ),
                        //       ),

                        //       // Vertical Divider
                        //       Container(
                        //         width: 1,
                        //         height: 32,
                        //         color: _CampaignCardColors.slate200.withOpacity(
                        //           0.6,
                        //         ),
                        //       ),

                        //       // Gifts Stat
                        //       Expanded(
                        //         child: _buildModernStatItem(
                        //           icon: isAutoGift
                        //               ? Icons.card_giftcard_rounded
                        //               : Icons.confirmation_number_rounded,
                        //           label: isAutoGift ? 'Gifts' : 'Codes',
                        //           value: _formatNumber(campaign.totalGifts),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 24),

                        // Footer Meta
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Mechanism Badge
                            _buildMechanismBadge(
                              isAutoGift,
                              bgLight,
                              borderLight,
                              primaryColor,
                            ),

                            // Badges (Owner, Shared, Status)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Owner Badge
                                if (isOwner) ...[
                                  _buildOwnerBadge(),
                                  const SizedBox(width: 8),
                                ],
                                // Shared Badge (shown when not owner)
                                if (!isOwner) ...[
                                  _buildSharedBadge(),
                                  const SizedBox(width: 8),
                                ],
                                // Status Badge
                                _buildStatusBadge(),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isOwner)
            // Edit Button (Floating)
            Positioned(
              top: 20,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  context.push(AppRoutes.addVendorCampaign, extra: campaign);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _CampaignCardColors.slate100,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    size: 18,
                    color: _CampaignCardColors.slate400,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModernStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 18, color: _CampaignCardColors.slate400),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: _CampaignCardColors.slate400,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                fontFamily: 'Plus Jakarta Sans',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                color: _CampaignCardColors.slate900,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMechanismBadge(
    bool isAutoGift,
    Color bgLight,
    Color borderLight,
    Color primaryColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderLight, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAutoGift ? Icons.auto_awesome_rounded : Icons.qr_code_2_rounded,
            size: 12,
            color: primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            isAutoGift ? 'Auto Reward' : 'Unique Code',
            style: const TextStyle(
              color: _CampaignCardColors.slate600,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final isPublic = campaign.visibility.name == 'public';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPublic ? Icons.public_rounded : Icons.lock_rounded,
          size: 14,
          color: isPublic
              ? _CampaignCardColors.green500
              : _CampaignCardColors.slate400,
        ),
        const SizedBox(width: 6),
        Text(
          isPublic ? 'PUBLIC' : 'PRIVATE',
          style: const TextStyle(
            color: _CampaignCardColors.slate500,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            fontFamily: 'Plus Jakarta Sans',
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildOwnerBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFDCEEFC), // blue-100
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBAE6FD), // blue-200
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.stars_rounded,
            size: 12,
            color: Color(0xFF0284C7), // blue-600
          ),
          const SizedBox(width: 6),
          Text(
            'OWNER',
            style: const TextStyle(
              color: Color(0xFF075985), // blue-800
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'Plus Jakarta Sans',
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7), // green-100
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBBF7D0), // green-200
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.share_rounded,
            size: 12,
            color: Color(0xFF16A34A), // green-600
          ),
          const SizedBox(width: 6),
          Text(
            'SHARED',
            style: const TextStyle(
              color: Color(0xFF15803D), // green-700
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'Plus Jakarta Sans',
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k'.replaceAll('.0k', 'k');
    }
    return number.toString();
  }
}
