import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/campaign_gift_list/view_model/campaign_gift_list_controller.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/view_model/current_campaign_selection_controller.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/gift/presentation/add_edit_auto_redeemable_gift/view_model/add_edit_auto_redeemable_gift_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/vendors_campaign_list_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_shop_list/view_model/vendor_shop_list_controller.dart';

// Color constants matching the HTML design
class _GiftPageColors {
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
  static const Color orange400 = Color(0xFFFB923C);
  static const Color orange500 = Color(0xFFF97316);
}

class AddEditAutoRedeemableGiftPage extends ConsumerStatefulWidget {
  const AddEditAutoRedeemableGiftPage({
    required this.campaignId,
    required this.campaignName,
    required this.totalAllowedGifts,
    super.key,
  }) : existingGift = null;

  // Edit constructor
  const AddEditAutoRedeemableGiftPage.edit({
    required this.existingGift,
    required this.totalAllowedGifts,
    required this.campaignId,
    super.key,
  }) : campaignName = null;

  final GiftModel? existingGift;
  final String? campaignId;
  final String? campaignName;
  final int totalAllowedGifts;

  @override
  ConsumerState<AddEditAutoRedeemableGiftPage> createState() =>
      _AddEditAutoRedeemableGiftPageState();
}

class _AddEditAutoRedeemableGiftPageState
    extends ConsumerState<AddEditAutoRedeemableGiftPage> {
  final _formKey = GlobalKey<FormState>();
  final _giftNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _totalGiftsController = TextEditingController();

  List<SupportedShopModel> _selectedShops = [];

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.existingGift != null) {
      _giftNameController.text = widget.existingGift!.name;
      _descriptionController.text = widget.existingGift!.description;
      _totalGiftsController.text = widget.existingGift!.totalQuantity
          .toString();
      _selectedShops = List<SupportedShopModel>.from(
        widget.existingGift!.supportedShops ?? [],
      );
    }
  }

  @override
  void dispose() {
    _giftNameController.dispose();
    _descriptionController.dispose();
    _totalGiftsController.dispose();
    super.dispose();
  }

  bool get _isEditMode => widget.existingGift != null;

  InputDecoration _buildInputDecoration({
    required String label,
    required String placeholder,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: _GiftPageColors.slate700,
      ),
      hintText: placeholder,
      hintStyle: const TextStyle(
        color: _GiftPageColors.slate400,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _GiftPageColors.slate200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _GiftPageColors.slate200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: _GiftPageColors.orange400,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }

  void _showShopSelectionModal() {
    // Track selected shops in the modal
    final tempSelectedShops = List<SupportedShopModel>.from(_selectedShops);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final shopList = ref.watch(vendorShopListControllerProvider);
        return shopList.when(
          data: (shops) {
            return StatefulBuilder(
              builder: (context, setModalState) {
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.85,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Handle
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
                                color: _GiftPageColors.slate200,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Modal Header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Select Shops',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: _GiftPageColors.slate900,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _GiftPageColors.slate50,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: _GiftPageColors.slate500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: _GiftPageColors.slate100),

                      // Shop List
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(24),
                          itemCount: shops.length,
                          itemBuilder: (context, index) {
                            final shop = shops[index];
                            final isSelected = tempSelectedShops.any(
                              (s) => s.id == shop.id,
                            );

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  setModalState(() {
                                    if (isSelected) {
                                      tempSelectedShops.removeWhere(
                                        (s) => s.id == shop.id,
                                      );
                                    } else {
                                      tempSelectedShops.add(
                                        SupportedShopModel(
                                          id: shop.id!,
                                          name: shop.shopName,
                                          shopAddress: shop.shopAddress,
                                          shopPhone: shop.shopPhone,
                                          shopEmail: shop.shopEmail,
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? _GiftPageColors.orange50.withOpacity(
                                            0.5,
                                          )
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? _GiftPageColors.brandStart
                                          : _GiftPageColors.slate200,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              _GiftPageColors.brandStart,
                                              _GiftPageColors.brandEnd,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: _GiftPageColors.brandStart
                                                  .withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            shop.shopName
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              shop.shopName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: _GiftPageColors.slate900,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              shop.shopAddress,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: _GiftPageColors.slate500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? _GiftPageColors.brandStart
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: isSelected
                                                ? _GiftPageColors.brandStart
                                                : _GiftPageColors.slate300,
                                            width: 2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? const Icon(
                                                Icons.check,
                                                size: 14,
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Bottom Action Button
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: _GiftPageColors.slate100),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedShops = tempSelectedShops;
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _GiftPageColors.slate900,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Confirm Selection',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: _GiftPageColors.brandStart,
              ),
            ),
          ),
          error: (error, stack) => Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            padding: const EdgeInsets.all(24),
            child: const Text(
              'Error loading shops',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      },
    );
  }

  void _removeShop(String shopId) {
    setState(() {
      _selectedShops.removeWhere((shop) => shop.id == shopId);
    });
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      // Check if at least one shop is selected
      if (_selectedShops.isEmpty) {
        showToastAtTop(context, 'Please select at least one shop', false);
        return;
      }

      if (_isEditMode) {
        // Handle edit gift
        ref
            .read(addEditAutoRedeemableGiftControllerProvider.notifier)
            .editGift(
              existingGift: widget.existingGift!,
              giftName: _giftNameController.text,
              giftDescription: _descriptionController.text,
              selectedShops: _selectedShops,
              totalGifts: _totalGiftsController.text,
              remainingQuantity:
                  int.parse(_totalGiftsController.text) -
                  (widget.existingGift!.totalQuantity -
                      widget.existingGift!.remainingQuantity),
            );
      } else {
        // Handle create gift
        ref
            .read(addEditAutoRedeemableGiftControllerProvider.notifier)
            .saveGift(
              campaignId: widget.campaignId!,
              campaignName: widget.campaignName!,
              giftName: _giftNameController.text,
              giftDescription: _descriptionController.text,
              selectedShops: _selectedShops,
              totalGifts: _totalGiftsController.text,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addEditAutoRedeemableGiftControllerProvider, (previous, next) {
      next.when(
        data: (gift) {
          if (gift != null) {
            ref.refresh(
              campaignGiftListControllerProvider(
                campaignId: widget.campaignId!,
              ),
            );

            ref
                .read(currentCampaignSelectionControllerProvider.notifier)
                .reloadCurrentCampaignFromSource();
            // ..refresh(vendorsCampaignListControllerProvider);

            // ref
            //     .read(currentCampaignSelectionControllerProvider.notifier)
            //     .updateTotalGiftsAdded(
            //       (ref
            //                   .read(
            //                       currentCampaignSelectionControllerProvider)
            //                   .value
            //                   ?.totalGiftsAdded ??
            //               0) +
            //           int.parse(_totalGiftsController.text),
            //     );
            // Navigator.pop(
            //     context, (gift.name, gift.description, gift.totalQuantity));
            Navigator.pop(context);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(
            //       _isEditMode
            //           ? 'Gift updated successfully!'
            //           : 'Gift created successfully!',
            //     ),
            //     backgroundColor: Colors.green.shade600,
            //     behavior: SnackBarBehavior.floating,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // );

            showToastAtTop(
              context,
              _isEditMode
                  ? 'Gift updated successfully!'
                  : 'Gift created successfully!',
              true,
            );

            Navigator.pop(context, gift);
          }
        },
        loading: () {
          // Optionally show a loading indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const CircularProgressIndicator(
                    color: _GiftPageColors.brandStart,
                  ),
                ),
              );
            },
          );
        },
        error: (error, stack) {
          Navigator.pop(context); // Dismiss loading indicator
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: const Text('Error loading shops'),
          //     backgroundColor: Colors.red,
          //     behavior: SnackBarBehavior.floating,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          // );
          showToastAtTop(context, 'Error loading shops', false);
        },
      );
    });

    return Scaffold(
      backgroundColor: _GiftPageColors.slate50,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: _GiftPageColors.slate50.withOpacity(0.9),
                border: const Border(
                  bottom: BorderSide(color: _GiftPageColors.slate200),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.chevron_left,
                            color: _GiftPageColors.slate500,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Title
                      Text(
                        _isEditMode ? 'Edit Gift' : 'Add Gift',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _GiftPageColors.slate900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Main Content
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.of(context).padding.top + 64 + 24,
                20,
                120,
              ),
              children: [
                // Gift Name Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gift Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _GiftPageColors.slate700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _giftNameController,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _GiftPageColors.slate900,
                      ),
                      decoration: _buildInputDecoration(
                        label: '',
                        placeholder: 'e.g., Free Coffee Voucher',
                      ).copyWith(labelText: null),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Gift name is required';
                        }
                        if (value.length > 100) {
                          return 'Gift name cannot exceed 100 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Description Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _GiftPageColors.slate700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _descriptionController,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _GiftPageColors.slate900,
                      ),
                      decoration: _buildInputDecoration(
                        label: '',
                        placeholder: 'Describe the gift...',
                      ).copyWith(labelText: null),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Description is required';
                        }
                        if (value.length > 500) {
                          return 'Description cannot exceed 500 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Total Gifts Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Available Quantity',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _GiftPageColors.slate700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _totalGiftsController,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _GiftPageColors.slate900,
                      ),
                      decoration:
                          _buildInputDecoration(
                            label: '',
                            placeholder:
                                _isEditMode && widget.existingGift != null
                                ? 'Range: ${widget.existingGift!.totalQuantity - widget.existingGift!.remainingQuantity}-${widget.totalAllowedGifts}'
                                : 'Max: ${widget.totalAllowedGifts}',
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 16, right: 8),
                              child: Icon(
                                Icons.confirmation_number_outlined,
                                color: _GiftPageColors.slate400,
                                size: 20,
                              ),
                            ),
                          ).copyWith(
                            labelText: null,
                            helperText:
                                _isEditMode && widget.existingGift != null
                                ? 'Range: ${widget.existingGift!.totalQuantity - widget.existingGift!.remainingQuantity} (used) to ${widget.totalAllowedGifts} (max)'
                                : 'Maximum ${widget.totalAllowedGifts} gifts allowed',
                            helperStyle: const TextStyle(
                              fontSize: 12,
                              color: _GiftPageColors.slate500,
                            ),
                          ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        // TextInputFormatter.withFunction((oldValue, newValue) {
                        //   if (newValue.text.isEmpty) {
                        //     return newValue;
                        //   }
                        //   final number = int.tryParse(newValue.text);
                        //   if (number == null ||
                        //       number > widget.totalAllowedGifts) {
                        //     return oldValue;
                        //   }
                        //   // For edit mode, check lower limit
                        //   if (_isEditMode && widget.existingGift != null) {
                        //     final usedGifts =
                        //         widget.existingGift!.totalQuantity -
                        //         widget.existingGift!.remainingQuantity;
                        //     if (number < usedGifts) {
                        //       return oldValue;
                        //     }
                        //   }
                        //   return newValue;
                        // }),
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Total gifts is required';
                        }
                        final number = int.tryParse(value);
                        if (number == null || number <= 0) {
                          return 'Please enter a valid number greater than 0';
                        }

                        // For edit mode, check lower limit (used gifts)
                        if (_isEditMode && widget.existingGift != null) {
                          final usedGifts =
                              widget.existingGift!.totalQuantity -
                              widget.existingGift!.remainingQuantity;
                          if (number < usedGifts) {
                            return 'Cannot be less than $usedGifts (already used/redeemed)';
                          }
                        }

                        if (number > widget.totalAllowedGifts) {
                          return 'Cannot exceed ${widget.totalAllowedGifts} gifts';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Supported Shops Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _GiftPageColors.slate100),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.storefront,
                                color: _GiftPageColors.orange500,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Supported Shops',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: _GiftPageColors.slate900,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '*',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red.shade600,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: _showShopSelectionModal,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _GiftPageColors.orange50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 14,
                                    color: _GiftPageColors.brandStart,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Add',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: _GiftPageColors.brandStart,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Selected Shops Display
                      if (_selectedShops.isEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: BoxDecoration(
                            color: _GiftPageColors.slate50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _GiftPageColors.slate200,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _GiftPageColors.slate100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.storefront_outlined,
                                  color: _GiftPageColors.slate400,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'No shops selected.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _GiftPageColors.slate500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Tap "Add" to select redemption locations.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _GiftPageColors.slate500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      else
                        Column(
                          children: _selectedShops.map((shop) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _GiftPageColors.slate200,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            _GiftPageColors.brandStart,
                                            _GiftPageColors.brandEnd,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Text(
                                          shop.name
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            shop.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: _GiftPageColors.slate800,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            shop.shopAddress,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: _GiftPageColors.slate500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _removeShop(shop.id),
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: _GiftPageColors.slate400,
                                          size: 20,
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
                ),
              ],
            ),
          ),

          // Sticky Footer
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    MediaQuery.of(context).padding.bottom + 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    border: const Border(
                      top: BorderSide(color: _GiftPageColors.slate200),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: _handleSave,
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _GiftPageColors.brandStart,
                            _GiftPageColors.brandEnd,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _GiftPageColors.brandStart.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isEditMode ? 'Update Gift' : 'Create Gift',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
