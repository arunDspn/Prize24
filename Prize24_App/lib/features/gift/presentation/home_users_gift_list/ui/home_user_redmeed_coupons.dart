import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';

import 'package:prize24_app/features/gift/presentation/home_users_gift_list/ui/widgets/coupon_ticket_widget.dart';
import 'package:prize24_app/features/gift/presentation/home_users_gift_list/view_model/get_all_coupons_controller.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';

/// Theme colors matching the HTML design
class _ThemeColors {
  // Page colors
  static const Color pageBg = Color(0xFFF8FAFC); // slate-50
  static const Color pageCard = Color(0xFFFFFFFF); // white
  static const Color pageInput = Color(0xFFF1F5F9); // slate-100

  // Text colors
  static const Color textMain = Color(0xFF1E293B); // slate-800
  static const Color textSub = Color(0xFF64748B); // slate-500

  // Brand colors
  static const Color brandStart = Color(0xFFEF4444); // red-500
  static const Color brandEnd = Color(0xFFF97316); // orange-500
}

class HomePageCoupons extends ConsumerStatefulWidget {
  const HomePageCoupons({super.key});

  @override
  ConsumerState<HomePageCoupons> createState() => _HomePageCouponsState();
}

class _HomePageCouponsState extends ConsumerState<HomePageCoupons> {
  @override
  Widget build(BuildContext context) {
    final isAuth = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: _ThemeColors.pageBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _ThemeColors.pageCard.withOpacity(0.9),
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Row(
          children: [
            // Logo with gradient background
            Center(
              child: Image.asset(
                'assets/images/p24_3x_red.png',
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Prize24',
              style: GoogleFonts.inter(
                color: _ThemeColors.textMain,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: _ThemeColors.pageInput),
        ),
      ),
      body: isAuth.when(
        data: (data) {
          if (data == null) {
            return const SizedBox.shrink();
          }
          return _AuthUserView(data);
        },
        error: (error, stackTrace) {
          // Error handling Widget - matching HTML error state
          return Container(
            color: _ThemeColors.pageBg,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Error icon container
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.red.shade100),
                      ),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        size: 48,
                        color: Colors.red.shade500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Oops! Something went wrong',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _ThemeColors.textMain,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We encountered an error while loading your data. Please check your internet connection and try again.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: _ThemeColors.textSub,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // Retry button with gradient
                    _GradientButton(
                      text: 'Retry',
                      onPressed: () {
                        final _ = ref.refresh(getAllCouponsControllerProvider);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () {
          // Loading state matching HTML design
          return Container(
            color: _ThemeColors.pageBg,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        _ThemeColors.brandStart,
                      ),
                      backgroundColor: _ThemeColors.brandStart.withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Fetching your coupons...',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _ThemeColors.textSub,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AuthUserView extends ConsumerStatefulWidget {
  const _AuthUserView(this.user);

  final AppUser user;

  @override
  ConsumerState<_AuthUserView> createState() => _AuthUserViewState();
}

class _AuthUserViewState extends ConsumerState<_AuthUserView> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Check if we're near the bottom (within 200 pixels)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreIfNeeded();
    }
  }

  Future<void> _loadMoreIfNeeded() async {
    if (_isLoadingMore) return;

    final state = ref.read(getAllCouponsControllerProvider).asData?.value;
    if (state == null || !state.hasMore || state.isLoadingMore) return;

    setState(() => _isLoadingMore = true);

    try {
      await ref.read(getAllCouponsControllerProvider.notifier).loadMore();
    } finally {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(getAllCouponsControllerProvider);

    return list.when(
      data: (state) {
        final items = state.items;
        // Check if the list is empty
        if (items.isEmpty && !state.isLoadingMore) {
          // Empty state matching HTML design
          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(getAllCouponsControllerProvider.notifier)
                  .refresh();
            },
            color: _ThemeColors.brandStart,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight * 0.9,
                    ),
                    child: IntrinsicHeight(
                      child: Container(
                        color: _ThemeColors.pageBg,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Empty state illustration
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Main circle with ticket icon
                                  Container(
                                    width: 128,
                                    height: 128,
                                    decoration: BoxDecoration(
                                      color: _ThemeColors.pageInput,
                                      borderRadius: BorderRadius.circular(64),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.confirmation_number_outlined,
                                        size: 56,
                                        color: _ThemeColors.textSub.withOpacity(
                                          0.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Floating QR icon
                                  Positioned(
                                    bottom: -8,
                                    right: -8,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.04,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                        border: Border.all(
                                          color: _ThemeColors.pageInput,
                                        ),
                                      ),
                                      child: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            const LinearGradient(
                                              colors: [
                                                _ThemeColors.brandStart,
                                                _ThemeColors.brandEnd,
                                              ],
                                            ).createShader(bounds),
                                        child: const Icon(
                                          Icons.qr_code_2,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Text(
                                'No Coupons Yet',
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: _ThemeColors.textMain,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Start scanning QR codes to collect\nyour first coupon!',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: _ThemeColors.textSub,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: double.infinity,
                                child: _GradientButton(
                                  text: 'View My QR Code',
                                  icon: Icons.qr_code_2,
                                  onPressed: () {
                                    context.push('/qrscanscreen');
                                  },
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
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(getAllCouponsControllerProvider.notifier).refresh();
          },
          color: _ThemeColors.brandStart,
          child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            itemCount: items.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == items.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _ThemeColors.brandStart,
                      ),
                    ),
                  ),
                );
              }
              final coupon = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CouponTicketCard(gift: coupon),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) {
        // Error handling Widget matching HTML design
        return Container(
          color: _ThemeColors.pageBg,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Error icon container
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red.shade100),
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      size: 48,
                      color: Colors.red.shade500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Oops! Something went wrong',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _ThemeColors.textMain,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We encountered an error while loading your data. Please check your internet connection and try again.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: _ThemeColors.textSub,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Retry button with gradient
                  _GradientButton(
                    text: 'Retry',
                    onPressed: () {
                      final _ = ref.refresh(getAllCouponsControllerProvider);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () {
        // Loading state matching HTML design
        return Container(
          color: _ThemeColors.pageBg,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      _ThemeColors.brandStart,
                    ),
                    backgroundColor: _ThemeColors.brandStart.withOpacity(0.1),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Fetching your coupons...',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _ThemeColors.textSub,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Gradient button widget matching the HTML design
class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.text,
    required this.onPressed,
    this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_ThemeColors.brandStart, _ThemeColors.brandEnd],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _ThemeColors.brandEnd.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: Colors.white),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
