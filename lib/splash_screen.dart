import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Navigation now uses named routes; specific screen imports removed to avoid
// creating additional widget instances that could conflict during restore.

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;

  late Animation<double> _logoAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Create animations
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    // Start logo rotation and scale
    _logoController.forward();
    _scaleController.forward();

    // Start fade animation after a short delay
    await Future.delayed(const Duration(milliseconds: 500));
    _fadeController.forward();

    // Wait for the splash duration
    await Future.delayed(const Duration(milliseconds: 3000));

    if (mounted) {
      final box = GetStorage();
      final seenOnboarding = box.read('seenOnboarding') ?? false;

      // Helper to safely navigate using named routes and log missing routes.
      void safeNavigate(String routeName) {
        // Debug log for route navigation attempts
        // ignore: avoid_print
        print('[splash] attempting navigation to: $routeName');
        try {
          Get.offAllNamed(routeName);
        } catch (e) {
          // ignore: avoid_print
          print('[splash] navigation to $routeName failed: $e');
          // fallback to splash route to avoid a null route crash
          try {
            if (routeName != '/splash') Get.offAllNamed('/splash');
          } catch (_) {
            // last-resort: do nothing - stay on splash
          }
        }
      }

      if (seenOnboarding) {
        // Go directly to appropriate HomeScreen based on platform
        if (kIsWeb) {
          safeNavigate('/WebHomeScreen');
        } else {
          safeNavigate('/HomeScreen');
        }
      } else {
        // Check platform and navigate accordingly
        if (kIsWeb) {
          // Web platform - go to web onboarding
          safeNavigate('/WebOnboarding');
        } else {
          // Mobile platform - go to mobile onboarding
          safeNavigate('/Onboarding');
        }
      }
    }
  }


  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom "e" Logo
            AnimatedBuilder(
              animation: _logoAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    child: Image.asset('assets/app_logos/logo.png'),
                  ),
                );
              },
            ),

            const SizedBox(height: 80),

            // Three dots loading indicator
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 600),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ELogoPainter extends CustomPainter {
  final double progress;

  ELogoPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    // Create gradient
    final gradient = LinearGradient(
      colors: [
        const Color(0xFFE53E3E), // Red
        const Color(0xFFFF6B35), // Orange
      ],
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradientPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw the "e" shape
    final path = Path();

    // Main curve of the "e" (left side)
    path.moveTo(center.dx - radius * 0.3, center.dy - radius * 0.5);
    path.quadraticBezierTo(
      center.dx - radius * 0.8,
      center.dy - radius * 0.5,
      center.dx - radius * 0.8,
      center.dy,
    );
    path.quadraticBezierTo(
      center.dx - radius * 0.8,
      center.dy + radius * 0.5,
      center.dx - radius * 0.3,
      center.dy + radius * 0.5,
    );

    // Horizontal line across the middle
    path.moveTo(center.dx - radius * 0.8, center.dy);
    path.lineTo(center.dx + radius * 0.2, center.dy);

    // Right side curve
    path.moveTo(center.dx + radius * 0.2, center.dy - radius * 0.3);
    path.quadraticBezierTo(
      center.dx + radius * 0.2,
      center.dy - radius * 0.1,
      center.dx + radius * 0.1,
      center.dy - radius * 0.1,
    );

    // Draw the path with gradient
    canvas.drawPath(path, gradientPaint);

    // Draw the small circle (dot) on the right
    final dotPaint = Paint()
      ..color = const Color(0xFFFF6B35)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(center.dx + radius * 0.4, center.dy - radius * 0.2),
      4,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is ELogoPainter && oldDelegate.progress != progress;
  }
}
