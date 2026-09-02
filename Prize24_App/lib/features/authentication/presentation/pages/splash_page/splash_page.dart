import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/configs/assets.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Particle class for the orbiting animation
class Particle {
  Particle()
    : angle = _random.nextDouble() * pi * 2,
      radius = 45 + _random.nextDouble() * 70,
      speed = 0.01 + _random.nextDouble() * 0.025,
      size = 1 + _random.nextDouble() * 2.5,
      color = colors[_random.nextInt(colors.length)],
      opacity = _random.nextDouble(),
      fadeSpeed = 0.005 + _random.nextDouble() * 0.015;
  double angle;
  double radius;
  double speed;
  double size;
  Color color;
  double opacity;
  double fadeSpeed;

  static final List<Color> colors = [
    const Color(0xFFFF8C00), // Dark Orange
    const Color(0xFFFFA500), // Orange
    const Color(0xFFFFD700), // Gold
    const Color(0xFFFF4500), // Orange Red
  ];

  static final Random _random = Random();

  void reset() {
    angle = _random.nextDouble() * pi * 2;
    radius = 45 + _random.nextDouble() * 70;
    speed = 0.01 + _random.nextDouble() * 0.025;
    size = 1 + _random.nextDouble() * 2.5;
    color = colors[_random.nextInt(colors.length)];
    opacity = 1.0;
    fadeSpeed = 0.005 + _random.nextDouble() * 0.015;
  }

  void update() {
    angle += speed;
    opacity -= fadeSpeed;
    if (opacity <= 0) {
      reset();
    }
  }
}

// Trail class for the orbiting trails
class Trail {
  Trail()
    : angle = _random.nextDouble() * pi * 2,
      radius = 55 + _random.nextDouble() * 45,
      speed = 0.015 + _random.nextDouble() * 0.02,
      length = 15 + _random.nextInt(25),
      color = colors[_random.nextInt(colors.length)],
      width = 0.8 + _random.nextDouble() * 1.2,
      drift = (_random.nextDouble() - 0.5) * 0.4;
  List<Offset> points = [];
  double angle;
  double radius;
  double speed;
  int length;
  Color color;
  double width;
  double drift;

  static final List<Color> colors = [
    const Color(0xFFFF8C00),
    const Color(0xFFFFA500),
    const Color(0xFFFFD700),
    const Color(0xFFFF4500),
  ];

  static final Random _random = Random();

  void update(Offset center) {
    angle += speed;
    radius += drift;

    final x = center.dx + cos(angle) * radius;
    final y = center.dy + sin(angle) * radius;

    points.add(Offset(x, y));

    if (points.length > length) {
      points.removeAt(0);
    }

    if ((radius - 80).abs() > 60) {
      drift *= -1;
    }
  }
}

// Custom Painter for the particle animation
class SparkOverlayPainter extends CustomPainter {
  SparkOverlayPainter({required this.particles, required this.trails});
  final List<Particle> particles;
  final List<Trail> trails;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw radial gradient background glow
    final gradient = RadialGradient(
      center: Alignment.center,
      radius: 0.4,
      colors: [const Color(0xFFFF8C00).withOpacity(0.12), Colors.transparent],
    );

    final rect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    );

    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Draw trails
    for (final trail in trails) {
      if (trail.points.length < 2) continue;

      final trailPaint = Paint()
        ..color = trail.color.withOpacity(0.35)
        ..strokeWidth = trail.width
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final path = Path()..moveTo(trail.points[0].dx, trail.points[0].dy);

      for (var i = 1; i < trail.points.length; i++) {
        path.lineTo(trail.points[i].dx, trail.points[i].dy);
      }

      canvas.drawPath(path, trailPaint);
    }

    // Draw particles
    for (final particle in particles) {
      final jitterX = sin(particle.angle * 8) * 1.5;
      final jitterY = cos(particle.angle * 8) * 1.5;

      final x = center.dx + cos(particle.angle) * particle.radius + jitterX;
      final y = center.dy + sin(particle.angle) * particle.radius + jitterY;

      // Draw glow
      final glowPaint = Paint()
        ..color = particle.color.withOpacity(particle.opacity * 0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawCircle(Offset(x, y), particle.size * 2, glowPaint);

      // Draw particle
      final particlePaint = Paint()
        ..color = particle.color.withOpacity(particle.opacity);

      canvas.drawCircle(Offset(x, y), particle.size, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant SparkOverlayPainter oldDelegate) => true;
}

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Particle> _particles = [];
  final List<Trail> _trails = [];

  static const int particleCount = 65;
  static const int trailCount = 18;

  @override
  void initState() {
    super.initState();

    // Initialize particles
    for (int i = 0; i < particleCount; i++) {
      _particles.add(Particle());
    }

    // Initialize trails
    for (int i = 0; i < trailCount; i++) {
      _trails.add(Trail());
    }

    // Setup animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_updateAnimation);

    _animationController.repeat();

    // Check auth after 2 seconds (moved from build to initState to run only once)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        ref.read(authControllerProvider.notifier).checkAuth();
      }
    });
  }

  void _updateAnimation() {
    setState(() {
      // Update particles
      for (final particle in _particles) {
        particle.update();
      }

      // Update trails with center position
      const canvasSize = 300.0;
      const center = Offset(canvasSize / 2, canvasSize / 2);
      for (final trail in _trails) {
        trail.update(center);
      }
    });
  }

  @override
  void dispose() {
    _animationController
      ..removeListener(_updateAnimation)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          Future<void>.delayed(const Duration(seconds: 1)).then((_) {
            if (data == null) {
              // if (context.mounted) context.go(AppRoutes.getStarted);
              // Not logged in
              // ref
              //     .read(anonymousLoginControllerProvider.notifier)
              //     .loginAnonymously()
              //     .then((user) {});
              // To Get Started Page
              if (context.mounted) context.go(AppRoutes.getStarted);
            } else if (data.deletionRequestedAt != null) {
              // Account has a pending deletion request - route to a
              // dedicated page instead of Home, where the user can
              // cancel the request or sign out.
              if (context.mounted) {
                context.go(AppRoutes.accountDeletionPending);
              }
            } else {
              //todo: TEMP
              // if (data is AuthenticatedUser) {
              //   if (data.isVendor) {
              //     ref
              //         .read(getMyShopControllerProvider.notifier)
              //         .getDetails(userId: data.userId);
              //   }
              // }
              if (context.mounted) context.go(AppRoutes.home);
            }
          });
        },
        error: (error, stackTrace) {
          // Snackbar
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(error.toString()),
          //   ),
          // );

          showToastAtTop(context, 'Something went wrong', false);
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Particle animation overlay
                Positioned.fill(
                  child: CustomPaint(
                    painter: SparkOverlayPainter(
                      particles: _particles,
                      trails: _trails,
                    ),
                  ),
                ),
                // Logo in center
                Image.asset(AppAssets.p24LaunchLogo, width: 120, height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
