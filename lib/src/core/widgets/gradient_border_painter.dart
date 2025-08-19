import 'package:flutter/material.dart';

class GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Paint paint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF8E24AA), // Roxo escuro
          Color(0xFFBA68C8), // Roxo claro
          Color(0xFF8E24AA), // Roxo escuro
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2 - 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
