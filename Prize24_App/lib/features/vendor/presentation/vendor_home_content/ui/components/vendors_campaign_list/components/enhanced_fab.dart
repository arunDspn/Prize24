import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/features/global_controller/subscription/subscription_controller.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/vendors_campaign_list_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Campaign Colors
class _CampaignColors {
  static const Color brandStart = Color(0xFFF97316);
  static const Color brandEnd = Color(0xFFEA580C);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [brandStart, brandEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AddCampaignFAB extends ConsumerWidget {
  const AddCampaignFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendorCampaignListState = ref.watch(
      vendorsCampaignListControllerProvider,
    );

    final user = ref.watch(authControllerProvider).requireValue!;

    final subscriptionState = ref
        .watch(subscriptionControllerProvider)
        .requireValue;

    final vendorsOwnCampaignCount = vendorCampaignListState.maybeWhen(
      data: (campaigns) =>
          campaigns.where((c) => c.vendorId == user.userId).length,
      orElse: () => 0,
    );

    return vendorCampaignListState.maybeWhen(
      data: (campaigns) {
        if (vendorsOwnCampaignCount >= (subscriptionState?.maxCampaigns ?? 0)) {
          return const SizedBox.shrink();
        }
        return _AnimatedSlideUp(
          delay: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: _CampaignColors.brandGradient,
              boxShadow: [
                BoxShadow(
                  color: _CampaignColors.brandStart.withOpacity(0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                  spreadRadius: -10,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: () {
                  context.push(AppRoutes.addVendorCampaign);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Add Campaign',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.white,
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
      orElse: () => const SizedBox.shrink(),
    );
  }
}

// Animated Slide Up Widget
class _AnimatedSlideUp extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _AnimatedSlideUp({required this.child, this.delay = Duration.zero});

  @override
  State<_AnimatedSlideUp> createState() => _AnimatedSlideUpState();
}

class _AnimatedSlideUpState extends State<_AnimatedSlideUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
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
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(opacity: _opacityAnimation, child: widget.child),
    );
  }
}
