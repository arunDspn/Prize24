import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/common_widgets/t_secondary_button.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/campaign_gift_list/view_model/campaign_gift_list_controller.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/single_gift_detail/view_models/delete_gift/delete_autoredeemgift_by_owner_controller.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/view_model/current_campaign_selection_controller.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/vendors_campaign_list_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

/// Design System Colors - Following the HTML Tailwind Theme
class _DesignColors {
  // Slate palette
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Brand gradient colors
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);

  // Additional colors
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange500 = Color(0xFFF97316);
  static const Color green50 = Color(0xFFF0FDF4);
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green500 = Color(0xFF22C55E);
  static const Color green600 = Color(0xFF16A34A);
  static const Color green700 = Color(0xFF15803D);
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue600 = Color(0xFF2563EB);
  static const Color blue700 = Color(0xFF1D4ED8);
  static const Color purple50 = Color(0xFFFAF5FF);
  static const Color purple100 = Color(0xFFF3E8FF);
  static const Color purple500 = Color(0xFFA855F7);
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red500 = Color(0xFFEF4444);
  static const Color red600 = Color(0xFFDC2626);
  static const Color teal500 = Color(0xFF14B8A6);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

/// A Page to display details of a single gift in the vendor campaign detail view
class VendorSingleGiftDetailView extends ConsumerStatefulWidget {
  const VendorSingleGiftDetailView({required this.gift, super.key});

  final GiftModel gift;

  @override
  ConsumerState<VendorSingleGiftDetailView> createState() =>
      _VendorSingleGiftDetailViewState();
}

class _VendorSingleGiftDetailViewState
    extends ConsumerState<VendorSingleGiftDetailView> {
  late GiftModel currentGift;
  bool _isDeleteLoaderVisible = false;
  bool _isDeleteResultHandled = false;

  @override
  void initState() {
    super.initState();
    currentGift = widget.gift;
  }

  @override
  Widget build(BuildContext context) {
    final deleteGiftState = ref.watch(
      deleteAutoredeemgiftByOwnerControllerProvider,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleDeleteGiftState(
        deleteGiftState,
        context,
        widget.gift.remainingQuantity,
      );
    });

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _DesignColors.slate50,
      appBar: _buildAppBar(context, theme, ref),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(theme),
            const SizedBox(height: 24),
            _buildBasicInfoSection(context, theme),
            const SizedBox(height: 24),
            _buildGiftTypeSection(theme),
            const SizedBox(height: 24),
            _buildQuantitySection(theme),
            const SizedBox(height: 24),
            if (widget.gift.giftType.toLowerCase() == 'code')
              ..._buildCodeGiftSections(context, theme)
            else
              ..._buildAutoGiftSections(context, theme),
            const SizedBox(height: 32),
            // _buildActionButtons(context, theme),
          ],
        ),
      ),
    );
  }

  void _handleDeleteGiftState(
    AsyncValue<String?> state,
    BuildContext context,
    int giftCountToDelet,
  ) {
    if (!mounted) return;

    if (state.isLoading) {
      if (_isDeleteLoaderVisible) return;
      _isDeleteLoaderVisible = true;
      showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => const PopScope(
          canPop: false,
          child: AlertDialog(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.4),
                ),
                SizedBox(width: 12),
                Text(
                  'Deleting gift...',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      return;
    }

    if (_isDeleteLoaderVisible) {
      Navigator.of(context, rootNavigator: true).pop();
      _isDeleteLoaderVisible = false;
    }

    if (_isDeleteResultHandled) return;

    state.whenOrNull(
      data: (result) {
        if (result == null) return;
        _isDeleteResultHandled = true;

        final currentCampaign = ref
            .read(currentCampaignSelectionControllerProvider)
            .requireValue!;

        final campaignId = currentCampaign.id;
        final nextTotalGiftsAdded =
            currentCampaign.totalGiftsAdded - currentGift.totalQuantity;
        // ref
        //     .read(currentCampaignSelectionControllerProvider.notifier)
        //     .updateTotalGiftsAdded(
        //       nextTotalGiftsAdded < 0 ? 0 : nextTotalGiftsAdded,
        //     );

        // ref
        //     .read(currentCampaignSelectionControllerProvider.notifier)
        //     .updateTotalGiftsAdded(giftCountToDelet);

        ref
            .read(vendorsCampaignListControllerProvider.notifier)
            .updateGiftCount(currentCampaign!.id!, giftCountToDelet);
        // ref.refresh(
        //   campaignGiftListControllerProvider(
        //     campaignId: currentGift.campaignId,
        //   ),
        // );

        ref
            .read(currentCampaignSelectionControllerProvider.notifier)
            .reloadCurrentCampaignFromSource();

        ref.invalidate(
          campaignGiftListControllerProvider(campaignId: campaignId ?? ''),
        );

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text(
                  'Gift Deleted',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            backgroundColor: _DesignColors.red500,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
        ref.invalidate(deleteAutoredeemgiftByOwnerControllerProvider);
      },
      error: (error, stackTrace) {
        _isDeleteResultHandled = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Failed to delete gift. Please try again.',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: _DesignColors.red600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
        ref.invalidate(deleteAutoredeemgiftByOwnerControllerProvider);
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
  ) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: _DesignColors.slate50.withOpacity(0.9),
              border: const Border(
                bottom: BorderSide(color: _DesignColors.slate200, width: 1),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    // Back button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: _DesignColors.slate500,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Title
                    const Text(
                      'Gift Details',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _DesignColors.slate900,
                      ),
                    ),
                    const Spacer(),
                    // Edit button
                    if (widget.gift.userId ==
                        ref
                            .read(authControllerProvider)
                            .requireValue!
                            .userId) ...[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            final currentCampaign = ref
                                .read(
                                  currentCampaignSelectionControllerProvider,
                                )
                                .requireValue!;

                            final previousGiftCount = currentGift.totalQuantity;

                            final data = await context.push(
                              AppRoutes.editAutoRedeemableGift,
                              extra: (
                                currentGift,
                                (currentCampaign.totalGifts -
                                        currentCampaign.totalGiftsAdded) +
                                    currentGift.totalQuantity,
                                currentGift.campaignId,
                              ),
                            );

                            if (data is GiftModel) {
                              if (previousGiftCount != data.totalQuantity) {
                                final difference =
                                    data.totalQuantity - previousGiftCount;
                                final newValue =
                                    (currentCampaign.totalGiftsAdded -
                                        previousGiftCount) +
                                    data.totalQuantity;
                                ref
                                    .read(
                                      currentCampaignSelectionControllerProvider
                                          .notifier,
                                    )
                                    .updateTotalGiftsAdded(newValue);
                              }
                              setState(() {
                                currentGift = data;
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.edit_outlined,
                              color: _DesignColors.slate500,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      // Delete button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            await _deleteGift(context);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.delete_outline_outlined,
                              color: _DesignColors.slate500,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(width: 8),
                    // Menu button
                    // PopupMenuButton(
                    //   icon: Container(
                    //     width: 40,
                    //     height: 40,
                    //     decoration: const BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Colors.transparent,
                    //     ),
                    //     child: const Icon(
                    //       Icons.more_vert,
                    //       color: _DesignColors.slate500,
                    //       size: 20,
                    //     ),
                    //   ),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   color: Colors.white,
                    //   elevation: 8,
                    //   shadowColor: Colors.black.withOpacity(0.15),
                    //   offset: const Offset(0, 12),
                    //   itemBuilder: (context) => [
                    //     const PopupMenuItem(
                    //       value: 'analytics',
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.bar_chart,
                    //             size: 18,
                    //             color: _DesignColors.slate400,
                    //           ),
                    //           SizedBox(width: 8),
                    //           Text(
                    //             'Analytics',
                    //             style: TextStyle(
                    //               fontFamily: 'Plus Jakarta Sans',
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w500,
                    //               color: _DesignColors.slate800,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     const PopupMenuItem(
                    //       value: 'duplicate',
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.copy,
                    //             size: 18,
                    //             color: _DesignColors.slate400,
                    //           ),
                    //           SizedBox(width: 8),
                    //           Text(
                    //             'Duplicate',
                    //             style: TextStyle(
                    //               fontFamily: 'Plus Jakarta Sans',
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w500,
                    //               color: _DesignColors.slate800,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     const PopupMenuItem(
                    //       value: 'delete',
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.delete_outline,
                    //             size: 18,
                    //             color: _DesignColors.red500,
                    //           ),
                    //           SizedBox(width: 8),
                    //           Text(
                    //             'Delete',
                    //             style: TextStyle(
                    //               fontFamily: 'Plus Jakarta Sans',
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w500,
                    //               color: _DesignColors.red600,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    //   onSelected: (value) {
                    //     switch (value) {
                    //       case 'analytics':
                    //         // _showAnalytics(context);
                    //         break;
                    //       case 'duplicate':
                    //         _duplicateGift(context);
                    //         break;
                    //       case 'delete':
                    //         _deleteGift(context);
                    //         break;
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _DesignColors.slate100, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Top gradient bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 6,
              decoration: const BoxDecoration(
                gradient: _DesignColors.brandGradient,
              ),
            ),
          ),
          // Decorative blur
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: _DesignColors.orange50.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gift Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: _DesignColors.orange50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _DesignColors.orange100,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.card_giftcard,
                    color: _DesignColors.orange500,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 20),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentGift.name,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _DesignColors.slate900,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.gift.campaignName,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _DesignColors.slate500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        currentGift.description,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _DesignColors.slate600,
                          height: 1.5,
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

  Widget _buildBasicInfoSection(BuildContext context, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _DesignColors.slate100, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Icon(Icons.info, color: _DesignColors.blue500, size: 20),
              SizedBox(width: 8),
              Text(
                'Basic Information',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _DesignColors.slate900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Gift ID Row
          _buildInfoRow(
            context,
            theme,
            icon: Icons.fingerprint,
            label: 'Gift ID',
            value: widget.gift.id ?? 'N/A',
            copyable: true,
          ),
          // Created Row
          _buildInfoRow(
            context,
            theme,
            icon: Icons.calendar_today_outlined,
            label: 'Created',
            value: _formatDate(widget.gift.createdAt),
          ),
          // Public Slug Row (Conditional)
          if (widget.gift.publicgSlug != null)
            _buildInfoRow(
              context,
              theme,
              icon: Icons.link,
              label: 'Public Slug',
              value: widget.gift.publicgSlug!,
              copyable: true,
              isLast: true,
              valueColor: _DesignColors.blue600,
            ),
        ],
      ),
    );
  }

  Widget _buildGiftTypeSection(ThemeData theme) {
    final isAutoGift = widget.gift.giftType.toLowerCase() == 'auto';
    final isRedeemable = widget.gift.isRedeemable;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _DesignColors.slate100, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Icon(Icons.tune, color: _DesignColors.purple500, size: 20),
              SizedBox(width: 8),
              Text(
                'Configuration',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _DesignColors.slate900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Badges
          Row(
            children: [
              _buildTypeBadge(
                theme,
                icon: isAutoGift ? Icons.auto_awesome : Icons.code,
                label: isAutoGift ? 'Auto Gift' : 'Code Gift',
                backgroundColor: isAutoGift
                    ? _DesignColors.orange50
                    : _DesignColors.purple50,
                borderColor: isAutoGift
                    ? _DesignColors.orange100
                    : _DesignColors.purple100,
                iconColor: isAutoGift
                    ? _DesignColors.orange500
                    : _DesignColors.purple500,
              ),
              const SizedBox(width: 12),
              _buildTypeBadge(
                theme,
                icon: isRedeemable ? Icons.qr_code_scanner : Icons.info_outline,
                label: isRedeemable ? 'Redeemable' : 'Informational',
                backgroundColor: isRedeemable
                    ? _DesignColors.green50
                    : _DesignColors.blue50,
                borderColor: isRedeemable
                    ? _DesignColors.green100
                    : _DesignColors.blue100,
                iconColor: isRedeemable
                    ? _DesignColors.green500
                    : _DesignColors.blue500,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Requirements Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _DesignColors.slate50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _DesignColors.slate100, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'REQUIREMENTS',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _DesignColors.slate400,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.gift.expectedFieldsDescription,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _DesignColors.slate600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySection(ThemeData theme) {
    final remainingPercentage = currentGift.totalQuantity > 0
        ? (currentGift.remainingQuantity / currentGift.totalQuantity * 100)
              .round()
        : 0;
    final claimed = currentGift.totalQuantity - currentGift.remainingQuantity;

    // Determine progress bar color based on remaining percentage
    Color progressColor;
    Color progressTextColor;
    if (remainingPercentage < 20) {
      progressColor = _DesignColors.red500;
      progressTextColor = _DesignColors.red600;
    } else if (remainingPercentage < 50) {
      progressColor = _DesignColors.orange500;
      progressTextColor = Colors.orange.shade700;
    } else {
      progressColor = _DesignColors.green500;
      progressTextColor = _DesignColors.green600;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _DesignColors.slate100, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Icon(Icons.inventory_2, color: _DesignColors.teal500, size: 20),
              SizedBox(width: 8),
              Text(
                'Inventory',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _DesignColors.slate900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats Grid
          Row(
            children: [
              // Total
              Expanded(
                child: _buildQuantityCard(
                  theme,
                  icon: Icons.layers,
                  label: 'Total',
                  value: currentGift.totalQuantity.toString(),
                  backgroundColor: _DesignColors.slate50,
                  borderColor: _DesignColors.slate100,
                  iconColor: _DesignColors.slate400,
                  valueColor: _DesignColors.slate900,
                  labelColor: _DesignColors.slate400,
                ),
              ),
              const SizedBox(width: 12),
              // Remaining
              Expanded(
                child: _buildQuantityCard(
                  theme,
                  icon: Icons.check_circle,
                  label: 'Left',
                  value: currentGift.remainingQuantity.toString(),
                  backgroundColor: _DesignColors.green50,
                  borderColor: _DesignColors.green100,
                  iconColor: _DesignColors.green500,
                  valueColor: _DesignColors.green700,
                  labelColor: _DesignColors.green600.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 12),
              // Claimed
              Expanded(
                child: _buildQuantityCard(
                  theme,
                  icon: Icons.people,
                  label: 'Claimed',
                  value: claimed.toString(),
                  backgroundColor: _DesignColors.blue50,
                  borderColor: _DesignColors.blue100,
                  iconColor: _DesignColors.blue500,
                  valueColor: _DesignColors.blue700,
                  labelColor: _DesignColors.blue600.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Availability',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _DesignColors.slate500,
                    ),
                  ),
                  Text(
                    '$remainingPercentage% Remaining',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: progressTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _DesignColors.slate100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: currentGift.totalQuantity > 0
                      ? currentGift.remainingQuantity /
                            currentGift.totalQuantity
                      : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCodeGiftSections(BuildContext context, ThemeData theme) {
    final sections = <Widget>[];

    // Supported Shops Section (for redeemable)
    if (widget.gift.isRedeemable &&
        currentGift.supportedShops != null &&
        currentGift.supportedShops!.isNotEmpty) {
      sections.add(_buildSupportedShopsSection(theme));
      sections.add(const SizedBox(height: 24));
    }

    return sections;
  }

  List<Widget> _buildAutoGiftSections(BuildContext context, ThemeData theme) {
    final sections = <Widget>[];

    // Supported Shops Section (for redeemable)
    if (widget.gift.isRedeemable &&
        currentGift.supportedShops != null &&
        currentGift.supportedShops!.isNotEmpty) {
      sections.add(_buildSupportedShopsSection(theme));
      sections.add(const SizedBox(height: 24));
    }

    return sections;
  }

  Widget _buildCodesSection(BuildContext context, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _DesignColors.slate100, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.code, color: _DesignColors.purple500, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Gift Codes',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _DesignColors.slate900,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _DesignColors.purple50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _DesignColors.purple100, width: 1),
                ),
                child: Text(
                  '${widget.gift.remainingQuantity} codes',
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _DesignColors.purple500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSupportedShopsSection(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _DesignColors.slate100, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Icon(Icons.storefront, color: _DesignColors.green500, size: 20),
              SizedBox(width: 8),
              Text(
                'Supported Shops',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _DesignColors.slate900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...currentGift.supportedShops!.map(
            (shop) => _buildShopCard(theme, shop),
          ),
        ],
      ),
    );
  }

  Widget _buildPayloadsSection(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: _DesignColors.slate100, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.text_fields,
                    color: _DesignColors.blue500,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Gift Payloads',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _DesignColors.slate900,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _DesignColors.blue50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _DesignColors.blue100, width: 1),
                ),
                child: Text(
                  '${widget.gift.remainingQuantity} payloads',
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _DesignColors.blue500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        Row(
          children: [
            // Expanded(
            //   child: TSecondaryButton(
            //     onPressed: () {
            //       // TODO: Navigate to edit gift page
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //             content: Text('Edit functionality to be implemented')),
            //       );
            //     },
            //     text: 'Edit Gift',
            //     icon: Icons.edit,
            //   ),
            // ),
            const SizedBox(width: 12),
            // Expanded(
            //   child: TPrimaryButton(
            //     onPressed: () {
            //       _showAnalytics(context);
            //     },
            //     text: 'View Analytics',
            //     icon: Icons.analytics,
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TSecondaryButton(
            onPressed: () {
              _duplicateGift(context);
            },
            text: 'Duplicate Gift',
            icon: Icons.copy,
          ),
        ),
      ],
    );
  }

  // Helper Widgets
  Widget _buildInfoRow(
    BuildContext context,
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String value,
    bool copyable = false,
    bool isLast = false,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: _DesignColors.slate50, width: 1),
              ),
      ),
      child: Row(
        children: [
          // Icon and Label
          Row(
            children: [
              Icon(icon, size: 16, color: _DesignColors.slate400),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _DesignColors.slate500,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Value and Copy button
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: copyable ? 'monospace' : 'Plus Jakarta Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: valueColor ?? _DesignColors.slate800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (copyable) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Copied to clipboard',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: _DesignColors.green600,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: const Icon(
                    Icons.copy,
                    size: 16,
                    color: _DesignColors.slate400,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color borderColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _DesignColors.slate600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityCard(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String value,
    required Color backgroundColor,
    required Color borderColor,
    required Color iconColor,
    required Color valueColor,
    required Color labelColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: valueColor,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: labelColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeCard(
    BuildContext context,
    ThemeData theme,
    CodeGiftCodeModel code,
    int index,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _DesignColors.slate50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: code.isRedeemed
              ? _DesignColors.red500.withOpacity(0.3)
              : _DesignColors.green500.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Code #$index',
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _DesignColors.slate800,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: code.isRedeemed
                      ? _DesignColors.red50
                      : _DesignColors.green50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  code.isRedeemed ? 'Redeemed' : 'Available',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: code.isRedeemed
                        ? _DesignColors.red500
                        : _DesignColors.green500,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _DesignColors.slate200),
                  ),
                  child: Text(
                    code.code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _DesignColors.slate800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: code.code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text('Code copied to clipboard'),
                        ],
                      ),
                      backgroundColor: _DesignColors.green600,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _DesignColors.slate200),
                  ),
                  child: const Icon(
                    Icons.copy,
                    size: 18,
                    color: _DesignColors.orange500,
                  ),
                ),
              ),
            ],
          ),
          if (code.redeemedByUserId != null) ...[
            const SizedBox(height: 8),
            Text(
              'Redeemed by: ${code.redeemedByUserId}',
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 12,
                color: _DesignColors.slate500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildShopCard(ThemeData theme, SupportedShopModel shop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _DesignColors.slate50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _DesignColors.slate100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop Icon
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
              color: _DesignColors.green600,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          // Shop Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _DesignColors.slate800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  shop.shopAddress,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _DesignColors.slate500,
                  ),
                ),
                if (shop.shopPhone.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    shop.shopPhone,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: _DesignColors.slate400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopInfoRow(ThemeData theme, IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: _DesignColors.slate400),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              color: _DesignColors.slate600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPayloadCard(
    ThemeData theme,
    AutoGiftPayloadModel payload,
    int index,
  ) {
    final isRedeemed = payload.redeemedAt != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _DesignColors.slate50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isRedeemed
              ? _DesignColors.red500.withOpacity(0.3)
              : _DesignColors.blue500.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payload #$index',
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _DesignColors.slate800,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isRedeemed
                      ? _DesignColors.red50
                      : _DesignColors.blue50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isRedeemed ? 'Redeemed' : 'Available',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: isRedeemed
                        ? _DesignColors.red500
                        : _DesignColors.blue500,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _DesignColors.slate200),
            ),
            child: Text(
              payload.content,
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 14,
                color: _DesignColors.slate800,
                height: 1.3,
              ),
            ),
          ),
          if (payload.redeemedAt != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Redeemed: ',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    color: _DesignColors.slate500,
                  ),
                ),
                Text(
                  _formatDate(payload.redeemedAt!),
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _DesignColors.slate600,
                  ),
                ),
              ],
            ),
            if (payload.redeemedByUserId != null) ...[
              const SizedBox(height: 2),
              Text(
                'By: ${payload.redeemedByUserId}',
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  color: _DesignColors.slate500,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  // Helper Methods
  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // void _showAnalytics(BuildContext context) {
  void _duplicateGift(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Duplicate Gift',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w700,
            color: _DesignColors.slate900,
          ),
        ),
        content: const Text(
          'Are you sure you want to create a copy of this gift?',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: _DesignColors.slate600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w600,
                color: _DesignColors.slate500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Gift Duplicated',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: _DesignColors.green600,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            child: const Text(
              'Duplicate',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w600,
                color: _DesignColors.orange500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteGift(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Gift',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w700,
            color: _DesignColors.slate900,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this gift? This action cannot be undone.',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: _DesignColors.slate600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w600,
                color: _DesignColors.slate500,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: _DesignColors.red500),
            child: const Text(
              'Delete',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w600,
                color: _DesignColors.red500,
              ),
            ),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;

    final giftId = currentGift.id;
    if (giftId == null || giftId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Unable to delete this gift. Missing gift id.',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: _DesignColors.red600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    _isDeleteResultHandled = false;
    unawaited(
      ref
          .read(deleteAutoredeemgiftByOwnerControllerProvider.notifier)
          .deleteAutoRedeemableGiftByOwner(
            campaignId: currentGift.campaignId,
            giftId: giftId,
          ),
    );
  }

  void _showAllCodes(BuildContext context, ThemeData theme) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Gift Codes',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _DesignColors.slate900,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: _DesignColors.slate100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: _DesignColors.slate500,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
