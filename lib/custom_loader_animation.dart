import 'package:flutter/material.dart';
import 'dart:math';

class CustomLoaderAnimation extends StatefulWidget {
  final Color loaderColor;

  const CustomLoaderAnimation({super.key, required this.loaderColor});

  @override
  _CustomLoaderAnimationState createState() => _CustomLoaderAnimationState();
}

class _CustomLoaderAnimationState extends State<CustomLoaderAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Loop the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(200, 200), // Set the size of the hexagon loader
        painter: LoaderDotsPainter(
            animation: _controller, loaderColor: widget.loaderColor),
      ),
    );
  }
}

class LoaderDotsPainter extends CustomPainter {
  final Animation<double> animation;
  final Color loaderColor;
  final Paint _paint;
  LoaderDotsPainter({required this.animation, required this.loaderColor})
      : _paint = Paint()..style = PaintingStyle.fill,
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 3;
    final dotRadius = radius / 8;
    const angleStep = 2 * pi / 6; // 6 sides of the hexagon

    for (int i = 0; i < 6; i++) {
      // Calculate dot positions on the hexagon
      final angle = i * angleStep + (animation.value * 2 * pi);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      // Change dot opacity based on position
      final opacity = 0.5 + 0.5 * sin(animation.value * 2 * pi + i);
      _paint.color = loaderColor.withAlpha(opacity.toInt());

      // Draw the dot
      canvas.drawCircle(Offset(x, y), dotRadius, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
