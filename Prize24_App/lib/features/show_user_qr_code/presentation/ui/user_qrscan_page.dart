import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/show_user_qr_code/presentation/view_model/avail_full_text_campaign_controller.dart';
import 'package:prize24_app/features/show_user_qr_code/presentation/view_model/avail_semi_text_campaign_controller.dart';
import 'package:prize24_app/features/show_user_qr_code/presentation/view_model/scan_result_inapp_message/results/inapp_scan_success_results.dart';
import 'package:prize24_app/features/show_user_qr_code/presentation/view_model/scan_result_inapp_message/scan_result_inapp_message_controller.dart';

// Design constants matching the HTML styles
class _QRPageColors {
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF1E293B);
  static const Color textSub = Color(0xFF64748B);
  static const Color accent = Color(0xFF0F172A);
  static const Color inputBg = Color(0xFFF1F5F9);
  static const Color gradientStart = Color(0xFFEF4444); // red-500
  static const Color gradientEnd = Color(0xFFF97316); // orange-500
}

// Validation models
enum InputType { campaignOnly, fullFormat, invalid }

class ValidationResult {
  ValidationResult({
    required this.type,
    required this.isValid,
    this.campaign,
    this.gift,
    this.code,
    this.errorMessage,
  });
  final InputType type;
  final bool isValid;
  final String? campaign;
  final String? gift;
  final String? code;
  final String? errorMessage;
}

class InputValidator {
  static ValidationResult validate(String input) {
    if (input.trim().isEmpty) {
      return ValidationResult(
        type: InputType.invalid,
        isValid: false,
        errorMessage: 'Input cannot be empty',
      );
    }

    final parts = input.trim().split('/');

    if (parts.length == 1) {
      // Case 1: campaign only
      final campaign = parts[0].trim();
      if (_isValidCampaign(campaign)) {
        return ValidationResult(
          type: InputType.campaignOnly,
          isValid: true,
          campaign: campaign,
        );
      } else {
        return ValidationResult(
          type: InputType.invalid,
          isValid: false,
          errorMessage: 'Invalid campaign name',
        );
      }
    } else if (parts.length == 3) {
      // Case 2: campaign/gift/code
      final campaign = parts[0].trim();
      final gift = parts[1].trim();
      final code = parts[2].trim();

      if (_isValidFullFormat(campaign, gift, code)) {
        return ValidationResult(
          type: InputType.fullFormat,
          isValid: true,
          campaign: campaign,
          gift: gift,
          code: code,
        );
      } else {
        return ValidationResult(
          type: InputType.invalid,
          isValid: false,
          errorMessage: 'Invalid format. All parts must be non-empty',
        );
      }
    } else {
      return ValidationResult(
        type: InputType.invalid,
        isValid: false,
        errorMessage: 'Invalid format. Use "campaign" or "campaign/gift/code"',
      );
    }
  }

  static bool _isValidCampaign(String campaign) {
    return campaign.isNotEmpty && campaign.length >= 2;
  }

  static bool _isValidFullFormat(String campaign, String gift, String code) {
    return campaign.isNotEmpty &&
        gift.isNotEmpty &&
        code.isNotEmpty &&
        campaign.length >= 2 &&
        gift.length >= 2 &&
        code.length >= 2;
  }
}

/// Page to display the user's QR code
/// Which is used for availing gifts from vendors under a specific campaign
/// This page is accessible only to authenticated users
/// and displays the user's ID in a QR code format
class UserQRCodePage extends ConsumerStatefulWidget {
  const UserQRCodePage({super.key});

  @override
  ConsumerState<UserQRCodePage> createState() => _UserQRCodePageState();
}

class _UserQRCodePageState extends ConsumerState<UserQRCodePage> {
  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authControllerProvider);
    ref.listen(scanResultInappMessageControllerProvider, (previous, next) {
      next.whenData((scanResult) {
        if (scanResult != null) {
          var message = '';
          var icon = Icons.check_circle;
          switch (scanResult) {
            case InappScanSuccessResultsCheckIn():
              message = 'Check-in successful!';
              icon = Icons.check_circle;
            case InappScanSuccessResultsPrizeAvailed():
              message = 'Prize availed successfully!';
              icon = Icons.card_giftcard;
            case InappScanSuccessResultsPrizeRedeemed():
              message = 'Prize redeemed successfully!';
              icon = Icons.redeem;
          }
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _QRPageColors.cardBg,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: const Color(0xFF22C55E),
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Success!',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _QRPageColors.textMain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: _QRPageColors.textSub,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF22C55E),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'OK',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      });
    });

    return Scaffold(
      backgroundColor: _QRPageColors.cardBg,
      appBar: AppBar(
        backgroundColor: _QRPageColors.cardBg,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: _QRPageColors.textMain),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        centerTitle: true,
        title: Text(
          'QR Code',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            color: _QRPageColors.textMain,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Decorative background shapes
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _QRPageColors.gradientEnd.withOpacity(0.1),
                    _QRPageColors.gradientEnd.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _QRPageColors.gradientStart.withOpacity(0.1),
                    _QRPageColors.gradientStart.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: authController.when(
              data: (data) {
                if (data == null) {
                  return Center(
                    child: Text(
                      'No data available',
                      style: GoogleFonts.inter(color: _QRPageColors.textSub),
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      // User Info Card
                      _UserInfoCard(
                        userName: data.userName,
                        userEmail: data.userEmail,
                      ),
                      const SizedBox(height: 32),

                      // Main title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: _QRPageColors.textMain,
                              height: 1.3,
                            ),
                            children: [
                              const TextSpan(text: 'Your '),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                        colors: [
                                          _QRPageColors.gradientStart,
                                          _QRPageColors.gradientEnd,
                                        ],
                                      ).createShader(bounds),
                                  child: Text(
                                    'QR Code',
                                    style: GoogleFonts.inter(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Subtitle
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Show this QR code to our partner to redeem your gift and earn rewards.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _QRPageColors.textSub,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // QR Code
                      _FloatingQRCard(userId: data.userId),
                      const SizedBox(height: 24),

                      // Copy & Share buttons
                      _QRDataActions(userId: data.userId),
                      const SizedBox(height: 40),

                      // // Feature cards
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 24),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: _FeatureCard(
                      //               icon: Icons.card_giftcard_rounded,
                      //               title: 'Earn Rewards',
                      //               subtitle: 'Collect gifts from partners',
                      //               color: _QRPageColors.gradientStart,
                      //             ),
                      //           ),
                      //           SizedBox(width: 12),
                      //           Expanded(
                      //             child: _FeatureCard(
                      //               icon: Icons.verified_rounded,
                      //               title: 'Verified',
                      //               subtitle: 'Secure & authentic',
                      //               color: _QRPageColors.gradientEnd,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(height: 12),
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: _FeatureCard(
                      //               icon: Icons.flash_on_rounded,
                      //               title: 'Quick Scan',
                      //               subtitle: 'Instant redemption',
                      //               color: Color(0xFF8B5CF6),
                      //             ),
                      //           ),
                      //           SizedBox(width: 12),
                      //           Expanded(
                      //             child: _FeatureCard(
                      //               icon: Icons.store_rounded,
                      //               title: 'Partners',
                      //               subtitle: 'Multiple locations',
                      //               color: Color(0xFF06B6D4),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 32),

                      // Info banner
                      _InfoBanner(),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: _QRPageColors.gradientStart,
                ),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: _QRPageColors.textSub.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error, Please try again',
                      style: GoogleFonts.inter(
                        color: _QRPageColors.textSub,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// User Info Card displaying user details
class _UserInfoCard extends StatelessWidget {
  const _UserInfoCard({required this.userName, required this.userEmail});

  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _QRPageColors.gradientStart.withOpacity(0.1),
            _QRPageColors.gradientEnd.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _QRPageColors.gradientStart.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _QRPageColors.gradientStart,
                  _QRPageColors.gradientEnd,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: _QRPageColors.gradientStart.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _QRPageColors.textMain,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      size: 14,
                      color: _QRPageColors.textSub,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        userEmail,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: _QRPageColors.textSub,
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
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _QRPageColors.gradientStart,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _QRPageColors.gradientStart.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, size: 14, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  'Active',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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

/// Feature Card for displaying app features
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _QRPageColors.textMain,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: _QRPageColors.textSub,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Info Banner with helpful tips
class _InfoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _QRPageColors.accent.withOpacity(0.05),
            _QRPageColors.accent.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _QRPageColors.inputBg, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: Color(0xFF3B82F6),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How to Use',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _QRPageColors.textMain,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Simply show this QR code to any partner venue. They will scan it to verify and apply streak and gifts to your account instantly.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: _QRPageColors.textSub,
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
}

/// Floating QR Card with gradient background and animation
class _FloatingQRCard extends StatefulWidget {
  const _FloatingQRCard({required this.userId});

  final String userId;

  @override
  State<_FloatingQRCard> createState() => _FloatingQRCardState();
}

class _FloatingQRCardState extends State<_FloatingQRCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: -10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_QRPageColors.gradientStart, _QRPageColors.gradientEnd],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _QRPageColors.gradientStart.withOpacity(0.5),
              blurRadius: 40,
              offset: const Offset(0, 20),
              spreadRadius: -10,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            width: 250,
            height: 250,
            child: PrettyQrView.data(
              data: widget.userId,
              decoration: const PrettyQrDecoration(
                shape: PrettyQrRoundedSymbol(color: _QRPageColors.textMain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Copy & Share action buttons for the QR code data string
class _QRDataActions extends StatelessWidget {
  const _QRDataActions({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.copy_rounded,
              label: 'Copy ID',
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: userId));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'ID copied to clipboard',
                        style: GoogleFonts.inter(fontSize: 13),
                      ),
                      backgroundColor: const Color(0xFF22C55E),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              icon: Icons.share_rounded,
              label: 'Share ID',
              onPressed: () {
                SharePlus.instance.share(
                  ShareParams(text: userId, subject: 'My Prize24 ID'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _QRPageColors.inputBg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: _QRPageColors.textMain),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _QRPageColors.textMain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Text Input Section for campaign/gift/code input
class TextInputSection extends ConsumerStatefulWidget {
  const TextInputSection({super.key, this.onTextInputChanged});

  final void Function(bool hasText)? onTextInputChanged;

  @override
  ConsumerState<TextInputSection> createState() => _TextInputSectionState();
}

class _TextInputSectionState extends ConsumerState<TextInputSection> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  ValidationResult _validationResult = ValidationResult(
    type: InputType.invalid,
    isValid: false,
  );

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _controller.addListener(_notifyTextChange);
  }

  void _notifyTextChange() {
    widget.onTextInputChanged?.call(_controller.text.isNotEmpty);
  }

  @override
  void dispose() {
    _controller.removeListener(_notifyTextChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    setState(() {
      _validationResult = InputValidator.validate(value);
    });
  }

  void _onSubmit() {
    if (_validationResult.isValid) {
      if (_validationResult.type == InputType.campaignOnly) {
        ref
            .read(availSemiTextCampaignControllerProvider.notifier)
            .availCampaign(_validationResult.campaign!);
      } else if (_validationResult.type == InputType.fullFormat) {
        ref
            .read(availFullTextCampaignControllerProvider.notifier)
            .availCampaign(
              campaignSlug: _validationResult.campaign!,
              giftSlug: _validationResult.gift!,
              code: _validationResult.code!,
            );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(_validationResult.errorMessage ?? 'Invalid input'),
        //     backgroundColor: Colors.red,
        //   ),
        // );
        showToastAtTop(
          context,
          _validationResult.errorMessage ?? 'Invalid input',
          false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Full text Watch
    ref
      ..listen(availFullTextCampaignControllerProvider, (previous, next) {
        next.when(
          data: (data) {
            if (data != null) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pop();
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(data),
              //     backgroundColor: Colors.green,
              //   ),
              // );
              showToastAtTop(context, data, true);
            }
          },
          loading: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: _QRPageColors.cardBg,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: _QRPageColors.gradientStart,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Processing Gift Code...',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _QRPageColors.textMain,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Please wait while we validate your gift code',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: _QRPageColors.textSub,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stack) {
            Navigator.of(context).pop();

            showToastAtTop(context, 'Error, Please try again', false);
          },
        );
      })
      ..listen(availSemiTextCampaignControllerProvider, (previous, next) {
        next.when(
          data: (data) {
            if (data != null) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pop();
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(data),
              //     backgroundColor: Colors.green,
              //   ),
              // );
              showToastAtTop(context, data, true);
            }
          },
          loading: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: _QRPageColors.cardBg,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: _QRPageColors.gradientStart,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Processing Campaign...',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _QRPageColors.textMain,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Please wait while we validate your request',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: _QRPageColors.textSub,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stack) {
            Navigator.of(context).pop();
            showToastAtTop(context, 'Something went wrong', false);
          },
        );
      });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'CAMPAIGN INFO',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: _QRPageColors.textMain,
            ),
          ),
        ),
        // Input field
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white : _QRPageColors.inputBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.transparent, width: 2),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onTextChanged,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: _QRPageColors.textMain,
            ),
            decoration: InputDecoration(
              hintText: 'campaign/gift/code',
              hintStyle: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: _QRPageColors.textSub.withOpacity(0.6),
              ),
              prefixIcon: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.qr_code_rounded,
                  color: _isFocused
                      ? _QRPageColors.textMain
                      : _QRPageColors.textSub,
                  size: 22,
                ),
              ),
              suffixIcon: _validationResult.isValid
                  ? const Icon(Icons.check_circle, color: Color(0xFF22C55E))
                  : _controller.text.isNotEmpty
                  ? const Icon(Icons.error, color: Color(0xFFEF4444))
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              errorText:
                  !_validationResult.isValid && _controller.text.isNotEmpty
                  ? _validationResult.errorMessage
                  : null,
              errorStyle: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        // Helper text
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 16),
          child: Text(
            'Format: "campaign" or "campaign/gift/code"',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: _QRPageColors.textSub.withOpacity(0.7),
            ),
          ),
        ),
        // Validation display - shows parsed components when valid
        if (_validationResult.isValid) _buildValidationDisplay(),
        if (_validationResult.isValid) const SizedBox(height: 16),
        // Action button with gradient
        _GradientActionButton(
          isActive: _validationResult.isValid,
          onPressed: _onSubmit,
          label: _validationResult.isValid
              ? 'Redeem Gift'
              : 'Enter Valid Format',
        ),
      ],
    );
  }

  Widget _buildValidationDisplay() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF22C55E).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF22C55E),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _validationResult.type == InputType.campaignOnly
                    ? 'Campaign Only Format'
                    : 'Full Format (Campaign/Gift/Code)',
                style: GoogleFonts.inter(
                  color: const Color(0xFF22C55E),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildParsedComponents(),
        ],
      ),
    );
  }

  Widget _buildParsedComponents() {
    return Column(
      children: [
        _buildComponent('Campaign', _validationResult.campaign!),
        if (_validationResult.gift != null)
          _buildComponent('Gift', _validationResult.gift!),
        if (_validationResult.code != null)
          _buildComponent('Code', _validationResult.code!),
      ],
    );
  }

  Widget _buildComponent(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: GoogleFonts.inter(
                color: _QRPageColors.textSub,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: _QRPageColors.textMain,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Gradient Action Button matching the HTML design
class _GradientActionButton extends StatelessWidget {
  const _GradientActionButton({
    required this.isActive,
    required this.onPressed,
    required this.label,
  });

  final bool isActive;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    // Create lighter gradient colors when disabled
    final gradientStartColor = isActive
        ? _QRPageColors.gradientStart
        : Color.lerp(_QRPageColors.gradientStart, Colors.white, 0.5)!;
    final gradientEndColor = isActive
        ? _QRPageColors.gradientEnd
        : Color.lerp(_QRPageColors.gradientEnd, Colors.white, 0.5)!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gradientStartColor, gradientEndColor],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: _QRPageColors.gradientStart.withOpacity(0.5),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                  spreadRadius: -5,
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isActive ? onPressed : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
