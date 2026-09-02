import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';

import 'package:prize24_app/configs/assets.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/vendor/presentation/partial_registeration_view/view_model/vendor_phone_number_registeration_controller.dart';

/// Brand colors matching the vendor theme
class _VendorBrandColors {
  static const Color background = Color(0xFFF8FAFC);
  static const Color card = Colors.white;
  static const Color textMain = Color(0xFF1E293B);
  static const Color textSub = Color(0xFF64748B);
  static const Color accent = Color(0xFF0F172A);
  static const Color inputBg = Color(0xFFF1F5F9);
  static const Color gradStart = Color(0xFFEF4444); // red-500
  static const Color gradEnd = Color(0xFFF97316); // orange-500
}

class PartialRegisterationView extends ConsumerStatefulWidget {
  const PartialRegisterationView({super.key});

  @override
  ConsumerState<PartialRegisterationView> createState() =>
      _PartialRegisterationViewState();
}

class _PartialRegisterationViewState
    extends ConsumerState<PartialRegisterationView> {
  static const int _minPhoneDigits = 4;
  static const int _maxPhoneDigits = 15;

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  Country _selectedCountryCode = Country(
    name: 'India',
    code: 'IN',
    dialCode: '+91',
    flagUri: 'assets/flags/in.png',
  );
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitPhoneNumber() async {
    if (_formKey.currentState?.validate() ?? false) {
      final localNumber = _phoneController.text.trim();
      final internationalNumber =
          '${_selectedCountryCode.dialCode}$localNumber';

      ref
          .read(vendorPhoneNumberRegisterationControllerProvider.notifier)
          .registerVendorPhoneNumber(phoneNumber: internationalNumber);
    }
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Remove any non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < _minPhoneDigits ||
        digitsOnly.length > _maxPhoneDigits) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    ref.listen(vendorPhoneNumberRegisterationControllerProvider, (
      previous,
      next,
    ) {
      next.whenOrNull(
        data: (data) {
          if (data != null) {
            setState(() {
              _isLoading = false;
            });
            // Locally update the auth user state with the new phone number
            ref
                .read(authControllerProvider.notifier)
                .authStateChanged(
                  ref
                      .read(authControllerProvider)
                      .requireValue!
                      .copyWith(vendorPhoneNumber: data),
                );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('Phone number registered successfully!'),
            //   ),
            // );
            showToastAtTop(
              context,
              'Phone number registered successfully!',
              true,
            );
          }
        },
        loading: () {
          setState(() {
            _isLoading = true;
          });
        },
        error: (error, stackTrace) {
          setState(() {
            _isLoading = false;
          });
          showToastAtTop(
            context,
            'Something went wrong, Failed to register phone number',
            false,
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: _VendorBrandColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: _VendorBrandColors.textMain),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 48 : 24,
            vertical: isTablet ? 64 : 32,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenSize.height * 0.02),

                // Logo Section with soft shadow
                Center(
                  child: Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      color: _VendorBrandColors.card,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF0F172A,
                          ).withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        AppAssets.p24LogoIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Title with gradient accent
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: isTablet ? 36 : 28,
                      fontWeight: FontWeight.bold,
                      color: _VendorBrandColors.accent,
                      height: 1.15,
                      letterSpacing: -0.5,
                      fontFamily: 'Inter',
                    ),
                    children: [
                      const TextSpan(text: 'Complete Your '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              _VendorBrandColors.gradStart,
                              _VendorBrandColors.gradEnd,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'Registration',
                            style: TextStyle(
                              fontSize: isTablet ? 36 : 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.15,
                              letterSpacing: -0.5,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Description
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 550),
                    child: Text(
                      "You're almost there! To unlock all vendor features and start managing your business, please provide your phone number.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 15,
                        color: _VendorBrandColors.textSub,
                        height: 1.6,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // Phone number field card
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _VendorBrandColors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _VendorBrandColors.inputBg,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF0F172A,
                            ).withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Phone number field
                          Container(
                            decoration: BoxDecoration(
                              color: _VendorBrandColors.inputBg,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _VendorBrandColors.inputBg,
                              ),
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
                                  favorite: const ['+91', '+1', '+971'],
                                  mode: CountryCodePickerMode.dialog,
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  enabled: !_isLoading,
                                  textStyle: const TextStyle(
                                    color: _VendorBrandColors.textMain,
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 28,
                                  color: _VendorBrandColors.textSub.withValues(
                                    alpha: 0.25,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _phoneController,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      labelStyle: const TextStyle(
                                        color: _VendorBrandColors.textSub,
                                        fontFamily: 'Inter',
                                      ),
                                      hintText: 'Enter your phone number',
                                      hintStyle: TextStyle(
                                        color: _VendorBrandColors.textSub
                                            .withValues(alpha: 0.5),
                                        fontFamily: 'Inter',
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 16,
                                          ),
                                    ),
                                    style: const TextStyle(
                                      color: _VendorBrandColors.textMain,
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                    ),
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(15),
                                    ],
                                    validator: _validatePhoneNumber,
                                    enabled: !_isLoading,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Gradient Submit button
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 320 : double.infinity,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _isLoading ? null : _submitPhoneNumber,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            gradient: _isLoading
                                ? LinearGradient(
                                    colors: [
                                      _VendorBrandColors.gradStart.withValues(
                                        alpha: 0.5,
                                      ),
                                      _VendorBrandColors.gradEnd.withValues(
                                        alpha: 0.5,
                                      ),
                                    ],
                                  )
                                : const LinearGradient(
                                    colors: [
                                      _VendorBrandColors.gradStart,
                                      _VendorBrandColors.gradEnd,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: _isLoading
                                ? []
                                : [
                                    BoxShadow(
                                      color: _VendorBrandColors.gradStart
                                          .withValues(alpha: 0.3),
                                      blurRadius: 25,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                          ),
                          child: _isLoading
                              ? const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Complete Registration',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Icon(
                                      Icons.arrow_forward_rounded,
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
                const SizedBox(height: 24),

                // Help text card
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _VendorBrandColors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _VendorBrandColors.inputBg,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF0F172A,
                            ).withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7ED), // orange-50
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              color: _VendorBrandColors.gradEnd,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Your phone number will be used for account verification and important notifications.',
                              style: const TextStyle(
                                fontSize: 13,
                                color: _VendorBrandColors.textSub,
                                height: 1.5,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
