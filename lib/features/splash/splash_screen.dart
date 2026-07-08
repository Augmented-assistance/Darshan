import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/camera');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Replace with real logo/Lottie animation
            const Icon(Icons.map_outlined, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Text(
              'SmritAI',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 40),
            const FourDotLoader(),
          ],
        ),
      ),
    );
  }
}

class FourDotLoader extends StatefulWidget {
  const FourDotLoader({super.key});

  @override
  State<FourDotLoader> createState() => _FourDotLoaderState();
}

class _FourDotLoaderState extends State<FourDotLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        return ScaleTransition(
          scale: DelayTween(begin: 0.0, end: 1.0, delay: index * 0.2)
              .animate(_controller),
          child: Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}

class DelayTween extends Tween<double> {
  final double delay;

  DelayTween({super.begin, super.end, required this.delay});

  @override
  double learn(double t) => super.lerp((t - delay).clamp(0.0, 1.0));

  @override
  double lerp(double t) {
    double adjustedT = (t - delay) * 2;
    if (adjustedT < 0) return begin!;
    if (adjustedT > 1) return end!;
    return super.lerp(adjustedT);
  }
}
