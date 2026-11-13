import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _lineController;
  late Animation<double> _lineWidthAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _lineWidthAnimation = Tween<double>(begin: 0.0, end: 40.0).animate(
      CurvedAnimation(
        parent: _lineController,
        curve: Curves.easeInOut,
      ),
    );

    _lineController.forward();

    _navigationTimer = Timer(const Duration(milliseconds: 1200), () {
      if (mounted) {
        context.go('/chat');
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _lineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary(isDark),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Darshan',
              style: AppTypography.h1(
                AppColors.textPrimary(isDark),
              ).copyWith(
                fontSize: 32,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            AnimatedBuilder(
              animation: _lineWidthAnimation,
              builder: (context, child) {
                return Container(
                  width: _lineWidthAnimation.value,
                  height: 1.0,
                  color: AppColors.accent(isDark),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
