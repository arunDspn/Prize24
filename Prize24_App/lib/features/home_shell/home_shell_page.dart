import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:prize24_app/common_widgets/custom_bottom_nav_bar.dart';
import 'package:prize24_app/configs/theme_config.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/global_controller/subscription/subscription_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

class HomeShellPage extends ConsumerStatefulWidget {
  const HomeShellPage({required this.child, super.key});

  final StatefulNavigationShell child;

  @override
  ConsumerState<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends ConsumerState<HomeShellPage> {
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    if (index == 2) {
      context.push(AppRoutes.qrScanScreen);
      return;
    }

    if (index >= 3) {
      widget.child.goBranch(index - 1, initialLocation: index == _currentIndex);

      _currentIndex = index;

      return;
    }
    widget.child.goBranch(index, initialLocation: index == _currentIndex);
    _currentIndex = index;
  }

  bool _canPop = false;

  @override
  Widget build(BuildContext context) {
    final subscriptionState = ref.watch(subscriptionControllerProvider);
    final authUser = ref.watch(authControllerProvider).requireValue;
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          print('');
        } else {
          _onItemTapped(0);
          // Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Press back again to exit')),
          );

          setState(() {
            _canPop = true;
          });
        }
      },
      child: Scaffold(
        extendBody: true,
        body: subscriptionState.when(
          data: (data) {
            return Stack(
              children: [
                // Main content
                widget.child,
                // Floating glass nav bar positioned at bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SafeArea(
                    child: GlassFloatingNavBar(
                      currentIndex: _currentIndex,
                      onTap: _onItemTapped,
                      centerButtonColor: ThemeConfig.primaryColor,
                      items: const [
                        BottomNavItem(
                          icon: FaIcon(FontAwesomeIcons.house),
                          label: 'Home',
                        ),
                        BottomNavItem(
                          icon: FaIcon(FontAwesomeIcons.fire),
                          label: 'Streaks',
                        ),
                        BottomNavItem(
                          icon: FaIcon(FontAwesomeIcons.qrcode),
                          label: '',
                          isCenterItem: true,
                        ),
                        BottomNavItem(
                          icon: FaIcon(FontAwesomeIcons.bagShopping),
                          label: 'Partner',
                        ),
                        BottomNavItem(
                          icon: FaIcon(FontAwesomeIcons.gear),
                          label: 'Settings',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return _SubscriptionErrorStateWIthUserQRCode(
              authUser: authUser,
              ref: ref,
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),

        // bottomNavigationBar: BottomNavigationBar(
        //   selectedLabelStyle: const TextStyle(
        //     fontWeight: FontWeight.bold,
        //   ),
        //   elevation: 10,
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: Theme.of(context).colorScheme.primary,
        //   unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        //   currentIndex: widget.child.currentIndex,
        //   onTap: _onItemTapped,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.qr_code_2_outlined),
        //       label: '',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_bag),
        //       label: 'Vendor',
        //     ),
        //     // Settings
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.settings),
        //       label: 'Settings',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class _SubscriptionErrorStateWIthUserQRCode extends StatefulWidget {
  const _SubscriptionErrorStateWIthUserQRCode({
    super.key,
    required this.authUser,
    required this.ref,
  });

  final AppUser? authUser;
  final WidgetRef ref;

  @override
  State<_SubscriptionErrorStateWIthUserQRCode> createState() =>
      _SubscriptionErrorStateWIthUserQRCodeState();
}

class _SubscriptionErrorStateWIthUserQRCodeState
    extends State<_SubscriptionErrorStateWIthUserQRCode>
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
    const gradientStart = Color(0xFFEF4444); // red-500
    const gradientEnd = Color(0xFFF97316); // orange-500
    const textMain = Color(0xFF1E293B);
    const textSub = Color(0xFF64748B);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated QR code
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: child,
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow effect
                  Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: RadialGradient(
                        colors: [
                          gradientStart.withOpacity(0.3),
                          gradientEnd.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Main QR card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [gradientStart, gradientEnd],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: gradientStart.withOpacity(0.5),
                          blurRadius: 40,
                          offset: const Offset(0, 20),
                          spreadRadius: -10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // QR code container
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: 220,
                            height: 220,
                            child: PrettyQrView.data(
                              data: widget.authUser?.userId ?? 'No User ID',
                              decoration: const PrettyQrDecoration(
                                shape: PrettyQrRoundedSymbol(color: textMain),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Scan instruction
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.qr_code_scanner_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Ready to Scan',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Corner decorations
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // QR Code Info Message
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF3B82F6).withOpacity(0.1),
                    const Color(0xFF8B5CF6).withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.info_outline_rounded,
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
                          'Your QR Code is Active',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: textMain,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'You can still use this QR code for streak check-ins and gift redemptions at partner locations.',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: textSub,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Error state UI
            FaIcon(
              FontAwesomeIcons.triangleExclamation,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Subscription Data Unavailable',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textMain,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Unable to load subscription information at this time',
              style: GoogleFonts.inter(fontSize: 14, color: textSub),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                widget.ref.invalidate(subscriptionControllerProvider);
              },
              icon: const FaIcon(FontAwesomeIcons.arrowsRotate, size: 16),
              label: Text(
                'Retry',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: gradientStart,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
