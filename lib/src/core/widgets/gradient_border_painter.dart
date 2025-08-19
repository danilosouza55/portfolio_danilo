import 'package:flutter/material.dart';

class GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Paint paint = Paint()
      ..shader = const SweepGradient(
        colors: [],
        stops: [0.0, 0.5, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2 - 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
