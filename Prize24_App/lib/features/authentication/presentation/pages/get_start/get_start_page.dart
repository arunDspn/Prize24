import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/authentication/presentation/pages/get_start/controllers/apple_signin/apple_signin_controller.dart';
import 'package:prize24_app/features/authentication/presentation/pages/get_start/controllers/google_signin/google_signin_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

// ============================================================================
// COLOR PALETTE (from HTML)
// ============================================================================
class _GetStartColors {
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

  static const Color orange300 = Color(0xFFFDBA74);
  static const Color orange400 = Color(0xFFFB923C);
  static const Color orange500 = Color(0xFFF97316);
  static const Color red300 = Color(0xFFFCA5A5);
  static const Color red500 = Color(0xFFEF4444);
  static const Color purple200 = Color(0xFFE9D5FF);
  static const Color purple500 = Color(0xFFA855F7);
  static const Color green500 = Color(0xFF22C55E);
  static const Color green600 = Color(0xFF16A34A);
  static const Color blue400 = Color(0xFF60A5FA);

  // Gradient colors
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
}

// ============================================================================
// MAIN PAGE
// ============================================================================
class GetStartPage extends ConsumerStatefulWidget {
  const GetStartPage({super.key});

  @override
  ConsumerState<GetStartPage> createState() => _GetStartPageState();
}

class _GetStartPageState extends ConsumerState<GetStartPage>
    with TickerProviderStateMixin {
  bool _isGoogleSignInLoading = false;
  bool _isAppleSignInLoading = false;

  // Animation Controllers
  late AnimationController _slideUpController;
  late AnimationController _blobController;
  late AnimationController _orbitController;
  late AnimationController _floatController;
  late AnimationController _shineController;
  late AnimationController _textGradientController;
  late AnimationController _bounceController;

  // Slide Up Animations with stagger
  late Animation<double> _logoSlideUp;
  late Animation<double> _heroSlideUp;
  late Animation<double> _illustrationSlideUp;
  late Animation<double> _buttonsSlideUp;
  late Animation<double> _termsSlideUp;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    // Slide Up Controller (staggered)
    _slideUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Blob Controller (infinite loop)
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();

    // Orbit Controller (infinite rotation)
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Float Controller (infinite float animation)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Shine Controller (button shine effect)
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Text Gradient Controller (flowing gradient)
    _textGradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // Bounce Controller (notification badge)
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    // Create staggered slide up animations
    _logoSlideUp = _createSlideUpAnimation(0.0, 0.3);
    _heroSlideUp = _createSlideUpAnimation(0.1, 0.4);
    _illustrationSlideUp = _createSlideUpAnimation(0.2, 0.5);
    _buttonsSlideUp = _createSlideUpAnimation(0.3, 0.6);
    _termsSlideUp = _createSlideUpAnimation(0.4, 0.7);

    // Start the slide up animation
    _slideUpController.forward();
  }

  Animation<double> _createSlideUpAnimation(double start, double end) {
    return CurvedAnimation(
      parent: _slideUpController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _slideUpController.dispose();
    _blobController.dispose();
    _orbitController.dispose();
    _floatController.dispose();
    _shineController.dispose();
    _textGradientController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Google Listener - BUSINESS LOGIC PRESERVED
    ref
      ..listen(googleSigninControllerProvider, (previous, next) {
        if (next.isLoading) {
          setState(() {
            _isGoogleSignInLoading = true;
          });
        } else {
          setState(() {
            _isGoogleSignInLoading = false;
          });
        }

        next.whenOrNull(
          data: (user) {
            if (user != null) {
              if (user.deletionRequestedAt != null) {
                // Account has a pending deletion request - route to a
                // dedicated page instead of Home, where the user can
                // cancel the request or sign out.
                if (context.mounted) {
                  context.go(AppRoutes.accountDeletionPending);
                }
              } else {
                _showToast('Welcome, ${user.userName}!', ToastType.success);
                context.go(AppRoutes.home);
              }
            }
          },
          error: (error, stackTrace) {
            final errorMessage = error.toString();
            if (!errorMessage.contains('Cancelled by user')) {
              _showToast('Sign in failed', ToastType.error);
            }
          },
        );
      })
      ..listen(appleSigninControllerProvider, (previous, next) {
        if (next.isLoading) {
          setState(() {
            _isAppleSignInLoading = true;
          });
        } else {
          setState(() {
            _isAppleSignInLoading = false;
          });
        }

        next.whenOrNull(
          data: (user) {
            if (user != null) {
              if (user.deletionRequestedAt != null) {
                // Account has a pending deletion request - route to a
                // dedicated page instead of Home, where the user can
                // cancel the request or sign out.
                if (context.mounted) {
                  context.go(AppRoutes.accountDeletionPending);
                }
              } else {
                _showToast('Welcome, ${user.userName}!', ToastType.success);
                context.go(AppRoutes.home);
              }
            }
          },
          error: (error, stackTrace) {
            final errorMessage = error.toString();
            if (!errorMessage.contains('Cancelled by user')) {
              _showToast('Sign in failed', ToastType.error);
            }
          },
        );
      });
    return Scaffold(
      backgroundColor: _GetStartColors.slate50,
      body: Stack(
        children: [
          // Fluid Aurora Background
          _buildAuroraBackground(),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 1. Logo
                        _buildAnimatedLogo(),
                        const SizedBox(height: 10),

                        // 2. Hero Text
                        _buildHeroText(),
                        const SizedBox(height: 10),

                        // 3. Dynamic Illustration
                        _buildDynamicIllustration(),
                        const SizedBox(height: 10),

                        // 4. Action Buttons
                        _buildActionButtons(),

                        // 5. Footer Terms
                        _buildTermsAndPrivacy(),
                      ],
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

  // ============================================================================
  // AURORA BACKGROUND WITH ANIMATED BLOBS
  // ============================================================================
  Widget _buildAuroraBackground() {
    return AnimatedBuilder(
      animation: _blobController,
      builder: (context, child) {
        return Stack(
          children: [
            // Orange Blob (top-left)
            Positioned(
              top: -50,
              left: -50,
              child: _buildAnimatedBlob(
                size: 500,
                color: _GetStartColors.orange300.withOpacity(0.3),
                offset: 0,
              ),
            ),
            // Red Blob (top-right)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              right: -50,
              child: _buildAnimatedBlob(
                size: 400,
                color: _GetStartColors.red300.withOpacity(0.3),
                offset: 0.33,
              ),
            ),
            // Purple Blob (bottom-left)
            Positioned(
              bottom: -50,
              left: MediaQuery.of(context).size.width * 0.2,
              child: _buildAnimatedBlob(
                size: 600,
                color: _GetStartColors.purple200.withOpacity(0.3),
                offset: 0.66,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedBlob({
    required double size,
    required Color color,
    required double offset,
  }) {
    final progress = (_blobController.value + offset) % 1.0;
    final translateX = math.sin(progress * 2 * math.pi) * 30;
    final translateY = math.cos(progress * 2 * math.pi) * 50;
    final scale = 0.9 + 0.2 * math.sin(progress * 2 * math.pi);

    return Transform.translate(
      offset: Offset(translateX, translateY),
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 80,
                spreadRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // LOGO WITH GLASSMORPHISM
  // ============================================================================
  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _logoSlideUp,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _logoSlideUp.value)),
          child: Opacity(
            opacity: _logoSlideUp.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1F2687).withOpacity(0.05),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ColorFilter.mode(
                    Colors.white.withOpacity(0.1),
                    BlendMode.overlay,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Prize24',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================================
  // HERO TEXT WITH ANIMATED GRADIENT
  // ============================================================================
  Widget _buildHeroText() {
    return AnimatedBuilder(
      animation: _heroSlideUp,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _heroSlideUp.value)),
          child: Opacity(
            opacity: _heroSlideUp.value,
            child: Column(
              children: [
                // Main Heading
                const Text(
                  'Unlock exclusive',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: _GetStartColors.slate900,
                    height: 1.1,
                    fontFamily: 'Gilroy',
                  ),
                ),
                const SizedBox(height: 4),
                // Animated Gradient Text
                _buildAnimatedGradientText(),
                const SizedBox(height: 16),
                // Description
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'The most enjoyable loyalty program!\n Maintain a streak to unlock premium gifts from stores you love and visit.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.5,
                      fontFamily: 'Gilroy',
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

  Widget _buildAnimatedGradientText() {
    return AnimatedBuilder(
      animation: _textGradientController,
      builder: (context, child) {
        return Stack(
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: const [
                    Color(0xFFF97316), // Orange
                    Color(0xFFEF4444), // Red
                    Color(0xFFEC4899), // Pink
                    Color(0xFFF97316), // Orange (repeat)
                  ],
                  stops: const [0.0, 0.33, 0.66, 1.0],
                  begin: Alignment(-3 + (_textGradientController.value * 6), 0),
                  end: Alignment(0 + (_textGradientController.value * 6), 0),
                ).createShader(bounds);
              },
              child: const Text(
                'Freebies & Rewards',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.1,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
            // Underline SVG decoration
            Positioned(
              bottom: -4,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: const Size(double.infinity, 12),
                painter: _UnderlinePainter(
                  color: _GetStartColors.orange400.withOpacity(0.5),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================================
  // DYNAMIC ILLUSTRATION WITH ORBIT AND FLOATING ELEMENTS
  // ============================================================================
  Widget _buildDynamicIllustration() {
    return AnimatedBuilder(
      animation: _illustrationSlideUp,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _illustrationSlideUp.value)),
          child: Opacity(
            opacity: _illustrationSlideUp.value,
            child: SizedBox(
              width: 320,
              height: 320,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Orbit System
                  _buildOrbitSystem(),

                  // Main Floating Card
                  _buildMainFloatingCard(),

                  // Floating Gift Element (Right)
                  _buildFloatingGiftElement(),

                  // Particles
                  _buildParticles(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrbitSystem() {
    return AnimatedBuilder(
      animation: _orbitController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _orbitController.value * 2 * math.pi,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _GetStartColors.slate300.withOpacity(0.6),
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            child: Stack(
              children: [
                // Planet 1 - Ticket (Top)
                Positioned(
                  top: 0,
                  left: 140 - 24,
                  child: Transform.rotate(
                    angle: -_orbitController.value * 2 * math.pi,
                    child: _buildOrbitItem(
                      icon: Icons.confirmation_number_outlined,
                      color: _GetStartColors.purple500,
                      size: 48,
                    ),
                  ),
                ),
                // Planet 2 - Sparkle (Bottom Left)
                Positioned(
                  bottom: 42,
                  left: 28,
                  child: Transform.rotate(
                    angle: -_orbitController.value * 2 * math.pi,
                    child: _buildOrbitItem(
                      icon: Icons.auto_awesome,
                      color: _GetStartColors.green500,
                      size: 40,
                      isCircle: true,
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

  Widget _buildOrbitItem({
    required IconData icon,
    required Color color,
    required double size,
    bool isCircle = false,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isCircle ? size / 2 : 16),
        border: Border.all(color: _GetStartColors.slate100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }

  Widget _buildMainFloatingCard() {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final translateY = -15 * _floatController.value;
        return Transform.translate(
          offset: Offset(0, translateY),
          child: Stack(
            children: [
              Container(
                width: 176,
                height: 176,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.6),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF5F6D).withOpacity(0.3),
                      blurRadius: 40,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    children: [
                      // Shine Swipe Effect
                      _buildShineEffect(),
                      // Storefront Icon
                      Center(
                        child: Image.asset(
                          'assets/images/p24_3x_red.png',
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bouncing Notification Badge
              Positioned(top: 12, right: 12, child: _buildBouncingBadge()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShineEffect() {
    return AnimatedBuilder(
      animation: _shineController,
      builder: (context, child) {
        return Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Transform.translate(
              offset: Offset(-200 + (_shineController.value * 400), 0),
              child: Transform(
                transform: Matrix4.skewX(-0.3),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBouncingBadge() {
    return AnimatedBuilder(
      animation: _bounceController,
      builder: (context, child) {
        final bounce = math.sin(_bounceController.value * math.pi) * 4;
        return Transform.translate(
          offset: Offset(0, -bounce),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEF4444), Color(0xFFF97316)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingGiftElement() {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final translateY = 15 * (1 - _floatController.value);
        return Positioned(
          top: 40,
          right: 16,
          child: Transform.translate(
            offset: Offset(0, translateY),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _GetStartColors.slate50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.card_giftcard_rounded,
                size: 32,
                color: _GetStartColors.red500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildParticles() {
    return Stack(
      children: [
        // Orange particle (top-left)
        Positioned(
          top: 80,
          left: 40,
          child: _buildPingParticle(color: _GetStartColors.orange400, size: 12),
        ),
        // Blue particle (bottom-right)
        Positioned(
          bottom: 80,
          right: 40,
          child: _buildPingParticle(
            color: _GetStartColors.blue400,
            size: 8,
            delay: 1000,
          ),
        ),
      ],
    );
  }

  Widget _buildPingParticle({
    required Color color,
    required double size,
    int delay = 0,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 1500 + delay),
      builder: (context, value, child) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color.withOpacity(0.75 * (1 - (value % 1))),
            shape: BoxShape.circle,
          ),
        );
      },
      onEnd: () {
        // This will restart the animation
        if (mounted) setState(() {});
      },
    );
  }

  // ============================================================================
  // ACTION BUTTONS
  // ============================================================================
  Widget _buildActionButtons() {
    return AnimatedBuilder(
      animation: _buttonsSlideUp,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _buttonsSlideUp.value)),
          child: Opacity(
            opacity: _buttonsSlideUp.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Google Sign In Button
                  _buildGoogleButton(),
                  const SizedBox(height: 16),

                  // Apple Sign In Button (iOS only)
                  if (Platform.isIOS) _buildAppleButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGoogleButton() {
    return AnimatedBuilder(
      animation: _shineController,
      builder: (context, child) {
        return GestureDetector(
          onTap: _isGoogleSignInLoading ? null : _handleGoogleSignIn,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 56,
            decoration: BoxDecoration(
              color: _GetStartColors.slate900,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: _GetStartColors.slate200,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // Shine Effect
                  Positioned(
                    left: -100 + (_shineController.value * 400),
                    top: 0,
                    bottom: 0,
                    child: Transform(
                      transform: Matrix4.skewX(-0.5),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Center(
                    child: _isGoogleSignInLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.g_mobiledata_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppleButton() {
    return GestureDetector(
      onTap: _isAppleSignInLoading ? null : _handleAppleSignIn,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _GetStartColors.slate200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: _isAppleSignInLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _GetStartColors.slate900,
                    ),
                  ),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.apple,
                      color: _GetStartColors.slate700,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Continue with Apple',
                      style: TextStyle(
                        color: _GetStartColors.slate700,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // ============================================================================
  // TERMS AND PRIVACY
  // ============================================================================
  Widget _buildTermsAndPrivacy() {
    return AnimatedBuilder(
      animation: _termsSlideUp,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _termsSlideUp.value)),
          child: Opacity(
            opacity: _termsSlideUp.value * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(top: 32, left: 40, right: 40),
              child: Text.rich(
                TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _GetStartColors.slate400,
                    height: 1.5,
                    fontFamily: 'Gilroy',
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        color: _GetStartColors.slate600,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchUrl('https://prize24.app/terms.html');
                        },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        color: _GetStartColors.slate600,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchUrl('https://prize24.app/privacy.html');
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(String urlString) async {
    try {
      final url = Uri.parse(urlString);
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } catch (e) {
      if (mounted) {
        _showToast('Could not open link', ToastType.error);
      }
    }
  }

  // ============================================================================
  // TOAST NOTIFICATION
  // ============================================================================
  void _showToast(String message, ToastType type) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        onDismiss: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);
  }

  // ============================================================================
  // BUSINESS LOGIC - PRESERVED
  // ============================================================================
  void _handleGoogleSignIn() {
    setState(() {
      _isGoogleSignInLoading = true;
    });

    ref.read(googleSigninControllerProvider.notifier).signInWithGoogle();
  }

  void _handleAppleSignIn() {
    setState(() {
      _isAppleSignInLoading = true;
    });

    // Future.delayed(const Duration(seconds: 2), () {
    //   if (mounted) {
    //     setState(() {
    //       _isAppleSignInLoading = false;
    //     });
    //     _showToast('Apple Sign In - Coming Soon', ToastType.neutral);
    //   }
    // });

    ref.read(appleSigninControllerProvider.notifier).signInWithApple();
  }
}

// ============================================================================
// CUSTOM PAINTERS
// ============================================================================
class _UnderlinePainter extends CustomPainter {
  final Color color;

  _UnderlinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height / 2,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// TOAST WIDGET
// ============================================================================
enum ToastType { success, error, neutral }

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
  });
  final String message;
  final ToastType type;
  final VoidCallback onDismiss;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(
      begin: -30,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    IconData icon;

    switch (widget.type) {
      case ToastType.success:
        bgColor = _GetStartColors.green600;
        icon = Icons.check_circle;
        break;
      case ToastType.error:
        bgColor = _GetStartColors.red500;
        icon = Icons.warning_rounded;
        break;
      case ToastType.neutral:
        bgColor = _GetStartColors.slate900;
        icon = Icons.info_rounded;
        break;
    }

    return Positioned(
      top: MediaQuery.of(context).padding.top + 24,
      left: 16,
      right: 16,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 380),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          widget.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
