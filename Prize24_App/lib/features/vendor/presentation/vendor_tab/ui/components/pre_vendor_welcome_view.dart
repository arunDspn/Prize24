part of '../vendor_home_page1.dart';

/// Brand colors matching the HTML design
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

class PreVendorWelcomeView extends ConsumerWidget {
  const PreVendorWelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    ref.listen(
      registerUserAsVendorControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (data) {
            if (data != null) {
              logger.d('User registered as vendor with ID: $data');
              showToastAtTop(
                context,
                'You are now registered as a vendor!',
                true,
              );

              ref
                  .read(authControllerProvider.notifier)
                  .updateAuthUserWithVendorFlag();

              // why pop back? we are already on vendor home page just listen sttream
              // Trauma effect
              // context.pop();
            }
          },
          error: (error, stackTrace) {
            logger.e('Error registering user as vendor: $error');
            showToastAtTop(
              context,
              'Error registering as vendor: $error',
              false,
            );
          },
        );
      },
    );

    return ColoredBox(
      color: _VendorBrandColors.background,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 48 : 24,
            vertical: isTablet ? 64 : 32,
          ),
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.02),

              // Logo Section with soft shadow
              _buildLogoSection(),

              SizedBox(height: isTablet ? 20 : 10),

              // Hero Section
              _buildHeroSection(isTablet),

              SizedBox(height: isTablet ? 20 : 10),

              // Features Grid
              _buildFeaturesGrid(isTablet),

              SizedBox(height: isTablet ? 20 : 10),

              // Call-to-Action Button
              _buildCtaButton(context, isTablet, ref),

              const SizedBox(height: 66),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        color: _VendorBrandColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
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
    );
  }

  Widget _buildHeroSection(bool isTablet) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Column(
        children: [
          // Hero Title with gradient text
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: isTablet ? 48 : 28,
                fontWeight: FontWeight.bold,
                color: _VendorBrandColors.accent,
                height: 1.15,
                letterSpacing: -0.5,
                fontFamily: 'Inter',
              ),
              children: [
                const TextSpan(text: 'Become a Partner & provide '),
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
                      'extra value',
                      style: TextStyle(
                        fontSize: isTablet ? 48 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.15,
                        letterSpacing: -0.5,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: ' to your visitors!'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Subtitle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Text(
              'Create loyalty coupons, distribute them to your visitors, and give the best experience they deserve!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                color: _VendorBrandColors.textSub,
                height: 1.6,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid(bool isTablet) {
    final features = [
      _FeatureData(
        icon: Icons.people_outline_rounded,
        iconBgColor: const Color(0xFFFFF7ED), // orange-50
        iconColor: _VendorBrandColors.gradEnd,
        title: 'Create Streaks',
        description:
            'Create engaging and fun streaks that visitors can show off to their friends.',
      ),
      _FeatureData(
        icon: Icons.local_offer_outlined,
        iconBgColor: const Color(0xFFFEF2F2), // red-50
        iconColor: _VendorBrandColors.gradStart,
        title: 'Create Loyalty Coupons',
        description:
            'Design real value offerings that reward your most loyal visitors.',
      ),
      _FeatureData(
        icon: Icons.card_giftcard_rounded,
        iconBgColor: const Color(0xFFF8FAFC), // slate-50
        iconColor: _VendorBrandColors.accent,
        title: 'Distribute Coupons',
        description:
            'Make distribution playful and exciting for every visitor.',
      ),
    ];

    if (isTablet) {
      // Horizontal grid for tablets
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: features.map((feature) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _VendorFeatureCard(feature: feature),
              ),
            );
          }).toList(),
        ),
      );
    } else {
      // Vertical list for mobile
      return Column(
        children: features.map((feature) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _VendorFeatureCard(feature: feature),
          );
        }).toList(),
      );
    }
  }

  Widget _buildCtaButton(BuildContext context, bool isTablet, WidgetRef ref) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: isTablet ? 320 : double.infinity,
      ),
      width: double.infinity,
      child: _GradientCtaButton(
        text: 'Become a Partner',
        onPressed: () => _showSubscriptionPaywall(context, ref),
      ),
    );
  }

  Future<void> _showSubscriptionPaywall(
      BuildContext context, WidgetRef ref) async {
    try {
      final offerings = await Purchases.getOfferings();
      final offering = offerings.all['Standard Plan Offering'];

      if (offering != null) {
        final result = await RevenueCatUI.presentPaywall(offering: offering);
        if (result == PaywallResult.purchased) {
          // Register as vendor - the listener (line 23) will handle success/error messages
          await ref
              .read(registerUserAsVendorControllerProvider.notifier)
              .registerAsVendor();
          // await Purchases.getCustomerInfo();
          await ref
              .read(subscriptionControllerProvider.notifier)
              .recheckEntitlements();
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.error_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Subscription plan not available',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFFEF4444),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.all(16),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showToastAtTop(context, 'Something went wrong', false);
      }
    }
  }
}

/// Data class for feature card content
class _FeatureData {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String description;

  _FeatureData({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.description,
  });
}

/// Modern feature card matching the HTML design
class _VendorFeatureCard extends StatelessWidget {
  const _VendorFeatureCard({required this.feature});

  final _FeatureData feature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: _VendorBrandColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _VendorBrandColors.inputBg,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: feature.iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature.icon,
              size: 24,
              color: feature.iconColor,
            ),
          ),
          const SizedBox(width: 16),

          // Title and Description Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _VendorBrandColors.textMain,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  feature.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _VendorBrandColors.textSub,
                    height: 1.5,
                    fontFamily: 'Inter',
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

/// Gradient CTA button matching the HTML design
class _GradientCtaButton extends StatelessWidget {
  const _GradientCtaButton({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                _VendorBrandColors.gradStart,
                _VendorBrandColors.gradEnd,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _VendorBrandColors.gradStart.withValues(alpha: 0.3),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
