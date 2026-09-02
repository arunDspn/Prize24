import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/campaign_gift_list/ui/campaign_gift_list_view.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/campaign_gift_list/view_model/campaign_gift_list_controller.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/vendor_scan_user/ui/vendor_scanner_for_user_gift_page.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/view_model/current_campaign_selection_controller.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/redeem_gift/ui/redeem_gift_page.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/vendors_campaign_list_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Custom color palette based on HTML design
class _DesignColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange500 = Color(0xFFF97316);
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color green500 = Color(0xFF22C55E);
  static const Color yellow500 = Color(0xFFEAB308);
}

enum _CampaignAppBarAction { activityLog }

class VendorCampaignDetailPage extends ConsumerWidget {
  const VendorCampaignDetailPage({
    // required this.campaign,
    super.key,
  });

  // final CampaignModel campaign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCampaign = ref.watch(
      currentCampaignSelectionControllerProvider,
    );

    return selectedCampaign.when(
      data: (campaign) {
        if (campaign != null) {
          return _buildBody(campaign, context, ref);
        } else {
          return const Scaffold(
            body: Center(child: Text('No campaign selected')),
          );
        }
      },
      error: (error, stackTrace) {
        return const Scaffold(
          body: Center(child: Text('Error loading campaign')),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: _DesignColors.brandStart),
        ),
      ),
    );
  }

  Widget _buildBody(
    CampaignModel campaign,
    BuildContext context,
    WidgetRef ref,
  ) {
    final userId = ref.read(authControllerProvider).requireValue!.userId;
    final isASharedCampaign = campaign.sharedVendors.any(
      (vendor) => vendor.vendorId == userId,
    );
    return Scaffold(
      backgroundColor: _DesignColors.slate50,
      appBar: _buildAppBar(context, campaign),
      floatingActionButton: ref
          .watch(campaignGiftListControllerProvider(campaignId: campaign.id!))
          .maybeWhen(
            data: (gifts) => gifts.length < 10
                ? _buildFloatingActionButton(context, campaign, ref)
                : null,
            orElse: () => null,
          ),

      // _buildFloatingActionButton(context, campaign, ref),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(isASharedCampaign, campaign),
            const SizedBox(height: 24),
            _buildQuickActionsSection(context, isASharedCampaign, campaign),
            const SizedBox(height: 24),
            _buildCampaignInfoSection(campaign),
            const SizedBox(height: 24),
            // _buildGiftDetailsSection(campaign),
            const SizedBox(height: 24),
            // _buildSharedVendorsSection(context, campaign),
            // const SizedBox(height: 24),
            _buildCampaignGiftsSection(campaign, ref),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    CampaignModel campaign,
  ) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: BoxDecoration(
          color: _DesignColors.slate50.withOpacity(0.9),
          border: const Border(
            bottom: BorderSide(color: _DesignColors.slate200, width: 1),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Back button
                _buildCircleButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(width: 12),
                // Title
                const Text(
                  'Campaign Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _DesignColors.slate900,
                    fontFamily: 'Inter',
                  ),
                ),
                const Spacer(),
                // Add vendor button
                // _buildCircleButton(
                //   icon: Icons.person_add_outlined,
                //   onTap: () {
                //     context.push(
                //       AppRoutes.vendorsToCampaign,
                //       extra: {
                //         'vendorIds':
                //             campaign.sharedVendors
                //                 ?.map((vendor) => vendor.vendorId)
                //                 .toList() ??
                //             [],
                //         'campaignId': campaign.id!,
                //       },
                //     );
                //   },
                //   hoverColor: _DesignColors.brandStart,
                // ),
                const SizedBox(width: 4),
                // Overflow menu
                PopupMenuButton<_CampaignAppBarAction>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: _DesignColors.slate500,
                    size: 20,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: _DesignColors.slate100,
                      width: 1,
                    ),
                  ),
                  elevation: 8,
                  onSelected: (action) {
                    switch (action) {
                      case _CampaignAppBarAction.activityLog:
                        context.push(
                          AppRoutes.campaignActivityLog,
                          extra: campaign.id,
                        );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: _CampaignAppBarAction.activityLog,
                      child: Row(
                        children: [
                          Icon(
                            Icons.timeline_rounded,
                            size: 18,
                            color: _DesignColors.slate500,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Activity Log',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _DesignColors.slate700,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? hoverColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Icon(icon, size: 20, color: _DesignColors.slate500),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(
    BuildContext context,
    CampaignModel campaign,
    WidgetRef ref,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_DesignColors.brandStart, _DesignColors.brandEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: _DesignColors.brandStart.withOpacity(0.4),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () async {
            // final value = await Navigator.push(context, MaterialPageRoute(
            //   builder: (context) {
            //     return AddEditAutoRedeemableGiftPage(
            //       campaignId: campaign.id!,
            //       campaignName: campaign.name,
            //       totalAllowedGifts:
            //           campaign.totalGifts - campaign.totalGiftsAdded,
            //     );
            //   },
            // ));

            final data = await context.push(
              AppRoutes.addAutoRedeemableGift,
              extra: (
                campaign.id!,
                campaign.name,
                campaign.totalGifts - campaign.totalGiftsAdded,
              ),
            );

            if (data is GiftModel) {
              // final newValue = (campaign.totalGiftsAdded + data.totalQuantity);

              await ref
                  .read(currentCampaignSelectionControllerProvider.notifier)
                  .selectCampaign(
                    campaign.copyWith(
                      totalGiftsAdded:
                          campaign.totalGiftsAdded +
                          data.totalQuantity, // New gift total added to the campaign,
                    ),
                  );
              // if (previousGiftCount != data.totalQuantity) {
              //   final difference = data.totalQuantity - previousGiftCount;
              //   final newValue =
              //       (currentCampaign.totalGiftsAdded - previousGiftCount) +
              //           data.totalQuantity;
              //   ref
              //       .read(currentCampaignSelectionControllerProvider.notifier)
              //       .updateTotalGiftsAdded(newValue);
              // }
              // setState(() {
              //   currentGift = data;
              // });
            }
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Text(
                  'Add Gift',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isASharedCampaign, CampaignModel campaign) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _DesignColors.slate100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner with gradient
          Container(
            height: 128,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_DesignColors.brandStart, _DesignColors.brandEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Overlay pattern effect
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
                // Ticket icon
                Center(
                  child: Transform.rotate(
                    angle: 0.2,
                    child: Icon(
                      Icons.confirmation_number_outlined,
                      size: 64,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campaign name
                Text(
                  campaign.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: _DesignColors.slate900,
                    height: 1.2,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  campaign.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _DesignColors.slate500,
                    height: 1.5,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 16),
                // Vendor info chip
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _DesignColors.slate50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _DesignColors.slate100, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.storefront,
                        size: 14,
                        color: _DesignColors.slate400,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Vendor: ${campaign.vendorName}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _DesignColors.slate500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // // Stats chips
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       // Users stat
                //       // _buildStatChip(
                //       //   icon: Icons.people,
                //       //   iconColor: _DesignColors.orange500,
                //       //   bgColor: _DesignColors.orange50,
                //       //   borderColor: _DesignColors.orange100,
                //       //   label: 'Users',
                //       //   value: '${campaign.totalParticipants}',
                //       // ),
                //       // const SizedBox(width: 12),
                //       // // Gifts stat
                //       // _buildStatChip(
                //       //   icon: Icons.card_giftcard,
                //       //   iconColor: _DesignColors.blue500,
                //       //   bgColor: _DesignColors.blue50,
                //       //   borderColor: _DesignColors.blue100,
                //       //   label: 'Gifts',
                //       //   value: '${campaign.totalGifts}',
                //       // ),

                //       // Remaining space for gift
                //       const SizedBox(width: 12),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 12),
                // Availed / Redeemed row
                Wrap(
                  children: [
                    _buildStatChip(
                      icon: Icons.card_giftcard,
                      iconColor: _DesignColors.blue500,
                      bgColor: _DesignColors.blue50,
                      borderColor: _DesignColors.blue100,
                      label: 'Total Gifts Added',
                      value: '${campaign.totalGiftsAdded}',
                    ),
                    _buildStatChip(
                      icon: Icons.redeem_rounded,
                      iconColor: _DesignColors.purple500,
                      bgColor: const Color(0xFFF5F3FF),
                      borderColor: const Color(0xFFEDE9FE),
                      label: 'Availed',
                      value: '${campaign.totalAvailed}',
                    ),
                    const SizedBox(width: 12),
                    _buildStatChip(
                      icon: Icons.check_circle_outline_rounded,
                      iconColor: _DesignColors.green500,
                      bgColor: const Color(0xFFF0FDF4),
                      borderColor: const Color(0xFFDCFCE7),
                      label: 'Redeemed',
                      value: '${campaign.totalRedeemed}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _DesignColors.slate400,
                    letterSpacing: 0.5,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _DesignColors.slate800,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection(
    BuildContext context,
    bool isASharedCampaign,
    CampaignModel campaign,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _DesignColors.slate100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          const Row(
            children: [
              Icon(Icons.bolt, color: _DesignColors.yellow500, size: 20),
              SizedBox(width: 8),
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _DesignColors.slate900,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action buttons grid
          Row(
            children: [
              // Avail Gift button
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.card_giftcard,
                  title: 'Avail Gift',
                  subtitle: 'Get gift',
                  isEnabled: campaign.totalGiftsAdded > 0,
                  onTap: () {
                    if (isASharedCampaign) {
                      if (campaign.allowedGiftType == GiftType.auto) {
                        context.push(
                          AppRoutes.availGiftBySharedVendor,
                          extra: AvailGiftUIData.forOwner(
                            campaignId: campaign.id!,
                            campaignName: campaign.name,
                          ),
                        );
                      }
                    } else {
                      if (campaign.allowedGiftType == GiftType.auto) {
                        context.push(
                          AppRoutes.availGiftByOwner,
                          extra: AvailGiftUIData.forOwner(
                            campaignId: campaign.id!,
                            campaignName: campaign.name,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Redeem Gift button
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.qr_code,
                  title: 'Redeem Gift',
                  subtitle: 'Process code',
                  isEnabled: campaign.totalGiftsAdded > 0,
                  onTap: () {
                    if (isASharedCampaign) {
                      context.push(
                        AppRoutes.redeemAvailedGiftBySharedVendor,
                        extra: RedeemGiftBasicData.forSharedVendor(
                          campaignId: campaign.id!,
                          campaignName: campaign.name,
                        ),
                      );
                    } else {
                      context.push(
                        AppRoutes.redeemAvailedGiftByOwner,
                        extra: RedeemGiftBasicData.forOwner(
                          campaignId: campaign.id!,
                          campaignName: campaign.name,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          if (campaign.totalGiftsAdded == 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _DesignColors.orange50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _DesignColors.orange100, width: 1),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 14,
                    color: _DesignColors.orange500,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'No gifts available',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _DesignColors.orange500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isEnabled = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isEnabled ? onTap : null,
        child: Opacity(
          opacity: isEnabled ? 1.0 : 0.4,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _DesignColors.slate50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _DesignColors.slate100, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(icon, size: 16, color: _DesignColors.slate400),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _DesignColors.slate800,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: _DesignColors.slate500,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignInfoSection(CampaignModel campaign) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _DesignColors.slate100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          const Row(
            children: [
              Icon(Icons.info_outline, color: _DesignColors.blue500, size: 20),
              SizedBox(width: 8),
              Text(
                'Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _DesignColors.slate900,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Info rows
          _buildInfoRow(
            icon: Icons.visibility_outlined,
            label: 'Visibility',
            value: campaign.visibility.toShortString().toUpperCase(),
            showBorder: true,
          ),
          _buildInfoRow(
            icon: Icons.card_giftcard_outlined,
            label: 'Gift Type',
            value: campaign.allowedGiftType.toShortString().toUpperCase(),
            showBorder: true,
          ),
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Created',
            value:
                '${campaign.createdAt.day}/${campaign.createdAt.month}/${campaign.createdAt.year}',
            showBorder: false,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool showBorder,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: showBorder
            ? const Border(
                bottom: BorderSide(color: _DesignColors.slate50, width: 1),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: _DesignColors.slate400),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _DesignColors.slate500,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _DesignColors.slate800,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftDetailsSection(CampaignModel campaign) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _DesignColors.slate100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          const Row(
            children: [
              Icon(
                Icons.card_giftcard,
                color: _DesignColors.purple500,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Gift Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _DesignColors.slate900,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Gift details card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _DesignColors.slate50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _DesignColors.slate100, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total available row
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.confirmation_number_outlined,
                        size: 18,
                        color: _DesignColors.slate400,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TOTAL AVAILABLE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: _DesignColors.slate400,
                            letterSpacing: 0.5,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          '${campaign.totalGifts} Gifts',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: _DesignColors.slate900,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Type row
                Row(
                  children: [
                    const Icon(
                      Icons.sell_outlined,
                      size: 14,
                      color: _DesignColors.slate400,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Type: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _DesignColors.slate500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Text(
                      campaign.allowedGiftType.toShortString().toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _DesignColors.slate800,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharedVendorsSection(
    BuildContext context,
    CampaignModel campaign,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _DesignColors.slate100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.storefront,
                    color: _DesignColors.green500,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Shared Vendors',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _DesignColors.slate900,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              // Add button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    context.push(
                      AppRoutes.vendorsToCampaign,
                      extra: {
                        'vendorIds':
                            campaign.sharedVendors
                                ?.map((vendor) => vendor.vendorId)
                                .toList() ??
                            [],
                        'campaignId': campaign.id!,
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _DesignColors.orange50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '+ Add',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _DesignColors.brandStart,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Vendors list
          if (campaign.sharedVendors?.isEmpty ?? true)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _DesignColors.slate50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _DesignColors.slate200,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Center(
                child: Text(
                  'No shared vendors yet',
                  style: TextStyle(
                    fontSize: 14,
                    color: _DesignColors.slate500,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            )
          else
            Column(
              children: campaign.sharedVendors!.asMap().entries.map((entry) {
                final vendor = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key < campaign.sharedVendors!.length - 1
                        ? 12
                        : 0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _DesignColors.slate50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _DesignColors.slate100,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.storefront,
                            size: 16,
                            color: _DesignColors.slate400,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            vendor.vendorName ?? 'Unknown Vendor',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _DesignColors.slate700,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildCampaignGiftsSection(CampaignModel campaign, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _DesignColors.slate100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Campaign Gifts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _DesignColors.slate900,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),

          // Campaign gift list component
          CampaignGiftListView(campaign.id!, (p0) {
            // ref
            //     .read(currentCampaignSelectionControllerProvider.notifier)
            //     .updateTotalGiftsAdded(p0);

            print("Woo" + p0.toString());

            // final currentCampaign = ref
            //     .read(currentCampaignSelectionControllerProvider)
            //     .requireValue;

            // ref
            //     .read(vendorsCampaignListControllerProvider.notifier)
            //     .updateGiftCount(currentCampaign!.id!, p0);
          }),
        ],
      ),
    );
  }
}
