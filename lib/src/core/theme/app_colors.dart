import 'package:flutter/material.dart';

/// Paleta de cores moderna e profissional para o portfólio
class AppColors {
  // Gradientes primários
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [Color(0xFF00d4ff), Color(0xFF0099ff)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Cores base - Tema escuro moderno
  static const Color darkBg = Color(0xFF0a0e27);
  static const Color darkBgSecondary = Color(0xFF1a1f3a);
  static const Color darkBgTertiary = Color(0xFF252d48);
  static const Color darkCard = Color(0xFF1f2640);

  // Cores de texto
  static const Color textPrimary = Color(0xFFf5f5f7);
  static const Color textSecondary = Color(0xFF9ca3af);
  static const Color textTertiary = Color(0xFF6b7280);

  // Cores de destaque
  static const Color primary = Color(0xFF667eea);
  static const Color primaryLight = Color(0xFF8b9ffa);
  static const Color primaryDark = Color(0xFF4c5fd7);

  static const Color accent = Color(0xFF00d4ff);
  static const Color accentLight = Color(0xFF33e5ff);
  static const Color accentDark = Color(0xFF00a8cc);

  static const Color success = Color(0xFF10b981);
  static const Color warning = Color(0xFFf59e0b);
  static const Color error = Color(0xFFef4444);
  static const Color info = Color(0xFF3b82f6);

  // Cores de status
  static const Color divider = Color(0xFF374151);
  static const Color border = Color(0xFF4b5563);
  static const Color shadow = Color(0x1a000000);

  // Gradientes adicionais
  static const successGradient = LinearGradient(
    colors: [Color(0xFF10b981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const warningGradient = LinearGradient(
    colors: [Color(0xFFf59e0b), Color(0xFFd97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const errorGradient = LinearGradient(
    colors: [Color(0xFFef4444), Color(0xFFdc2626)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
