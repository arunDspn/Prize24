import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/vendors_campaign_list_controller.dart';

// Slate color palette from HTML design
class _SlateColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate900 = Color(0xFF0F172A);
}

// Brand gradient colors
class _BrandColors {
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
  static const Color orange500 = Color(0xFFF97316);
}

class CampaignSelecterListModal extends ConsumerStatefulWidget {
  const CampaignSelecterListModal({super.key});

  static Future<CampaignModel?> show(BuildContext context) {
    return showModalBottomSheet<CampaignModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0xFF0F172A).withOpacity(0.4),
      builder: (context) => const CampaignSelecterListModal(),
    );
  }

  @override
  ConsumerState<CampaignSelecterListModal> createState() =>
      _CampaignSelecterListModalState();
}

class _CampaignSelecterListModalState
    extends ConsumerState<CampaignSelecterListModal>
    with SingleTickerProviderStateMixin {
  CampaignModel? selectedCampaign;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vendorsCampaignListControllerProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag handle
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 12, bottom: 4),
                  child: Center(
                    child: Container(
                      width: 48,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _SlateColors.slate200,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),

              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _SlateColors.slate100,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Campaign',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _SlateColors.slate900,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Material(
                      color: _SlateColors.slate50,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.close_rounded,
                            size: 18,
                            color: _SlateColors.slate500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: context.mounted
                    ? state.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return _buildEmptyState();
                          }
                          return _buildCampaignList(data, scrollController);
                        },
                        loading: () => _buildLoadingState(),
                        error: (error, stackTrace) => _buildErrorState(error),
                      )
                    : const SizedBox.shrink(),
              ),

              // Sticky Footer
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: _SlateColors.slate100,
                      width: 1,
                    ),
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: _buildConfirmButton(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(_BrandColors.orange500),
              backgroundColor: _SlateColors.slate100,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Loading campaigns...',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _SlateColors.slate400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: _SlateColors.slate50,
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.campaign_outlined,
              size: 32,
              color: _SlateColors.slate300,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'No Campaigns Available',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: _SlateColors.slate500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 32,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              // 'Error: $error',
              'Failed to load campaigns. Please try again later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.red.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignList(
      List<CampaignModel> data, ScrollController scrollController) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(20),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final campaign = data[index];
        final isSelected = selectedCampaign?.id == campaign.id;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _CampaignListItem(
            campaign: campaign,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                selectedCampaign =
                    selectedCampaign?.id == campaign.id ? null : campaign;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildConfirmButton() {
    final bool isEnabled = selectedCampaign != null;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isEnabled ? 1.0 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled
              ? () {
                  Navigator.pop(context, selectedCampaign);
                }
              : null,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _BrandColors.brandStart,
                  _BrandColors.brandEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: isEnabled
                  ? [
                      BoxShadow(
                        color: _BrandColors.brandStart.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Confirm Selection',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.check_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CampaignListItem extends StatelessWidget {
  final CampaignModel campaign;
  final bool isSelected;
  final VoidCallback onTap;

  const _CampaignListItem({
    required this.campaign,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final visibilityText = campaign.visibility.toShortString().toUpperCase();
    final isPublic = campaign.visibility.name == 'public';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? _BrandColors.orange500.withOpacity(0.05)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isSelected ? _BrandColors.orange500 : _SlateColors.slate200,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Checkbox
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _BrandColors.orange500
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? _BrandColors.orange500
                          : _SlateColors.slate300,
                      width: 2,
                    ),
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isSelected ? 1.0 : 0.0,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: isSelected ? 1.0 : 0.5,
                      child: const Icon(
                        Icons.check_rounded,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            campaign.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _SlateColors.slate900,
                              height: 1.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Visibility Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isPublic
                                ? const Color(0xFFDCFCE7)
                                : const Color(0xFFFFF7ED),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: isPublic
                                  ? const Color(0xFFBBF7D0)
                                  : const Color(0xFFFFEDD5),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            visibilityText,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: isPublic
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFFEA580C),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      campaign.description,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: _SlateColors.slate500,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
