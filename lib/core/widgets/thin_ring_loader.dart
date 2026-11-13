import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ThinRingLoader extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const ThinRingLoader({
    super.key,
    this.size = 40.0,
    this.strokeWidth = 1.5,
    this.color,
  });

  @override
  State<ThinRingLoader> createState() => _ThinRingLoaderState();
}

class _ThinRingLoaderState extends State<ThinRingLoader>
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ringColor = widget.color ?? AppColors.accent(isDark);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _ThinRingPainter(
            progress: _controller.value,
            color: ringColor,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );
  }
}

class _ThinRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _ThinRingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track circle (very light hairline)
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color.withValues(alpha: 0.15);

    canvas.drawCircle(center, radius, trackPaint);

    // Single rotating arc
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;

    final startAngle = progress * 2 * math.pi;
    const sweepAngle = math.pi * 0.7; // ~120 degrees single arc

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ThinRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
