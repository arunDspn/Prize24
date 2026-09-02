import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/campaign/presentation/add_edit_vendor_campaign/view_model/add_edit_vendor_campaign_controller.dart';
import 'package:prize24_app/features/campaign/presentation/add_edit_vendor_campaign/view_model/public_slug_availabilty_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/vendors_campaign_list_controller.dart';

// ============================================================================
// DESIGN SYSTEM - Matching HTML/Tailwind Styles
// ============================================================================

class _AppColors {
  // Slate palette
  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate700 = Color(0xFF334155);
  static const slate900 = Color(0xFF0F172A);

  // Brand gradient colors
  static const brandStart = Color(0xFFFF5F6D);
  static const brandEnd = Color(0xFFFFC371);

  // Focus/accent (orange)
  static const orangeAccent = Color(0xFFFF9500);

  // Status colors
  static const blue50 = Color(0xFFEFF6FF);
  static const blue100 = Color(0xFFDBEAFE);
  static const blue500 = Color(0xFF3B82F6);
  static const blue700 = Color(0xFF1D4ED8);

  static const green500 = Color(0xFF22C55E);
  static const green600 = Color(0xFF16A34A);

  static const red500 = Color(0xFFEF4444);
}

class _AppShadows {
  static const soft = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 20,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
  ];
}

class AddEditVendorCampaginPage extends ConsumerStatefulWidget {
  const AddEditVendorCampaginPage({required this.existingCampaign, super.key});

  final CampaignModel? existingCampaign;

  @override
  ConsumerState<AddEditVendorCampaginPage> createState() =>
      _AddEditVendorCampaginPageState();
}

class _AddEditVendorCampaginPageState
    extends ConsumerState<AddEditVendorCampaginPage> {
  final _formKey = GlobalKey<FormState>();

  static const String _fixedTotalParticipantsDisplay = '1,00,00,000';
  static const String _fixedTotalGiftsDisplay = '1,00,00,000';
  static const int _fixedTotalParticipantsValue = 10000000;
  static const int _fixedTotalGiftsValue = 10000000;

  // Controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  // final TextEditingController _totalParticipantsController =
  //     TextEditingController();
  // final TextEditingController _totalGiftsController = TextEditingController();
  final TextEditingController _publicSlugController = TextEditingController();

  bool? _isSlugAvailable;
  Timer? _debounceTimer;

  // Dropdown values
  CampaignVisibility? _selectedVisibility = CampaignVisibility.private;
  GiftType? _selectedGiftType = GiftType.auto;

  // Check slug availability
  Future<void> _checkSlugAvailability(String slug) async {
    if (slug.isEmpty) {
      setState(() {
        _isSlugAvailable = null;
      });
      return;
    }

    // Call the controller to check slug availability
    ref
        .read(publicSlugAvailabiltyControllerProvider.notifier)
        .checkSlugAvailability(slug: slug);
  }

  // Add a listener to the controller to update _publicSlugController
  void _setupSlugAvailabilityListener() {
    _publicSlugController.addListener(() {
      // Reset slug availability status when typing
      if (_isSlugAvailable != null) {
        setState(() {
          _isSlugAvailable = null;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Listen to title changes to auto-generate slug
    _titleController.addListener(_generateSlugFromTitle);

    // Listen to slug changes to reset availability status
    _setupSlugAvailabilityListener();

    // Populate form fields if editing an existing campaign
    if (widget.existingCampaign != null) {
      _populateFormWithExistingData();
    }
  }

  void _populateFormWithExistingData() {
    final campaign = widget.existingCampaign!;

    // Populate text controllers
    _titleController.text = campaign.name;
    _descriptionController.text = campaign.description;
    // _totalParticipantsController.text = campaign.totalParticipants.toString();
    // _totalGiftsController.text = campaign.totalGifts.toString();

    // Set dropdown values
    _selectedVisibility = campaign.visibility;
    _selectedGiftType = campaign.allowedGiftType;

    // Populate public slug if campaign is public
    if (campaign.visibility == CampaignVisibility.public &&
        campaign.publicSlug != null) {
      _publicSlugController.text = campaign.publicSlug!;
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _titleController
      ..removeListener(_generateSlugFromTitle)
      ..dispose();
    _descriptionController.dispose();
    // _totalParticipantsController.dispose();
    // _totalGiftsController.dispose();
    _publicSlugController.dispose();
    super.dispose();
  }

  void _generateSlugFromTitle() {
    if (_selectedVisibility == CampaignVisibility.public) {
      final title = _titleController.text;
      final slug = _generateSlug(title);
      _publicSlugController.text = slug;
    }
  }

  String _generateSlug(String title) {
    return title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '') // Remove special characters
        .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
        .replaceAll(RegExp(r'-+'), '-') // Replace multiple hyphens with single
        .replaceAll(RegExp(r'^-|-$'), ''); // Remove leading/trailing hyphens
  }

  // Check if all conditions are met to enable the save button
  // bool _isSaveButtonEnabled() {
  //   // If editing an existing campaign, no need to check slug availability
  //   if (widget.existingCampaign != null) {
  //     return true;
  //   }
  //
  //   // For new campaigns
  //   final isBasicInfoFilled =
  //       _titleController.text.isNotEmpty &&
  //       _descriptionController.text.isNotEmpty &&
  //       _selectedVisibility != null &&
  //       _selectedGiftType != null;
  //
  //   // If it's a private campaign, just check basic info
  //   if (_selectedVisibility == CampaignVisibility.private) {
  //     return isBasicInfoFilled;
  //   }
  //
  //   // For public campaigns, also check slug availability
  //   if (_selectedVisibility == CampaignVisibility.public) {
  //     return isBasicInfoFilled &&
  //         _publicSlugController.text.isNotEmpty &&
  //         _isSlugAvailable == true; // Must be explicitly true
  //   }
  //
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    // Listen to the slug availability controller
    ref
      ..listen(publicSlugAvailabiltyControllerProvider, (previous, next) {
        next.when(
          data: (isAvailable) {
            setState(() {
              _isSlugAvailable = isAvailable;
            });
          },
          loading: () {},
          error: (_, __) {
            setState(() {
              _isSlugAvailable = false;
            });
          },
        );
      })
      // Listen to the controller state
      ..listen(addEditVendorCampaignControllerProvider, (previous, next) {
        next.maybeWhen(
          orElse: () {},
          loading: () {
            // Show loading indicator using root navigator
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              useRootNavigator: true,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          },
          error: (error, stackTrace) {
            // Hide loading indicator from root navigator
            Navigator.of(context, rootNavigator: true).pop();
            // Show error message
            showToastAtTop(context, 'Something went wrong', false);
          },
          data: (data) {
            if (data == null) return;
            // Hide loading indicator from root navigator
            ref.invalidate(vendorsCampaignListControllerProvider);
            Navigator.of(context, rootNavigator: true).pop();
            // Show success message
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(widget.existingCampaign != null
            //         ? 'Campaign updated successfully!'
            //         : 'Campaign added successfully!'),
            //     backgroundColor: Colors.green,
            //   ),
            // );

            showToastAtTop(
              context,
              widget.existingCampaign != null
                  ? 'Campaign updated successfully!'
                  : 'Campaign added successfully!',
              true,
            );

            // Invalidate campaign list to refresh
            ref.invalidate(addEditVendorCampaignControllerProvider);

            // Navigate back to previous page
            // context.pop();

            // todo: CHeck if we need to refresh campaign list
            // Navigate back after successful update
            // if (widget.existingCampaign != null) {
            //   context.pop();
            // } else {
            //   // Reset form for add mode
            //   _formKey.currentState?.reset();
            //   _titleController.clear();
            //   _descriptionController.clear();
            //   _totalParticipantsController.clear();
            //   _totalGiftsController.clear();
            //   _publicSlugController.clear();
            //   setState(() {
            //     _selectedVisibility = null;
            //     _selectedGiftType = null;
            //   });
            // }
          },
        );
      });
    return Scaffold(
      backgroundColor: _AppColors.slate50,
      body: Stack(
        children: [
          // Main content
          CustomScrollView(
            slivers: [
              // Frosted Glass AppBar
              SliverAppBar(
                pinned: true,
                backgroundColor: _AppColors.slate50.withOpacity(0.9),
                elevation: 0,
                scrolledUnderElevation: 0,
                toolbarHeight: 64,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: _AppColors.slate500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  widget.existingCampaign != null
                      ? 'Edit Campaign'
                      : 'Add Campaign',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _AppColors.slate900,
                  ),
                ),
                centerTitle: false,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1),
                  child: Container(height: 1, color: _AppColors.slate200),
                ),
              ),

              // Form Content
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 140),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Info Note (Edit Mode)
                          if (widget.existingCampaign != null) ...[
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _AppColors.blue50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _AppColors.blue100),
                              ),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_rounded,
                                    color: _AppColors.blue500,
                                    size: 20,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Note: Campaign visibility, gift type, and public slug cannot be changed after creation.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _AppColors.blue700,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Campaign Title Field
                          _buildStyledTextField(
                            label: 'Campaign Title',
                            controller: _titleController,
                            hintText: 'e.g., Summer Blowout Sale',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter campaign title';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Description Field
                          _buildStyledTextField(
                            label: 'Description',
                            controller: _descriptionController,
                            hintText: 'Describe your campaign...',
                            maxLines: 4,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter campaign description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Stats Grid (2 columns)
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: _buildStyledTextField(
                          //         label: 'Total Participants',
                          //         controller: null,
                          //         initialValue: _fixedTotalParticipantsDisplay,
                          //         hintText: _fixedTotalParticipantsDisplay,
                          //         enabled: false,
                          //         readOnly: true,
                          //         validator: (_) => null,
                          //       ),
                          //     ),
                          //     const SizedBox(width: 16),
                          //     Expanded(
                          //       child: _buildStyledTextField(
                          //         label: 'Total Gifts',
                          //         controller: null,
                          //         initialValue: _fixedTotalGiftsDisplay,
                          //         hintText: _fixedTotalGiftsDisplay,
                          //         enabled: false,
                          //         readOnly: true,
                          //         validator: (_) => null,
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // Only show Visibility, Gift Type, and Slug for ADD mode
                          if (widget.existingCampaign == null) ...[
                            const SizedBox(height: 24),

                            // Divider
                            Container(height: 1, color: _AppColors.slate200),
                            const SizedBox(height: 24),

                            // Visibility Select
                            _buildStyledDropdown<CampaignVisibility>(
                              label: 'Visibility',
                              value: _selectedVisibility,
                              enabled: true,
                              items: CampaignVisibility.values,
                              itemLabel: (item) {
                                switch (item) {
                                  case CampaignVisibility.private:
                                    return 'Private (Invite Only)';
                                  case CampaignVisibility.public:
                                    return 'Public (Open to All)';
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  _selectedVisibility = value;
                                  if (value == CampaignVisibility.public) {
                                    _generateSlugFromTitle();
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 24),

                            // // Gift Type Select
                            // _buildStyledDropdown<GiftType>(
                            //   label: 'Gift Type',
                            //   value: _selectedGiftType,
                            //   enabled: true,
                            //   items: GiftType.values,
                            //   itemLabel: (item) {
                            //     switch (item) {
                            //       case GiftType.auto:
                            //         return 'Auto (Automatic Distribution)';
                            //       case GiftType.code:
                            //         return 'Code (Manual Redemption)';
                            //     }
                            //   },
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _selectedGiftType = value;
                            //     });
                            //   },
                            // ),

                            // Public Slug Section (only for public visibility)
                            if (_selectedVisibility ==
                                CampaignVisibility.public) ...[
                              const SizedBox(height: 24),
                              _buildPublicSlugField(),
                              const SizedBox(height: 12),
                              _buildSlugFeedback(),
                            ],
                          ],
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),

          // Sticky Footer Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: const Border(
                  top: BorderSide(color: _AppColors.slate200),
                ),
              ),
              child: ClipRRect(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 672),
                  child: _buildGradientButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.existingCampaign != null) {
                          // Edit existing campaign
                          ref
                              .read(
                                addEditVendorCampaignControllerProvider
                                    .notifier,
                              )
                              .editCampaign(
                                id: widget.existingCampaign!.id!,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                totalParticipants: _fixedTotalParticipantsValue,
                                totalGifts: _fixedTotalGiftsValue,
                                existingCampaign: widget.existingCampaign!,
                              );
                        } else {
                          // Add new campaign
                          ref
                              .read(
                                addEditVendorCampaignControllerProvider
                                    .notifier,
                              )
                              .addCampaign(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                totalParticipants: _fixedTotalParticipantsValue,
                                totalGifts: _fixedTotalGiftsValue,
                                visibility: _selectedVisibility!,
                                allowedGiftType: _selectedGiftType!,
                                publicSlug:
                                    _selectedVisibility ==
                                        CampaignVisibility.public
                                    ? _publicSlugController.text.trim().isEmpty
                                          ? null
                                          : _publicSlugController.text.trim()
                                    : null,
                              );
                        }
                      }
                    },
                    icon: Icons.save_rounded,
                    text: widget.existingCampaign != null
                        ? 'Update Campaign'
                        : 'Save Campaign',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // STYLED FORM WIDGETS
  // ============================================================================

  Widget _buildStyledTextField({
    required String label,
    TextEditingController? controller,
    String? initialValue,
    required String hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool enabled = true,
    bool readOnly = false,
    Widget? prefix,
    Widget? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _AppColors.slate700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _AppColors.slate900,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _AppColors.slate400,
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: prefix,
            suffixIcon: suffix,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _AppColors.slate200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _AppColors.slate200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _AppColors.orangeAccent.withOpacity(0.8),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _AppColors.red500),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _AppColors.red500, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _AppColors.slate200.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStyledDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) itemLabel,
    required void Function(T?) onChanged,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _AppColors.slate700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: enabled ? Colors.white : _AppColors.slate100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _AppColors.slate200),
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            onChanged: enabled ? onChanged : null,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: _AppColors.slate500,
            ),
            dropdownColor: Colors.white,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _AppColors.slate900,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  itemLabel(item),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _AppColors.slate900,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPublicSlugField() {
    final slugAvailabilityState = ref.watch(
      publicSlugAvailabiltyControllerProvider,
    );
    final isLoading = slugAvailabilityState.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Public Slug',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _AppColors.slate700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _publicSlugController,
          enabled: widget.existingCampaign == null,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _AppColors.slate900,
          ),
          decoration: InputDecoration(
            hintText: 'campaign-name',
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _AppColors.slate400,
            ),
            filled: true,
            fillColor: Colors.white,
            prefix: const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Text(
                'prize24.app/',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _AppColors.slate400,
                ),
              ),
            ),
            suffixIcon: _buildSlugStatusIcon(isLoading),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _AppColors.slate200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _AppColors.slate200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _AppColors.orangeAccent.withOpacity(0.8),
                width: 2,
              ),
            ),
          ),
          onChanged: (value) {
            // Cancel previous timer
            _debounceTimer?.cancel();

            // Reset availability status while typing
            if (_isSlugAvailable != null) {
              setState(() {
                _isSlugAvailable = null;
              });
            }

            // Start new debounce timer (800ms delay)
            _debounceTimer = Timer(const Duration(milliseconds: 800), () {
              _checkSlugAvailability(value);
            });
          },
        ),
      ],
    );
  }

  Widget? _buildSlugStatusIcon(bool isLoading) {
    if (isLoading) {
      return Container(
        padding: const EdgeInsets.all(14),
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(_AppColors.orangeAccent),
          ),
        ),
      );
    }

    if (_isSlugAvailable == true) {
      return const Icon(Icons.check_circle_rounded, color: _AppColors.green500);
    }

    if (_isSlugAvailable == false) {
      return const Icon(Icons.cancel_rounded, color: _AppColors.red500);
    }

    return null;
  }

  Widget _buildSlugFeedback() {
    if (_isSlugAvailable == true) {
      return const Text(
        'Slug is available!',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _AppColors.green600,
        ),
      );
    }

    if (_isSlugAvailable == false) {
      return const Text(
        'Slug is already taken.',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _AppColors.red500,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildGradientButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String text,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_AppColors.brandStart, _AppColors.brandEnd],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _AppShadows.soft,
          ),
          child: Container(
            height: 56,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
