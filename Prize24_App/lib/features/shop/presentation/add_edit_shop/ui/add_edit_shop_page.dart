import 'package:collection/collection.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/create_club/ui/components/campaign_selection_list/campaign_selecter_list_modal.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:prize24_app/features/shop/presentation/add_edit_shop/view_model/add_edit_shop_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/vendors_campaign_list_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_shop_list/view_model/vendor_shop_list_controller.dart';

class AddOrEditShopPage extends ConsumerStatefulWidget {
  const AddOrEditShopPage({super.key, this.shop});

  final ShopModel? shop;

  @override
  ConsumerState<AddOrEditShopPage> createState() => _AddOrEditShopPageState();
}

class _AddOrEditShopPageState extends ConsumerState<AddOrEditShopPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopEmailController = TextEditingController();
  final TextEditingController _shopPhoneController = TextEditingController();
  final TextEditingController _shopAddressController = TextEditingController();
  final TextEditingController _shopDescriptionController =
      TextEditingController();
  final TextEditingController _giftCycleDayController = TextEditingController();

  Country _selectedCountryCode = Country(
    name: 'India',
    code: 'IN',
    dialCode: '+91',
    flagUri: 'assets/flags/in.png',
  );

  // Focus nodes for input focus states
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _cycleFocus = FocusNode();

  // Selected Campaign
  CampaignModel? _selectedCampaign;
  bool _hasInitializedCampaign = false;

  // Animation controller for fade-in
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Loading state
  bool _isLoading = false;

  // Colors from design
  static const Color _slate50 = Color(0xFFF8FAFC);
  static const Color _slate100 = Color(0xFFF1F5F9);
  static const Color _slate200 = Color(0xFFE2E8F0);
  static const Color _slate300 = Color(0xFFCBD5E1);
  static const Color _slate400 = Color(0xFF94A3B8);
  static const Color _slate500 = Color(0xFF64748B);
  static const Color _slate700 = Color(0xFF334155);
  static const Color _slate900 = Color(0xFF0F172A);
  static const Color _brandStart = Color(0xFFFF5F6D);
  static const Color _brandEnd = Color(0xFFFFC371);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();

    if (widget.shop != null) {
      _shopNameController.text = widget.shop!.shopName;
      _shopEmailController.text = widget.shop!.shopEmail ?? '';
      _shopPhoneController.text = widget.shop!.shopPhone.replaceFirst(
        RegExp(r'^\+\d{1,4}'),
        '',
      );
      _shopAddressController.text = widget.shop!.shopAddress;
      _shopDescriptionController.text = widget.shop!.shopDescription ?? '';
      _giftCycleDayController.text = widget.shop!.giftCycleDay.toString();
      // _selectedCampaign = widget.shop!.associatedCampaignId
    }
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _shopEmailController.dispose();
    _shopPhoneController.dispose();
    _shopAddressController.dispose();
    _shopDescriptionController.dispose();
    _giftCycleDayController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    _descFocus.dispose();
    _cycleFocus.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addEditShopControllerProvider, (previous, next) {
      next.when(
        data: (data) {
          if (data != null) {
            setState(() => _isLoading = false);
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop(data);
            }

            // ref
            //     .read(vendorShopListControllerProvider.notifier)
            //     .locallyUpdateShop(data);

            final _ = ref.refresh(vendorShopListControllerProvider);

            _showToast(
              'Shop ${widget.shop == null ? 'added' : 'updated'} successfully!',
              isSuccess: true,
            );

            // Future.delayed(const Duration(milliseconds: 1500), () {
            //   if (mounted) Navigator.of(context).pop(data);
            // });
          }
        },
        loading: () {
          setState(() => _isLoading = true);
        },
        error: (error, stackTrace) {
          setState(() => _isLoading = false);
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          _showToast(
            'Error updating shop. Please try again.',
            isSuccess: false,
          );
        },
      );
    });

    final campaigns = ref.watch(vendorsCampaignListControllerProvider);

    return Scaffold(
      backgroundColor: _slate50,
      body: campaigns.when(
        data: (data) {
          if (!_hasInitializedCampaign &&
              widget.shop != null &&
              widget.shop!.associatedCampaignId != null) {
            final associatedCampaign = data.firstWhereOrNull(
              (campaign) => campaign.id == widget.shop!.associatedCampaignId,
            );
            _selectedCampaign = associatedCampaign;
            _hasInitializedCampaign = true;
          }

          return Column(
            children: [
              // Custom AppBar with frosted glass effect
              _buildAppBar(),

              // Main Content
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 140),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Intro Text
                              _buildIntroSection(),
                              const SizedBox(height: 32),

                              // Form Fields
                              _buildFormFields(),
                              const SizedBox(height: 32),

                              // Configuration Section
                              _buildConfigurationSection(),
                            ],
                          ),
                        ),
                      ),

                      // Sticky Footer Button
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: _buildStickyFooter(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text(
              // 'Error loading campaigns: $error',
              'Something went wrong! Please try again.',
              style: TextStyle(color: Colors.red),
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: _slate50.withOpacity(0.9),
        border: const Border(bottom: BorderSide(color: _slate200, width: 1)),
      ),
      child: ClipRRect(
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              // Back Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: _slate500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Title
              Text(
                widget.shop == null ? 'Add Shop' : 'Edit Shop',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _slate900,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shop Details',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: _slate900,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Provide your shop details to start running offers and campaigns.',
          style: TextStyle(fontSize: 14, color: _slate500, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        // Shop Name
        _buildInputField(
          label: 'Shop Name',
          controller: _shopNameController,
          focusNode: _nameFocus,
          icon: Icons.storefront_rounded,
          placeholder: 'e.g., Urban Coffee',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter shop name';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),

        // Email
        _buildInputField(
          label: 'Email',
          controller: _shopEmailController,
          focusNode: _emailFocus,
          icon: Icons.email_outlined,
          placeholder: 'contact@shop.com',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 20),

        // Phone
        _buildPhoneField(),
        const SizedBox(height: 20),

        // Address
        _buildInputField(
          label: 'Address',
          controller: _shopAddressController,
          focusNode: _addressFocus,
          icon: Icons.location_on_outlined,
          placeholder: 'Street Address, City...',
          maxLines: 2,
          isTextArea: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter shop address';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),

        // Description
        _buildInputField(
          label: 'Description',
          controller: _shopDescriptionController,
          focusNode: _descFocus,
          icon: Icons.notes_rounded,
          placeholder: 'Tell us about your shop...',
          maxLines: 3,
          isTextArea: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter shop description';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _slate700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _slate200, width: 1),
          ),
          child: Row(
            children: [
              CountryCodePicker(
                onChanged: (countryCode) {
                  setState(() {
                    _selectedCountryCode = countryCode;
                  });
                },
                initialSelection: _selectedCountryCode.code,
                mode: CountryCodePickerMode.dialog,
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                showFlag: true,
                enabled: !_isLoading,
                textStyle: const TextStyle(
                  color: _slate900,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(width: 1, height: 28, color: _slate200),
              Expanded(
                child: TextFormField(
                  controller: _shopPhoneController,
                  focusNode: _phoneFocus,
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter shop phone';
                    }
                    if (value.length < 7 || value.length > 15) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _slate900,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Phone number',
                    hintStyle: TextStyle(
                      color: _slate400,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required IconData icon,
    required String placeholder,
    TextInputType? keyboardType,
    int? maxLength,
    int maxLines = 1,
    bool isTextArea = false,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _slate700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _slate200, width: 1),
          ),
          child: Row(
            crossAxisAlignment: isTextArea
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: isTextArea ? 14 : 0),
                child: Icon(icon, size: 22, color: _slate400),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  inputFormatters: inputFormatters,
                  validator: validator,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _slate900,
                  ),
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: const TextStyle(
                      color: _slate400,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: isTextArea ? 14 : 14,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    counterText: '',
                    errorStyle: TextStyle(
                      color: Colors.red.shade400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfigurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [_brandStart, _brandEnd],
              ).createShader(bounds),
              child: const Icon(
                Icons.settings_rounded,
                size: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Configuration',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _slate900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Configuration Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _slate100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gift Cycle Day Field
              _buildConfigInputField(),
              const SizedBox(height: 24),

              // Campaign Selector
              _buildCampaignSelector(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfigInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gift Cycle Day (1-31)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _slate700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: _slate50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _slate200, width: 1),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Icon(
                  Icons.calendar_today_rounded,
                  size: 22,
                  color: _slate400,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _giftCycleDayController,
                  focusNode: _cycleFocus,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _slate900,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'e.g. 30',
                    hintStyle: TextStyle(
                      color: _slate400,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final day = int.tryParse(value);
                      if (day == null || day < 1 || day > 31) {
                        return 'Please enter a valid day (1-31)';
                      }
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            'Days required to complete a cycle.',
            style: TextStyle(fontSize: 12, color: _slate400),
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Associated Campaign',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _slate700,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _slate50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Optional',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: _slate400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Campaign Selector Card
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              final result = await CampaignSelecterListModal.show(context);
              if (result != null) {
                setState(() {
                  _selectedCampaign = result;
                });
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedCampaign != null
                      ? _brandStart.withOpacity(0.5)
                      : _slate200,
                ),
              ),
              constraints: const BoxConstraints(minHeight: 72),
              child: _selectedCampaign == null
                  ? _buildEmptyCampaignState()
                  : _buildSelectedCampaignState(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCampaignState() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _slate50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.campaign_outlined,
            size: 22,
            color: _slate400,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Select a campaign',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: _slate400,
            ),
          ),
        ),
        const Icon(Icons.chevron_right_rounded, color: _slate300, size: 22),
      ],
    );
  }

  Widget _buildSelectedCampaignState() {
    final campaign = _selectedCampaign!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                campaign.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _slate900,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (campaign.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  campaign.description,
                  style: const TextStyle(fontSize: 12, color: _slate500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 8),
              _buildVisibilityChip(campaign.visibility),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedCampaign = null;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.close_rounded, size: 18, color: _slate400),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisibilityChip(CampaignVisibility visibility) {
    final isPublic = visibility == CampaignVisibility.public;
    final color = isPublic ? Colors.green : Colors.orange;
    final label = isPublic ? 'Public' : 'Private';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color.shade600,
        ),
      ),
    );
  }

  Widget _buildStickyFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        border: const Border(top: BorderSide(color: _slate200, width: 1)),
      ),
      child: ClipRRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isLoading ? null : _saveShop,
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_brandStart, _brandEnd],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _brandStart.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.save_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.shop == null ? 'Save Shop' : 'Update Shop',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveShop() {
    if (_formKey.currentState!.validate()) {
      if (widget.shop != null) {
        ref
            .read(addEditShopControllerProvider.notifier)
            .editShop(
              shop: widget.shop!.copyWith(
                shopName: _shopNameController.text,
                shopEmail: _shopEmailController.text.isEmpty
                    ? null
                    : _shopEmailController.text,
                shopPhone:
                    '${_selectedCountryCode.dialCode}${_shopPhoneController.text.trim()}',
                shopAddress: _shopAddressController.text,
                shopDescription: _shopDescriptionController.text,
                associatedCampaignId: _selectedCampaign?.id,
                giftCycleDay: int.parse(_giftCycleDayController.text),
              ),
            );
      } else {
        // Validate gift cycle day for new shops
        if (_giftCycleDayController.text.isEmpty) {
          _showToast('Please enter a gift cycle day', isSuccess: false);
          return;
        }

        ref
            .read(addEditShopControllerProvider.notifier)
            .addShop(
              shopName: _shopNameController.text,
              shopEmail: _shopEmailController.text.isEmpty
                  ? null
                  : _shopEmailController.text,
              shopPhone:
                  '${_selectedCountryCode.dialCode}${_shopPhoneController.text.trim()}',
              shopAddress: _shopAddressController.text,
              shopDescription: _shopDescriptionController.text,
              associatedCampaignId: _selectedCampaign?.id,
              giftCycleDay: int.parse(_giftCycleDayController.text),
              bonusIncrement: 1,
              daysRequired: 1,
            );
      }
    }
  }

  void _showToast(String message, {required bool isSuccess}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSuccess
                      ? Colors.green.shade600
                      : Colors.red.shade500,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSuccess
                          ? Icons.check_circle_rounded
                          : Icons.warning_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        message,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
