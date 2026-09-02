import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/vendor_scan_user/ui/vendor_scanner_for_user_gift_page.dart';
import 'package:prize24_app/features/redeem_gift/ui/redeem_gift_page.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_campaigns/staff_campaign_model.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Custom color palette matching VendorCampaignDetailPage design
class _DesignColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
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
  static const Color purple50 = Color(0xFFFAF5FF);
  static const Color purple100 = Color(0xFFF3E8FF);
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color green50 = Color(0xFFF0FDF4);
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green500 = Color(0xFF22C55E);
  static const Color yellow500 = Color(0xFFEAB308);
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red100 = Color(0xFFFEE2E2);
  static const Color red500 = Color(0xFFEF4444);
}

class StaffCampaignDetailPage extends ConsumerWidget {
  const StaffCampaignDetailPage({required this.datas, super.key});

  final Map<String, dynamic> datas;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaign = datas['campaign'] as StaffCampaignModel;
    final shopId = datas['shopId'] as String;

    return Scaffold(
      backgroundColor: _DesignColors.slate50,
      appBar: _buildAppBar(context, campaign),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(campaign),
            const SizedBox(height: 24),
            _buildQuickActionsSection(context, campaign, shopId),
            const SizedBox(height: 24),
            _buildCampaignInfoSection(campaign),
            const SizedBox(height: 24),
            _buildGiftDetailsSection(campaign),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    StaffCampaignModel campaign,
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
                _buildCircleButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Campaign Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _DesignColors.slate900,
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

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
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

  Widget _buildHeroSection(StaffCampaignModel campaign) {
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
                Text(
                  campaign.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _DesignColors.slate500,
                    height: 1.5,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 24),

                // Stats chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildStatChip(
                        icon: Icons.card_giftcard,
                        iconColor: _DesignColors.blue500,
                        bgColor: _DesignColors.blue50,
                        borderColor: _DesignColors.blue100,
                        label: 'Total Gifts Added',
                        value: '${campaign.totalGiftsAdded}',
                      ),
                      // const SizedBox(width: 12),
                      // _buildStatChip(
                      //   icon: Icons.people,
                      //   iconColor: campaign.totalParticipants > 0
                      //       ? _DesignColors.green500
                      //       : _DesignColors.red500,
                      //   bgColor: campaign.totalParticipants > 0
                      //       ? _DesignColors.green50
                      //       : _DesignColors.red50,
                      //   borderColor: campaign.totalParticipants > 0
                      //       ? _DesignColors.green100
                      //       : _DesignColors.red100,
                      //   label: 'Users',
                      //   value: '${campaign.totalParticipants}',
                      // ),
                      // const SizedBox(width: 12),
                      // _buildStatChip(
                      //   icon: Icons.people,
                      //   iconColor: _DesignColors.purple500,
                      //   bgColor: _DesignColors.purple50,
                      //   borderColor: _DesignColors.purple100,
                      //   label: 'Max Users',
                      //   value: '${campaign.maxParticipants}',
                      // ),
                    ],
                  ),
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
    return Container(
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
    );
  }

  Widget _buildQuickActionsSection(
    BuildContext context,
    StaffCampaignModel campaign,
    String shopId,
  ) {
    final isEnabled = campaign.totalGiftsAdded > 0;

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
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.card_giftcard,
                  title: 'Avail Gift',
                  subtitle: 'Give to customer',
                  isEnabled: isEnabled,
                  onTap: () {
                    final data = AvailGiftUIData.forStaff(
                      campaignId: campaign.id,
                      shopId: shopId,
                      campaignName: campaign.name,
                    );
                    context.push(AppRoutes.availGiftByStaff, extra: data);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.qr_code,
                  title: 'Redeem Gift',
                  subtitle: 'Scan & validate',
                  isEnabled: isEnabled,
                  onTap: () {
                    final data = RedeemGiftBasicData.forStaff(
                      campaignId: campaign.id,
                      shopId: shopId,
                      campaignName: campaign.name,
                    );
                    context.push(
                      AppRoutes.redeemAvailedGiftByStaff,
                      extra: data,
                    );
                  },
                ),
              ),
            ],
          ),
          if (!isEnabled) ...[
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
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isEnabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isEnabled
                ? _DesignColors.slate50
                : _DesignColors.slate50.withOpacity(0.5),
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
                child: Icon(
                  icon,
                  size: 16,
                  color: isEnabled
                      ? _DesignColors.slate400
                      : _DesignColors.slate400.withOpacity(0.4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isEnabled
                      ? _DesignColors.slate800
                      : _DesignColors.slate400,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isEnabled
                      ? _DesignColors.slate500
                      : _DesignColors.slate400,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignInfoSection(StaffCampaignModel campaign) {
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
          _buildInfoRow(
            icon: Icons.visibility_outlined,
            label: 'Visibility',
            value: campaign.visibility.toUpperCase(),
            showBorder: true,
          ),
          _buildInfoRow(
            icon: Icons.card_giftcard_outlined,
            label: 'Gift Type',
            value: campaign.giftType.toUpperCase(),
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

  Widget _buildGiftDetailsSection(StaffCampaignModel campaign) {
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
          const Row(
            children: [
              Icon(
                Icons.card_giftcard,
                color: _DesignColors.purple500,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Gift Status',
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: campaign.remainingGifts > 0
                  ? _DesignColors.green50
                  : _DesignColors.red50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: campaign.remainingGifts > 0
                    ? _DesignColors.green100
                    : _DesignColors.red100,
                width: 1,
              ),
            ),
            child: Row(
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
                  child: Icon(
                    campaign.remainingGifts > 0
                        ? Icons.check_circle
                        : Icons.warning_amber_rounded,
                    size: 18,
                    color: campaign.remainingGifts > 0
                        ? _DesignColors.green500
                        : _DesignColors.red500,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.remainingGifts > 0
                            ? 'Gifts Available'
                            : 'No Gifts Available',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _DesignColors.slate400,
                          letterSpacing: 0.5,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        campaign.remainingGifts > 0
                            ? 'Ready for distribution'
                            : 'Contact shop owner',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _DesignColors.slate700,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
