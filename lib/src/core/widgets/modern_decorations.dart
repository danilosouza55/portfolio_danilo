import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Decorações visuais modernas
class ModernDecorations {
  /// Cria um fundo com padrão de grade
  static Widget gridBackground({
    double gridSize = 30,
    Color? gridColor,
    Color? backgroundColor,
    required Widget child,
  }) {
    return Container(
      color: backgroundColor ?? AppColors.darkBg,
      child: Stack(
        children: [
          CustomPaint(
            painter: GridPainter(
              gridSize: gridSize,
              gridColor: gridColor ?? AppColors.border.withValues(alpha: 0.1),
            ),
            size: Size.infinite,
          ),
          child,
        ],
      ),
    );
  }

  /// Cria uma linha diagonal decorativa
  static Widget diagonalLine({
    required Color color,
    double strokeWidth = 2,
    double angle = 45,
  }) {
    return Transform.rotate(
      angle: angle * 3.14159 / 180,
      child: Container(
        height: strokeWidth,
        color: color,
      ),
    );
  }

  /// Cria bolinhas decorativas flutuantes
  static Widget floatingBubbles({
    int bubbleCount = 5,
    double maxSize = 100,
    required Widget child,
  }) {
    return Stack(
      children: [
        ...List.generate(
          bubbleCount,
          (index) => Positioned(
            left: (index * 80.0) % 300,
            top: (index * 120.0) % 400,
            child: Container(
              width: 50 + (index * 10),
              height: 50 + (index * 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: index.isEven
                    ? AppColors.primaryGradient
                    : AppColors.accentGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }

  /// Divisor decorativo com ondas
  static Widget waveDivider({
    Color? color,
    double height = 60,
  }) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: WavePainter(
          color: color ?? AppColors.primary,
        ),
        size: Size.infinite,
      ),
    );
  }

  /// Linha com gradient
  static Widget gradientLine({
    required Gradient gradient,
    double height = 4,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(gradient: gradient),
    );
  }

  /// Fundo com blur/glassmorphism
  static Widget glassBackground({
    required Widget child,
    Color? backgroundColor,
    double opacity = 0.7,
  }) {
    return Container(
      color: (backgroundColor ?? AppColors.darkBg).withValues(alpha: opacity),
      child: child,
    );
  }

  /// Padrão de pontos
  static Widget dotsPattern({
    Color? dotsColor,
    double dotSize = 4,
    double spacing = 20,
    required Widget child,
  }) {
    return Stack(
      children: [
        CustomPaint(
          painter: DotsPainter(
            dotsColor: dotsColor ?? AppColors.border.withValues(alpha: 0.2),
            dotSize: dotSize,
            spacing: spacing,
          ),
          size: Size.infinite,
        ),
        child,
      ],
    );
  }
}

/// Painter para grade
class GridPainter extends CustomPainter {
  final double gridSize;
  final Color gridColor;

  GridPainter({
    required this.gridSize,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) {
    return oldDelegate.gridSize != gridSize ||
        oldDelegate.gridColor != gridColor;
  }
}

/// Painter para ondas
class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    const amplitude = 10.0;
    const frequency = 0.015;

    path.moveTo(0, size.height / 2);

    for (double i = 0; i <= size.width; i++) {
      final y = size.height / 2 + amplitude * _simpleSin(i * frequency);
      path.lineTo(i, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;
}

/// Painter para pontos
class DotsPainter extends CustomPainter {
  final Color dotsColor;
  final double dotSize;
  final double spacing;

  DotsPainter({
    required this.dotsColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotsColor
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DotsPainter oldDelegate) {
    return oldDelegate.dotsColor != dotsColor ||
        oldDelegate.dotSize != dotSize ||
        oldDelegate.spacing != spacing;
  }
}

/// Função seno simplificada
double _simpleSin(double x) {
  x = x % (2 * 3.14159265358979323846);
  final y = x * (2 / 3.14159265358979323846);
  if (y < 0) {
    return -(y * y * (0.785 + 0.251 * (y * y)));
  }
  return y * y * (0.785 + 0.251 * (y * y));
}
