import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/t_primary_button.dart';
import 'package:prize24_app/common_widgets/t_primary_text_form_field.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/campaign/presentation/vendor_campaign_detail/components/campaign_gift_list/view_model/campaign_gift_list_controller.dart';
import 'package:prize24_app/features/gift/domain/models/gift_model.dart';
import 'package:prize24_app/features/gift/presentation/add_edit_gift/view_model/add_edit_gift_view_model.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_shop_list/view_model/vendor_shop_list_controller.dart';

class AddNewGiftUIDataParcel {
  AddNewGiftUIDataParcel({
    required this.isPublic,
    required this.giftType,
    required this.campaignName,
    required this.campaignId,
    required this.userId,
    required this.allowedTotalGifts,
    this.existingGift,
  });
  final bool isPublic;
  final GiftType giftType;
  final String campaignName;
  final String campaignId;
  final String userId;
  final int allowedTotalGifts;

  final GiftModel? existingGift;
}

class AddEditGiftPage extends ConsumerWidget {
  const AddEditGiftPage({
    required this.uiData,
    // set to null when creating a new gift
    // this.existingGift,
    // this.autoGiftPayloads,
    // this.codeGiftCodes,
    super.key,
  })  : existingGift = null,
        autoGiftPayloads = null,
        codeGiftCodes = null;

  // Named constructor to edit an existing gift
  const AddEditGiftPage.edit({
    required this.existingGift,
    this.autoGiftPayloads,
    this.codeGiftCodes,
    super.key,
  }) : uiData = null;

  final GiftModel? existingGift;
  final List<AutoGiftPayloadModel>? autoGiftPayloads;
  final List<CodeGiftCodeModel>? codeGiftCodes;
  final AddNewGiftUIDataParcel? uiData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopListState = ref.watch(vendorShopListControllerProvider);

    return shopListState.when(
      data: (shops) {
        if (uiData != null) {
          return AddEditGiftPageBody(
            // isPublic: uiData!.isPublic,
            // giftType: uiData!.giftType,
            isPublic: true,
            giftType: GiftType.auto,
            campaignName: uiData!.campaignName,
            campaignId: uiData!.campaignId,
            userId: uiData!.userId,
            allowedTotalGifts: uiData!.allowedTotalGifts,
            existingGift: uiData!.existingGift,
            availableShops: shops,
          );
        } else {
          // throw Exception('UI data parcel is null');
          return AddEditGiftPageBody(
            isPublic: true,
            giftType: GiftType.auto,
            campaignName: existingGift!.campaignName,
            campaignId: existingGift!.campaignId,
            userId: existingGift!.userId,
            allowedTotalGifts: existingGift!.totalQuantity,
            existingGift: existingGift,
            availableShops: shops,
          );
        }
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            'Error loading shops',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class AddEditGiftPageBody extends ConsumerStatefulWidget {
  const AddEditGiftPageBody({
    required this.isPublic,
    required this.giftType,
    required this.campaignName,
    required this.campaignId,
    required this.userId,
    required this.allowedTotalGifts,
    required this.availableShops,
    this.existingGift,
    super.key,
  });

  final bool isPublic;
  final GiftType giftType;
  final String campaignName;
  final String campaignId;
  final String userId;
  final int allowedTotalGifts;
  final GiftModel? existingGift;
  final List<ShopModel> availableShops;

  @override
  ConsumerState<AddEditGiftPageBody> createState() => _AddEditGiftPageState();
}

class _AddEditGiftPageState extends ConsumerState<AddEditGiftPageBody> {
  final _formKey = GlobalKey<FormState>();
  List<ShopModel> _availableShops =
      []; // This would come from a repository/provider

  // Controllers for form fields
  late final TextEditingController _giftNameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _totalGiftsController;
  late final TextEditingController _plugSlugNameController;

  // Listener functions
  void _onTotalGiftsChanged() {
    final text = _totalGiftsController.text;
    final number = int.tryParse(text);

    // Prevent entering numbers that exceed the allowed total gifts
    if (number != null && number > widget.allowedTotalGifts) {
      final selection = _totalGiftsController.selection;
      _totalGiftsController.value = TextEditingValue(
        text: widget.allowedTotalGifts.toString(),
        selection: selection.copyWith(
          baseOffset: widget.allowedTotalGifts.toString().length,
          extentOffset: widget.allowedTotalGifts.toString().length,
        ),
      );
      return;
    }

    ref.read(addEditGiftViewModelProvider.notifier).updateTotalGifts(
        _totalGiftsController.text,
        giftType: widget.giftType);
  }

  void _onPlugSlugNameChanged() {
    final current = _plugSlugNameController.text;
    final formatted = current
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9-]'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');

    if (formatted != current) {
      final selection = _plugSlugNameController.selection;
      _plugSlugNameController.value = TextEditingValue(
        text: formatted,
        selection: selection.copyWith(
          baseOffset: formatted.length,
          extentOffset: formatted.length,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Filling _availableShops with the provided list
    _availableShops = widget.availableShops;

    // Initialize controllers
    _giftNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _totalGiftsController = TextEditingController();
    _plugSlugNameController = TextEditingController();

    // Add listener to total gifts controller (only for AUTO type gifts)
    if (widget.giftType == GiftType.auto) {
      _totalGiftsController.addListener(_onTotalGiftsChanged);
    }

    // Add listener to plug slug name controller for public campaigns
    if (widget.isPublic) {
      _plugSlugNameController.addListener(_onPlugSlugNameChanged);
    }

    // Initialize view model with existing gift if in edit mode
    if (widget.existingGift != null) {
      // throw Exception(
      //     'Existing gift should not be null when initializing for edit mode');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final viewModel = ref.read(addEditGiftViewModelProvider.notifier);
        // viewModel.initializeForEdit(widget.existingGift!);

        // Update controllers with the loaded data
        final state = ref.read(addEditGiftViewModelProvider);
        _giftNameController.text = state.giftName;
        _descriptionController.text = state.description;
        _totalGiftsController.text = state.totalGifts;
        _plugSlugNameController.text = state.plugSlugName;
      });
    } else {
      // Initialize for create mode
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final viewModel = ref.read(addEditGiftViewModelProvider.notifier);
        // Add initial code field for code type gifts
        if (widget.giftType == GiftType.code) {
          viewModel.addGiftCode();
        }
      });
    }

    // Mock shops data - in real app this would come from a provider
    // _availableShops = [
    //   const ShopModel(
    //     id: '1',
    //     shopName: 'Coffee Shop A',
    //     shopPhone: '+1234567890',
    //     shopAddress: '123 Main St',
    //     shopOwnerId: 'owner1',
    //     shopDescription: 'Great coffee shop',
    //   ),
    //   const ShopModel(
    //     id: '2',
    //     shopName: 'Restaurant B',
    //     shopPhone: '+1234567891',
    //     shopAddress: '456 Oak Ave',
    //     shopOwnerId: 'owner2',
    //     shopDescription: 'Fine dining restaurant',
    //   ),
    // ];
  }

  @override
  void dispose() {
    // Remove listener only if it was added (for AUTO type gifts)
    if (widget.giftType == GiftType.auto) {
      _totalGiftsController.removeListener(_onTotalGiftsChanged);
    }

    // Remove plug slug name listener if it was added
    if (widget.isPublic) {
      _plugSlugNameController.removeListener(_onPlugSlugNameChanged);
    }

    _giftNameController.dispose();
    _descriptionController.dispose();
    _totalGiftsController.dispose();
    _plugSlugNameController.dispose();
    super.dispose();
  }

  void _showShopSelector(
      AddEditGiftViewModel viewModel, AddEditGiftState state) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Shops'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _availableShops.length,
            itemBuilder: (context, index) {
              final shop = _availableShops[index];
              final isSelected = state.selectedShops.contains(shop);
              return CheckboxListTile(
                title: Text(shop.shopName),
                subtitle: Text(shop.shopAddress),
                value: isSelected,
                onChanged: (selected) {
                  if (selected == true) {
                    viewModel.addSelectedShop(shop);
                  } else {
                    viewModel.removeSelectedShop(shop);
                  }
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveGift(AddEditGiftViewModel viewModel) async {
    // Sync controller values with view model
    viewModel.updateGiftName(_giftNameController.text);
    viewModel.updateDescription(_descriptionController.text);

    // Only update total gifts from controller for AUTO type gifts
    // For CODE type gifts, total gifts is managed automatically by the number of codes
    if (widget.giftType == GiftType.auto) {
      viewModel.updateTotalGifts(_totalGiftsController.text,
          giftType: widget.giftType);
    }

    viewModel.updatePlugSlugName(_plugSlugNameController.text);

    final result = await viewModel.saveGift(
      giftType: widget.giftType,
      campaignId: widget.campaignId,
      campaignName: widget.campaignName,
      // userId: widget.userId,
      isPublicCampaign: widget.isPublic,
    );

    ref.refresh(
      campaignGiftListControllerProvider(campaignId: widget.campaignId),
    );

    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.existingGift != null
                ? 'Gift updated successfully!'
                : 'Gift created successfully!',
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen(
    //   addEditGiftViewModelProvider,
    //   (previous, next) {
    //     next.when((giftName, description, totalGifts, isRedeemable, plugSlugName, giftCodes, giftPayloads, selectedShops, isLoading, isSubmitting, errorMessage, fieldErrors, existingGift) => ,)
    //   },
    // );

    final state = ref.watch(addEditGiftViewModelProvider);
    final viewModel = ref.read(addEditGiftViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingGift != null ? 'Edit Gift' : 'Add Gift'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Error message display
              if (state.errorMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: viewModel.clearError,
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ],
                  ),
                ),

              // Campaign Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Campaign: ${widget.campaignName}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Type: ${widget.giftType.name.toUpperCase()} • ${widget.isPublic ? 'Public' : 'Private'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Common Fields
              TPrimaryTextFormField(
                controller: _giftNameController,
                label: 'Gift Name',
                hint: 'Enter gift name',
                icon: Icons.card_giftcard,
                validator: (value) {
                  final error = state.fieldErrors['giftName'];
                  if (error != null) return error;
                  if (value?.isEmpty ?? true) return 'Gift name is required';
                  if (value!.length > 100)
                    return 'Gift name must be less than 100 characters';
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TPrimaryTextFormField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter gift description',
                icon: Icons.description,
                maxLines: 3,
                validator: (value) {
                  final error = state.fieldErrors['description'];
                  if (error != null) return error;
                  if (value?.isEmpty ?? true) return 'Description is required';
                  if (value!.length > 500)
                    return 'Description must be less than 500 characters';
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Plug Slug Name Field (only for public campaigns)
              // if (widget.isPublic && widget.giftType == GiftType.code) ...[
              //   TPrimaryTextFormField(
              //     controller: _plugSlugNameController,
              //     label: 'Plug Slug Name',
              //     hint: 'Enter URL-friendly identifier (e.g., coffee-voucher)',
              //     icon: Icons.link,
              //     validator: (value) {
              //       final error = state.fieldErrors['plugSlugName'];
              //       if (error != null) return error;
              //       if (value?.isEmpty ?? true)
              //         return 'Plug slug name is required for public campaigns';
              //       final slugPattern = RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$');
              //       final trimmedValue = value!.trim().toLowerCase();
              //       if (!slugPattern.hasMatch(trimmedValue))
              //         return 'Must be lowercase, alphanumeric, and separated by hyphens';
              //       if (trimmedValue.length < 3)
              //         return 'Must be at least 3 characters long';
              //       if (trimmedValue.length > 50)
              //         return 'Must be less than 50 characters';
              //       return null;
              //     },
              //   ),
              //   const SizedBox(height: 8),
              //   // Helper text for slug format
              //   Padding(
              //     padding: const EdgeInsets.only(left: 12),
              //     child: Text(
              //       'Only lowercase letters, numbers, and hyphens allowed. Will be auto-formatted.',
              //       style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //             color: Theme.of(context).colorScheme.onSurfaceVariant,
              //           ),
              //     ),
              //   ),
              //   const SizedBox(height: 16),
              // ],

              // Is Redeemable Checkbox
              // Row(
              //   children: [
              //     Checkbox(
              //       value: state.isRedeemable,
              //       onChanged: (value) => viewModel.toggleRedeemable(
              //         value ?? false,
              //         giftType: widget.giftType,
              //       ),
              //     ),
              //     const SizedBox(width: 8),
              //     Text(
              //       'Is Redeemable',
              //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //             fontWeight: FontWeight.w600,
              //           ),
              //     ),
              //   ],
              // ),

              const SizedBox(height: 24),

              // Conditional Fields based on Gift Type
              if (widget.giftType == GiftType.auto)
                ..._buildAutoGiftFields(state, viewModel),
              if (widget.giftType == GiftType.code)
                ..._buildCodeGiftFields(state, viewModel),

              const SizedBox(height: 32),

              // Save Button
              TPrimaryButton(
                onPressed:
                    state.isSubmitting ? null : () => _saveGift(viewModel),
                text: state.isSubmitting
                    ? 'Saving...'
                    : (widget.existingGift != null
                        ? 'Update Gift'
                        : 'Save Gift'),
                icon: state.isSubmitting ? null : Icons.save,
                isLoading: state.isSubmitting,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAutoGiftFields(
      AddEditGiftState state, AddEditGiftViewModel viewModel) {
    return [
      // Total Gifts Field
      TPrimaryTextFormField(
        controller: _totalGiftsController,
        label: 'Total Gifts',
        hint: 'Enter number of gifts',
        icon: Icons.numbers,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          final error = state.fieldErrors['totalGifts'];
          if (error != null) return error;
          if (value?.isEmpty ?? true) return 'Total gifts is required';
          final number = int.tryParse(value!);
          if (number == null || number < 1) return 'Must be at least 1';
          if (number > widget.allowedTotalGifts)
            return 'You can\'t add more, please contact owner vendor (max: ${widget.allowedTotalGifts})';
          return null;
        },
      ),

      // Helper text for total gifts limit
      Padding(
        padding: const EdgeInsets.only(left: 12, top: 4),
        child: Text(
          'Maximum allowed: ${widget.allowedTotalGifts} gifts',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ),

      const SizedBox(height: 16),

      if (state.isRedeemable) ..._buildShopsField(state, viewModel),
      if (!state.isRedeemable) ..._buildPayloadFields(state, viewModel),
    ];
  }

  List<Widget> _buildCodeGiftFields(
      AddEditGiftState state, AddEditGiftViewModel viewModel) {
    return [
      // Codes Section
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gift Codes',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: state.giftCodes.length < widget.allowedTotalGifts
                    ? () => viewModel.addGiftCode()
                    : null,
                icon: const Icon(Icons.add_circle),
                color: state.giftCodes.length < widget.allowedTotalGifts
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.38),
              ),
              if (state.giftCodes.length >= widget.allowedTotalGifts)
                Text(
                  'You can\'t add more,\nplease contact owner vendor',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 8),

      // Dynamic Code Fields
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.giftCodes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  flex: state.isRedeemable ? 1 : 2,
                  child: TextFormField(
                    initialValue: state.giftCodes[index].code,
                    onChanged: (value) =>
                        viewModel.updateGiftCode(index, value),
                    decoration: InputDecoration(
                      labelText: 'Code ${index + 1}',
                      hintText: 'Enter gift code',
                      prefixIcon: const Icon(Icons.code),
                      border: const OutlineInputBorder(),
                      errorText: state.fieldErrors['code_$index'],
                    ),
                    validator: (value) {
                      final error = state.fieldErrors['code_$index'];
                      if (error != null) return error;
                      if (value?.isEmpty ?? true) return 'Code is required';
                      return null;
                    },
                  ),
                ),
                if (!state.isRedeemable) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      initialValue: state.giftCodes[index].payload,
                      onChanged: (value) =>
                          viewModel.updateGiftCodePayload(index, value),
                      decoration: InputDecoration(
                        labelText: 'Payload ${index + 1}',
                        hintText: 'Enter payload content',
                        prefixIcon: const Icon(Icons.text_fields),
                        border: const OutlineInputBorder(),
                        errorText: state.fieldErrors['payload_$index'],
                      ),
                      validator: (value) {
                        final error = state.fieldErrors['payload_$index'];
                        if (error != null) return error;
                        if (value?.isEmpty ?? true)
                          return 'Payload is required';
                        if (value!.length < 10)
                          return 'Payload must be at least 10 characters';
                        return null;
                      },
                    ),
                  ),
                ],
                const SizedBox(width: 8),
                IconButton(
                  onPressed: state.giftCodes.length > 1
                      ? () => viewModel.removeGiftCode(index)
                      : null,
                  icon: const Icon(Icons.remove_circle),
                  color: state.giftCodes.length > 1
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.38),
                ),
              ],
            ),
          );
        },
      ),

      if (state.isRedeemable) ...[
        const SizedBox(height: 16),
        ..._buildShopsField(state, viewModel),
      ],
    ];
  }

  List<Widget> _buildShopsField(
      AddEditGiftState state, AddEditGiftViewModel viewModel) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Supported Shops',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          TextButton.icon(
            onPressed: () => _showShopSelector(viewModel, state),
            icon: const Icon(Icons.add),
            label: const Text('Add Shops'),
          ),
        ],
      ),
      const SizedBox(height: 8),
      if (state.selectedShops.isEmpty)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          child: Text(
            'No shops selected. Tap "Add Shops" to select shops where this gift can be redeemed.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        )
      else
        Column(
          children: state.selectedShops.map((shop) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.store),
                title: Text(shop.shopName),
                subtitle: Text(shop.shopAddress),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => viewModel.removeSelectedShop(shop),
                ),
                tileColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }).toList(),
        ),
    ];
  }

  List<Widget> _buildPayloadFields(
      AddEditGiftState state, AddEditGiftViewModel viewModel) {
    return [
      Text(
        'Gift Payloads',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      const SizedBox(height: 8),
      if (state.giftPayloads.isEmpty)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          child: Text(
            'Enter the total number of gifts above to add payload fields.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        )
      else
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.giftPayloads.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                initialValue: state.giftPayloads[index],
                onChanged: (value) => viewModel.updateGiftPayload(index, value),
                decoration: InputDecoration(
                  labelText: 'Payload ${index + 1}',
                  hintText: 'Enter payload content (min 10 characters)',
                  prefixIcon: const Icon(Icons.text_fields),
                  border: const OutlineInputBorder(),
                  errorText: state.fieldErrors['payload_$index'],
                ),
                maxLines: 2,
                validator: (value) {
                  final error = state.fieldErrors['payload_$index'];
                  if (error != null) return error;
                  if (value?.isEmpty ?? true) return 'Payload is required';
                  if (value!.length < 10)
                    return 'Payload must be at least 10 characters';
                  return null;
                },
              ),
            );
          },
        ),
    ];
  }
}
